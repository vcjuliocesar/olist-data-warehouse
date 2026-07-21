from app.sql_runner import run_sql_file

def run_transformations() -> None:
    run_sql_file("sql/transformations/001_load_intermediate.sql")
    run_sql_file("sql/transformations/002_load_dimensions.sql")
    run_sql_file("sql/transformations/003_load_facts.sql")