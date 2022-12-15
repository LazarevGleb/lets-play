CREATE TABLE IF NOT EXISTS stadium
(
    id          SERIAL           NOT NULL PRIMARY KEY,
    address     TEXT             NOT NULL,
    location    GEOMETRY(Point) NOT NULL,
    capacity    TEXT             NOT NULL,
    description TEXT,
    data        JSONB
);

-- TODO удалить, как будет нормальное заполнение базы
INSERT INTO stadium(address, location, capacity, data)
VALUES ('Черкасова 15', 'POINT(60.02751024891673 30.42524817530528)', '7x7', '{
  "cover": "artificial turf"
}');
