{{
    config(
        materialized='view'
    )
}}

-- first time deals enter each stage (using MIN)
WITH stage_changes AS (
    SELECT
        deal_id,
        change_time,
        stage_id
    FROM {{ ref('stg_deal_changes') }}
    WHERE changed_field_key = 'stage_id'
        AND stage_id IS NOT NULL
),

first_entry AS (
    SELECT
        deal_id,
        stage_id,
        MIN(change_time) AS first_entry_time
    FROM stage_changes
    GROUP BY deal_id, stage_id
)

SELECT
    deal_id,
    stage_id,
    first_entry_time,
    DATE_TRUNC('month', first_entry_time) AS entry_month
FROM first_entry
