from app.repositories.etl_repository import EtlRepository

class QualityService:
    
    def __init__(self):
        self.repository = EtlRepository()
        
    def validate_counts(self):
        columns, rows = self.repository.execute_query_from_file(
            "sql/quality/001_check_counts.sql"
        )
        
        result = dict(zip(columns,rows[0]))
        
        print("\nCustomer Count Validation")
        print("-" * 40)
        
        for key,value in result.items():
            print(f"{key}: {value}")
            
        if result["has_mismatch"]:
            raise Exception(
                "Customer count mismatch detected."
            )
        
        print("Validation passed.")