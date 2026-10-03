-- File for seeding initial data into Novelvio database
-- Run this after the schema migrations

-- Insert some sample tasks
INSERT INTO public.tasks (title, description, reward_points, active) 
VALUES 
  ('Watch an Ad', 'Watch a 30-second advertisement', 10, TRUE),
  ('Complete Daily Task', 'Log in and complete your daily checklist', 25, TRUE),
  ('Invite a Friend', 'Invite a friend using your referral code', 100, TRUE),
  ('Shop Through Offers', 'Make a purchase through our partner stores', 50, TRUE),
  ('Survey Completion', 'Complete a quick survey about products', 15, TRUE)
ON CONFLICT DO NOTHING;
