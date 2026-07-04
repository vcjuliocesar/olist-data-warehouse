SELECT 'price >= 0' AS check_name, COUNT(*) AS failed_rule, 'error' AS severity
FROM intermediate.int_order_items
WHERE price < 0

UNION ALL

SELECT 'freight_value >= 0', COUNT(*), 'error'
FROM intermediate.int_order_items
WHERE freight_value < 0

UNION ALL

SELECT 'payment_value >= 0', COUNT(*), 'error'
FROM intermediate.int_order_payments
WHERE payment_value < 0

UNION ALL

SELECT 'delivery_date >= purchase_date', COUNT(*), 'error'
FROM intermediate.int_orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL
  AND order_delivered_customer_date < order_purchase_timestamp

UNION ALL

SELECT 'approved_at >= purchase_date', COUNT(*), 'error'
FROM intermediate.int_orders
WHERE order_approved_at IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL
  AND order_approved_at < order_purchase_timestamp

UNION ALL

SELECT 'review_score between 1 and 5', COUNT(*), 'error'
FROM intermediate.int_order_reviews
WHERE review_score IS NOT NULL
  AND review_score NOT BETWEEN 1 AND 5

UNION ALL

SELECT 'product_weight_g > 0', COUNT(*), 'warning'
FROM intermediate.int_products
WHERE product_weight_g IS NOT NULL
  AND product_weight_g <= 0

UNION ALL

SELECT 'product_dimensions > 0', COUNT(*), 'warning'
FROM intermediate.int_products
WHERE product_length_cm IS NOT NULL
  AND product_height_cm IS NOT NULL
  AND product_width_cm IS NOT NULL
  AND (
      product_length_cm <= 0
      OR product_height_cm <= 0
      OR product_width_cm <= 0
  );