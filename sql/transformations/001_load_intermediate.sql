TRUNCATE TABLE intermediate.int_customers;

INSERT INTO intermediate.int_customers (
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    loaded_at
)
SELECT DISTINCT ON (NULLIF(TRIM(customer_id),''))
    NULLIF(TRIM(customer_id),'') AS customer_id,
    NULLIF(TRIM(customer_unique_id),'') AS customer_unique_id,
    NULLIF(TRIM(customer_zip_code_prefix),'') AS customer_zip_code_prefix,
    LOWER(NULLIF(TRIM(customer_city),'')) AS customer_city,
    UPPER(NULLIF(TRIM(customer_state),'')) AS customer_state,
    loaded_at
FROM staging.stg_customers
WHERE NULLIF(TRIM(customer_id),'') IS NOT NULL
ORDER BY customer_id,loaded_at DESC;

TRUNCATE TABLE intermediate.int_order_items;

INSERT INTO intermediate.int_order_items (
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,
    loaded_at
)
SELECT DISTINCT ON (
    NULLIF(TRIM(order_id),''),
    NULLIF(TRIM(order_item_id),'')::INTEGER
)
    NULLIF(TRIM(order_id),'') AS order_id,
    NULLIF(TRIM(order_item_id),'')::INTEGER AS order_item_id,
    NULLIF(TRIM(product_id),'') AS product_id,
    NULLIF(TRIM(seller_id),'') AS seller_id,
    NULLIF(TRIM(shipping_limit_date),'')::TIMESTAMP AS shipping_limit_date,
    NULLIF(TRIM(price),'')::NUMERIC(12,2) AS price,
    NULLIF(TRIM(freight_value), '')::NUMERIC(12,2) AS freight_value,
    loaded_at
FROM staging.stg_order_items
WHERE NULLIF(TRIM(order_id),'') IS NOT NULL 
    AND NULLIF(TRIM(order_item_id),'') IS NOT NULL
ORDER BY 
    NULLIF(TRIM(order_id),''),
    NULLIF(TRIM(order_item_id),'')::INTEGER, 
    loaded_at DESC;


TRUNCATE TABLE intermediate.int_order_payments;

INSERT INTO intermediate.int_order_payments (
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value,
    loaded_at
)
SELECT DISTINCT ON (
    NULLIF(TRIM(order_id),''),
    NULLIF(TRIM(payment_sequential),'')::INTEGER
)
    NULLIF(TRIM(order_id),'') AS order_id,
    NULLIF(TRIM(payment_sequential),'')::INTEGER as payment_sequential,
    NULLIF(TRIM(payment_type),'') AS payment_type,
    NULLIF(TRIM(payment_installments),'')::INTEGER AS payment_installments,
    NULLIF(TRIM(payment_value),'')::NUMERIC(12,2) AS payment_value,
    loaded_at
FROM staging.stg_order_payments
WHERE NULLIF(TRIM(order_id),'') IS NOT NULL
    AND  NULLIF(TRIM(payment_sequential),'') IS NOT NULL
ORDER BY
    NULLIF(TRIM(order_id),''),
    NULLIF(TRIM(payment_sequential),'')::INTEGER,
    loaded_at DESC;


TRUNCATE TABLE intermediate.int_order_reviews;

INSERT INTO intermediate.int_order_reviews (
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp,
    loaded_at
)
SELECT DISTINCT ON (
    NULLIF(TRIM(review_id),''),
    NULLIF(TRIM(order_id),'')
)
    NULLIF(TRIM(review_id),'') AS review_id,
    NULLIF(TRIM(order_id),'') AS order_id,
    NULLIF(TRIM(review_score),'')::INTEGER AS review_score,
    NULLIF(TRIM(review_comment_title),'') AS review_comment_title,
    NULLIF(TRIM(review_comment_message),'') AS review_comment_message,
    NULLIF(TRIM(review_creation_date),'')::TIMESTAMP AS review_creation_date,
    NULLIF(TRIM(review_answer_timestamp),'')::TIMESTAMP AS review_answer_timestamp,
    loaded_at
FROM staging.stg_order_reviews
WHERE  NULLIF(TRIM(review_id),'') IS NOT NULL
    AND NULLIF(TRIM(order_id),'') IS NOT NULL
ORDER BY
    NULLIF(TRIM(review_id),''),
    NULLIF(TRIM(order_id),''),
    loaded_at DESC;

TRUNCATE TABLE intermediate.int_orders;

