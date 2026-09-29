USE D2C_Beauty_Analytics;
GO

-- Orders ? Customers

SELECT COUNT(*) AS orphan_orders
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- Orders ? Products

SELECT COUNT(*) AS orphan_products
FROM orders o
LEFT JOIN products p
    ON o.product_id = p.product_id
WHERE p.product_id IS NULL;


-- Funnel ? Customers

SELECT COUNT(*) AS orphan_funnel_customers
FROM customer_funnel f
LEFT JOIN customers c
    ON f.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- Funnel ? Campaigns

SELECT COUNT(*) AS orphan_campaigns
FROM customer_funnel f
LEFT JOIN marketing_campaigns m
    ON f.campaign_id = m.campaign_id
WHERE f.campaign_id IS NOT NULL
  AND m.campaign_id IS NULL;


-- Optional cleanup of staging/import tables

DROP TABLE customers_import;
DROP TABLE products_import;
DROP TABLE orders_import;
DROP TABLE marketing_campaigns_import;
DROP TABLE customer_funnel_import;
GO