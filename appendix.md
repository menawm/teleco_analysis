## 1. Project Overview

**Author:** Mena Melaku
**Project:** Subscriber Churn Prediction Model
**Tools:** Google BigQuery (SQL) · R (Logistic Regression) · Tableau


Subscriber churn is among the most consequential challenges facing subscription-based businesses. Each churned subscriber represents not only immediate revenue loss but compounding lifetime value erosion — a dynamic that becomes especially costly at scale. This project builds an end-to-end churn prediction system modeled on the analytical workflows used by lifecycle and retention analytics teams across the streaming and subscription industry.

Using the IBM Telco Customer Churn dataset, surfaced via Google BigQuery (`subscriber-lifecycle-analytics.telco_churn.master_subscribers`), this analysis spans 7,043 subscriber records and covers behavioral, contractual, and demographic attributes. The core deliverable is a logistic regression model trained to estimate each subscriber's probability of churn, which is then used to segment the subscriber base into four risk tiers — **Critical**, **High**, **Medium**, and **Low** — and quantify the monthly revenue exposure within each tier.

### Primary Objectives

- Identify the strongest behavioral and contractual predictors of churn
- Produce calibrated, subscriber-level churn probabilities
- Translate model output into actionable risk segments tied to revenue at risk
- Surface findings through Tableau dashboards designed for non-technical stakeholders

This project demonstrates an end-to-end analytics workflow: rigorous methodology, disciplined feature engineering, and insights framed around business impact rather than model mechanics alone.

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Risk%20Tier%20Breakdown.png" width="700"/>
  <br>
  <em>Figure 1 — Subscriber risk tier distribution across the full 7,043-subscriber base.</em>
</p>

---

## 2. Data & Methodology

**2.1 Data Source**

The dataset used in this analysis is the IBM Telco Customer Churn dataset, queried directly from Google BigQuery at `subscriber-lifecycle-analytics.telco_churn.master_subscribers`. It contains **7,043 subscriber records** across 33 variables, including demographic attributes, account characteristics, service subscriptions, and a binary churn label.

https://www.kaggle.com/datasets/yeanzc/telco-customer-churn-ibm-dataset


**2.2 Feature Engineering & Variable Selection**

Prior to modeling, several variables were removed to address structural data issues that would otherwise compromise model stability:

- **`total_charges`**: removed due to high multicollinearity with `tenure_months` (Pearson r = 0.83). Retaining both variables would inflate standard errors and destabilize coefficient estimates.
- **`satisfaction_score`**: removed due to complete separation: the variable perfectly predicted churn in a subset of cases, producing an unstable standard error of 583.92.
- **`internet_service`**: removed due to singularity with `internet_type`; the Fiber Optic level returned `NA` coefficients, indicating redundancy between the two variables.

Remaining numeric variables — including `tenure_months` and `monthly_charge` — were **scaled to mean = 0** to improve numerical stability and ensure coefficients are interpretable on a comparable scale.

Reference levels were set intentionally to reflect the lowest-risk baseline for each categorical variable:

| Variable | Reference Level |
|---|---|
| `contract_type` | Month-to-Month |
| `payment_method` | Credit Card |
| `online_security` | None |


**2.3 Model Specification**

A **logistic regression model** was selected for its interpretability and suitability for binary classification in a business context. Logistic regression produces well-calibrated probabilities and allows stakeholders to understand the directional impact of each predictor — a meaningful advantage over black-box alternatives when findings must be communicated to non-technical audiences.

The dataset was split **80/20** into training and test sets using `set.seed(42)` for reproducibility. To address the class imbalance (73% non-churn / 27% churn), **inverse-frequency class weights** were applied during training, ensuring the model does not systematically underpredict the minority (churn) class.

```r
model <- glm(churn_label ~ .,
             data    = train_data,
             family  = binomial,
             weights = weights)
```

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/lr%20model.png" width="400" height="600"/>
  <br>
  <em>Figure — Logistic regression model output.</em>
</p>

**2.4 Risk Tier Segmentation**

Predicted churn probabilities from the model were used to segment all 7,043 subscribers into four risk tiers:

| Tier | Probability Threshold | Subscribers |
|---|---|---|
| **Critical** | ≥ 0.75 | 1,081 |
| **High** | 0.50 – 0.74 | 1,323 |
| **Medium** | 0.25 – 0.49 | 1,556 |
| **Low** | < 0.25 | 3,083 |

