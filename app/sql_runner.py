import time
from pathlib import Path

import psycopg

from app.db import get_connection
from app.exceptions import TransformationError
from app.logger import setup_logger

logger = setup_logger(__name__)


def run_sql_file(file_path: str) -> None:
    path = Path(file_path)

    if not path.exists():
        raise FileNotFoundError(f"SQL file not found: {file_path}")

    sql = path.read_text(encoding="utf-8")
    started_at = time.perf_counter()

    logger.info("Executing SQL file | file=%s", path)

    try:
        with get_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(sql)
            conn.commit()

        duration = time.perf_counter() - started_at

        logger.info(
            "SQL file completed | file=%s | duration_seconds=%.3f",
            path,
            duration,
        )
    except psycopg.Error as exc:
        logger.exception("SQL execution failed | file=%s", path)

        raise TransformationError(
            f"Failed to execute SQL file: {path}"
        ) from exc