INSERT INTO intermediate.int_orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    loaded_at
)
SELECT DISTINCT ON (
    NULLIF(TRIM(order_id),'')
)
NULLIF(TRIM(order_id),'') AS order_id,
NULLIF(TRIM(customer_id),'') AS customer_id,
LOWER(NULLIF(TRIM(order_status),'')) AS order_status,
NULLIF(TRIM(order_purchase_timestamp),'')::TIMESTAMP AS order_purchase_timestamp,
NULLIF(TRIM(order_approved_at),'')::TIMESTAMP AS order_approved_at,
NULLIF(TRIM(order_delivered_carrier_date),'')::TIMESTAMP AS order_delivered_carrier_date,
NULLIF(TRIM(order_delivered_customer_date),'')::TIMESTAMP AS order_delivered_customer_date,
NULLIF(TRIM(order_estimated_delivery_date),'')::TIMESTAMP AS order_estimated_delivery_date,
loaded_at
FROM staging.stg_orders
WHERE NULLIF(TRIM(order_id),'') IS NOT NULL
    AND NULLIF(TRIM(customer_id), '') IS NOT NULL
ORDER BY NULLIF(TRIM(order_id),''),loaded_at DESC;


TRUNCATE TABLE intermediate.int_products;

INSERT INTO intermediate.int_products (
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    loaded_at
)
SELECT DISTINCT ON(
    NULLIF(TRIM(product_id),'')
)
    NULLIF(TRIM(product_id),'') AS product_id,
    NULLIF(TRIM(product_category_name),'') AS product_category_name,
    NULLIF(TRIM(product_name_lenght),'')::INTEGER AS product_name_length,
    NULLIF(TRIM(product_description_lenght),'')::INTEGER AS product_description_length,
    NULLIF(TRIM(product_photos_qty),'')::INTEGER AS product_photos_qty,
    NULLIF(TRIM(product_weight_g),'')::NUMERIC(12,2) AS product_weight_g,
    NULLIF(TRIM(product_length_cm),'')::NUMERIC(12,2) AS product_length_cm,
    NULLIF(TRIM(product_height_cm),'')::NUMERIC(12,2) AS product_height_cm,
    NULLIF(TRIM(product_width_cm),'')::NUMERIC(12,2) AS product_width_cm,
    loaded_at
FROM staging.stg_products
WHERE NULLIF(TRIM(product_id),'') IS NOT NULL
ORDER BY NULLIF(TRIM(product_id),''),loaded_at DESC;

TRUNCATE TABLE intermediate.int_sellers;

INSERT INTO intermediate.int_sellers (
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state,
    loaded_at
)
SELECT DISTINCT ON(
    NULLIF(TRIM(seller_id),'')
)
    NULLIF(TRIM(seller_id),'') AS seller_id,
    NULLIF(TRIM(seller_zip_code_prefix),'') AS seller_zip_code_prefix,
    LOWER(NULLIF(TRIM(seller_city),'')) AS seller_city,
    UPPER(NULLIF(TRIM(seller_state),'')) AS seller_state,
    loaded_at
FROM staging.stg_sellers
WHERE NULLIF(TRIM(seller_id),'') IS NOT NULL
ORDER BY NULLIF(TRIM(seller_id),''),loaded_at DESC;

TRUNCATE TABLE intermediate.int_product_category_name_translation;

INSERT INTO intermediate.int_product_category_name_translation (
    product_category_name,
    product_category_name_english,
    loaded_at
)
SELECT DISTINCT ON (
    LOWER(NULLIF(TRIM(product_category_name), ''))
)
    LOWER(NULLIF(TRIM(product_category_name), '')) AS product_category_name,
    LOWER(NULLIF(TRIM(product_category_name_english), '')) AS product_category_name_english,
    loaded_at
FROM staging.stg_product_category_name_translation
WHERE NULLIF(TRIM(product_category_name), '') IS NOT NULL
ORDER BY
    LOWER(NULLIF(TRIM(product_category_name), '')),
    loaded_at DESC;

TRUNCATE TABLE intermediate.int_geolocation;

INSERT INTO intermediate.int_geolocation (
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state,
    loaded_at
)
SELECT
    NULLIF(TRIM(geolocation_zip_code_prefix), '') AS geolocation_zip_code_prefix,
    AVG(NULLIF(TRIM(geolocation_lat), '')::NUMERIC(10,6)) AS geolocation_lat,
    AVG(NULLIF(TRIM(geolocation_lng), '')::NUMERIC(10,6)) AS geolocation_lng,
    MODE() WITHIN GROUP (ORDER BY LOWER(NULLIF(TRIM(geolocation_city), ''))) AS geolocation_city,
    MODE() WITHIN GROUP (ORDER BY UPPER(NULLIF(TRIM(geolocation_state), ''))) AS geolocation_state,
    MAX(loaded_at) AS loaded_at
FROM staging.stg_geolocation
WHERE NULLIF(TRIM(geolocation_zip_code_prefix), '') IS NOT NULL
GROUP BY NULLIF(TRIM(geolocation_zip_code_prefix), '');

