{{
    config(
        materialized='view'
    )
}}

-- cast stage_id to int
SELECT
    deal_id,
    change_time,
    changed_field_key,
    new_value,
    CASE 
        WHEN changed_field_key = 'stage_id' THEN CAST(new_value AS INTEGER)
        ELSE NULL
    END AS stage_id
FROM {{ source('postgres_public', 'deal_changes') }}
