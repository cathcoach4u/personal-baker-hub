# Baker AI — Setup Guide for GoDaddy

## What you're setting up
A chat widget in your Baker Hub dashboard that talks to Claude via a small PHP file on your GoDaddy server.

```
WordPress page (Baker Hub HTML)
    ↓ user asks a question
PHP proxy on GoDaddy (keeps API key safe)
    ↓ forwards to Claude
Claude API (answers using your dashboard data)
    ↓ returns response
Chat widget shows the answer
```

## Step 1: Upload the PHP proxy

1. Log in to your **GoDaddy cPanel** or **File Manager**
2. Navigate to your WordPress site's root folder (usually `public_html/`)
3. Upload the file: `baker-ai-proxy.php`
4. The file should be accessible at: `https://yourdomain.com/baker-ai-proxy.php`

## Step 2: Add your Claude API key

Open `baker-ai-proxy.php` on the server and find this line near the top:

```php
$CLAUDE_API_KEY = getenv('CLAUDE_API_KEY') ?: 'YOUR-API-KEY-HERE';
```

Replace `YOUR-API-KEY-HERE` with your actual Claude API key (starts with `sk-ant-...`).

## Step 3: Set your domain in the proxy

In `baker-ai-proxy.php`, find the `$allowed_origins` array and replace with your real domain:

```php
$allowed_origins = [
    'https://yourdomain.com',
    'https://www.yourdomain.com',
];
```

## Step 4: Set the proxy URL in the dashboard HTML

In `wordpress-dashboard.html`, find this line near the bottom:

```javascript
const PROXY_URL = 'https://yourdomain.com/baker-ai-proxy.php';
```

Replace with your actual URL.

## Step 5: Paste into WordPress

1. Edit your WordPress page
2. Add a **Custom HTML** block
3. Paste the entire contents of `wordpress-dashboard.html`
4. Publish

## Testing

1. Open your WordPress page
2. Click the robot icon (bottom-right corner)
3. Ask: "What's my NDIS budget status?"
4. You should get a response using your real dashboard data

## Troubleshooting

**"Could not reach Baker AI"**
- Check the PROXY_URL matches where you uploaded the PHP file
- Check your domain is in the $allowed_origins array

**"AI service error" (status 401)**
- Your Claude API key is incorrect or expired
- Check it starts with `sk-ant-`

**"Too many requests"**
- Rate limited to 20 requests per minute per user
- Wait a moment and try again

## Cost

Claude Sonnet API costs roughly $0.003-0.01 per question (a few cents per conversation). With normal personal use you'd spend less than $5/month.
