-- =============================================================
-- 05_lifecycle_segmentation.sql
-- Project: Subscriber Lifecycle Analytics
-- Description: Segments subscribers by tenure into lifecycle
--              stages and compares churn, satisfaction, and
--              revenue across each stage.
-- Author: Mena Melaku
-- =============================================================


SELECT

  -- Segment subscribers into lifecycle stages based on tenure
  CASE
    WHEN tenure_months <= 6   THEN '1. New (0-6 months)'
    WHEN tenure_months <= 12  THEN '2. Early (7-12 months)'
    WHEN tenure_months <= 24  THEN '3. Developing (13-24 months)'
    WHEN tenure_months <= 48  THEN '4. Established (25-48 months)'
    ELSE                           '5. Loyal (49+ months)'
  END                                           AS lifecycle_stage,

  -- Volume of subscribers in each stage
  COUNT(customer_id)                            AS total_subscribers,

  -- Churn rate per stage
  ROUND(COUNTIF(churn_label = TRUE) * 100.0
    / COUNT(customer_id), 2)                    AS churn_rate_pct,

  -- Average satisfaction per stage
  ROUND(AVG(satisfaction_score), 2)             AS avg_satisfaction,

  -- Average monthly charge per stage
  ROUND(AVG(monthly_charge), 2)                 AS avg_monthly_charge,

  -- Average CLTV per stage
  ROUND(AVG(cltv), 2)                           AS avg_cltv,

  -- Average tenure per stage
  ROUND(AVG(tenure_months), 1)                  AS avg_tenure_months

FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
GROUP BY lifecycle_stage
ORDER BY lifecycle_stage;