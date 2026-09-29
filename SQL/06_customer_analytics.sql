USE D2C_Beauty_Analytics;
GO


-- Q21: How can we assign RFM scores to every customer?

WITH RFM_Base AS
(
    SELECT
        customer_id,
        customer_name,
        customer_tier,
        DATEDIFF(DAY, last_order_date, '2025-12-31') AS recency_days,
        total_orders AS frequency,
        total_revenue AS monetary_value
    FROM customers
),
RFM_Scored AS
(
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value ASC) AS monetary_score
    FROM RFM_Base
)
SELECT
    customer_id,
    customer_name,
    customer_tier,
    recency_days,
    frequency,
    monetary_value,
    recency_score,
    frequency_score,
    monetary_score,
    CONCAT(recency_score, frequency_score, monetary_score) AS rfm_score
FROM RFM_Scored
ORDER BY rfm_score DESC;


-- Q22: Which RFM segments contain the most valuable customers?

WITH RFM_Base AS (
    SELECT
        customer_id,
        customer_name,
        customer_tier,
        DATEDIFF(DAY, last_order_date, '2025-12-31') AS recency_days,
        total_orders AS frequency,
        total_revenue AS monetary_value
    FROM customers
),

RFM_Scored AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value ASC) AS monetary_score
    FROM RFM_Base
)

SELECT
    customer_id,
    customer_name,
    customer_tier,
    recency_days,
    frequency,
    monetary_value,
    recency_score,
    frequency_score,
    monetary_score,
    CASE
        WHEN recency_score = 5
             AND frequency_score = 5
             AND monetary_score = 5
            THEN 'Champions'

        WHEN recency_score >= 4
             AND frequency_score >= 4
            THEN 'Loyal Customers'

        WHEN recency_score >= 4
             AND frequency_score <= 3
            THEN 'Potential Loyalists'

        WHEN recency_score <= 2
             AND frequency_score >= 4
            THEN 'At Risk'

        WHEN recency_score <= 2
             AND frequency_score <= 2
            THEN 'Lost Customers'

        ELSE 'Needs Attention'
    END AS rfm_segment

FROM RFM_Scored
ORDER BY monetary_value DESC;


-- Q23: How many customers fall into each RFM segment?

WITH RFM_Base AS (
    SELECT
        customer_id,
        DATEDIFF(DAY, last_order_date, '2025-12-31') AS recency_days,
        total_orders AS frequency,
        total_revenue AS monetary_value
    FROM customers
),

RFM_Scored AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value ASC) AS monetary_score
    FROM RFM_Base
),

RFM_Segmented AS (
    SELECT
        *,
        CASE
            WHEN recency_score = 5
                 AND frequency_score = 5
                 AND monetary_score = 5
                THEN 'Champions'

            WHEN recency_score >= 4
                 AND frequency_score >= 4
                THEN 'Loyal Customers'

            WHEN recency_score >= 4
                 AND frequency_score <= 3
                THEN 'Potential Loyalists'

            WHEN recency_score <= 2
                 AND frequency_score >= 4
                THEN 'At Risk'

            WHEN recency_score <= 2
                 AND frequency_score <= 2
                THEN 'Lost Customers'

            ELSE 'Needs Attention'
        END AS rfm_segment
    FROM RFM_Scored
)

SELECT
    rfm_segment,
    COUNT(*) AS total_customers
FROM RFM_Segmented
GROUP BY rfm_segment
ORDER BY total_customers DESC;


-- Q24: Which RFM segments generate the most revenue?

WITH RFM_Base AS (
    SELECT
        customer_id,
        DATEDIFF(DAY, last_order_date, '2025-12-31') AS recency_days,
        total_orders AS frequency,
        total_revenue AS monetary_value
    FROM customers
),

RFM_Scored AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value ASC) AS monetary_score
    FROM RFM_Base
),

RFM_Segmented AS (
    SELECT
        *,
        CASE
            WHEN recency_score = 5
                 AND frequency_score = 5
                 AND monetary_score = 5
                THEN 'Champions'

            WHEN recency_score >= 4
                 AND frequency_score >= 4
                THEN 'Loyal Customers'

            WHEN recency_score >= 4
                 AND frequency_score <= 3
                THEN 'Potential Loyalists'

            WHEN recency_score <= 2
                 AND frequency_score >= 4
                THEN 'At Risk'

            WHEN recency_score <= 2
                 AND frequency_score <= 2
                THEN 'Lost Customers'

            ELSE 'Needs Attention'
        END AS rfm_segment
    FROM RFM_Scored
)

