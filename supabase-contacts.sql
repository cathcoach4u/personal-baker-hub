-- Baker Hub — Contacts Table
-- Run this in Supabase SQL Editor after the initial setup

CREATE TABLE contacts (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  contact_person TEXT,
  phone TEXT,
  email TEXT,
  meeting_link TEXT,
  notes TEXT,
  category TEXT NOT NULL,
  for_person TEXT
);

ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all" ON contacts FOR ALL USING (true) WITH CHECK (true);

INSERT INTO contacts (name, contact_person, phone, category) VALUES
  ('Alignment Health Co.', 'Daniel Murray', '0475 852 878', 'Medical'),
  ('Cardiologist', 'Dr. Ferris Touma', '0284888900', 'Medical'),
  ('Centre for Clinical Therapy', 'Tamsen St Clare', '9908 2950', 'Health & Wellness'),
  ('Chatswood Dermatology Centre', 'Dr. Gottschalk', '0294195148', 'Medical'),
  ('Chris Foy DJ', 'Chris Foy', NULL, 'Entertainment'),
  ('Dentist', 'Dr Keith Al-Juboori', '+61 2 8044 6444', 'Medical'),
  ('Dr', 'Dulip Wettasinghe', '94333750', 'Medical'),
  ('Dr', 'Abi', '02 9188 8421', 'Medical'),
  ('Dr Vivienne James / Gordon Clinic', 'Dr Vivienne James', '02 9418 4488', 'Medical'),
  ('Energise', 'Cafe - Luca, Lucy', NULL, 'Food & Lifestyle'),
  ('Fiona Debarge', 'Fiona Debarge', '+61 403 772 056', 'NDIS'),
  ('Foxtel', 'Foxtel', NULL, 'Home & Services'),
  ('Glenrose Chemist', 'Douglas and Dawn', '(02) 9452 5989', 'Pharmacy'),
  ('Glenrose Village Medical Centre', 'Dr Yasmin Trinidad', '02 8329 7830', 'Medical'),
  ('Jasmine dog groomer', NULL, '+61 403 287 323', 'Home & Services'),
  ('Medicare card', NULL, NULL, 'Government'),
  ('Medicare Safety Net Concession Card', 'Medicare Australia', '132 011', 'Government'),
  ('MRI - Medical Imaging Department', 'Royal North Shore Hospital', '(02)9926 4444', 'Medical'),
  ('Nespresso (Cath)', NULL, NULL, 'Food & Lifestyle'),
  ('North Shore Vertigo and Neurology Clinic', NULL, '0294390199', 'Medical'),
  ('Palms Spa Massage and Acupuncture', NULL, '0432 663 388', 'Health & Wellness'),
  ('Peninsula Gastro', 'Dr Siow', NULL, 'Medical'),
  ('Pharmacist of Sarah Baker', 'Zarna (Tysabri)', '+61 (0) 430 422 328', 'Pharmacy'),
  ('Pool Service', 'Nick', '+61 458 851 321', 'Home & Services'),
  ('PRP imaging', NULL, '89786222', 'Medical'),
  ('Russell''s Basketball', 'Yoel - NSBL', '+61 403 994 240', 'Entertainment'),
  ('Salon Warehouse', NULL, NULL, 'Home & Services'),
  ('Simba Health', NULL, '(02) 9482 4511', 'Medical');
