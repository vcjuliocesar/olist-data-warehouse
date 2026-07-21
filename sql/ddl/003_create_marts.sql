CREATE SCHEMA IF NOT EXISTS marts;

CREATE TABLE IF NOT EXISTS marts.dim_customers (
    customer_key BIGSERIAL PRIMARY KEY,
    customer_id TEXT NOT NULL UNIQUE,
    customer_unique_id TEXT,
    customer_city TEXT,
    customer_state TEXT
);

CREATE TABLE IF NOT EXISTS marts.dim_products (
    product_key BIGSERIAL PRIMARY KEY,
    product_id TEXT NOT NULL UNIQUE,
    product_category_name TEXT
);

CREATE TABLE IF NOT EXISTS marts.dim_sellers (
    seller_key BIGSERIAL PRIMARY KEY,
    seller_id TEXT NOT NULL UNIQUE,
    seller_city TEXT,
    seller_state TEXT
);

CREATE TABLE IF NOT EXISTS marts.dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    weekday INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS marts.fact_order_items (
    order_id TEXT NOT NULL,
    order_item_id INTEGER NOT NULL,

    customer_key BIGINT NOT NULL REFERENCES marts.dim_customers(customer_key),
    product_key BIGINT NOT NULL REFERENCES marts.dim_products(product_key),
    seller_key BIGINT NOT NULL REFERENCES marts.dim_sellers(seller_key),
    date_key INTEGER NOT NULL REFERENCES marts.dim_date(date_key),

    quantity INTEGER NOT NULL DEFAULT 1,
    price NUMERIC(12,2) NOT NULL,
    freight_value NUMERIC(12,2) NOT NULL,

    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE IF NOT EXISTS marts.fact_payments (
    order_id TEXT NOT NULL,
    payment_sequential INTEGER NOT NULL,

    customer_key BIGINT NOT NULL REFERENCES marts.dim_customers(customer_key),
    date_key INTEGER NOT NULL REFERENCES marts.dim_date(date_key),

    payment_type TEXT,
    payment_installments INTEGER,
    payment_value NUMERIC(12,2) NOT NULL,

    PRIMARY KEY (order_id, payment_sequential)
);