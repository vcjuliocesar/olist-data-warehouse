-- Items duplicados
SELECT
    customer_id,
    COUNT(*) AS total_repeticiones
FROM intermediate.int_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Items duplicados
SELECT
    order_id,
    COUNT(*) AS total_repeticiones
FROM intermediate.int_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Items duplicados
SELECT
    order_id,
    order_item_id,
    COUNT(*) AS total_repeticiones
FROM intermediate.int_order_items
GROUP BY
    order_id,
    order_item_id
HAVING COUNT(*) > 1;

-- Items duplicados
SELECT
    order_id,
    payment_sequential,
    COUNT(*) AS total_repeticiones
FROM intermediate.int_order_payments
GROUP BY
    order_id,
    payment_sequential
HAVING COUNT(*) > 1;

-- Items duplicados
SELECT
    product_id,
    COUNT(*) AS total_repeticiones
FROM intermediate.int_products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Items duplicados
SELECT
    seller_id,
    COUNT(*) AS total_repeticiones
FROM intermediate.int_sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- Items duplicados
SELECT
    review_id,
    order_id,
    COUNT(*) AS total_repeticiones
FROM intermediate.int_order_reviews
GROUP BY
    review_id,
    order_id
HAVING COUNT(*) > 1;