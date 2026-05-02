-- =============================================================
-- 02_clean_data.sql
-- Project: Subscriber Lifecycle Analytics
-- Description: Data quality checks across subscribers,
--              subscriptions, and services tables
-- Author: Mena Melaku
-- =============================================================


-- -------------------------------------------------------------
-- SECTION 1: NULL CHECKS
-- Identify missing values in columns critical to analysis.
-- Nulls in these fields will distort KPIs and model outputs.
-- -------------------------------------------------------------

-- 1a. Null check: subscribers
SELECT
  COUNTIF(customer_id IS NULL)       AS null_customer_id,
  COUNTIF(tenure_months IS NULL)     AS null_tenure_months,
  COUNTIF(satisfaction_score IS NULL) AS null_satisfaction_score,
  COUNTIF(churn_label IS NULL)       AS null_churn_label,
  COUNTIF(cltv IS NULL)              AS null_cltv
FROM `subscriber-lifecycle-analytics.telco_churn.subscribers`;


-- 1b. Null check: subscriptions
SELECT
  COUNTIF(customer_id IS NULL)     AS null_customer_id,
  COUNTIF(monthly_charge IS NULL)  AS null_monthly_charge,
  COUNTIF(total_revenue IS NULL)   AS null_total_revenue,
  COUNTIF(contract_type IS NULL)   AS null_contract_type
FROM `subscriber-lifecycle-analytics.telco_churn.subscriptions`;


-- 1c. Null check: services
SELECT
  COUNTIF(customer_id IS NULL)      AS null_customer_id,
  COUNTIF(internet_service IS NULL) AS null_internet_service,
  COUNTIF(streaming_tv IS NULL)     AS null_streaming_tv
FROM `subscriber-lifecycle-analytics.telco_churn.services`;


-- -------------------------------------------------------------
-- SECTION 2: DUPLICATE CHECKS
-- Each customer_id should appear exactly once per table.
-- Duplicates inflate subscriber counts and distort all metrics.
-- -------------------------------------------------------------

-- 2a. Duplicate check: subscribers
SELECT
  customer_id,
  COUNT(*) AS row_count
FROM `subscriber-lifecycle-analytics.telco_churn.subscribers`
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 2b. Duplicate check: subscriptions
SELECT
  customer_id,
  COUNT(*) AS row_count
FROM `subscriber-lifecycle-analytics.telco_churn.subscriptions`
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 2c. Duplicate check: services
SELECT
  customer_id,
  COUNT(*) AS row_count
FROM `subscriber-lifecycle-analytics.telco_churn.services`
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- -------------------------------------------------------------
-- SECTION 3: CONSISTENCY CHECKS
-- Verify categorical columns contain only expected values.
-- Unexpected values indicate data entry issues or mapping errors.
-- -------------------------------------------------------------

-- 3a. Distinct values in churn_label
SELECT
  churn_label,
  COUNT(*) AS subscriber_count
FROM `subscriber-lifecycle-analytics.telco_churn.subscribers`
GROUP BY churn_label;


-- 3b. Distinct values in customer_status
SELECT
  customer_status,
  COUNT(*) AS subscriber_count
FROM `subscriber-lifecycle-analytics.telco_churn.subscribers`
GROUP BY customer_status;


-- 3c. Distinct values in contract_type
SELECT
  contract_type,
  COUNT(*) AS subscriber_count
FROM `subscriber-lifecycle-analytics.telco_churn.subscriptions`
GROUP BY contract_type;


-- 3d. Distinct values in internet_service
SELECT
  internet_service,
  COUNT(*) AS subscriber_count
FROM `subscriber-lifecycle-analytics.telco_churn.services`
GROUP BY internet_service;
