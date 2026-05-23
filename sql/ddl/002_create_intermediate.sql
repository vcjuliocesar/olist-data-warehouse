CREATE SCHEMA IF NOT EXISTS intermediate;

CREATE TABLE IF NOT EXISTS intermediate.int_customers (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT,
    loaded_at TIMESTAMP
)

CREATE TABLE IF NOT EXISTS intermediate.stg_order_items (
    order_id TEXT PRIMARY KEY,
    order_item_id INTEGER,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price NUMERIC(12,2),
    freight_value NUMERIC(12,2),
    loaded_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intermediate.stg_order_payments (
    order_id TEXT PRIMARY KEY,
    payment_sequential INTEGER,
    payment_type TEXT,
    payment_installments INTEGER,
    payment_value NUMERIC(12,2),
    loaded_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intermediate.stg_order_reviews (
    review_id TEXT PRIMARY KEY,
    order_id TEXT,
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    loaded_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS intermediate.stg_orders (
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

CREATE TABLE IF NOT EXISTS intermediate.stg_products (
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

CREATE TABLE IF NOT EXISTS intermediate.stg_sellers (
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

CREATE TABLE IF NOT EXISTS intermediate.stg_product_category_name_translation (
    id BIGSERIAL PRIMARY KEY,
    product_category_name TEXT,
    product_category_name_english TEXT,

    source_file TEXT,
    source_row_number INTEGER,
    batch_id UUID,

    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);