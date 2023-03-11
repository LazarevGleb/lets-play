DROP DOMAIN IF EXISTS phone;
CREATE DOMAIN phone AS TEXT CHECK (VALUE ~* '^\+7(9\d{9})$');

CREATE TABLE IF NOT EXISTS player
(
    id                  SERIAL           NOT NULL PRIMARY KEY,
    phone               phone            NOT NULL UNIQUE,
    name                TEXT             NOT NULL,
    nickname            TEXT             NOT NULL UNIQUE,
    birth_date          DATE             NOT NULL,
    rank                FLOAT            ,
    primary_position    SMALLINT         NOT NULL,
    secondary_position  SMALLINT         ,
    avatar              TEXT             UNIQUE,

    CONSTRAINT pk_primary_position FOREIGN KEY(primary_position) REFERENCES position(id),
    CONSTRAINT pk_secondary_position FOREIGN KEY(secondary_position) REFERENCES position(id)
);

CREATE INDEX idx_player ON player (phone);

INSERT INTO player(phone, name, nickname, birth_date, rank, primary_position, secondary_position, avatar)
VALUES
('+79522760148', 'Антон', 'AntonGongelev', '1993-09-25', 4.5, 1, 2, null),
('+79697326169', 'Глеб', 'LazarevGB', '1993-12-06', 4.5, 2, 4, null);
