<?php
/**
 * Baker AI — Claude API Proxy
 * Upload this file to your GoDaddy hosting.
 * Set your API key below or in a .env file.
 */

// ===== CONFIGURATION =====
$CLAUDE_API_KEY = getenv('CLAUDE_API_KEY') ?: 'YOUR-API-KEY-HERE';
// Replace YOUR-API-KEY-HERE with your actual Claude API key,
// or set CLAUDE_API_KEY as an environment variable in GoDaddy.
// ===========================

// CORS — allow your WordPress domain
$allowed_origins = [
    'https://yourdomain.com',      // <-- Replace with your actual WordPress domain
    'https://www.yourdomain.com',  // <-- Replace with www version too
    'http://localhost:3001',        // Dev/testing
];

$origin = $_SERVER['HTTP_ORIGIN'] ?? '';
if (in_array($origin, $allowed_origins)) {
    header("Access-Control-Allow-Origin: $origin");
}
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

// Handle preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// Only accept POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

// Rate limiting (simple, per-IP, 20 requests per minute)
$rate_limit_dir = sys_get_temp_dir() . '/baker-ai-rate/';
if (!is_dir($rate_limit_dir)) mkdir($rate_limit_dir, 0700, true);
$ip_hash = md5($_SERVER['REMOTE_ADDR'] ?? 'unknown');
$rate_file = $rate_limit_dir . $ip_hash;
$now = time();
$window = 60;
$max_requests = 20;

$requests = [];
if (file_exists($rate_file)) {
    $requests = json_decode(file_get_contents($rate_file), true) ?: [];
    $requests = array_filter($requests, fn($t) => $t > $now - $window);
}
if (count($requests) >= $max_requests) {
    http_response_code(429);
    echo json_encode(['error' => 'Too many requests. Please wait a moment.']);
    exit;
}
$requests[] = $now;
file_put_contents($rate_file, json_encode($requests));

// Parse request
$input = json_decode(file_get_contents('php://input'), true);
if (!$input || empty($input['message'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing message']);
    exit;
}

$user_message = substr($input['message'], 0, 2000); // Limit message length
$dashboard_data = $input['data'] ?? '';

// Build the system prompt with dashboard context
$system_prompt = <<<PROMPT
You are Baker AI, a helpful personal finance assistant embedded in the Baker Hub dashboard.

## Your role
- Answer questions about the user's NDIS funding, insurance policies, and superannuation
- Analyse spending patterns and provide insights
- Give proactive suggestions to help manage finances better
- Explain NDIS categories, insurance terms, and financial concepts in plain language
- Help draft communications to providers if asked
- Be friendly, concise, and practical

## User context
- Located in Australia
- All amounts are in Australian Dollars (AUD)
- Date format: DD/MM/YYYY

## Current dashboard data
{$dashboard_data}

## Guidelines
- When answering about data, reference specific numbers from the dashboard data above
- If asked about something not in the data, say so clearly
- Keep responses concise — 2-3 short paragraphs max unless asked for detail
- Use bullet points for lists
- When suggesting improvements, be specific and actionable
PROMPT;

// Call Claude API
$api_payload = json_encode([
    'model' => 'claude-sonnet-4-20250514',
    'max_tokens' => 1024,
    'system' => $system_prompt,
    'messages' => [
        ['role' => 'user', 'content' => $user_message]
    ]
]);

$ch = curl_init('https://api.anthropic.com/v1/messages');
curl_setopt_array($ch, [
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => $api_payload,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT => 30,
    CURLOPT_HTTPHEADER => [
        'Content-Type: application/json',
        'x-api-key: ' . $CLAUDE_API_KEY,
        'anthropic-version: 2023-06-01',
    ],
]);

$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$curl_error = curl_error($ch);
curl_close($ch);

if ($curl_error) {
    http_response_code(502);
    echo json_encode(['error' => 'Failed to reach AI service']);
    exit;
}

if ($http_code !== 200) {
    http_response_code($http_code);
    echo json_encode(['error' => 'AI service error', 'status' => $http_code]);
    exit;
}

$result = json_decode($response, true);
$reply = $result['content'][0]['text'] ?? 'Sorry, I could not generate a response.';

echo json_encode(['reply' => $reply]);
