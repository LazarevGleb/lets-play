ALTER TABLE stadium
    ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ NOT NULL default now();

ALTER TABLE stadium
    ADD COLUMN IF NOT EXISTS removed_at timestamptz;
