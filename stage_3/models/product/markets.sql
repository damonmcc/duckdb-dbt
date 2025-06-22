SELECT market_name,
FROM {{ ref('stg__markets') }}
