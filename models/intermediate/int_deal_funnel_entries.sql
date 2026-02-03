{{
    config(
        materialized='view'
    )
}}

-- combine stages and activities into one
WITH stage_entries AS (
    SELECT
        deal_id,
        stage_id AS funnel_step,
        entry_month AS entry_date,
        'Stage' AS entry_type,
        NULL AS kpi_name
    FROM {{ ref('int_deal_stage_transitions') }}
),

sales_call_1_entries AS (
    SELECT
        deal_id,
        2.1 AS funnel_step,
        activity_month AS entry_date,
        'Activity' AS entry_type,
        'Sales Call 1' AS kpi_name
    FROM {{ ref('int_deal_activities') }}
    WHERE activity_type_id = 1
),

sales_call_2_entries AS (
    SELECT
        deal_id,
        3.1 AS funnel_step,
        activity_month AS entry_date,
        'Activity' AS entry_type,
        'Sales Call 2' AS kpi_name
    FROM {{ ref('int_deal_activities') }}
    WHERE activity_type_id = 2
),

all_entries AS (
    SELECT * FROM stage_entries
    UNION ALL
    SELECT * FROM sales_call_1_entries
    UNION ALL
    SELECT * FROM sales_call_2_entries
)

SELECT
    deal_id,
    funnel_step,
    entry_date,
    entry_type,
    kpi_name
FROM all_entries
