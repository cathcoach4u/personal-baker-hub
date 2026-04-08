-- Create habits table
CREATE TABLE IF NOT EXISTS habits (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  task TEXT NOT NULL,
  frequency TEXT NOT NULL,
  due_date DATE,
  completed_this_cycle BOOLEAN DEFAULT false,
  last_completed DATE,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Enable RLS
ALTER TABLE habits ENABLE ROW LEVEL SECURITY;

-- Set allow_all policy
DROP POLICY IF EXISTS "allow_all" ON habits;
CREATE POLICY "allow_all" ON habits FOR ALL USING (true) WITH CHECK (true);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_habits_frequency ON habits(frequency);
CREATE INDEX IF NOT EXISTS idx_habits_due_date ON habits(due_date);

-- Insert sample habits
INSERT INTO habits (task, frequency, due_date, notes)
VALUES
  -- Weekly
  ('Shopping', 'Weekly', '2026-04-15', 'Groceries'),
  ('Wash Rosie', 'Weekly', '2026-04-15', 'Dog wash'),

  -- Monthly
  ('Wash fish tank', 'Monthly', '2026-04-30', ''),

  -- 6-Monthly
  ('Dental clean', '6-Monthly', '2026-05-01', 'May and November'),

  -- Annual
  ('GP check', 'Annual', '2026-01-15', 'January');
