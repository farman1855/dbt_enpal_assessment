{{
    config(
        materialized='view'
    )
}}

SELECT
    activity_id,
    deal_id,
    type AS activity_type_code,
    assigned_to_user,
    done,
    due_to
FROM {{ source('postgres_public', 'activity') }}
