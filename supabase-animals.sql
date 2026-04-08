-- Create animals table
CREATE TABLE IF NOT EXISTS animals (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name TEXT NOT NULL,
  type TEXT NOT NULL,
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

-- Insert Gypsy data
INSERT INTO animals (name, type, microchip_number, desexed, desexed_date, notes)
VALUES ('Gypsy', 'Cat', '991003003098563', true, '2023-08-28', 'Tick bite treated 10 Dec 2024');

-- Insert Gypsy vaccinations and treatments
INSERT INTO animal_medical_records (animal_id, record_type, date_recorded, description, cost, veterinarian_name)
VALUES
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Vaccination', '2025-03-24', 'Vaccinations', 140.00, 'Dr Jessica March'),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Vaccination', '2025-10-30', 'Vaccination (First)', NULL, NULL),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Treatment', '2025-12-29', 'Worming: Milpro (full tablet) - Weight 1.9 kg', NULL, NULL),
  ((SELECT id FROM animals WHERE name='Gypsy'), 'Vaccination', '2025-12-30', 'Vaccination (Second) - Consult booked', NULL, NULL);

-- Insert other animals (placeholder records)
INSERT INTO animals (name, type, notes)
VALUES
  ('Rosie', 'Dog', 'Microchip and medical history to be added'),
  ('Ellie', 'Cat', 'Microchip and medical history to be added');
