-- Placeholder for database seed and application setup.
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  points INTEGER NOT NULL DEFAULT 0
);
