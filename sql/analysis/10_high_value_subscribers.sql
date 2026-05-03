-- =============================================================
-- 10_high_value_subscribers.sql
-- Project: Subscriber Lifecycle Analytics
-- Description: Uses CTEs to identify high value subscribers
--              who are at risk of churning. Combines revenue,
--              satisfaction, and tenure to build a priority
--              retention target list.
-- Author: Mena Melaku
-- =============================================================


-- -------------------------------------------------------------
-- CTE 1: Calculate each subscriber's value tier
-- based on CLTV relative to the overall average
-- -------------------------------------------------------------

WITH subscriber_value AS (
  SELECT
    customer_id,
    contract_type,
    monthly_charge,
    total_revenue,
    tenure_months,
    satisfaction_score,
    churn_label,
    churn_score,
    cltv,

    -- Flag subscribers above the average CLTV as high value
    AVG(cltv) OVER ()                           AS avg_cltv,

    CASE
      WHEN cltv >= AVG(cltv) OVER () * 1.5 THEN 'High Value'
      WHEN cltv >= AVG(cltv) OVER ()       THEN 'Above Average'
      ELSE                                       'Below Average'
    END                                         AS value_tier

  FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
),


-- -------------------------------------------------------------
-- CTE 2: Identify at-risk subscribers within each value tier
-- At risk = satisfaction score of 1 or 2, not yet churned
-- -------------------------------------------------------------

at_risk AS (
  SELECT
    customer_id,
    contract_type,
    monthly_charge,
    total_revenue,
    tenure_months,
    satisfaction_score,
    churn_score,
    cltv,
    value_tier,
    avg_cltv
  FROM subscriber_value
  WHERE satisfaction_score <= 3
    AND churn_label = FALSE
)


-- -------------------------------------------------------------
-- FINAL SELECT: Priority retention targets
-- High value subscribers who are unhappy but haven't left yet
-- -------------------------------------------------------------

SELECT
  customer_id,
  contract_type,
  value_tier,
  monthly_charge,
  cltv,
  satisfaction_score,
  churn_score,
  tenure_months,

  -- How much above or below average CLTV is this subscriber
  ROUND(cltv - avg_cltv, 2)                     AS cltv_vs_avg

FROM at_risk
ORDER BY value_tier, cltv DESC
LIMIT 20;