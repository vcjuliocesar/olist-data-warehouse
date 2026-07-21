SELECT 'orders -> customers' AS check_name, COUNT(*) AS missing_records,'error' AS severity
FROM intermediate.int_orders o
LEFT JOIN intermediate.int_customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL

UNION ALL

SELECT 'order items -> orders' AS check_name, COUNT(*) AS missing_records,'error' AS severity
FROM intermediate.int_order_items oi
LEFT JOIN intermediate.int_orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL

UNION ALL

SELECT 'order items -> products' AS check_name, COUNT(*) AS missing_records,'error' AS severity
FROM intermediate.int_order_items oi
LEFT JOIN intermediate.int_products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL

UNION ALL

SELECT 'Order Items -> Sellers' AS check_name, COUNT(*) AS missing_records,'error' AS severity
FROM intermediate.int_order_items oi
LEFT JOIN intermediate.int_sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL

UNION ALL

SELECT 'payments -> orders' AS check_name, COUNT(*) AS missing_records,'error' AS severity
FROM intermediate.int_order_payments p
LEFT JOIN intermediate.int_orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL

UNION ALL

SELECT 'reviews -> orders' AS check_name, COUNT(*) AS missing_records,'error' AS severity
FROM intermediate.int_order_reviews r
LEFT JOIN intermediate.int_orders o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;