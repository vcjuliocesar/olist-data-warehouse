from pathlib import Path
from app.db import get_connection

def run_sql_file(file_path: str) -> None:
    path = Path(file_path)
    
    if not path.exists():
        raise FileNotFoundError(f"SQL file not found: {file_path}")
    
    sql = path.read_text(encoding="utf-8")
    
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(sql)
        conn.commit()
    
    print(f"Executed: {file_path}")