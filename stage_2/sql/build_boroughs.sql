LOAD spatial;
DROP TABLE IF EXISTS cleaned__boroughs;
CREATE TABLE cleaned__boroughs AS
SELECT
    boroname as boro_name,
    borocode as boro_code,
    ST_Transform(geom, 'EPSG:4326', 'ESRI:102718', always_xy := true) as geom,
  FROM
    borough_boundaries;