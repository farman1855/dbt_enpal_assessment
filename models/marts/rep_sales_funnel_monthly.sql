{{
    config(
        materialized='table',
        schema='pipedrive_analytics'
    )
}}

-- monthly funnel report
WITH funnel_entries AS (
    SELECT
        fe.deal_id,
        fe.entry_date,
        fe.funnel_step,
        -- get stage name for stages, kpi_name for activities
        COALESCE(s.stage_name, fe.kpi_name) AS kpi_name
    FROM {{ ref('int_deal_funnel_entries') }} fe
    LEFT JOIN {{ ref('stg_stages') }} s
        ON fe.entry_type = 'Stage'
        AND fe.funnel_step = s.stage_id
)

SELECT
    entry_date AS month,
    kpi_name,
    funnel_step,
    COUNT(DISTINCT deal_id) AS deals_count
FROM funnel_entries
GROUP BY entry_date, kpi_name, funnel_step
ORDER BY month DESC, funnel_step ASC
