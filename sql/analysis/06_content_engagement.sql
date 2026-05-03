-- =============================================================
-- 06_content_engagement.sql
-- Project: Subscriber Lifecycle Analytics
-- Description: Analyzes how feature adoption correlates with
--              churn rate and satisfaction. Identifies which
--              features are most associated with retention.
-- Author: Mena Melaku
-- =============================================================


-- -------------------------------------------------------------
-- SECTION 1: Churn rate by number of features adopted
-- More features = deeper engagement = lower churn?
-- -------------------------------------------------------------

SELECT
  -- Count how many features each subscriber uses
  (CASE WHEN streaming_tv = TRUE THEN 1 ELSE 0 END +
   CASE WHEN streaming_movies = TRUE THEN 1 ELSE 0 END +
   CASE WHEN streaming_music = TRUE THEN 1 ELSE 0 END +
   CASE WHEN online_security = TRUE THEN 1 ELSE 0 END +
   CASE WHEN online_backup = TRUE THEN 1 ELSE 0 END +
   CASE WHEN device_protection = TRUE THEN 1 ELSE 0 END +
   CASE WHEN unlimited_data = TRUE THEN 1 ELSE 0 END)  AS features_adopted,

  COUNT(customer_id)                                    AS total_subscribers,

  ROUND(COUNTIF(churn_label = TRUE) * 100.0
    / COUNT(customer_id), 2)                            AS churn_rate_pct,

  ROUND(AVG(satisfaction_score), 2)                     AS avg_satisfaction

FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
GROUP BY features_adopted
ORDER BY features_adopted;


-- -------------------------------------------------------------
-- SECTION 2: Churn rate by individual feature
-- Which specific features are most associated with retention?
-- -------------------------------------------------------------

SELECT 'Streaming TV'      AS feature, 
  COUNT(customer_id)       AS total_subscribers,
  ROUND(COUNTIF(churn_label = TRUE) * 100.0 / COUNT(customer_id), 2) AS churn_rate_pct
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE streaming_tv = TRUE

UNION ALL

SELECT 'Streaming Movies'  AS feature,
  COUNT(customer_id)       AS total_subscribers,
  ROUND(COUNTIF(churn_label = TRUE) * 100.0 / COUNT(customer_id), 2) AS churn_rate_pct
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE streaming_movies = TRUE

UNION ALL

SELECT 'Streaming Music'   AS feature,
  COUNT(customer_id)       AS total_subscribers,
  ROUND(COUNTIF(churn_label = TRUE) * 100.0 / COUNT(customer_id), 2) AS churn_rate_pct
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE streaming_music = TRUE

UNION ALL

SELECT 'Online Security'   AS feature,
  COUNT(customer_id)       AS total_subscribers,
  ROUND(COUNTIF(churn_label = TRUE) * 100.0 / COUNT(customer_id), 2) AS churn_rate_pct
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE online_security = TRUE

UNION ALL

SELECT 'Online Backup'     AS feature,
  COUNT(customer_id)       AS total_subscribers,
  ROUND(COUNTIF(churn_label = TRUE) * 100.0 / COUNT(customer_id), 2) AS churn_rate_pct
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE online_backup = TRUE

UNION ALL

SELECT 'Device Protection' AS feature,
  COUNT(customer_id)       AS total_subscribers,
  ROUND(COUNTIF(churn_label = TRUE) * 100.0 / COUNT(customer_id), 2) AS churn_rate_pct
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE device_protection = TRUE

UNION ALL

SELECT 'Unlimited Data'    AS feature,
  COUNT(customer_id)       AS total_subscribers,
  ROUND(COUNTIF(churn_label = TRUE) * 100.0 / COUNT(customer_id), 2) AS churn_rate_pct
FROM `subscriber-lifecycle-analytics.telco_churn.master_subscribers`
WHERE unlimited_data = TRUE

ORDER BY churn_rate_pct;