# GlowNest — D2C Beauty & Customer Analytics

## Project Overview

**From Growth to Profitability: A Data-Driven Analysis of India's Beauty & Cosmetics Industry**

This portfolio project analyses a synthetic D2C beauty brand, **GlowNest**, to understand how customer behaviour, retention, marketing efficiency, product performance and unit economics influence sustainable growth.

The project is designed around a core business question:

> **Why are customers churning, which customers are most valuable, where are they dropping off, and what actions can improve retention and revenue?**

The broader business case uses India's beauty and cosmetics industry as the context, with SUGAR Cosmetics as a case-study reference. **GlowNest data is synthetic and is not actual SUGAR customer, sales or financial data.**

---

## Business Problem

Rapid revenue growth does not automatically translate into sustainable profitability. A D2C beauty business can face high acquisition costs, weak repeat purchasing, discount pressure, returns, marketplace costs and operational expenses.

This project investigates:

- Customer retention and churn
- Repeat purchase behaviour
- Customer segmentation and RFM analysis
- Customer value / LTV
- Marketing spend, CAC and ROAS
- Purchase-funnel performance
- Product and category performance
- Return rates
- Contribution-margin economics
- Revenue concentration across leading products

---

## Objectives

1. Measure overall sales and customer performance.
2. Identify high-value and at-risk customer segments.
3. Analyse repeat purchase and churn behaviour.
4. Understand customer cohort retention.
5. Evaluate acquisition-channel and marketing efficiency.
6. Identify top-performing product categories and products.
7. Analyse the purchase funnel and conversion.
8. Connect growth metrics with profitability-oriented measures.

---

## Dataset

The project uses five relational synthetic datasets covering **2024–2025**:

| Table | Rows | Purpose |
|---|---:|---|
| Customers | 2,000 | Customer profile, acquisition, status, tier and lifetime metrics |
| Orders | 5,315 | Transaction-level sales, discounts, returns and variable costs |
| Products | 20 | Product category, pricing, COGS and product attributes |
| Marketing Campaigns | 150 | Campaign spend, reach, conversions, new customers and reported revenue |
| Customer Funnel | 11,157 | Website-to-purchase customer journey events |

### Key relationships

- `customers.customer_id` → `orders.customer_id`
- `products.product_id` → `orders.product_id`
- `customers.customer_id` → `customer_funnel.customer_id`
- `marketing_campaigns.campaign_id` → `customer_funnel.campaign_id`

The SQL validation workflow checks for orphan records across these relationships.

---

## Data Preparation

### Excel / Power Query

The Excel workflow was used for data preparation and quality checks, including:

- Importing CSV files
- Correcting data types
- Date parsing
- Missing-value handling
- Standardising categorical fields
- Duplicate checks
- Numeric range validation
- Business-logic checks
- Preparing clean datasets for analysis and database loading

### SQL Server

Cleaned data was loaded into a relational SQL Server database:

`D2C_Beauty_Analytics`

The SQL workflow is organised into:

1. Database creation
2. Table creation
3. Data loading
4. Data validation
5. Business analysis
6. Customer analytics

---

## SQL Analysis

The final SQL work contains **37 analytical questions** covering:

### Sales & Revenue
- Overall performance
- Monthly revenue and orders
- Acquisition-channel performance
- Customer-tier performance
- Category revenue
- Product returns
- Top customers

### Customer Analytics
- Repeat purchase rate
- Churn rate
- Customer status
- Customer frequency
- Customer monetary value
- Recency analysis
- Acquisition-channel value

### RFM Analysis
- RFM scoring
- RFM segmentation
- Segment size
- Segment revenue
- Average customer value
- Segment-level churn

### Cohort Analysis
- Cohort assignment
- Cohort size
- Monthly activity
- Retention rates
- Post-acquisition active-customer patterns

### Purchase Journey
- Purchase frequency distribution
- Purchase conversion
- Repeat-purchase conversion
- Churn by purchase frequency
- Churn by preferred channel and customer tier

---

## Power BI Dashboard

The final Power BI report contains **five pages**.

### 1. Executive Overview

Focus:
- Total Revenue
- Total Orders
- Average Order Value
- Contribution Margin %
- Customer Status
- Monthly Revenue Growth

### 2. Customer Segmentation & Value

Focus:
- Total Customers
- Repeat Customers
- Repeat Purchase Rate
- Average Customer Value
- RFM customer distribution
- Revenue by RFM segment
- Average customer revenue
- RFM churn
- Revenue by customer tier

### 3. Customer Retention & Cohort Analysis

Focus:
- Overall Churn Rate
- Inactive Customers
- Cohort Retention Analysis
- Repeat Purchase Rate by Customer Tier
- Churn Rate by Customer Tier

