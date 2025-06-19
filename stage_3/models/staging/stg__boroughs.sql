SELECT
  boroname as boro_name,
  borocode as boro_code,
  ST_Transform(geom, 'EPSG:4326', 'ESRI:102718', always_xy := true) as geom,
FROM {{ source("external_source", "Borough_Boundaries") }}
