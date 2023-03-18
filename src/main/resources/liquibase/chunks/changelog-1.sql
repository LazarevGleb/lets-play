CREATE TABLE IF NOT EXISTS stadium
(
    id          SERIAL          NOT NULL PRIMARY KEY,
    address     TEXT            NOT NULL,
    location    GEOMETRY(Point) NOT NULL UNIQUE,
    capacity    TEXT            NOT NULL,
    description TEXT,
    data        JSONB
);

CREATE INDEX IF NOT EXISTS aa ON stadium USING GIST (location);

-- TODO удалить, как будет нормальное заполнение базы
INSERT INTO stadium(address, location, capacity, data) -- 30 в.д. 60 с.ш.
VALUES ('Черкасова 15', 'POINT(30.42524817530528 60.02751024891673)', '7x7', '{
  "cover": "artificial turf"
}');