### 4. Customer Journey / Funnel Analysis

Focus:
- CAC
- ROAS
- Funnel Conversion Rate
- Marketing Spend
- Customer Journey Funnel
- Conversion Rate by Acquisition Channel
- Orders by Acquisition Channel

### 5. Product & Sales Performance

Focus:
- Revenue by Product Category
- Units Sold by Product Category
- Return Rate by Product Category
- Top 10 Products — Revenue Concentration (Pareto analysis)

---

## Key Results

The current synthetic dataset produces the following portfolio-level results:

| Metric | Result |
|---|---:|
| Customers | 2,000 |
| Orders | 5,315 |
| Units Sold | 7,399 |
| Order Revenue | ~₹3.09M |
| Average Order Value | ₹580.75 |
| Return Rate | 5.16% |
| Repeat Customers | 1,115 |
| Repeat Purchase Rate | 55.75% |
| Inactive Customers | 349 |
| Churn Rate | 17.45% |
| Marketing Spend | ~₹4.50M |
| CAC | ₹45.75 |
| ROAS | 37.73 |
| Funnel Conversion Rate | 22.68% |

### Selected analytical observations

- Revenue accelerates strongly through 2025, with monthly revenue reaching approximately **₹0.52M in December 2025**.
- **Skincare** is the largest category, generating approximately **₹1.70M revenue** and **3,853 units sold**.
- The top five products account for approximately **64% of the revenue generated by the Top 10 products**, indicating concentration among leading products.
- **Champions** have the highest average customer revenue within the current RFM output, while **Lost Customers** show the highest churn rate.
- Repeat-purchase rates are relatively close across customer tiers, while churn is higher for Regular and Value customers than for Premium customers.
- The funnel reports a **22.68% conversion rate**, with meaningful drop-off across the journey from visit to purchase.
- Acquisition channels show different patterns in conversion and order volume, demonstrating why channel performance should not be assessed using a single metric.

---

## Business Implications

The analysis points toward several areas for management attention:

### Retention
A meaningful inactive/customer-churn population creates an opportunity to improve repeat purchasing and reactivate high-value customers.

### Customer Value
RFM analysis helps separate high-value customers from customers requiring re-engagement and retention efforts.

### Marketing Efficiency
CAC and ROAS provide a way to evaluate acquisition efficiency alongside conversion and order volume.

### Product Concentration
A large share of Top-10 revenue comes from the leading products, creating both a strength and a concentration risk.

### Product Returns
Category-level return rates help identify areas where product experience, customer expectations or fulfilment may require deeper investigation.

### Funnel Optimisation
The customer journey shows where potential customers are lost between browsing and purchase, providing a basis for conversion optimisation.

---

## Important Data & Metric Notes

- All transactional and customer data in this portfolio project is **synthetic**.
- The synthetic data is intended for analytical demonstration and portfolio use.
- SUGAR Cosmetics is used for **business-case context**, not as the source of the customer or transaction data.
- Marketing metrics use the **campaign-level marketing dataset** (`spend`, `new_customers`, `revenue_generated`). They should be interpreted separately from the order-revenue series unless the two datasets are explicitly reconciled.
- Contribution margin and customer-value/LTV measures are modelled from the available transactional and customer fields in Power BI.

---

## Tools & Technologies

- **Excel**
- **Power Query**
- **SQL Server / T-SQL**
- **Power BI**
- DAX measures
- Relational data modelling
- RFM analysis
- Cohort analysis
- Funnel analysis
- Pareto analysis

---

## Project Structure

```text
GlowNest-D2C-Beauty-Analytics/
│
├── README.md
│
├── Excel/
│   ├── Clean_Dataset/
│   └── Dataset/
│
├── PowerBI/
│   └── GlowNest_Beauty_Customer_Analytics.pbix
│
└── SQL/
    ├── 01_create_database.sql
    ├── 02_create_tables.sql
    ├── 03_data_loading.sql
    ├── 04_data_validation.sql
    ├── 05_business_analysis.sql
    └── 06_customer_analytics.sql
```

---

## What This Project Demonstrates

This project demonstrates an end-to-end analytics workflow:

**Raw Data → Data Cleaning → Data Validation → Relational SQL Database → SQL Analysis → Customer Analytics → Power BI Data Modelling → Dashboard → Business Insights**

The objective is not only to report revenue, but to connect **growth, customer behaviour, marketing efficiency and profitability-oriented metrics** into one decision-support analysis.

---

## Disclaimer

This is a **portfolio analytics project using synthetic data**. The figures, customer records, transactions and campaign results are simulated for analytical demonstration and should not be treated as actual company financial or customer data.
