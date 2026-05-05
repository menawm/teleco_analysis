## 1. Executive Summary

Subscription businesses live or die by retention. This report presents the findings of an end-to-end churn analysis of 7,043 IBM Telco subscribers — covering churn scale, cost, predictive modeling, and a prioritized retention strategy — built to answer one question: **where is revenue at risk, and what do we do about it?**

**The Problem**

| Metric | Value |
|---|---|
| Overall Churn Rate | **26.54%** — 1 in 4 subscribers lost |
| Total Revenue Base | **$21.37M** monthly |
| Critical + High Risk Exposure | **$144,796** monthly |
| Annualized Revenue at Risk | **$1.74 million** |


**What the Data Shows**

> **Contract type is the single strongest retention lever.**
Month-to-Month subscribers churn at 45.84%. Two Year subscribers churn at just 2.55% and generate nearly 3x the lifetime revenue.

> **The first six months are make or break.**
New subscribers churn at 53.33%. Subscribers who reach 49+ months churn at just 9.51%. The onboarding window is the highest-leverage moment in the lifecycle.

> **Churn is not random.**
45% of all churn is competitor-driven. Senior citizens, Mailed Check subscribers, and Month-to-Month subscribers are all losing at dramatically higher rates than the base.

**What the Model Does**

- Scores every subscriber with a **churn probability between 0 and 1**
- Routes subscribers into **four risk tiers**: Critical, High, Medium, Low
- Correctly identifies **4 out of 5 subscribers who will churn** (sensitivity: 82%)
- Flags **1,081 Critical subscribers** for immediate retention outreach [(For more insights please refer to the Appendix)](https://github.com/menawm/teleco_analysis/blob/main/appendix.md)

**What We Recommend**

| Priority | Action |
|---|---|
| 1 | **90-day onboarding program** to move new subscribers past the highest-risk window |
| 2 | **Contract upgrade incentives** to shift Month-to-Month subscribers to annual plans |
| 3 | **Senior citizen retention track** to close a churn gap generic programs aren't addressing |
| 4 | **Mailed Check migration campaign** to eliminate payment friction as a churn driver |
| 5 | **Online security as a default onboarding step** — the feature most correlated with retention |
| 6 | **CRM integration of churn scores** to trigger outreach at the 0.75 risk threshold |

**The Opportunity**

| Scenario | Subscribers Retained | Annual Revenue Recovered |
|---|---|---|
| Conservative (10%) | 240 | **$173,755** |
| Moderate (20%) | 481 | **$347,510** |
| Ambitious (30%) | 721 | **$521,265** |

The model has already identified who to reach. The remaining question is how quickly the business moves to act on it.

**2. Key Findings**

The analysis of 7,043 IBM Telco subscribers surfaces a clear story: churn is expensive, predictable, and — most importantly — preventable. The findings below are organized around the business questions that matter most.

**Churn Is Costing More Than It Should**

- **Overall churn rate: 26.54%** — more than four times the 5–7% benchmark for healthy subscription businesses
- The total revenue base across all subscribers is **$21.37 million**
- **1,081 subscribers** are classified as Critical risk, putting **$77,833 in monthly revenue** in immediate jeopardy
- **1,323 subscribers** are classified as High risk, representing an additional **$66,963 in monthly revenue** at risk
- **Combined monthly exposure: $144,796** — revenue the business could lose without a retention strategy in place

At this scale, churn isn't a customer service problem. It's a revenue problem.

**Contract Structure Is the Strongest Retention Lever**

| Contract Type | Churn Rate | Avg. Lifetime Revenue |
|---|---|---|
| Month-to-Month | 45.84% | $1,707 |
| One Year | 10.71% | — |
| Two Year | 2.55% | $4,799 |

No single factor separates churners from stayers more clearly than contract type. **Two Year subscribers churn at just 2.55%** and generate nearly **three times the lifetime revenue** of Month-to-Month subscribers. The predictive model confirms contract type as the **single strongest churn predictor in either direction** [(For more insights please refer to the Appendix)](https://github.com/menawm/teleco_analysis/blob/main/appendix.md)

Moving subscribers off monthly agreements isn't just a retention play — it's a lifetime value play.


**The First Six Months Are Make or Break**

- **New subscribers (0–6 months) churn at 53.33%**, with an average satisfaction score of just **2.79**
- **Loyal subscribers (49+ months) churn at only 9.51%**, with satisfaction averaging **3.52**
- Every lifecycle stage shows the same pattern: **as tenure grows, churn falls and satisfaction rises**

The data is unambiguous — subscribers who don't find value early don't stay. A strong onboarding experience isn't a nice-to-have; it's the foundation of long-term retention.


**Who Is Most at Risk**

- **Senior citizens churn at 41.7%** — nearly double the **23.6%** rate for non-seniors
- **Mailed Check subscribers churn at 36.9%** vs. just **14.5%** for Credit Card users — a friction signal worth addressing
- **45% of all churn is competitor-driven** — subscribers aren't passively drifting away, they're being actively poached
- **Online security is the strongest protective feature**: subscribers with it churn at **14.61%**, nearly half the overall average

The at-risk profile is specific enough to act on. These aren't random losses — they're identifiable subscribers leaving for identifiable reasons.

---
## 3. Model Impact & Implementation

The churn prediction model transforms raw subscriber data into a prioritized action list. This section explains how it works in practice — not as a technical exercise, but as an operational tool that tells the right teams who to call, email, or flag, and when.


**How the Model Works in Practice**

- Every subscriber receives a **churn probability score between 0 and 1** — the closer to 1, the more likely they are to leave [[(For more insights please refer to the Appendix)](https://github.com/menawm/teleco_analysis/blob/main/appendix.md)
- Scores are grouped into **four risk tiers** that map directly to business action:

| Risk Tier | Probability Range | Subscriber Count |
|---|---|---|
| Critical | ≥ 0.75 | 1,081 |
| High | 0.50 – 0.74 | 1,323 |
| Medium | 0.25 – 0.49 | 1,556 |
| Low | < 0.25 | 3,083 |

- The model correctly identifies **4 out of 5 subscribers who will churn** (sensitivity: 82%) [[(For more insights please refer to the Appendix)](https://github.com/menawm/teleco_analysis/blob/main/appendix.md)
- Scores can be exported and **refreshed as new subscriber data becomes available**, keeping the priority list current


**Who Acts on the Scores**

Each risk tier routes to a different team with a different playbook:

- **Critical (1,081 subscribers)** → Customer Success or Retention team: immediate personal outreach, priority support, and targeted save offers
- **High (1,323 subscribers)** → Marketing team: automated retention campaigns, contract upgrade incentives, and satisfaction surveys
- **Medium (1,556 subscribers)** → Product team: feature adoption nudges, onboarding improvements, and engagement monitoring
- **Low (3,083 subscribers)** → No intervention needed: monitor and maintain

This structure ensures retention resources go where they have the highest impact — not spread thin across the entire subscriber base.

**What Triggers an Intervention**

Three conditions automatically flag a subscriber for action:

- **Churn probability crosses 0.75** → immediate retention flag sent to the Customer Success team
- **Satisfaction score drops to 3 or below combined with a churn score above 0.60** → early warning flag for proactive outreach before the subscriber decides to leave
- **Month-to-Month subscriber passes 90 days without a contract upgrade** → targeted upgrade outreach trigger

These triggers shift the team from reactive to proactive — catching at-risk subscribers before they cancel, not after.


**How Often the Model Refreshes**

- The model is ideally **retrained monthly** on new subscriber data to stay current with shifting behavior patterns
- **Risk tier assignments update with each refresh**, so the retention team always works from a live priority list — not a snapshot from six months ago

---

## 4. Strategic Recommendations

The findings point to six high-impact actions. These are prioritized by business impact — starting with the interventions that address the largest revenue exposure and the most preventable churn.


**1. Launch a 90-Day Onboarding Retention Program**

New subscribers are the most vulnerable segment in the entire base. With a **53.33% churn rate in the first six months** and an average satisfaction score of just 2.79, the data makes clear that subscribers who don't find value early don't stay.

**Action:** Build a structured 90-day onboarding journey — welcome sequences, feature education, usage check-ins, and satisfaction touchpoints — designed to move new subscribers past the high-risk window.

**Expected impact:** Even a modest improvement in early-tenure retention compounds significantly over time, given that loyal subscribers (49+ months) generate dramatically higher lifetime value.


**2. Incentivize Contract Upgrades from Month-to-Month to Annual Plans**

Month-to-Month subscribers churn at **45.84%** — nearly 18x the rate of Two Year subscribers. They also generate less than half the lifetime revenue (**$1,707 vs. $4,799**).

**Action:** Offer targeted upgrade incentives — discounted first year, locked pricing, or added features — to Month-to-Month subscribers, particularly those approaching the 90-day mark without upgrading.

**Expected impact:** Shifting even a fraction of the Month-to-Month base to annual contracts would meaningfully reduce churn exposure and increase average lifetime revenue per subscriber.


**3. Build a Dedicated Senior Citizen Retention Program**

Senior citizens churn at **41.7%** — nearly double the 23.6% rate for non-seniors — suggesting unmet needs around usability, support, or value perception that generic retention programs aren't addressing.

**Action:** Develop a dedicated retention track for senior subscribers: simplified communication, dedicated support access, and offers tailored to their usage patterns and price sensitivity.

**Expected impact:** Closing even half the gap between senior and non-senior churn rates would retain a meaningful portion of a high-risk segment.


**4. Migrate Mailed Check Subscribers to Automated Payment**

Mailed Check subscribers churn at **36.9%** — more than double the 14.5% rate for Credit Card users. Payment friction is a churn driver that is entirely within the business's control to fix.

**Action:** Launch a proactive migration campaign offering incentives — a billing credit, a free month, or a service upgrade — to move Mailed Check subscribers onto automated payment methods.

**Expected impact:** Reducing payment friction is one of the lowest-cost, highest-return retention levers available, with a clear benchmark to beat.


**5. Prioritize Online Security Feature During Onboarding**

Subscribers with online security churn at **14.61%** — nearly half the overall average of 26.54%. This is the strongest protective feature in the dataset.

**Action:** Make online security adoption a default step in the onboarding flow rather than an optional add-on, and highlight it in upgrade and retention communications.

**Expected impact:** Wider adoption of the feature most correlated with retention has the potential to meaningfully shift churn rates across the subscriber base.


**6. Deploy the Churn Model to Trigger Proactive Retention Outreach**

The predictive model identifies at-risk subscribers before they cancel — but only creates value if it's connected to a real retention workflow.

**Action:** Integrate churn probability scores into the CRM so that any subscriber crossing the **0.75 threshold** automatically triggers a retention flag and routes to the appropriate team within 24–48 hours.

**Expected impact:** The model correctly identifies **4 out of 5 subscribers who will churn**. Operationalizing it turns a predictive insight into a revenue protection mechanism — and puts the **$144,796 in monthly Critical and High tier revenue** within reach of active intervention.

---

## 5. ROI & Cost Savings Estimate

The following projections are built entirely from numbers in this analysis. They answer a straightforward question: if the retention programs recommended in Section 4 reduce churn among Critical and High risk subscribers, what does that recovery look like in dollar terms?

**The Revenue at Stake**

- **Critical tier:** 1,081 subscribers, **$77,833 in monthly revenue** at risk
- **High tier:** 1,323 subscribers, **$66,963 in monthly revenue** at risk
- **Combined monthly exposure: $144,796**
- **Average customer lifetime value (CLTV): $4,400**
- **Average monthly charge: $64.76**

**Recovery Scenarios**

| Metric | Conservative (10%) | Moderate (20%) | Ambitious (30%) |
|---|---|---|---|
| Subscribers Retained | 240 | 481 | 721 |
| Monthly Revenue Recovered | $14,480 | $28,959 | $43,439 |
| Annual Revenue Recovered | $173,755 | $347,510 | $521,265 |

*Figures based on combined Critical and High tier monthly revenue exposure of $144,796.*


**What These Numbers Mean**

Even the **conservative scenario — retaining just 10% of at-risk subscribers — recovers $173,755 in annual revenue**. That's a meaningful return that in most businesses would exceed the cost of a targeted retention program many times over. The moderate scenario crosses **$347,000 annually**, and the ambitious scenario approaches **$522,000** — from a subscriber base that the model has already identified and prioritized.

These aren't projections built on assumptions about new customer acquisition. They represent revenue the business has already earned and is currently at risk of losing.


**The Cost of Inaction**

Without intervention, the business is currently exposed to **$144,796 in monthly revenue** from Critical and High risk subscribers alone. That's **$1.74 million in annualized revenue** sitting in the highest-risk tiers of the subscriber base — with no retention mechanism in place to protect it.

Every month without action is a month that exposure compounds. Subscribers who churn don't pause — they cancel, and winning them back costs significantly more than keeping them.

---

## 6. Assumptions & Limitations

Every analysis rests on a set of assumptions. Being transparent about them isn't a weakness — it's what separates rigorous analysis from overconfident forecasting. The findings in this report are robust, but the following boundaries are worth keeping in mind.


**What the Numbers Are Based On**

- **Monthly charge is used as a proxy for revenue per subscriber.** Actual revenue may differ based on discounts, promotional pricing, or bundled plans not captured in the dataset.
- **Churn probabilities assume subscriber behavior is relatively stable month to month.** Significant market shifts, pricing changes, or competitive moves could alter the risk landscape faster than a monthly model refresh would capture.

**What the Dataset Can and Can't Tell Us**

- **The dataset is geographically limited to California** and may not generalize to subscribers in other markets, where competitive dynamics, demographics, and price sensitivity may differ meaningfully.
- **satisfaction_score and total_charges were excluded from the predictive model for statistical reasons** — specifically multicollinearity and data leakage [See Technical Report]. Both variables show strong descriptive relationships with churn and are used throughout the analysis, but their absence from the model is a known limitation.


**What the ROI Estimates Assume**

- **Recovery projections assume intervention effectiveness.** The scenarios in Section 5 reflect what is mathematically recoverable — actual results depend on the quality, timing, and targeting of retention programs.
- A well-designed retention program can meet or exceed the moderate scenario. A poorly executed one may fall short of even the conservative estimate. **The model identifies who to reach. The retention strategy determines what happens next.**

---

## 7. What We Would Do With More Data

This analysis was built on a rich but bounded dataset. The findings are actionable as they stand — but the questions below represent the next layer of insight that would make the retention strategy sharper, faster, and more precise.


**Time-Series Subscriber Data**

The current dataset is a snapshot. With **longitudinal data tracking subscribers across multiple months**, the model could identify not just who is at risk today, but how churn risk evolves over the lifecycle — catching subscribers earlier in their drift toward cancellation and giving the retention team a longer runway to intervene.


**Content Engagement Data**

Knowing what a subscriber has access to is not the same as knowing what they actually use. **Content engagement data — what subscribers watch, how often, and for how long** — would allow the model to distinguish between deeply engaged subscribers and those who are paying but barely logging in. Low engagement is one of the strongest early signals of churn in streaming businesses, and it's entirely absent from this dataset.


**Win-Back Data**

**45% of churn in this dataset is competitor-driven.** Understanding what brought churned subscribers back — which offers worked, how long the gap was, what triggered re-subscription — would allow the business to build a data-informed win-back playbook rather than relying on intuition.


**Competitive Pricing Data**

The competitor-driven churn finding is significant but incomplete. Without visibility into **what competitors are charging, what they're offering, and where they're targeting**, it's difficult to know whether the solution is a pricing response, a product response, or a marketing response. Even basic competitive benchmarking data would sharpen the strategic recommendation considerably.


**A/B Test Results From Retention Interventions**

The recommendations in Section 4 are grounded in the data — but the only way to know what actually works is to test it. **Structured A/B test results from retention campaigns** — comparing outreach timing, offer types, communication channels, and messaging — would close the loop between prediction and outcome, and allow the model to improve with every intervention cycle.
