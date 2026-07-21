SELECT 'int_customers.customer_id' AS check_name, COUNT(*) AS total_nulls, 'error' AS severity
FROM intermediate.int_customers
WHERE customer_id IS NULL

UNION ALL
SELECT 'int_customers.customer_unique_id', COUNT(*), 'error'
FROM intermediate.int_customers
WHERE customer_unique_id IS NULL

UNION ALL
SELECT 'int_orders.order_id', COUNT(*), 'error'
FROM intermediate.int_orders
WHERE order_id IS NULL

UNION ALL
SELECT 'int_orders.customer_id', COUNT(*), 'error'
FROM intermediate.int_orders
WHERE customer_id IS NULL

UNION ALL
SELECT 'int_orders.order_status', COUNT(*), 'error'
FROM intermediate.int_orders
WHERE order_status IS NULL

UNION ALL
SELECT 'int_orders.order_purchase_timestamp', COUNT(*), 'warning'
FROM intermediate.int_orders
WHERE order_purchase_timestamp IS NULL

UNION ALL
SELECT 'int_order_items.order_id', COUNT(*), 'error'
FROM intermediate.int_order_items
WHERE order_id IS NULL

UNION ALL
SELECT 'int_order_items.order_item_id', COUNT(*), 'error'
FROM intermediate.int_order_items
WHERE order_item_id IS NULL

UNION ALL
SELECT 'int_order_items.product_id', COUNT(*), 'error'
FROM intermediate.int_order_items
WHERE product_id IS NULL

UNION ALL
SELECT 'int_order_items.seller_id', COUNT(*), 'error'
FROM intermediate.int_order_items
WHERE seller_id IS NULL

UNION ALL
SELECT 'int_order_items.price', COUNT(*), 'error'
FROM intermediate.int_order_items
WHERE price IS NULL

UNION ALL
SELECT 'int_order_items.freight_value', COUNT(*), 'error'
FROM intermediate.int_order_items
WHERE freight_value IS NULL

UNION ALL
SELECT 'int_products.product_id', COUNT(*), 'error'
FROM intermediate.int_products
WHERE product_id IS NULL

UNION ALL
SELECT 'int_products.product_category_name', COUNT(*), 'warning'
FROM intermediate.int_products
WHERE product_category_name IS NULL

UNION ALL
SELECT 'int_sellers.seller_id', COUNT(*), 'error'
FROM intermediate.int_sellers
WHERE seller_id IS NULL

UNION ALL
SELECT 'int_order_payments.order_id', COUNT(*), 'error'
FROM intermediate.int_order_payments
WHERE order_id IS NULL

UNION ALL
SELECT 'int_order_payments.payment_sequential', COUNT(*), 'error'
FROM intermediate.int_order_payments
WHERE payment_sequential IS NULL

UNION ALL
SELECT 'int_order_payments.payment_type', COUNT(*), 'error'
FROM intermediate.int_order_payments
WHERE payment_type IS NULL

UNION ALL
SELECT 'int_order_payments.payment_value', COUNT(*), 'error'
FROM intermediate.int_order_payments
WHERE payment_value IS NULL;