from app.sql_runner import run_sql_file


def main() -> None:
    # DDL
    run_sql_file("sql/ddl/001_create_staging.sql")
    run_sql_file("sql/ddl/002_create_intermediate.sql")
    run_sql_file("sql/ddl/003_create_marts.sql")
    
    # Transformations
    run_sql_file("sql/transformations/001_load_intermediate.sql")
    run_sql_file("sql/transformations/002_load_dimensions.sql")
    run_sql_file("sql/transformations/003_load_facts.sql")

    # Quality checks
    run_sql_file("sql/quality/001_check_nulls.sql")
    
    
if __name__ == "__main__":
    main()