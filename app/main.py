from app.extract.csv_extractor import get_csv_files
from app.load.staging_loader import load_all_csvs_to_staging
from app.transform.sql_transformer import run_transformations
from app.services.quality_service import QualityService
from app.sql_runner import run_sql_file
from app.utils.timer import Timer


def main() -> None:
    timer = Timer()
    # DDL
    run_sql_file("sql/ddl/001_create_staging.sql")
    run_sql_file("sql/ddl/002_create_intermediate.sql")
    run_sql_file("sql/ddl/003_create_marts.sql")
    
    # maintenance
    run_sql_file("sql/maintenance/001_truncate_staging.sql")
    
    # Transformations
    csv_files = get_csv_files("data/raw")
    load_all_csvs_to_staging(csv_files)
    
    run_transformations()
    
    # Quality checks
    #run_sql_file("sql/quality/003_check_nulls.sql")
    
    quality_service = QualityService()
    
    quality_service.validate_counts()
    
    quality_service.validate_nulls()
    
    elapsed = timer.elapsed()
    
    print("-" * 40)
    print(f"Total time: {elapsed:.3f} seconds")
    
if __name__ == "__main__":
    main()