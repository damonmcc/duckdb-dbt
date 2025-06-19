WITH garden_info AS (
    SELECT *, FROM {{ source("external_source", "GreenThumb_Garden_Info") }}
)

SELECT DISTINCT
    parksid,
    gardenname,
    juris AS jurisdiction,
    borough,
    address,
    crossstreets AS cross_streets,
    zipcode,
    bbl,
    status,
    openhrssu,
    openhrsm,
    openhrstu,
    openhrsw,
    openhrsth,
    openhrsf,
    openhrssa,
    coundist,
    communityboard,
    nta,
    censustract AS census_tract,
    congressionaldist,
    assemblydist,
    statesenatedist,
    policeprecinct,
    lon AS longitude,
    lat AS latitude,
    ST_POINT(latitude, longitude) AS point_geometry_wgs84,
    ST_TRANSFORM(point_geometry_wgs84, 'EPSG:4326', 'ESRI:102718') AS geom,
FROM garden_info
