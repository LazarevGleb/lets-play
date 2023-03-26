CREATE TABLE IF NOT EXISTS event
(
    id           BIGSERIAL   NOT NULL,
    stadium_id   INT         NOT NULL,
    begin_at     TIMESTAMPTZ NOT NULL,
    is_finished  BOOLEAN     NOT NULL DEFAULT FALSE,
    is_cancelled BOOLEAN     NOT NULL DEFAULT FALSE,
    min_players  SMALLINT    NOT NULL DEFAULT 0,
    min_age      SMALLINT    NOT NULL DEFAULT 0,
    max_age      SMALLINT    NOT NULL DEFAULT 0,
    min_rank     REAL        NOT NULL DEFAULT 0,
    max_rank     REAL        NOT NULL DEFAULT 0,
    created_at   TIMESTAMPTZ NOT NULL,

    CONSTRAINT pk_event_id PRIMARY KEY (id),
    CONSTRAINT fk_event_stadium_id FOREIGN KEY (stadium_id) REFERENCES stadium (id)
);
