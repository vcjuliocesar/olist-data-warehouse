
-- Customers
SELECT 'int_customers.customer_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_customers
WHERE customer_id IS NULL;

SELECT 'int_customers.customer_unique_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_customers
WHERE customer_unique_id IS NULL;

-- Orders
SELECT 'int_orders.order_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_orders
WHERE order_id IS NULL;

SELECT 'int_orders.customer_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_orders
WHERE customer_id IS NULL;

SELECT 'int_orders.order_status' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_orders
WHERE order_status IS NULL;

SELECT 'int_orders.order_purchase_timestamp' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_orders
WHERE order_purchase_timestamp IS NULL;

-- Order Items
SELECT 'int_order_items.order_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_items
WHERE order_id IS NULL;

SELECT 'int_order_items.order_item_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_items
WHERE order_item_id IS NULL;

SELECT 'int_order_items.product_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_items
WHERE product_id IS NULL;

SELECT 'int_order_items.seller_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_items
WHERE seller_id IS NULL;

SELECT 'int_order_items.price' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_items
WHERE price IS NULL;

SELECT 'int_order_items.freight_value' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_items
WHERE freight_value IS NULL;

-- Products
SELECT 'int_products.product_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_products
WHERE product_id IS NULL;

SELECT 'int_products.product_category_name' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_products
WHERE product_category_name IS NULL;

-- Sellers
SELECT 'int_sellers.seller_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_sellers
WHERE seller_id IS NULL;

-- Payments
SELECT 'int_order_payments.order_id' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_payments
WHERE order_id IS NULL;

SELECT 'int_order_payments.payment_sequential' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_payments
WHERE payment_sequential IS NULL;

SELECT 'int_order_payments.payment_type' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_payments
WHERE payment_type IS NULL;

SELECT 'int_order_payments.payment_value' AS check_name, COUNT(*) AS total_nulls
FROM intermediate.int_order_payments
WHERE payment_value IS NULL;