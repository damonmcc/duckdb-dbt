{{ config(materialized='external', location='../data/output/stage_3/farm_to_market.csv') }}
{{ config(materialized='external', location='../data/output/stage_3/farm_to_market.parquet') }}

WITH markets AS (SELECT *, FROM {{ ref('stg__markets') }}),

farms AS (SELECT *, FROM {{ ref('int__farms') }}),

nyc_markets AS (
    SELECT DISTINCT
        market_name,
        coordinates_in_nyc,
        point_geometry_wgs84,
    FROM markets
    WHERE coordinates_in_nyc
),

nyc_farms AS (
    SELECT DISTINCT
        farm_name,
        coordinates_in_nyc,
        point_geometry_wgs84,
    FROM farms
    WHERE coordinates_in_nyc
),

combined AS (
    SELECT
        nyc_markets.market_name,
        nyc_farms.farm_name,
        cast(floor(
            st_distance(
                st_transform(
                    nyc_markets.point_geometry_wgs84,
                    'EPSG:4326',
                    'ESRI:102718',
                    always_xy := TRUE
                ),
                st_transform(
                    nyc_farms.point_geometry_wgs84,
                    'EPSG:4326',
                    'ESRI:102718',
                    always_xy := TRUE
                )
            )
        ) AS INTEGER) AS distance_ft,
        st_makeline(
            nyc_markets.point_geometry_wgs84, nyc_farms.point_geometry_wgs84
        ) AS line_geometry_wgs84,
    FROM
        nyc_farms, nyc_markets
)

SELECT *, FROM combined
ORDER BY
    distance_ft ASC
