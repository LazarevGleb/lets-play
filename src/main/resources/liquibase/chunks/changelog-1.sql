CREATE TABLE IF NOT EXISTS stadium (
    id SERIAL PRIMARY KEY,
    address TEXT NOT NULL,
    longitude FLOAT NOT NULL,
    latitude FLOAT NOT NULL,
    capacity SMALLINT NOT NULL,
    description TEXT,
    data TEXT
);