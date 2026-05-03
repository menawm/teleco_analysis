-- =============================================================
-- 08_churn_analysis.sql
-- Project: Subscriber Lifecycle Analytics
-- Description: Analyzes why subscribers leave by examining
--              churn categories, reasons, and the relationship
--              between satisfaction and churn behavior.
-- Author: Mena Melaku
-- =============================================================


-- -------------------------------------------------------------
-- SECTION 1: Churn volume and rate by category
-- What are the broad reasons subscribers are leaving?
-- -------------------------------------------------------------

SELECT
  churn_category,
  COUNT(customer_id)                            AS churned_subscribers,
  ROUND(COUNT(customer_id) * 100.0
    / SUM(COUNT(customer_id)) OVER (), 2)       AS pct_of_total_churn
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE churn_label = TRUE
GROUP BY churn_category
ORDER BY churned_subscribers DESC;


-- -------------------------------------------------------------
-- SECTION 2: Top specific churn reasons
-- What exactly are subscribers saying when they leave?
-- -------------------------------------------------------------

SELECT
  churn_reason,
  churn_category,
  COUNT(customer_id)                            AS churned_subscribers,
  ROUND(AVG(satisfaction_score), 2)             AS avg_satisfaction,
  ROUND(AVG(monthly_charge), 2)                 AS avg_monthly_charge,
  ROUND(AVG(tenure_months), 1)                  AS avg_tenure_months
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE churn_label = TRUE
GROUP BY churn_reason, churn_category
ORDER BY churned_subscribers DESC
LIMIT 10;


-- -------------------------------------------------------------
-- SECTION 3: Satisfaction score distribution among churned
-- Were churned subscribers unhappy before they left?
-- -------------------------------------------------------------

SELECT
  satisfaction_score,
  COUNT(customer_id)                            AS churned_subscribers,
  ROUND(COUNT(customer_id) * 100.0
    / SUM(COUNT(customer_id)) OVER (), 2)       AS pct_of_churned
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE churn_label = TRUE
GROUP BY satisfaction_score
ORDER BY satisfaction_score;