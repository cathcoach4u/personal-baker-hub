-- Baker Hub — Supabase Setup
-- Run this entire script in the Supabase SQL Editor (supabase.com > your project > SQL Editor)

-- ============================================================
-- TABLE 1: NDIS Funding Buckets
-- ============================================================
CREATE TABLE ndis_funds (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  fund_name TEXT NOT NULL UNIQUE,
  budget_amount NUMERIC(12,2) NOT NULL
);

ALTER TABLE ndis_funds ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all" ON ndis_funds FOR ALL USING (true) WITH CHECK (true);

INSERT INTO ndis_funds (fund_name, budget_amount) VALUES
  ('Improved Daily Living', 22308.85),
  ('Increased Social and Community', 7164.48);

-- ============================================================
-- TABLE 2: NDIS Transactions
-- ============================================================
CREATE TABLE ndis_transactions (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  provider_name TEXT NOT NULL,
  invoice_number TEXT NOT NULL,
  funded_support TEXT NOT NULL,
  ndis_number TEXT NOT NULL,
  date DATE NOT NULL,
  amount NUMERIC(12,2) NOT NULL DEFAULT 0,
  status TEXT NOT NULL CHECK (status IN ('Paid', 'Outstanding')),
  notes TEXT DEFAULT ''
);

ALTER TABLE ndis_transactions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all" ON ndis_transactions FOR ALL USING (true) WITH CHECK (true);

INSERT INTO ndis_transactions (provider_name, invoice_number, funded_support, ndis_number, date, amount, status, notes) VALUES
  ('Fiona Debarge', '3', 'Increased Social and Community', '432335528', '2025-11-25', 715.00, 'Paid', ''),
  ('Fiona Debarge', '6', 'Increased Social and Community', '432335528', '2025-12-09', 398.00, 'Paid', ''),
  ('Fiona Debarge', '7', 'Increased Social and Community', '432335528', '2025-12-18', 330.00, 'Paid', ''),
  ('Fiona Debarge', '11', 'Increased Social and Community', '432335528', '2026-01-31', 330.00, 'Paid', ''),
  ('Therese', '15', 'Increased Social and Community', '435019239', '2026-01-28', 175.00, 'Paid', ''),
  ('Therese', '17 Revision 1', 'Increased Social and Community', '435019239', '2026-01-28', 575.00, 'Paid', ''),
  ('Therese', '16', 'Increased Social and Community', '435019239', '2026-01-28', 350.00, 'Paid', ''),
  ('Fiona Debarge', '14', 'Increased Social and Community', '432335528', '2026-02-10', 343.75, 'Paid', ''),
  ('Fiona Debarge', '17', 'Increased Social and Community', '432335528', '2026-03-09', 398.75, 'Paid', ''),
  ('Fiona Debarge', '16', 'Increased Social and Community', '432335528', '2026-02-25', 247.50, 'Paid', ''),
  ('Therese', '18 and 19', 'Increased Social and Community', '432335528', '2026-02-26', 0.00, 'Paid', 'Awaiting signed consent form from Sarah.');

-- ============================================================
-- TABLE 3: Insurance Policies
-- ============================================================
CREATE TABLE insurance_policies (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  person_name TEXT NOT NULL,
  insurer TEXT NOT NULL,
  policy_number TEXT NOT NULL,
  premium_frequency TEXT,
  premium NUMERIC(12,2) NOT NULL DEFAULT 0,
  payment_method TEXT,
  cover_type TEXT NOT NULL,
  due_date DATE,
  paid_to_date DATE,
  superannuation_amount NUMERIC(12,2)
);

ALTER TABLE insurance_policies ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all" ON insurance_policies FOR ALL USING (true) WITH CHECK (true);

INSERT INTO insurance_policies (person_name, insurer, policy_number, premium_frequency, premium, payment_method, cover_type, due_date, paid_to_date, superannuation_amount) VALUES
  ('Cathrine Baker', 'AIA', '15652440', 'Annually', 467.64, 'Macquarie Super Plan', 'Life Cover', '2026-04-10', '2026-04-10', NULL),
  ('Cathrine Baker', 'Acenda', '36083146', 'Monthly', 326.20, 'MLC Masterkey', 'Life, Trauma & Income Protection Plus 1', '2026-02-10', '2026-02-20', NULL),
  ('Cathrine Baker', 'Acenda', '36093145', 'Monthly', 202.73, 'Credit Card', 'Income Protection Plus 1', '2026-02-11', '2026-02-11', NULL),
  ('Cathrine Baker', 'Acenda', '36135328', 'Monthly', 128.80, 'Credit Card', 'Critical Illness Plus 1', '2026-02-20', '2026-02-20', NULL),
  ('Cathrine Baker', 'Zurich', '50210902', 'Annually', 297.02, 'Macquarie Super Plan', 'Life & TPD', '2026-11-15', '2026-11-15', NULL),
  ('Cathrine Baker', 'Zurich', '50210901', 'Monthly', 48.08, 'Credit Card', 'TPD & Trauma', '2026-02-15', '2026-02-15', NULL),
  ('Cathrine Baker', 'TAL/Asteron', '81376809', 'Monthly', 94.30, 'Credit Card', 'Trauma & TPD', '2026-02-17', '2026-02-17', NULL),
  ('Andrew Baker', 'Ascenda', '36065775', 'Annually', 4066.00, 'MLC Masterkey', 'Life, Trauma & Income Protection Plus 1', '2026-11-18', '2026-11-18', NULL),
  ('Andrew Baker', 'Ascenda', '36085574', 'Monthly', 454.00, 'Credit Card', 'Income Protection Plus 1', '2026-02-19', '2026-02-19', NULL),
  ('Andrew Baker', 'Ascenda', '36158209', 'Monthly', 86.76, 'Credit Card', 'Critical Illness Plus 1', '2026-02-15', '2026-02-15', NULL),
  ('Andrew Baker', 'Zurich', '50211672', 'Annually', 600.86, 'Macquarie Super Plan', 'Life & TPD', '2026-11-28', '2026-11-28', NULL),
  ('Andrew Baker', 'Zurich', '50211674', 'Monthly', 105.29, 'Credit Card', 'TPD & Trauma', '2026-01-28', '2026-01-28', NULL),
  ('Andrew Baker', 'TAL/Asteron', '81376807', 'Monthly', 150.92, 'Credit Card', 'Trauma & TPD', '2026-02-17', '2026-02-17', NULL),
  ('Andrew Baker', 'ClearView', '51825896', 'Monthly', 76.78, 'Credit Card', 'Income Protection Plus', '2026-02-13', '2026-02-13', NULL),
  ('Cathrine Baker', 'Macquarie Superannuation', 'M99069 / 802445185', '', 0.00, '', 'Superannuation', NULL, NULL, 225857.13);
