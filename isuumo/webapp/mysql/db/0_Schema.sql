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
    geo GEOMETRY AS (POINT(latitude, longitude)) STORED NOT NULL, 
    SPATIAL INDEX(geo),
    sort_key  BIGINT AS (popularity * (-100000) + id)  NOT NULL,
    rentrange   INTEGER AS (CASE WHEN rent < 50000 THEN 0 WHEN rent < 100000 THEN 1 WHEN rent < 150000 THEN 2 ELSE 3 END) NOT NULL,
    door_heightrange   INTEGER AS (CASE WHEN door_height < 80 THEN 0 WHEN door_height < 110 THEN 1 WHEN door_height < 150 THEN 2 ELSE 3 END) NOT NULL,
    door_widthrange   INTEGER AS (CASE WHEN door_width < 80 THEN 0 WHEN door_width < 110 THEN 1 WHEN door_width < 150 THEN 2 ELSE 3 END) NOT NULL,
    index idx_heightrange (door_heightrange , sort_key),
    index idx_widthrange (door_widthrange , sort_key),
    index idx_rentrange (rentrange , sort_key),
    index idx_rentrange_heightrange (rentrange, door_heightrange, door_widthrange),
    index idx_rentrange_widthrange (rentrange , door_widthrange),
    index idx_rent_id (rent, id),
    index idx_sort_key (sort_key)
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
    sort_key  BIGINT AS (popularity * (-100000) + id)  NOT NULL,
    pricerange   INTEGER AS (CASE WHEN price < 3000 THEN 0 WHEN price < 6000 THEN 1 WHEN price < 9000 THEN 2 WHEN price < 12000 THEN 3 WHEN price < 15000 THEN 4 ELSE 5 END),
    heightrange   INTEGER AS (CASE WHEN height < 80 THEN 0 WHEN height < 110 THEN 1 WHEN height < 150 THEN 2 ELSE 3 END),
    widthrange   INTEGER AS (CASE WHEN width < 80 THEN 0 WHEN width < 110 THEN 1 WHEN width < 150 THEN 2 ELSE 3 END),
    depthrange   INTEGER AS (CASE WHEN depth < 80 THEN 0 WHEN depth < 110 THEN 1 WHEN depth < 150 THEN 2 ELSE 3 END),
    index idx_pricerange (pricerange, stock),
    index idx_heightrange (heightrange, stock),
    index idx_widthrange (widthrange, stock),
    index idx_depthrange (depthrange, stock),
    index idx_kind (kind, stock),
    index idx_price_id (price, id),
    index idx_sort_key (sort_key)
);
