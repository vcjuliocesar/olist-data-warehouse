from unittest import result

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
        
    def validate_duplicates(self):
        colums, rows = self.repository.execute_query_from_file(
            "sql/quality/003_check_duplicates.sql"
        )
        
        print("\nDuplicates Validation")
        print("-" * 40)
        
        has_error = False
        
        for row in rows:
            result = dict(zip(colums,row))
            
            check_name = result["check_name"]
            total_duplicates = result["total_duplicates"]
            severity = result["severity"]
                        
            print(f"{check_name} : {total_duplicates}")
                        
            if total_duplicates > 0 and severity == "error":
                has_error = True
                            
        if has_error:
            raise Exception("Duplicates validation failed.")
                                                
        print("Validation passed.")
        
    
    def validate_referential_integrity(self):
            colums, rows = self.repository.execute_query_from_file(
                "sql/quality/004_check_referential_integrity.sql"
            )
            
            print("\nReferential Integrity Validation")
            print("-" * 40)
            
            has_error = False
            
            for row in rows:
                result = dict(zip(colums,row))
                
                check_name = result["check_name"]
                missing_records = result["missing_records"]
                severity = result["severity"]
                            
                print(f"{check_name} : {missing_records}")
                            
                if missing_records > 0 and severity == "error":
                    has_error = True
                                
            if has_error:
                raise Exception("Referential Integrity Validation failed.")
                                                    
            print("Validation passed.")
    
    def validate_business_rules(self):
        colums, rows = self.repository.execute_query_from_file(
            "sql/quality/005_check_business_rules.sql"
        )
            
        print("\nBusiness rules Validation")
        print("-" * 40)
            
        has_error = False
            
        for row in rows:
            result = dict(zip(colums,row))
                
            check_name = result["check_name"]
            missing_records = result["failed_rule"]
            severity = result["severity"]
                            
            print(f"{check_name} : {missing_records}")
                            
            if missing_records > 0 and severity == "error":
                has_error = True
                                
        if has_error:
            raise Exception("Business rules Validation failed.")
                                                    
        print("Validation passed.")
            