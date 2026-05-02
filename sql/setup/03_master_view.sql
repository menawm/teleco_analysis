-- =============================================================
-- 03_master_view.sql
-- Project: Subscriber Lifecycle Analytics
-- Description: Master view joining subscribers, subscriptions,
--              and services into a single analytical layer.
--              All analysis queries should reference this view.
-- Author: Mena Melaku
-- =============================================================


CREATE OR REPLACE VIEW `subscriber-lifecycle-analytics.telco_churn.master_subscribers` AS
SELECT

  -- -------------------------
  -- SUBSCRIBER IDENTITY
  -- -------------------------
  s.customer_id,
  s.gender,
  s.age,
  s.senior_citizen,
  s.married,
  s.tenure_months,
  s.satisfaction_score,
  s.customer_status,
  s.churn_label,
  s.churn_score,
  s.cltv,
  s.churn_category,
  s.churn_reason,

  -- -------------------------
  -- SUBSCRIPTION & BILLING
  -- -------------------------
  sub.contract_type,
  sub.payment_method,
  sub.monthly_charge,
  sub.total_charges,
  sub.total_revenue,
  sub.total_refunds,
  sub.paperless_billing,

  -- -------------------------
  -- SERVICES & FEATURES
  -- -------------------------
  svc.phone_service,
  svc.internet_service,
  svc.internet_type,
  svc.streaming_tv,
  svc.streaming_movies,
  svc.streaming_music,
  svc.online_security,
  svc.online_backup,
  svc.device_protection,
  svc.unlimited_data

FROM `subscriber-lifecycle-analytics.telco_churn.subscribers` s
JOIN `subscriber-lifecycle-analytics.telco_churn.subscriptions` sub
  ON s.customer_id = sub.customer_id
JOIN `subscriber-lifecycle-analytics.telco_churn.services` svc
  ON s.customer_id = svc.customer_id;
