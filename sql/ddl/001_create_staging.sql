CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.stg_customers (
    id BIGSERIAL PRIMARY KEY,
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.stg_geolocation (
    id BIGSERIAL PRIMARY KEY,
    geolocation_zip_code_prefix TEXT,
    geolocation_lat TEXT,
    geolocation_lng TEXT,
    geolocation_city TEXT,
    geolocation_state TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.stg_order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id TEXT,
    order_item_id TEXT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TEXT,
    price TEXT,
    freight_value TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.stg_order_payments (
    id BIGSERIAL PRIMARY KEY,
    order_id TEXT,
    payment_sequential TEXT,
    payment_type TEXT,
    payment_installments TEXT,
    payment_value TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.stg_order_reviews (
    id BIGSERIAL PRIMARY KEY,
    review_id TEXT,
    order_id TEXT,
    review_score TEXT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TEXT,
    review_answer_timestamp TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.stg_orders (
    id BIGSERIAL PRIMARY KEY,
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TEXT,
    order_approved_at TEXT,
    order_delivered_carrier_date TEXT,
    order_delivered_customer_date TEXT,
    order_estimated_delivery_date TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.stg_products (
    id BIGSERIAL PRIMARY KEY,
    product_id TEXT,
    product_category_name TEXT,
    product_name_lenght TEXT,
    product_description_lenght TEXT,
    product_photos_qty TEXT,
    product_weight_g TEXT,
    product_length_cm TEXT,
    product_height_cm TEXT,
    product_width_cm TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.stg_sellers (
    id BIGSERIAL PRIMARY KEY,
    seller_id TEXT,
    seller_zip_code_prefix TEXT,
    seller_city TEXT,
    seller_state TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.stg_product_category_name_translation (
    id BIGSERIAL PRIMARY KEY,
    product_category_name TEXT,
    product_category_name_english TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);