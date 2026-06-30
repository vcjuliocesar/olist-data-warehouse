-- Conteos
SELECT COUNT(*) FROM intermediate.int_customers;
SELECT COUNT(*) FROM intermediate.int_orders;
SELECT COUNT(*) FROM intermediate.int_order_items;
SELECT COUNT(*) FROM intermediate.int_products;
SELECT COUNT(*) FROM intermediate.int_sellers;
SELECT COUNT(*) FROM intermediate.int_order_payments;

-- Orders sin customer
SELECT COUNT(*) AS orders_without_customer
FROM intermediate.int_orders o
LEFT JOIN intermediate.int_customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Items sin order
SELECT COUNT(*) AS items_without_order
FROM intermediate.int_order_items oi
LEFT JOIN intermediate.int_orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Items sin product
SELECT COUNT(*) AS items_without_product
FROM intermediate.int_order_items oi
LEFT JOIN intermediate.int_products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Items sin seller
SELECT COUNT(*) AS items_without_seller
FROM intermediate.int_order_items oi
LEFT JOIN intermediate.int_sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

-- Payments sin order
SELECT COUNT(*) AS payments_without_order
FROM intermediate.int_order_payments p
LEFT JOIN intermediate.int_orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;