Monthly revenue at risk was calculated for each tier by aggregating the `monthly_charge` values of subscribers within that segment.

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Churn%20Probability%20Distribution.png" width="700"/>
  <br>
  <em>Figure — Distribution of predicted churn probabilities across all 7,043 subscribers.</em>
</p>

---

## 3. Model Performance

The model was evaluated on the held-out test set (20% of the full dataset, n = 1,407). Performance was assessed across four metrics: accuracy, AUC, sensitivity, and specificity. Given the business context — where failing to identify an at-risk subscriber carries a higher cost than a false alarm — **sensitivity was prioritized** as the primary optimization target.


**3.1 Performance Summary**

| Metric | Value |
|---|---|
| **Accuracy** | 75.2% |
| **AUC** | 0.8719 |
| **Sensitivity (Recall)** | 82.0% |
| **Specificity** | 72.7% |

An **AUC of 0.8719** indicates strong discriminative ability — the model correctly ranks a randomly selected churner above a randomly selected non-churner ~87% of the time. This is well above the 0.5 baseline and reflects meaningful signal in the selected features.

**Sensitivity of 82%** means the model correctly flags 4 out of 5 subscribers who will churn, making it well-suited for proactive retention workflows where catching at-risk subscribers early is the priority.


**3.2 Confusion Matrix**

|  | **Predicted: No Churn** | **Predicted: Churn** |
|---|---|---|
| **Actual: No Churn** | 752 (TN) | 67 (FP) |
| **Actual: Churn** | 282 (FN) | 306 (TP) |

- **306 true positives** — churners correctly identified and eligible for intervention
- **67 false positives** — non-churners flagged unnecessarily; low operational cost
- **282 false negatives** — churners missed by the model; the primary area for future improvement

The asymmetry between false positives and false negatives reflects the deliberate weighting strategy: the model trades some specificity to recover more true churners, consistent with the retention-first objective.


**3.3 ROC Curve**

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/ROC%20Curve%20.png" width="700"/>
  <br>
  <em>Figure — ROC curve demonstrating model discriminative ability (AUC = 0.8719).</em>
</p>


The ROC curve confirms strong model performance across all classification thresholds, with the curve sitting well above the diagonal no-skill baseline. The selected operating threshold balances sensitivity and specificity in line with the business objective.

---
## 4. Key Findings

**4.1 Model Coefficients & Top Predictors**

The logistic regression coefficients quantify the direction and magnitude of each variable's relationship with churn probability, holding all other variables constant. The table below highlights the most influential predictors.

| Predictor | Log-Odds Coefficient | Direction |
|---|---|---|
| `contract_typeTwo Year` | -2.70 | ↓ Reduces churn |
| `contract_typeOne Year` | -1.41 | ↓ Reduces churn |
| `phone_serviceTRUE` | -1.38 | ↓ Reduces churn |
| `online_securityTRUE` | -0.68 | ↓ Reduces churn |
| `monthly_charge` | +1.47 | ↑ Increases churn |
| `payment_methodMailed Check` | +1.09 | ↑ Increases churn |
| `senior_citizenTRUE` | +0.71 | ↑ Increases churn |

**Contract type is the single strongest predictor of churn** — in either direction. Subscribers on two-year contracts are dramatically less likely to churn than the Month-to-Month baseline, while higher monthly charges and friction-prone payment methods meaningfully elevate risk.

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/lr%20top%20predictors%20of%20churn.png" width="700"/>
  <br>
  <em>Figure — Top predictors of churn by log-odds coefficient magnitude.</em>
</p>

**4.2 Churn by Contract Type**

Month-to-Month subscribers churn at a rate of **45.8%** — more than 18x the rate of Two Year subscribers at **2.5%**. This gap is the most operationally significant finding in the analysis: contract structure is not merely correlated with retention, it is its strongest lever.

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Churn%20by%20Contract.png" width="700"/>
  <br>
  <em>Figure — Churn rate by contract type: Month-to-Month (45.8%) vs. Two Year (2.5%).</em>
</p>


**4.3 Churn by Payment Method**

Subscribers paying by **Mailed Check churn at 36.9%**, compared to **14.5%** for Credit Card users. This likely reflects a combination of lower engagement and higher payment friction — both indicators of shallow product commitment. Automated payment methods correlate with stronger retention across the board.

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Churn%20by%20Payment%20Method.png" width="700"/>
  <br>
  <em>Figure — Churn rate by payment method: Mailed Check (36.9%) vs. Credit Card (14.5%).</em>
