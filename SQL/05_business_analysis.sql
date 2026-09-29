USE D2C_Beauty_Analytics;
GO

-- Q1: Overall business performance

SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold,
    SUM(final_amount) AS total_revenue,
    AVG(final_amount) AS average_order_value,
    CAST(
        SUM(CASE WHEN return_flag = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(order_id)
        AS DECIMAL(5,2)
    ) AS return_rate_percent
FROM orders;


-- Q2: How do monthly orders and revenue change over time?

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(final_amount) AS total_revenue
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;


-- Q3: Which acquisition channels generate the most orders and revenue?

SELECT
    acquisition_channel,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(final_amount) AS total_revenue,
    AVG(final_amount) AS average_order_value
FROM orders
GROUP BY acquisition_channel
ORDER BY total_revenue DESC;


-- Q4: Which customer tiers generate the most orders and revenue?

SELECT
    c.customer_tier,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    SUM(o.final_amount) AS total_revenue,
    AVG(o.final_amount) AS average_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_tier
ORDER BY total_revenue DESC;


-- Q5: Which product categories generate the most revenue?

SELECT
    p.product_category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.quantity) AS units_sold,
    SUM(o.final_amount) AS total_revenue,
    AVG(o.final_amount) AS average_order_value
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_category
ORDER BY total_revenue DESC;


-- Q6: Which product categories have the highest return rate?

SELECT
    p.product_category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(CASE WHEN o.return_flag = 1 THEN 1 ELSE 0 END) AS returned_orders,
    CAST(
        SUM(CASE WHEN o.return_flag = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(DISTINCT o.order_id)
        AS DECIMAL(5,2)
    ) AS return_rate_percent
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_category
ORDER BY return_rate_percent DESC;


-- Q7: Which customers generate the most revenue?

SELECT TOP 10
    c.customer_id,
    c.customer_name,
    c.customer_tier,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.final_amount) AS total_revenue,
    AVG(o.final_amount) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.customer_tier
ORDER BY total_revenue DESC;


-- Q8: What percentage of customers have made more than one purchase?

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    CAST(
        SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS repeat_purchase_rate
FROM customers;


-- Q9: How does customer status relate to orders and revenue?

SELECT
    c.customer_status,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    SUM(c.total_orders) AS total_orders,
    SUM(c.total_revenue) AS total_revenue,
    AVG(c.total_revenue) AS average_customer_revenue
FROM customers c
GROUP BY c.customer_status
ORDER BY total_revenue DESC;


-- Q10: What percentage of customers are classified as churned?

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Inactive' THEN 1 ELSE 0 END) AS churned_customers,
    CAST(
        SUM(CASE WHEN customer_status = 'Inactive' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS churn_rate_percent
FROM customers;


-- Q11: Which customer tiers have the highest churn rate?

SELECT
    customer_tier,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Inactive' THEN 1 ELSE 0 END) AS churned_customers,
    CAST(
        SUM(CASE WHEN customer_status = 'Inactive' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS churn_rate_percent
FROM customers
GROUP BY customer_tier
ORDER BY churn_rate_percent DESC;


-- Q12: Which acquisition channels have the highest customer churn?

SELECT
    acquisition_channel,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Inactive' THEN 1 ELSE 0 END) AS churned_customers,
    CAST(
        SUM(CASE WHEN customer_status = 'Inactive' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS churn_rate_percent
FROM customers
GROUP BY acquisition_channel
ORDER BY churn_rate_percent DESC;


-- Q13: Which customer tiers have the highest customer value?

SELECT
    customer_tier,
    COUNT(*) AS total_customers,
    AVG(total_orders) AS average_orders,
    AVG(total_revenue) AS average_customer_revenue,
    SUM(total_revenue) AS total_revenue
FROM customers
GROUP BY customer_tier
ORDER BY average_customer_revenue DESC;


-- Q14: Which customers have the most recent purchases?

SELECT TOP 10
    customer_id,
    customer_name,
    customer_tier,
    last_order_date,
    total_orders,
    total_revenue
FROM customers
ORDER BY last_order_date DESC;


-- Q15: How many days has it been since each customer's last purchase?

SELECT
    customer_id,
    customer_name,
    customer_tier,
    last_order_date,
    DATEDIFF(DAY, last_order_date, '2025-12-31') AS recency_days,
    total_orders,
    total_revenue
FROM customers
ORDER BY recency_days ASC;


-- Q16: How frequently does each customer purchase?

SELECT
    customer_id,
    customer_name,
    customer_tier,
    total_orders AS purchase_frequency,
    total_revenue
FROM customers
ORDER BY purchase_frequency DESC;


-- Q17: Which customers are both highly frequent and high-value?

SELECT TOP 10
    customer_id,
    customer_name,
    customer_tier,
    total_orders,
    total_revenue
FROM customers
ORDER BY
    total_orders DESC,
    total_revenue DESC;


-- Q18: Which acquisition channels bring the highest-value customers?

SELECT
    acquisition_channel,
    COUNT(*) AS total_customers,
    AVG(total_orders) AS average_orders,
    AVG(total_revenue) AS average_customer_revenue,
    SUM(total_revenue) AS total_revenue
FROM customers
GROUP BY acquisition_channel
ORDER BY average_customer_revenue DESC;


-- Q19: Which customers have the highest recency and may be at risk of churn?

SELECT TOP 20
    customer_id,
    customer_name,
    customer_tier,
    customer_status,
    last_order_date,
    DATEDIFF(DAY, last_order_date, '2025-12-31') AS recency_days,
    total_orders,
    total_revenue
FROM customers
ORDER BY recency_days DESC;


-- Q20: Which customers have the highest monetary value?

SELECT TOP 20
    customer_id,
    customer_name,
    customer_tier,
    total_orders,
    total_revenue AS monetary_value
FROM customers
ORDER BY monetary_value DESC;