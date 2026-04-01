-- Baker Hub — Bulky Waste Update
-- Run this in Supabase SQL Editor

-- Update the existing Bulky Waste important_dates record with the booked date
UPDATE important_dates
SET date_start = '2026-05-11',
    description = 'Booked for 11 May 2026. 1 of 2 free collections used this year. Once collected, the next one can be booked via council portal.',
    notes = 'Northern Beaches Council — 2 free per 12 months. Book via portal after collection.'
WHERE title = 'Bulky Waste Collection';

-- Add a house project for tracking the bulky waste collection
INSERT INTO house_projects (title, description, status, priority, due_date, notes) VALUES
  ('Bulky Waste Collection', 'Sort items for bulky waste pickup. Place on kerb night before collection day. Max 2 cubic metres per collection.', 'In Progress', 'Medium', '2026-05-11', 'Booked — 1 of 2 free collections used. Next available after this one is collected.');
