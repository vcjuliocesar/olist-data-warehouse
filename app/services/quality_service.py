from tabnanny import check

from app.repositories.etl_repository import EtlRepository

class QualityService:
    
    def __init__(self):
        self.repository = EtlRepository()
        
    def validate_counts(self):
        columns, rows = self.repository.execute_query_from_file(
            "sql/quality/001_check_counts.sql"
        )
        
        result = dict(zip(columns,rows[0]))
        
        print("\nCount Validation")
        print("-" * 40)
        
        for key,value in result.items():
            print(f"{key}: {value}")
            
        if result["has_mismatch"]:
            raise Exception(
                "Customer count mismatch detected."
            )
        
        print("Validation passed.")
        
    def validate_nulls(self):
        columns,rows = self.repository.execute_query_from_file(
            "sql/quality/002_check_nulls.sql"
        )
                    
        print("\nNull Validation")
        print("-" * 40)
        
        has_error = False
                
        for row in rows:
            result = dict(zip(columns,row))
            
            check_name = result["check_name"]
            total_nulls = result["total_nulls"]
            severity = result["severity"]
            
            print(f"{check_name} : {total_nulls}")
            
            if total_nulls > 0 and severity == "error":
                has_error = True
                
        if has_error:
            raise Exception("Null validation failed.")
                
                    
        print("Validation passed.")