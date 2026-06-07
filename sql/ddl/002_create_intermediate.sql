CREATE SCHEMA IF NOT EXISTS intermediate;

CREATE TABLE IF NOT EXISTS intermediate.int_customers (
    customer_id TEXT NOT NULL PRIMARY KEY,
    customer_unique_id TEXT NOT NULL,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT,
    loaded_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intermediate.int_order_items (
    order_id TEXT NOT NULL,
    order_item_id INTEGER NOT NULL,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price NUMERIC(12,2),
    freight_value NUMERIC(12,2),
    loaded_at TIMESTAMP,
    PRIMARY KEY (order_id,order_item_id)
);

CREATE TABLE IF NOT EXISTS intermediate.int_order_payments (
    order_id TEXT NOT NULL,
    payment_sequential INTEGER NOT NULL,
    payment_type TEXT,
    payment_installments INTEGER,
    payment_value NUMERIC(12,2),
    loaded_at TIMESTAMP,
    PRIMARY KEY (order_id,payment_sequential)
);

CREATE TABLE IF NOT EXISTS intermediate.int_order_reviews (
    review_id TEXT NOT NULL,
    order_id TEXT NOT NULL,
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    loaded_at TIMESTAMP,
    PRIMARY KEY (review_id,order_id)
);

CREATE TABLE IF NOT EXISTS intermediate.int_orders (
    order_id TEXT NOT NULL PRIMARY KEY,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    loaded_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intermediate.int_products (
    product_id TEXT NOT NULL PRIMARY KEY,
    product_category_name TEXT,
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g NUMERIC(10,2),
    product_length_cm NUMERIC(10,2),
    product_height_cm NUMERIC(10,2),
    product_width_cm NUMERIC(10,2),
    loaded_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intermediate.int_sellers (
    seller_id TEXT NOT NULL PRIMARY KEY,
    seller_zip_code_prefix TEXT,
    seller_city TEXT,
    seller_state TEXT,
    loaded_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intermediate.int_product_category_name_translation (
    product_category_name TEXT NOT NULL PRIMARY KEY,
    product_category_name_english TEXT,
    loaded_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intermediate.int_geolocation (
    geolocation_zip_code_prefix TEXT PRIMARY KEY,
    geolocation_lat NUMERIC(10,6),
    geolocation_lng NUMERIC(10,6),
    geolocation_city TEXT,
    geolocation_state TEXT,
    loaded_at TIMESTAMP
);
