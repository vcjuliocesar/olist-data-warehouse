TRUNCATE TABLE
    staging.stg_customers,
    staging.stg_orders,
    staging.stg_order_items,
    staging.stg_products,
    staging.stg_sellers,
    staging.stg_order_payments
RESTART IDENTITY;