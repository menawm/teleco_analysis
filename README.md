# Subscriber Lifecycle Churn Risk & Retention Analytics
![BigQuery](https://img.shields.io/badge/Google\_BigQuery-4285F4?style=flat&logo=googlebigquery&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-F46800?style=flat&logo=databricks&logoColor=white)
![R](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-1F3B4D?style=flat&logo=tableau&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-000000?style=flat&logo=github&logoColor=white)

An end-to-end subscriber lifecycle and churn analytics project built on the IBM Telco Customer Churn dataset (7,043 subscribers, 50 columns), spanning data engineering, SQL analytics, predictive modeling, and interactive visualization. Using Google BigQuery for cloud-scale data warehousing, SQL for modeling and segmentation, R for logistic regression churn prediction (AUC: 0.87), and Tableau for a live risk intelligence dashboard, this project mirrors the full analytics workflow used in modern DTC and streaming businesses — translating raw subscriber data into actionable retention strategy.

---

## Project Overview

This project answers a core business question: **which subscribers are most at risk of churning, and what can be done about it?** Starting from raw customer data, the pipeline moves through data modeling and cleaning in BigQuery, lifecycle segmentation and KPI development in SQL, predictive scoring in R, and finally an interactive Tableau dashboard that surfaces high-risk segments and revenue exposure in real time.

[**→ View Live Dashboard**](https://public.tableau.com/views/SubscriberChurnRiskIntelligenceLogisticRegressionBigQueryRTableau/SubscriberChurnRiskIntelligence?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) · 
[**→ Read the Business Insights Report**](https://github.com/menawm/teleco_analysis/blob/main/business_insights_report.md) · 
[**→ Read the Technical Appendix**](https://github.com/menawm/teleco_analysis/blob/main/appendix.md)

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| **Google BigQuery** | Cloud data warehouse, SQL execution environment |
| **SQL** | Data modeling, cleaning, segmentation, KPI development |
| **R / RStudio** | Logistic regression churn prediction model |
| **Tableau** | Interactive risk intelligence dashboard |

---

## Model Performance
- **AUC: 0.87** — strong discriminatory power between churners and retained subscribers
- **Sensitivity: 82%** — correctly identifies 82% of actual churners, prioritizing recall for retention targeting

---

## Key Findings
- Overall churn rate of **26.54%** — significantly above the 5–7% benchmark for subscription businesses
- New subscribers (0–6 months tenure) churn at **53.33%**, making early lifecycle the highest-risk window
- Two-year contract subscribers churn at just **2.55%** vs. **45.84%** for month-to-month plans
- **45% of churn is competitor-driven**, pointing to a pricing and feature differentiation gap
- Online security is the strongest protective product feature — subscribers with it churn at **14.61%**
- **1,081 subscribers** classified as critical churn risk, representing **$77,833 in monthly revenue at risk**

---

## Repository Structure
```
teleco_analysis/
├── sql/
│   ├── setup/
│   │   ├── 01_create_tables.sql
│   │   └── 03_master_view.sql
│   ├── cleaning/
│   │   └── 02_clean_data.sql
│   └── analysis/
│       ├── 04_kpi_summary.sql
│       ├── 05_lifecycle_segmentation.sql
│       ├── 06_content_engagement.sql
│       ├── 07_revenue_by_plan.sql
│       ├── 08_churn_analysis.sql
│       ├── 09_window_functions.sql
│       └── 10_high_value_subscribers.sql
├── r_studio/
    ├── teleco.Rproj
    ├── churn_model.R
    ├── churn_model.Rmd
    └── churn_model.html
```
---

## Dashboard Preview
*Dashboard screenshots will be added from the `images/` folder.*

---

## Author
**Mena Melaku**
[GitHub](https://github.com/menawm/teleco\_analysis)
