# 🎓 Student Engagement & Conversion Analysis (SQL)

## 📌 Project Overview
This project analyzes student engagement data from the 365 Data Science platform to understand the funnel from **free registration to paid subscription**. By calculating key performance indicators (KPIs) such as conversion rates and lead times, this analysis provides actionable insights into user behavior and content effectiveness.

## 💼 Business Problem
The primary goal is to measure the effectiveness of the platform's free content in driving paid conversions. 
Key questions addressed:
- What percentage of students who watch free content eventually upgrade to a paid plan?
- How long does it take for a student to start learning after registration?
- What is the average "decision window" between the first lecture watched and the final purchase?

## 🛠️ Tech Stack & Methodology
- **Tool:** MySQL / PostgreSQL
- **Key Techniques:** - **CTEs (Common Table Expressions):** Used for modular and readable query design, separating data cleaning from final aggregation.
  - **Data Integrity:** Handled 1:N relationship issues (duplicate records) to ensure an accurate base of **20,255 unique engaged students**.
  - **Date Functions:** Calculated precise intervals between registration, engagement, and purchase dates.

## 📊 Key Findings (Insights)
| Metric | Result | Interpretation |
| **Conversion Rate** | **12.99%** | Strong initial content appeal; 1 in 8 engaged students converts. |
| **Avg. Reg to Watch** | **5.16 days** | Indicates onboarding efficiency and immediate user intent. |
| **Avg. Watch to Purchase** | **28.53 days** | Defines the "consideration period" for marketing re-targeting. |

> **Analyst's Note:** The 12.99% conversion rate is significantly above the industry average for EdTech, suggesting high-quality free content. However, the interval between first watch and purchase (28.53 days) suggests a window where targeted promotional offers could further accelerate conversion.

## 📂 Project Structure
- `scripts/student_engagement_analysis.sql`: Main SQL script containing data cleaning and KPI calculations.

## 👤 Author
- **James Han**
- *Background in CPA (Accounting & Audit) | Transitioning to Data Analytics*
- [LinkedIn Profile Link]
