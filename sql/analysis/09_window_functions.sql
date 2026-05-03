-- =============================================================
-- 09_window_functions.sql
-- Project: Subscriber Lifecycle Analytics
-- Description: Uses window functions to rank and compare
--              subscribers within segments. Demonstrates
--              advanced SQL techniques for relative analysis.
-- Author: Mena Melaku
-- =============================================================


-- -------------------------------------------------------------
-- SECTION 1: Rank subscribers by revenue within contract type
-- Who are the highest value subscribers in each plan?
-- -------------------------------------------------------------

SELECT
  customer_id,
  contract_type,
  monthly_charge,
  total_revenue,
  tenure_months,
  churn_label,

  -- Rank each subscriber by revenue within their contract type
  RANK() OVER (
    PARTITION BY contract_type
    ORDER BY total_revenue DESC
  )                                             AS revenue_rank_in_plan,

  -- Percentile position within their contract type
  ROUND(PERCENT_RANK() OVER (
    PARTITION BY contract_type
    ORDER BY total_revenue DESC
  ) * 100, 1)                                  AS revenue_percentile

FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
QUALIFY revenue_rank_in_plan <= 5;


-- -------------------------------------------------------------
-- SECTION 2: Compare each subscriber's charge to their
-- contract type average
-- Are high-paying subscribers more or less likely to churn?
-- -------------------------------------------------------------

SELECT
  customer_id,
  contract_type,
  monthly_charge,
  churn_label,
  satisfaction_score,

  -- Average monthly charge for their contract type
  ROUND(AVG(monthly_charge) OVER (
    PARTITION BY contract_type
  ), 2)                                         AS avg_charge_in_plan,

  -- How much above or below average is this subscriber
  ROUND(monthly_charge - AVG(monthly_charge) OVER (
    PARTITION BY contract_type
  ), 2)                                         AS charge_vs_plan_avg

FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
ORDER BY contract_type, charge_vs_plan_avg DESC
LIMIT 20;