WITH garden_info AS (
    SELECT *, FROM {{ ref('stg__garden_info') }}
),

garden_block_lot AS (
    SELECT *, FROM {{ ref('stg__garden_block_lot') }}
),

boroughs AS (
    SELECT *, FROM {{ ref('stg__boroughs') }}
),

all_garden_details AS (
    SELECT
        garden_info.* EXCLUDE (garden_info.gardenname),
        garden_block_lot.* EXCLUDE (garden_block_lot.parksid),
        garden_info.gardenname AS farm_name,
    FROM
        garden_info
    LEFT JOIN garden_block_lot
        ON garden_info.parksid = garden_block_lot.parksid
),

garden_geometry AS (
    SELECT
        all_garden_details.*,
        ST_TRANSFORM(
            ST_POINT(all_garden_details.latitude, all_garden_details.longitude),
            'EPSG:4326',
            'ESRI:102718'
        ) AS geom,
    FROM
        all_garden_details
),

resolved_geometry AS (
    SELECT
        garden_geometry.* EXCLUDE (borough, geom),
        boroughs.boro_name AS borough,
        (
            COALESCE(boroughs.geom IS NOT NULL, FALSE)
        ) AS coordinates_in_nyc,
        (
            CASE
                WHEN coordinates_in_nyc THEN garden_geometry.geom
            END
        ) AS geom,
    FROM
        garden_geometry
    LEFT JOIN boroughs
        ON ST_INTERSECTS(garden_geometry.geom, boroughs.geom)
)

SELECT *, FROM resolved_geometry
