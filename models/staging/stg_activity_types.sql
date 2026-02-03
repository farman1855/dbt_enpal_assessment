{{
    config(
        materialized='view'
    )
}}

-- activity types lookup
SELECT
    id AS activity_type_id,
    name AS activity_type_name,
    type AS activity_type_code,
    active
FROM {{ source('postgres_public', 'activity_types') }}
