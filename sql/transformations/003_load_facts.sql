TRUNCATE TABLE marts.fact_order_items;

INSERT INTO marts.fact_order_items (
    order_id,
    order_item_id,
    customer_key,
    product_key,
    seller_key,
    date_key,
    quantity,
    price,
    freight_value
)
SELECT
    oi.order_id,
    oi.order_item_id,
    dc.customer_key,
    dp.product_key,
    ds.seller_key,
    dd.date_key,
    1 AS quantity,
    oi.price,
    oi.freight_value
FROM intermediate.int_order_items oi
JOIN intermediate.int_orders o
    ON oi.order_id = o.order_id
JOIN marts.dim_customers dc
    ON o.customer_id = dc.customer_id
JOIN marts.dim_products dp
    ON oi.product_id = dp.product_id
JOIN marts.dim_sellers ds
    ON oi.seller_id = ds.seller_id
JOIN marts.dim_date dd
    ON o.order_purchase_timestamp::DATE = dd.full_date
WHERE oi.price IS NOT NULL
  AND oi.freight_value IS NOT NULL;



TRUNCATE TABLE marts.fact_payments;

INSERT INTO marts.fact_payments (
    order_id,
    payment_sequential,
    customer_key,
    date_key,
    payment_type,
    payment_installments,
    payment_value
)
SELECT
    p.order_id,
    p.payment_sequential,
    dc.customer_key,
    dd.date_key,
    p.payment_type,
    p.payment_installments,
    p.payment_value
FROM intermediate.int_order_payments p
JOIN intermediate.int_orders o
    ON p.order_id = o.order_id
JOIN marts.dim_customers dc
    ON o.customer_id = dc.customer_id
JOIN marts.dim_date dd
    ON o.order_purchase_timestamp::DATE = dd.full_date
WHERE p.payment_value IS NOT NULL;