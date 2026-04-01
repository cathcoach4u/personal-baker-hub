-- Baker Hub — NDIS Edit & Receipt Upload
-- Run this in Supabase SQL Editor

-- Add receipt_path column to ndis_transactions
ALTER TABLE ndis_transactions ADD COLUMN IF NOT EXISTS receipt_path TEXT;

-- Allow updates from the browser
CREATE POLICY "Allow public update" ON ndis_transactions FOR UPDATE USING (true) WITH CHECK (true);

-- IMPORTANT: You also need to create a Storage bucket manually:
-- 1. Go to Supabase Dashboard > Storage (left sidebar)
-- 2. Click "New bucket"
-- 3. Name: ndis-receipts
-- 4. Toggle "Public bucket" ON
-- 5. Click "Create bucket"
