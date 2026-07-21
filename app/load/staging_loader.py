from pathlib import Path

from app.db import get_connection
from app.logger import setup_logger

logger = setup_logger(__name__)


CSV_TABLE_MAP = {
    "olist_customers_dataset.csv": {
        "table": "staging.stg_customers",
        "columns": [
            "customer_id",
            "customer_unique_id",
            "customer_zip_code_prefix",
            "customer_city",
            "customer_state",
        ],
    },
    "olist_orders_dataset.csv": {
        "table": "staging.stg_orders",
        "columns": [
            "order_id",
            "customer_id",
            "order_status",
            "order_purchase_timestamp",
            "order_approved_at",
            "order_delivered_carrier_date",
            "order_delivered_customer_date",
            "order_estimated_delivery_date",
        ],
    },
    "olist_order_items_dataset.csv": {
        "table": "staging.stg_order_items",
        "columns": [
            "order_id",
            "order_item_id",
            "product_id",
            "seller_id",
            "shipping_limit_date",
            "price",
            "freight_value",
        ],
    },
    "olist_products_dataset.csv": {
        "table": "staging.stg_products",
        "columns": [
            "product_id",
            "product_category_name",
            "product_name_lenght",
            "product_description_lenght",
            "product_photos_qty",
            "product_weight_g",
            "product_length_cm",
            "product_height_cm",
            "product_width_cm",
        ],
    },
    "olist_sellers_dataset.csv": {
        "table": "staging.stg_sellers",
        "columns": [
            "seller_id",
            "seller_zip_code_prefix",
            "seller_city",
            "seller_state",
        ],
    },
    "olist_order_payments_dataset.csv": {
        "table": "staging.stg_order_payments",
        "columns": [
            "order_id",
            "payment_sequential",
            "payment_type",
            "payment_installments",
            "payment_value",
        ],
    },
    "olist_geolocation_dataset.csv": {
        "table":"staging.stg_geolocation",
        "columns":[
            "geolocation_zip_code_prefix",
            "geolocation_lat",
            "geolocation_lng",
            "geolocation_city",
            "geolocation_state",
        ]
    },
    "olist_order_reviews_dataset.csv": {
            "table":"staging.stg_order_reviews",
            "columns":[
                "review_id",
                "order_id",
                "review_score",
                "review_comment_title",
                "review_comment_message",
                "review_creation_date",
                "review_answer_timestamp",
            ]
        },
    "product_category_name_translation.csv": {
                "table":"staging.stg_product_category_name_translation",
                "columns":[
                    "product_category_name",
                    "product_category_name_english",
                ]
            },
}


def load_csv_to_staging(file_path: Path) -> None:
    file_name = file_path.name

    if file_name not in CSV_TABLE_MAP:
        logger.warning("Skipping unknown file: %s", file_name)
        return

    table = CSV_TABLE_MAP[file_name]["table"]
    columns = CSV_TABLE_MAP[file_name]["columns"]
    columns_sql = ", ".join(columns)

    copy_sql = f"""
        COPY {table} ({columns_sql})
        FROM STDIN
        WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',')
    """

    with get_connection() as conn:
        with conn.cursor() as cur:
            with file_path.open("r", encoding="utf-8") as csv_file:
                with cur.copy(copy_sql) as copy:
                    while chunk := csv_file.read(1024 * 1024):
                        copy.write(chunk)
        conn.commit()
    logger.info("Loaded %s into %s", file_name, table)


def load_all_csvs_to_staging(csv_files: list[Path]) -> None:
    for file_path in csv_files:
        load_csv_to_staging(file_path)
