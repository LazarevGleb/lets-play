CREATE TABLE IF NOT EXISTS player
(
    id                 BIGSERIAL NOT NULL,
    phone              TEXT      NOT NULL,
    name               TEXT      NOT NULL,
    nickname           TEXT      NOT NULL,
    birth_date         DATE      NOT NULL,
    rank               REAL,
    primary_position   TEXT      NOT NULL,
    secondary_position TEXT,
    avatar             TEXT,

    CONSTRAINT pk_player_id PRIMARY KEY (id),
    CONSTRAINT uk_player_phone UNIQUE (phone),
    CONSTRAINT uk_player_nickname UNIQUE (nickname)
);

CREATE INDEX idx_player ON player (phone);

INSERT INTO player(phone, name, nickname, birth_date, rank, primary_position, secondary_position, avatar)
VALUES ('+79522760148', 'Антон', 'AntonGongelev', '1993-09-25', 4.5, 'FORWARD', 'HALFBACK', null),
       ('+79697326169', 'Глеб', 'LazarevGB', '1993-12-06', 4.5, 'HALFBACK', 'GOALKEEPER', null);
