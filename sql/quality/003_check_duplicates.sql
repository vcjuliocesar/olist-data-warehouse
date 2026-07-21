SELECT
    'int_customers.customer_id' AS check_name,
    COUNT(*) AS total_duplicates,
    'error' AS severity
FROM (
    SELECT customer_id
    FROM intermediate.int_customers
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) t

UNION ALL

SELECT
    'int_orders.order_id',
    COUNT(*),
    'error'
FROM (
    SELECT order_id
    FROM intermediate.int_orders
    GROUP BY order_id
    HAVING COUNT(*) > 1
) t

UNION ALL

SELECT
    'int_order_items.order_id+order_item_id',
    COUNT(*),
    'error'
FROM (
    SELECT order_id, order_item_id
    FROM intermediate.int_order_items
    GROUP BY order_id, order_item_id
    HAVING COUNT(*) > 1
) t

UNION ALL

SELECT
    'int_order_payments.order_id+payment_sequential',
    COUNT(*),
    'error'
FROM (
    SELECT order_id, payment_sequential
    FROM intermediate.int_order_payments
    GROUP BY order_id, payment_sequential
    HAVING COUNT(*) > 1
) t

UNION ALL

SELECT
    'int_products.product_id',
    COUNT(*),
    'error'
FROM (
    SELECT product_id
    FROM intermediate.int_products
    GROUP BY product_id
    HAVING COUNT(*) > 1
) t

UNION ALL

SELECT
    'int_sellers.seller_id',
    COUNT(*),
    'error'
FROM (
    SELECT seller_id
    FROM intermediate.int_sellers
    GROUP BY seller_id
    HAVING COUNT(*) > 1
) t

UNION ALL

SELECT
    'int_order_reviews.review_id+order_id',
    COUNT(*),
    'error'
FROM (
    SELECT review_id, order_id
    FROM intermediate.int_order_reviews
    GROUP BY review_id, order_id
    HAVING COUNT(*) > 1
) t;