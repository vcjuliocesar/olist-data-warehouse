from pathlib import Path

from app.db import get_connection
from app.logger import setup_logger

logger = setup_logger(__name__)


class EtlRepository:
    def execute_query_from_file(self, file_path: str) -> tuple[list[str], list[tuple]]:
        sql = Path(file_path).read_text(encoding="utf-8")

        with get_connection() as conn, conn.cursor() as cur:
            cur.execute(sql)

            if cur.description is None:
                raise ValueError(f"Query did not return a result set: {file_path}")

            columns = [desc.name for desc in cur.description]
            rows = cur.fetchall()

        logger.info("Loaded query results from %s", file_path)

        return columns, rows
