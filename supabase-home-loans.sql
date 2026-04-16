-- Home Loans table for Baker Hub Finance section
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS home_loans (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  lender TEXT,
  account_number TEXT,
  property_address TEXT,
  balance NUMERIC DEFAULT 0,
  interest_rate NUMERIC DEFAULT 0,
  rate_type TEXT DEFAULT 'Variable',
  repayment NUMERIC DEFAULT 0,
  repayment_frequency TEXT DEFAULT 'Monthly',
  repayment_type TEXT,
  offset_accounts INTEGER DEFAULT 0,
  loan_start_date DATE,
  last_updated DATE,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS
ALTER TABLE home_loans ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS allow_all ON home_loans;
CREATE POLICY allow_all ON home_loans FOR ALL USING (true) WITH CHECK (true);
