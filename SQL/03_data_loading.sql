USE D2C_Beauty_Analytics;
GO

-- Load Customers

INSERT INTO customers (
    customer_id,
    customer_name,
    age,
    gender,
    city,
    state,
    customer_tier,
    acquisition_channel,
    acquisition_campaign,
    first_order_date,
    customer_status,
    preferred_channel,
    preferred_product_category,
    last_order_date,
    total_orders,
    total_revenue
)
SELECT
    customer_id,
    customer_name,
    age,
    gender,
    city,
    state,
    customer_tier,
    acquisition_channel,
    acquisition_campaign,
    first_order_date,
    customer_status,
    preferred_channel,
    preferred_product_category,
    last_order_date,
    total_orders,
    total_revenue
FROM customers_import;


-- Load Products

INSERT INTO products (
    product_id,
    product_name,
    product_category,
    sub_category,
    brand,
    selling_price,
    COGS,
    manufacturing_city,
    size,
    SKU,
    color,
    launch_date,
    product_tier
)
SELECT
    product_id,
    product_name,
    product_category,
    sub_category,
    brand,
    selling_price,
    COGS,
    manufacturing_city,
    size,
    SKU,
    color,
    launch_date,
    product_tier
FROM products_import;


-- Load Orders

INSERT INTO orders (
    order_id,
    customer_id,
    product_id,
    order_date,
    shipping_date,
    quantity,
    unit_price,
    discount_percent,
    discount_amount,
    final_amount,
    channel,
    acquisition_channel,
    payment_method,
    order_status,
    city,
    return_flag,
    return_reason,
    shipping_cost,
    marketplace_commission,
    fulfillment_cost
)
SELECT
    order_id,
    customer_id,
    product_id,
    order_date,
    shipping_date,
    quantity,
    unit_price,
    discount_percent,
    discount_amount,
    final_amount,
    channel,
    acquisition_channel,
    payment_method,
    order_status,
    city,
    return_flag,
    return_reason,
    shipping_cost,
    marketplace_commission,
    fulfillment_cost
FROM orders_import;


-- Load Marketing Campaigns

INSERT INTO marketing_campaigns (
    campaign_id,
    campaign_date,
    campaign_name,
    marketing_channel,
    campaign_type,
    target_segment,
    spend,
    impressions,
    clicks,
    website_visits,
    add_to_cart,
    conversions,
    new_customers,
    revenue_generated
)
SELECT
    campaign_id,
    campaign_date,
    campaign_name,
    marketing_channel,
    campaign_type,
    target_segment,
    spend,
    impressions,
    clicks,
    website_visits,
    add_to_cart,
    conversions,
    new_customers,
    revenue_generated
FROM marketing_campaigns_import;


-- Load Customer Funnel

INSERT INTO customer_funnel (
    event_id,
    customer_id,
    event_date,
    session_id,
    channel,
    device,
    funnel_stage,
    product_category,
    campaign_id
)
SELECT
    event_id,
    customer_id,
    event_date,
    session_id,
    channel,
    device,
    funnel_stage,
    product_category,
    campaign_id
FROM customer_funnel_import;


-- Row Count Validation

SELECT COUNT(*) AS row_count
FROM customers;

SELECT COUNT(*) AS row_count
FROM products;

SELECT COUNT(*) AS row_count
FROM orders;

SELECT COUNT(*) AS row_count
FROM marketing_campaigns;

SELECT COUNT(*) AS row_count
FROM customer_funnel;