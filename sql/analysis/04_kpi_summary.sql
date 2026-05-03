-- =============================================================
-- 04_kpi_summary.sql
-- Project: Subscriber Lifecycle Analytics
-- Description: Headline KPIs giving a snapshot of overall
--              subscriber base health and business performance.
-- Author: Mena Melaku
-- =============================================================


SELECT

  -- Total subscriber base
  COUNT(customer_id)                                    AS total_subscribers,

  -- Churn rate: percentage of subscribers who have left
  ROUND(COUNTIF(churn_label = TRUE) * 100.0
    / COUNT(customer_id), 2)                            AS churn_rate_pct,

  -- Average time a subscriber stays before churning or being measured
  ROUND(AVG(tenure_months), 1)                          AS avg_tenure_months,

  -- Average monthly charge across all subscribers
  ROUND(AVG(monthly_charge), 2)                         AS avg_monthly_charge,

  -- Average satisfaction score across all subscribers
  ROUND(AVG(satisfaction_score), 2)                     AS avg_satisfaction_score,

  -- Average customer lifetime value
  ROUND(AVG(cltv), 2)                                   AS avg_cltv,

  -- Total revenue generated across all subscribers
  ROUND(SUM(total_revenue), 2)                          AS total_revenue

FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`;