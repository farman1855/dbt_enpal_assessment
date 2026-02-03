{{
    config(
        materialized='view'
    )
}}

-- Sales Call 1 and Sales Call 2 - first occurrence
WITH activity_with_types AS (
    SELECT
        a.deal_id,
        a.activity_type_code,
        at.activity_type_id,
        at.activity_type_name,
        a.due_to
    FROM {{ ref('stg_activity') }} a
    LEFT JOIN {{ ref('stg_activity_types') }} at
        ON a.activity_type_code = at.activity_type_code
    WHERE at.activity_type_id IN (1, 2)
),

first_activity AS (
    SELECT
        deal_id,
        activity_type_id,
        activity_type_name,
        MIN(due_to) AS first_activity_time
    FROM activity_with_types
    WHERE due_to IS NOT NULL
    GROUP BY deal_id, activity_type_id, activity_type_name
)

SELECT
    deal_id,
    activity_type_id,
    activity_type_name,
    first_activity_time,
    DATE_TRUNC('month', first_activity_time) AS activity_month
FROM first_activity
