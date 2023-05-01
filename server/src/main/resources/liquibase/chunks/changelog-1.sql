CREATE TABLE IF NOT EXISTS stadium
(
    id          SERIAL          NOT NULL,
    address     TEXT            NOT NULL,
    location    GEOMETRY(Point) NOT NULL,
    capacity    TEXT,
    description TEXT,
    data        JSONB,
    created_at  TIMESTAMPTZ     NOT NULL,
    removed_at  TIMESTAMPTZ,

    CONSTRAINT pk_stadium_id PRIMARY KEY (id),
    CONSTRAINT uk_stadium_location UNIQUE (location)
);

CREATE INDEX IF NOT EXISTS aa ON stadium USING GIST (location);

-- TODO удалить, как будет нормальное заполнение базы
INSERT INTO stadium(address, location, capacity, data, created_at) -- 30 в.д. 60 с.ш.
VALUES ('Черкасова 15', 'POINT(30.42524817530528 60.02751024891673)', '7x7', '{
  "cover": "artificial turf"
}', now());
