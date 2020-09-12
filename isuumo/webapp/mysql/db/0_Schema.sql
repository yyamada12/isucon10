DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL,
    rentrange   INTEGER AS (CASE WHEN rent < 50000 THEN 0 WHEN rent < 100000 THEN 1 WHEN rent < 150000 THEN 2 ELSE 3 END),
    door_heightrange   INTEGER AS (CASE WHEN door_height < 80 THEN 0 WHEN door_height < 110 THEN 1 WHEN door_height < 150 THEN 2 ELSE 3 END),
    door_widthrange   INTEGER AS (CASE WHEN door_width < 80 THEN 0 WHEN door_width < 110 THEN 1 WHEN door_width < 150 THEN 2 ELSE 3 END),
    index idx_heightrange (door_heightrange asc, popularity desc, id asc),
    index idx_widthrange (door_widthrange asc, popularity desc, id asc),
    index idx_rentrange (rentrange asc, popularity desc, id asc),
    index idx_lat (latitude)
);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL,
    pricerange   INTEGER AS (CASE WHEN price < 3000 THEN 0 WHEN price < 6000 THEN 1 WHEN price < 9000 THEN 2 WHEN price < 12000 THEN 3 WHEN price < 15000 THEN 4 ELSE 5 END),
    heightrange   INTEGER AS (CASE WHEN height < 80 THEN 0 WHEN height < 110 THEN 1 WHEN height < 150 THEN 2 ELSE 3 END),
    widthrange   INTEGER AS (CASE WHEN width < 80 THEN 0 WHEN width < 110 THEN 1 WHEN width < 150 THEN 2 ELSE 3 END),
    depthrange   INTEGER AS (CASE WHEN depth < 80 THEN 0 WHEN depth < 110 THEN 1 WHEN depth < 150 THEN 2 ELSE 3 END),
    index idx_pricerange (pricerange),
    index idx_heightrange (heightrange),
    index idx_widthrange (widthrange),
    index idx_depthrange (depthrange)
);
