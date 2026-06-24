from pathlib import Path
from app.db import get_connection
from app.logger import setuo_logger

logger = setuo_logger(__name__)

class EtlRepository:
    
    def execute_query_from_file(self,file_path:str):
        sql = Path(file_path).read_text(encoding="utf-8")
        
        with get_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(sql)
                
                columns = [desc[0] for desc in cur.description]
                rows = cur.fetchall()
                
        logger.info(f"loadded {file_path}")
        
        return columns,rows