SELECT
    rfm_segment,
    COUNT(*) AS total_customers,
    SUM(monetary_value) AS total_revenue,
    AVG(monetary_value) AS average_customer_revenue
FROM RFM_Segmented
GROUP BY rfm_segment
ORDER BY total_revenue DESC;


-- Q25: Which RFM segments have the highest average customer value?

WITH RFM_Base AS (
    SELECT
        customer_id,
        DATEDIFF(DAY, last_order_date, '2025-12-31') AS recency_days,
        total_orders AS frequency,
        total_revenue AS monetary_value
    FROM customers
),

RFM_Scored AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value ASC) AS monetary_score
    FROM RFM_Base
),

RFM_Segmented AS (
    SELECT
        *,
        CASE
            WHEN recency_score = 5
                 AND frequency_score = 5
                 AND monetary_score = 5
                THEN 'Champions'

            WHEN recency_score >= 4
                 AND frequency_score >= 4
                THEN 'Loyal Customers'

            WHEN recency_score >= 4
                 AND frequency_score <= 3
                THEN 'Potential Loyalists'

            WHEN recency_score <= 2
                 AND frequency_score >= 4
                THEN 'At Risk'

            WHEN recency_score <= 2
                 AND frequency_score <= 2
                THEN 'Lost Customers'

            ELSE 'Needs Attention'
        END AS rfm_segment
    FROM RFM_Scored
)

SELECT
    rfm_segment,
    COUNT(*) AS total_customers,
    AVG(monetary_value) AS average_customer_value
FROM RFM_Segmented
GROUP BY rfm_segment
ORDER BY average_customer_value DESC;


-- Q26: What is each customer's first-purchase cohort month?

SELECT
    customer_id,
    DATEFROMPARTS(
        YEAR(first_order_date),
        MONTH(first_order_date),
        1
    ) AS cohort_month
FROM customers
ORDER BY cohort_month, customer_id;


-- Q27: How many customers belong to each monthly cohort?

SELECT
    DATEFROMPARTS(
        YEAR(first_order_date),
        MONTH(first_order_date),
        1
    ) AS cohort_month,
    COUNT(*) AS cohort_customers
FROM customers
GROUP BY
    DATEFROMPARTS(
        YEAR(first_order_date),
        MONTH(first_order_date),
        1
    )
ORDER BY cohort_month;


-- Q28: How does customer retention change by cohort month?

WITH Customer_Cohorts AS (
    SELECT
        customer_id,
        DATEFROMPARTS(
            YEAR(first_order_date),
            MONTH(first_order_date),
            1
        ) AS cohort_month
    FROM customers
),

Customer_Activity AS (
    SELECT
        c.customer_id,
        c.cohort_month,
        DATEFROMPARTS(
            YEAR(o.order_date),
            MONTH(o.order_date),
            1
        ) AS order_month
    FROM Customer_Cohorts c
    JOIN orders o
        ON c.customer_id = o.customer_id
)

SELECT
    cohort_month,
    order_month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM Customer_Activity
GROUP BY
    cohort_month,
    order_month
ORDER BY
    cohort_month,
    order_month;


-- Q29: What is the customer retention rate for each cohort?

WITH Customer_Cohorts AS (
    SELECT
        customer_id,
        DATEFROMPARTS(
            YEAR(first_order_date),
            MONTH(first_order_date),
            1
        ) AS cohort_month
    FROM customers
),

Cohort_Size AS (
    SELECT
        cohort_month,
        COUNT(*) AS cohort_customers
    FROM Customer_Cohorts
    GROUP BY cohort_month
),

Customer_Activity AS (
    SELECT DISTINCT
        c.customer_id,
        c.cohort_month,
        DATEFROMPARTS(
            YEAR(o.order_date),
            MONTH(o.order_date),
            1
        ) AS order_month
    FROM Customer_Cohorts c
    JOIN orders o
        ON c.customer_id = o.customer_id
),

