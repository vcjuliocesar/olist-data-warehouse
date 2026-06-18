from pathlib import Path
from app.db import get_connection
from app.logger import setuo_logger

logger = setuo_logger(__name__)

def run_sql_file(file_path: str) -> None:
    path = Path(file_path)
    
    if not path.exists():
        raise FileNotFoundError(f"SQL file not found: {file_path}")
    
    sql = path.read_text(encoding="utf-8")
    
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(sql)
        conn.commit()
    
    logger.info(f"Executed: {file_path}")