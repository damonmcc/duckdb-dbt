SELECT
    boroname AS boro_name,
    borocode AS boro_code,
    ST_TRANSFORM(geom, 'EPSG:4326', 'ESRI:102718', always_xy := TRUE) AS geom,
FROM {{ source("external_source", "Borough_Boundaries") }}
