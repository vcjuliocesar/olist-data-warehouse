TRUNCATE TABLE
    marts.fact_order_items,
    marts.fact_payments,
    marts.dim_customers,
    marts.dim_products,
    marts.dim_sellers,
    marts.dim_date
RESTART IDENTITY CASCADE;

INSERT INTO marts.dim_customers (
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
)
SELECT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
FROM intermediate.int_customers;



INSERT INTO marts.dim_products (
    product_id,
    product_category_name
)
SELECT
    product_id,
    product_category_name
FROM intermediate.int_products;



INSERT INTO marts.dim_sellers (
    seller_id,
    seller_city,
    seller_state
)
SELECT
    seller_id,
    seller_city,
    seller_state
FROM intermediate.int_sellers;



INSERT INTO marts.dim_date (
    date_key,
    full_date,
    day,
    month,
    year,
    quarter,
    weekday
)
SELECT
    TO_CHAR(d::DATE, 'YYYYMMDD')::INTEGER AS date_key,
    d::DATE AS full_date,
    EXTRACT(DAY FROM d)::INTEGER AS day,
    EXTRACT(MONTH FROM d)::INTEGER AS month,
    EXTRACT(YEAR FROM d)::INTEGER AS year,
    EXTRACT(QUARTER FROM d)::INTEGER AS quarter,
    EXTRACT(ISODOW FROM d)::INTEGER AS weekday
FROM generate_series(
    '2016-01-01'::DATE,
    '2020-12-31'::DATE,
    INTERVAL '1 day'
) AS d;