with markets as (
    select *, from {{ source("external_source", "NYC_Farmers_Markets") }}
)

select distinct
    "Market Name" as market_name,
    "Accepts EBT" as accepts_ebt,
    "Distributes Health Bucks?" as distributes_health_bucks,
    "Street Address" as address,
    borough,
    latitude,
    longitude,
    (
        case
            when "Open Year-Round" = 'Yes' then TRUE
            when "Open Year-Round" = 'No' then FALSE
        end
    ) as open_year_round,
    ST_POINT(latitude, longitude) as point_geometry_wgs84,
    ST_TRANSFORM(point_geometry_wgs84, 'EPSG:4326', 'ESRI:102718') as geom,
from
    markets
