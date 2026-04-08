-- Create monthly_tasks table
CREATE TABLE IF NOT EXISTS monthly_tasks (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  task TEXT NOT NULL,
  done BOOLEAN DEFAULT false,
  month_year TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  completed_at TIMESTAMP WITH TIME ZONE
);

-- Enable RLS
ALTER TABLE monthly_tasks ENABLE ROW LEVEL SECURITY;

-- Set allow_all policy
DROP POLICY IF EXISTS "allow_all" ON monthly_tasks;
CREATE POLICY "allow_all" ON monthly_tasks FOR ALL USING (true) WITH CHECK (true);

-- Create index for efficient filtering by month_year
CREATE INDEX IF NOT EXISTS idx_monthly_tasks_month_year ON monthly_tasks(month_year);

-- Insert sample monthly tasks for current month (Apr 2026)
INSERT INTO monthly_tasks (task, month_year)
VALUES
  ('NDIS invoice reconciliation', 'Apr 2026'),
  ('Insurance premium review', 'Apr 2026'),
  ('Budget check & reconciliation', 'Apr 2026'),
  ('Utilities bill payment', 'Apr 2026'),
  ('House maintenance inspection', 'Apr 2026');
