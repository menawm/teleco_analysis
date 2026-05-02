-- =============================================================
-- 01_create_tables.sql
-- Project: Subscriber Lifecycle Analytics
-- Description: Split raw_telco into normalized tables:
--              subscribers, subscriptions, and services
-- Author: Mena Melaku
-- =============================================================


-- -------------------------------------------------------------
-- TABLE 1: subscribers
-- Who is the customer? Identity, tenure, satisfaction, and churn outcome.
-- Core to any subscription business: understanding who stays and who leaves.
-- -------------------------------------------------------------

CREATE OR REPLACE TABLE `subscriber-lifecycle-analytics.telco_churn.subscribers` AS
SELECT
  `Customer ID`        AS customer_id,
  `Gender`             AS gender,
  `Age`                AS age,
  `Senior Citizen`     AS senior_citizen,
  `Married`            AS married,
  `Tenure in Months`   AS tenure_months,
  `Satisfaction Score` AS satisfaction_score,
  `Customer Status`    AS customer_status,
  `Churn Label`        AS churn_label,
  `Churn Score`        AS churn_score,
  `CLTV`               AS cltv,
  `Churn Category`     AS churn_category,
  `Churn Reason`       AS churn_reason
FROM `subscriber-lifecycle-analytics.telco_churn.raw_telco`;


-- -------------------------------------------------------------
-- TABLE 2: subscriptions
-- What is the billing relationship? Contract, payment method, and revenue.
-- -------------------------------------------------------------

CREATE OR REPLACE TABLE `subscriber-lifecycle-analytics.telco_churn.subscriptions` AS
SELECT
  `Customer ID`        AS customer_id,
  `Contract`           AS contract_type,
  `Payment Method`     AS payment_method,
  `Monthly Charge`     AS monthly_charge,
  `Total Charges`      AS total_charges,
  `Total Revenue`      AS total_revenue,
  `Total Refunds`      AS total_refunds,
  `Paperless Billing`  AS paperless_billing
FROM `subscriber-lifecycle-analytics.telco_churn.raw_telco`;


-- -------------------------------------------------------------
-- TABLE 3: services
-- Which features or products is the customer using?
-- Feature adoption and usage breadth are key churn predictors
-- across subscription models.
-- -------------------------------------------------------------

CREATE OR REPLACE TABLE `subscriber-lifecycle-analytics.telco_churn.services` AS
SELECT
  `Customer ID`             AS customer_id,
  `Phone Service`           AS phone_service,
  `Internet Service`        AS internet_service,
  `Internet Type`           AS internet_type,
  `Streaming TV`            AS streaming_tv,
  `Streaming Movies`        AS streaming_movies,
  `Streaming Music`         AS streaming_music,
  `Online Security`         AS online_security,
  `Online Backup`           AS online_backup,
  `Device Protection Plan`  AS device_protection,
  `Unlimited Data`          AS unlimited_data
FROM `subscriber-lifecycle-analytics.telco_churn.raw_telco`;