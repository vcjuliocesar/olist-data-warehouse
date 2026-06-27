TRUNCATE TABLE
    staging.stg_customers,
    staging.stg_orders,
    staging.stg_order_items,
    staging.stg_geolocation,
    staging.stg_products,
    staging.stg_sellers,
    staging.stg_order_payments,
    staging.stg_order_reviews,
    staging.stg_product_category_name_translation
RESTART IDENTITY;