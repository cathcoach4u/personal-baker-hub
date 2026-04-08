-- Baker Hub — NDIS Providers Table
-- Run this in Supabase SQL Editor

CREATE TABLE ndis_providers (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  ndis_number TEXT,
  default_fund TEXT,
  notes TEXT
);

ALTER TABLE ndis_providers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all" ON ndis_providers FOR ALL USING (true) WITH CHECK (true);

-- Seed from existing transaction data
INSERT INTO ndis_providers (name, ndis_number, default_fund) VALUES
  ('Fiona Debarge', '432335528', 'Increased Social and Community'),
  ('Therese', '435019239', 'Increased Social and Community');
