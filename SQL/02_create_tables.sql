USE D2C_Beauty_Analytics;
GO

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    age INT,
    gender VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    customer_tier VARCHAR(20),
    acquisition_channel VARCHAR(50),
    acquisition_campaign VARCHAR(100),
    first_order_date DATE,
    customer_status VARCHAR(20),
    preferred_channel VARCHAR(50),
    preferred_product_category VARCHAR(50),
    last_order_date DATE,
    total_orders INT,
    total_revenue DECIMAL(12,2)
);
GO

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    product_category VARCHAR(50),
    sub_category VARCHAR(50),
    brand VARCHAR(50),
    selling_price DECIMAL(10,2),
    COGS DECIMAL(10,2),
    manufacturing_city VARCHAR(50),
    size VARCHAR(30),
    SKU VARCHAR(50),
    color VARCHAR(50),
    launch_date DATE,
    product_tier VARCHAR(20)
);
GO

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    shipping_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    discount_amount DECIMAL(10,2),
    final_amount DECIMAL(10,2),
    channel VARCHAR(50),
    acquisition_channel VARCHAR(50),
    payment_method VARCHAR(50),
    order_status VARCHAR(20),
    city VARCHAR(50),
    return_flag INT,
    return_reason VARCHAR(100),
    shipping_cost DECIMAL(10,2),
    marketplace_commission DECIMAL(10,2),
    fulfillment_cost DECIMAL(10,2)
);
GO

CREATE TABLE marketing_campaigns (
    campaign_id INT PRIMARY KEY,
    campaign_date DATE,
    campaign_name VARCHAR(100),
    marketing_channel VARCHAR(50),
    campaign_type VARCHAR(50),
    target_segment VARCHAR(50),
    spend DECIMAL(12,2),
    impressions INT,
    clicks INT,
    website_visits INT,
    add_to_cart INT,
    conversions INT,
    new_customers INT,
    revenue_generated DECIMAL(12,2)
);
GO

CREATE TABLE customer_funnel (
    event_id INT PRIMARY KEY,
    customer_id INT,
    event_date DATE,
    session_id VARCHAR(100),
    channel VARCHAR(50),
    device VARCHAR(30),
    funnel_stage VARCHAR(50),
    product_category VARCHAR(50),
    campaign_id INT
);
GO