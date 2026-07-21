from app.exceptions import DataQualityError
from app.repositories.etl_repository import EtlRepository


class QualityService:
    def __init__(self) -> None:
        self.repository = EtlRepository()

    def validate_counts(self) -> None:
        columns, rows = self.repository.execute_query_from_file(
            "sql/quality/001_check_counts.sql"
        )

        print("\nCount Validation")
        print("-" * 40)

        has_error = False
        for row in rows:
            result = dict(zip(columns, row))
            for key, value in result.items():
                print(f"{key}: {value}")
            has_error = has_error or result["has_mismatch"]

        if has_error:
            raise DataQualityError("Entity count mismatch detected.")

        print("Validation passed.")

    def validate_nulls(self) -> None:
        self._validate_rows(
            "sql/quality/002_check_nulls.sql",
            "Null Validation",
            "total_nulls",
            "Null validation failed.",
        )

    def validate_duplicates(self) -> None:
        self._validate_rows(
            "sql/quality/003_check_duplicates.sql",
            "Duplicates Validation",
            "total_duplicates",
            "Duplicates validation failed.",
        )

    def validate_referential_integrity(self) -> None:
        self._validate_rows(
            "sql/quality/004_check_referential_integrity.sql",
            "Referential Integrity Validation",
            "missing_records",
            "Referential integrity validation failed.",
        )

    def validate_business_rules(self) -> None:
        self._validate_rows(
            "sql/quality/005_check_business_rules.sql",
            "Business Rules Validation",
            "failed_rule",
            "Business rules validation failed.",
        )

    def _validate_rows(
        self,
        file_path: str,
        title: str,
        value_column: str,
        error_message: str,
    ) -> None:
        columns, rows = self.repository.execute_query_from_file(file_path)

        print(f"\n{title}")
        print("-" * 40)

        has_error = False
        for row in rows:
            result = dict(zip(columns, row))
            value = result[value_column]
            print(f'{result["check_name"]} : {value}')
            has_error = has_error or (value > 0 and result["severity"] == "error")

        if has_error:
            raise DataQualityError(error_message)

        print("Validation passed.")
