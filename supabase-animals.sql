-- Baker Hub — Animals & Medical Records
-- Run this in Supabase SQL Editor after the initial setup

-- Create animals table
CREATE TABLE IF NOT EXISTS animals (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name TEXT NOT NULL,
  type TEXT NOT NULL,
  breed TEXT,
  dob DATE,
  microchip_number TEXT,
  desexed BOOLEAN DEFAULT false,
  desexed_date DATE,
  insurance_provider TEXT,
  insurance_policy TEXT,
  insurance_phone TEXT,
  vet_clinic_name TEXT,
  vet_phone TEXT,
  vet_email TEXT,
  vet_address TEXT,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create animal medical records table (vaccinations, treatments, vet visits)
CREATE TABLE IF NOT EXISTS animal_medical_records (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  animal_id BIGINT NOT NULL REFERENCES animals(id) ON DELETE CASCADE,
  record_type TEXT NOT NULL,
  date_recorded DATE NOT NULL,
  description TEXT NOT NULL,
  cost DECIMAL(10,2),
  veterinarian_name TEXT,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Enable RLS
ALTER TABLE animals ENABLE ROW LEVEL SECURITY;
ALTER TABLE animal_medical_records ENABLE ROW LEVEL SECURITY;

-- Set allow_all policies
DROP POLICY IF EXISTS "allow_all" ON animals;
CREATE POLICY "allow_all" ON animals FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "allow_all" ON animal_medical_records;
CREATE POLICY "allow_all" ON animal_medical_records FOR ALL USING (true) WITH CHECK (true);

-- If upgrading from older schema, add new columns:
-- ALTER TABLE animals ADD COLUMN IF NOT EXISTS breed TEXT;
-- ALTER TABLE animals ADD COLUMN IF NOT EXISTS dob DATE;

-- ============================================================
-- GYPSY — Tonkinese Cat
-- ============================================================
INSERT INTO animals (name, type, breed, dob, microchip_number, desexed, desexed_date, insurance_provider, insurance_policy, notes)
VALUES (
  'Gypsy', 'Cat', 'Tonkinese', '2022-10-25', '991003003098563',
  true, '2023-08-28',
  'Everyday Pet Insurance (Woolworths)', 'WW19538882',
  'Insurance: Indoor Cat cover, 80% benefit, $0 excess, $53.48/month. Policy period: 14 Mar 2024 - 14 Mar 2025. Next vaccination: 19 Mar 2027.'
);

-- Gypsy medical records
INSERT INTO animal_medical_records (animal_id, record_type, date_recorded, description, cost, veterinarian_name, notes)
VALUES
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Treatment', '2024-12-10', 'Tick bite treatment — required overnight hospital stay', NULL, NULL, NULL),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Vaccination', '2025-03-24', 'Vaccinations (Ref: 1159060)', 140.00, 'Dr Jessica March', 'Cost includes GST $12.70'),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Vaccination', '2025-10-30', 'First vaccination', NULL, NULL, NULL),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Treatment', '2025-12-29', 'Milpro worming tablet (full tablet) — Weight: 1.9 kg', NULL, NULL, 'Discovered Gypsy had not been desexed. Booked consultation for 30 Dec.'),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Vaccination', '2025-12-30', 'Second vaccination and desexing assessment', NULL, NULL, NULL),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Treatment', '2026-02-13', 'Vet visit for cough — commenced antibiotics', NULL, NULL, NULL),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Treatment', '2026-02-16', 'Follow-up for cough — Weight: ~2.3 kg (up ~400g)', NULL, NULL, NULL),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Vaccination', '2026-03-19', 'Annual vaccination', NULL, NULL, NULL);

-- ============================================================
-- ELLIE — Tonkinese Cat (kitten)
-- ============================================================
INSERT INTO animals (name, type, breed, dob, microchip_number, desexed, desexed_date, insurance_provider, insurance_policy, notes)
VALUES (
  'Ellie', 'Cat', 'Tonkinese', '2025-08-25', '991003003098563',
  true, '2026-01-28',
  'Everyday Pet Insurance (Woolworths)', 'WW23330005-BP11210026',
  'Insurance: Basic cover, $22.24/fortnightly (first payment 26 Feb 2026). Policy period: 31 Dec 2025 - 31 Dec 2026.'
);

-- Ellie medical records
INSERT INTO animal_medical_records (animal_id, record_type, date_recorded, description, cost, veterinarian_name, notes)
VALUES
  ((SELECT id FROM animals WHERE name='Ellie'), 'Vaccination', '2025-12-30', 'Second vaccination — Weight: 1.7 kg', NULL, NULL, NULL);

-- ============================================================
-- ROSIE — Maltese Cross Dog
-- ============================================================
INSERT INTO animals (name, type, breed, dob, desexed, insurance_provider, insurance_policy, vet_clinic_name, notes)
VALUES (
  'Rosie', 'Dog', 'Maltese Cross', '2019-06-01',
  false,
  'Everyday Pet Insurance (Woolworths)', 'WW1520216',
  'Belrose Veterinary Hospital',
  'Insurance: Standard cover, 80% benefit, $100 excess, $39.05/fortnightly. Policy period: 28 May 2023 - 28 May 2024. Next treatments due: 1 Nov 2026 (Tick & Flea $155.70, Heartworm $114.70, C7 Vaccination $180). Vet advice: no regular worming needed, continue annual injections.'
);

-- Rosie medical records
INSERT INTO animal_medical_records (animal_id, record_type, date_recorded, description, cost, veterinarian_name, notes)
VALUES
  ((SELECT id FROM animals WHERE name='Rosie'), 'Treatment', '2024-10-26', 'Heartworm injection', 108.70, NULL, 'Belrose Veterinary Hospital'),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Vaccination', '2024-10-26', 'C5 Vaccination', 155.00, NULL, 'Belrose Veterinary Hospital'),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Treatment', '2024-10-26', 'Tick & Flea injection', 150.00, NULL, 'Belrose Veterinary Hospital'),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Treatment', '2025-11-01', 'Express Anal Glands', 35.00, NULL, 'Belrose Veterinary Hospital'),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Treatment', '2025-11-01', 'Tick & Flea injection', 155.70, NULL, 'Belrose Veterinary Hospital. Next due: 1 Nov 2026'),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Treatment', '2025-11-01', 'Cytopoint (10mg)', 165.40, NULL, 'Belrose Veterinary Hospital'),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Treatment', '2025-11-01', 'Heartworm injection', 114.70, NULL, 'Belrose Veterinary Hospital. Next due: 1 Nov 2026'),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Vaccination', '2025-11-01', 'C7 Vaccination', 180.00, NULL, 'Belrose Veterinary Hospital. Next due: 1 Nov 2026'),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Treatment', '2025-12-29', 'Minor sore on left rear leg — advice: monitor', NULL, NULL, NULL);

-- Rosie weight history (stored as medical records)
INSERT INTO animal_medical_records (animal_id, record_type, date_recorded, description, cost, veterinarian_name, notes)
VALUES
  ((SELECT id FROM animals WHERE name='Rosie'), 'Weight Check', '2024-03-08', 'Weight: 4.6 kg', NULL, NULL, NULL),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Weight Check', '2024-03-24', 'Weight: 4.4 kg', NULL, NULL, NULL),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Weight Check', '2024-10-26', 'Weight: 4.2 kg', NULL, NULL, NULL),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Weight Check', '2025-10-31', 'Weight: 4.4 kg', NULL, NULL, NULL),
  ((SELECT id FROM animals WHERE name='Rosie'), 'Weight Check', '2025-12-29', 'Weight: 4.3 kg', NULL, NULL, NULL);