Retention AS (
    SELECT
        a.cohort_month,
        a.order_month,
        COUNT(DISTINCT a.customer_id) AS active_customers,
        s.cohort_customers
    FROM Customer_Activity a
    JOIN Cohort_Size s
        ON a.cohort_month = s.cohort_month
    GROUP BY
        a.cohort_month,
        a.order_month,
        s.cohort_customers
)

SELECT
    cohort_month,
    order_month,
    active_customers,
    cohort_customers,
    CAST(
        active_customers * 100.0 / cohort_customers
        AS DECIMAL(5,2)
    ) AS retention_rate_percent
FROM Retention
ORDER BY
    cohort_month,
    order_month;


-- Q30: Which cohorts have the highest number of active customers after acquisition?

WITH Customer_Cohorts AS (
    SELECT
        customer_id,
        DATEFROMPARTS(
            YEAR(first_order_date),
            MONTH(first_order_date),
            1
        ) AS cohort_month
    FROM customers
),

Customer_Activity AS (
    SELECT DISTINCT
        c.customer_id,
        c.cohort_month,
        DATEFROMPARTS(
            YEAR(o.order_date),
            MONTH(o.order_date),
            1
        ) AS order_month
    FROM Customer_Cohorts c
    JOIN orders o
        ON c.customer_id = o.customer_id
),

Cohort_Retention AS (
    SELECT
        cohort_month,
        order_month,
        COUNT(DISTINCT customer_id) AS active_customers
    FROM Customer_Activity
    GROUP BY cohort_month, order_month
)

SELECT
    cohort_month,
    MAX(
        CASE
            WHEN order_month > cohort_month
            THEN active_customers
        END
    ) AS highest_active_customers
FROM Cohort_Retention
GROUP BY cohort_month
ORDER BY highest_active_customers DESC;


-- Q31: Customer purchase funnel

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN total_orders >= 1 THEN 1 ELSE 0 END) AS customers_with_purchase,
    SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers
FROM customers;


-- Q32: Customer purchase funnel conversion rates

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN total_orders >= 1 THEN 1 ELSE 0 END) AS customers_with_purchase,
    SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers,

    CAST(
        SUM(CASE WHEN total_orders >= 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS purchase_conversion_rate,

    CAST(
        SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) * 100.0
        / SUM(CASE WHEN total_orders >= 1 THEN 1 ELSE 0 END)
        AS DECIMAL(5,2)
    ) AS repeat_purchase_rate

FROM customers;


-- Q33: How are customers distributed by purchase frequency?

SELECT
    total_orders AS purchase_frequency,
    COUNT(*) AS customer_count,
    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER()
        AS DECIMAL(5,2)
    ) AS customer_percentage
FROM customers
GROUP BY total_orders
ORDER BY total_orders;


-- Q34: How does revenue vary by purchase frequency?

SELECT
    total_orders AS purchase_frequency,
    COUNT(*) AS customer_count,
    SUM(total_revenue) AS total_revenue,
    AVG(total_revenue) AS average_customer_revenue
FROM customers
GROUP BY total_orders
ORDER BY total_orders;


-- Q35: How does churn vary by purchase frequency?

SELECT
    total_orders AS purchase_frequency,
    COUNT(*) AS customer_count,
    SUM(
        CASE
            WHEN customer_status = 'Inactive'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    CAST(
        SUM(
            CASE
                WHEN customer_status = 'Inactive'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS churn_rate_percent
FROM customers
GROUP BY total_orders
ORDER BY total_orders;


-- Q36: Which preferred channels have the highest churn?

SELECT
    preferred_channel,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN customer_status = 'Inactive'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    CAST(
        SUM(
            CASE
                WHEN customer_status = 'Inactive'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS churn_rate_percent
FROM customers
GROUP BY preferred_channel
ORDER BY churn_rate_percent DESC;


-- Q37: How does churn vary by customer tier and preferred channel?

SELECT
    customer_tier,
    preferred_channel,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN customer_status = 'Inactive'
            THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    CAST(
        SUM(
            CASE
                WHEN customer_status = 'Inactive'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS churn_rate_percent
FROM customers
GROUP BY
    customer_tier,
    preferred_channel
ORDER BY churn_rate_percent DESC;