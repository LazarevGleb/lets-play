CREATE TABLE IF NOT EXISTS player_event
(
    id        BIGSERIAL NOT NULL,
    player_id BIGINT    NOT NULL,
    event_id  BIGINT    NOT NULL,
    with_ball BOOLEAN   NOT NULL DEFAULT FALSE,

    CONSTRAINT pk_player_event PRIMARY KEY (id),
    CONSTRAINT fk_player_event_player_id FOREIGN KEY (player_id) REFERENCES player (id),
    CONSTRAINT fk_player_event_event_id FOREIGN KEY (event_id) REFERENCES event (id),
    CONSTRAINT uk_player_event_player_id_event_id UNIQUE (player_id, event_id)
);