</p>


**4.4 Churn by Senior Citizen Status**

Senior citizens churn at **41.7%** versus **23.6%** for non-seniors, a gap of 18 percentage points. This segment warrants dedicated retention attention, whether through simplified user experience, targeted support, or tailored plan structures.

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Churn%20by%20Senior%20Citizen.png" width="700"/>
  <br>
  <em>Figure — Churn rate by senior citizen status: Senior (41.7%) vs. Non-Senior (23.6%).</em>
</p>

**4.5 Gender Shows No Meaningful Difference**

Gender was not a meaningful predictor of churn. Churn rates are nearly identical across male and female subscribers, suggesting that retention strategies should not be segmented by gender and that resources are better directed toward contract type, payment behavior, and demographic risk factors.

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Churn%20by%20Gender.png" width="700"/>
  <br>
  <em>Figure — Churn rate by gender, showing no meaningful difference between male and female subscribers.</em>
</p>

**4.6 Revenue at Risk by Risk Tier**

Aggregating monthly charges across risk tiers reveals the financial exposure concentrated in the top two segments:

| Tier | Subscribers | Monthly Revenue at Risk |
|---|---|---|
| **Critical** | 1,081 | $77,833 |
| **High** | 1,323 | $66,963 |
| **Medium** | 1,556 | — |
| **Low** | 3,083 | — |

**$144,796 in monthly recurring revenue** is at elevated risk across the Critical and High tiers alone, making these segments the clear priority for any retention intervention.

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Revenue%20at%20Risk.png" width="700"/>
  <br>
  <em>Figure — Monthly revenue at risk by subscriber risk tier.</em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Lifetime%20Value%20at%20Risk.png" width="700"/>
  <br>
  <em>Figure — Estimated lifetime value at risk across Critical and High risk tiers.</em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Intervention%20Priority.png" width="700"/>
  <br>
  <em>Figure — Intervention priority matrix mapping risk tier to revenue exposure.</em>
</p>

---

## 5. Limitations

No model is without constraints. The following limitations are documented transparently to contextualize the findings and inform future iterations of this work.

**5.1 Excluded Variables**

**`satisfaction_score`** was removed from the model due to complete separation — a condition where the variable perfectly predicts the outcome for a subset of observations, producing numerically unstable coefficient estimates (SE = 583.92). While satisfaction is likely one of the most predictive signals available in a real-world churn context, its exclusion here was necessary to preserve model integrity. Future work could explore regularization techniques such as Firth's penalized likelihood regression, which is designed to handle complete separation without discarding the variable entirely.


**5.2 Geographic Scope**

The dataset is **geographically limited to California**. Churn dynamics — including the influence of contract norms, competitive alternatives, and demographic composition — vary meaningfully across markets. Findings should not be generalized to a national or global subscriber base without revalidation on broader data.

<p align="center">
  <img src="https://raw.githubusercontent.com/menawm/teleco_analysis/main/assets/Churn%20by%20City.png" width="700"/>
  <br>
  <em>Figure — Churn rate by city, highlighting the geographic concentration of the dataset within California.</em>
</p>


**5.3 Linearity Assumption**

Logistic regression assumes a **linear relationship between each predictor and the log-odds of churn**. This assumption may not hold for all variables in this dataset — particularly continuous features like `tenure_months` and `monthly_charge`, where the true relationship with churn could be non-linear. Ensemble methods such as gradient boosting or random forest models would relax this assumption and may improve predictive performance, at the cost of interpretability.


**5.4 Static Snapshot**

This model is trained on a **static cross-sectional dataset** and does not account for how subscriber behavior evolves over time. In practice, churn risk is dynamic — a subscriber's likelihood of churning may shift in response to content releases, price changes, or competitive events. A production-grade lifecycle model would incorporate time-series features and be retrained on a rolling basis to remain calibrated to current subscriber behavior.


**5.5 Dataset Origin**

The IBM Telco Customer Churn dataset is a **publicly available benchmark dataset** originally designed for telecommunications, not streaming or media. While it provides a rigorous foundation for demonstrating end-to-end analytical methodology, the variables and churn patterns it contains may not fully reflect the dynamics of a modern SVOD subscriber base. Results should be interpreted in that context.

