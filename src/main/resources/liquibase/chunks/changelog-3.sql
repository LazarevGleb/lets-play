DROP DOMAIN IF EXISTS phone;
CREATE DOMAIN phone AS TEXT CHECK (VALUE ~* '^\+?7(9\d{9})$');

CREATE TABLE IF NOT EXISTS player
(
    id                  SERIAL           NOT NULL PRIMARY KEY,
    phone               phone            NOT NULL UNIQUE,
    name                TEXT             NOT NULL,
    nickname            TEXT             NOT NULL UNIQUE,
    age                 SMALLINT         NOT NULL,
    birth_date          DATE             NOT NULL,
    rank                FLOAT            ,
    primary_position    SMALLINT         NOT NULL,
    secondary_position  SMALLINT         ,
    avatar              TEXT             UNIQUE,

    CONSTRAINT pk_primary_position FOREIGN KEY(primary_position) REFERENCES position(id),
    CONSTRAINT pk_secondary_position FOREIGN KEY(secondary_position) REFERENCES position(id)
);

INSERT INTO player(phone, name, nickname, age, birth_date, rank, primary_position)
VALUES (
'+79522760148', 'Антон', 'AntonGongelev', '29', '1993-09-25', '4.5', '1'
);
