-- Baker Hub — House Projects & Important Dates
-- Run this in Supabase SQL Editor

-- ============================================================
-- TABLE: Important Dates
-- ============================================================
CREATE TABLE important_dates (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  date_start DATE,
  date_end DATE,
  time_info TEXT,
  location TEXT,
  category TEXT NOT NULL,
  notes TEXT
);

ALTER TABLE important_dates ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all" ON important_dates FOR ALL USING (true) WITH CHECK (true);

INSERT INTO important_dates (title, description, date_start, date_end, time_info, location, category, notes) VALUES
  ('Chemical CleanOut', 'Free drop-off for household chemicals, paints, pesticides, gas bottles, batteries, oils, etc.', '2026-06-27', '2026-06-28', '9am - 3:30pm', 'Mona Vale Beach car park (Surfview Road, Mona Vale)', 'Council', 'Northern Beaches Council'),
  ('Bulky Waste Collection', 'Book anytime via council portal. 2 free collections per 12 months.', NULL, NULL, NULL, NULL, 'Council', 'Northern Beaches Council — book via portal'),
  ('Food Waste Pilot Phase 2', 'Selected Cromer/Dee Why households receive a burgundy bin for food scraps.', '2026-04-01', '2026-09-30', NULL, NULL, 'Council', 'Northern Beaches Council — April to September 2026'),
  ('Bin Collection — Thursday', 'Weekly: Red lid (General Waste). Fortnightly alternating: Week A = Yellow lid (Recycling), Week B = Green lid (Vegetation/Organics). Place bins on kerb night before, lid facing street.', NULL, NULL, 'Thursdays', NULL, 'Council', 'Northern Beaches Council — see dashboard for current week A/B');

-- ============================================================
-- TABLE: House Projects
-- ============================================================
CREATE TABLE house_projects (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'Not Started' CHECK (status IN ('Not Started', 'In Progress', 'Complete')),
  priority TEXT DEFAULT 'Medium' CHECK (priority IN ('Low', 'Medium', 'High', 'Urgent')),
  due_date DATE,
  notes TEXT
);

ALTER TABLE house_projects ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all" ON house_projects FOR ALL USING (true) WITH CHECK (true);
