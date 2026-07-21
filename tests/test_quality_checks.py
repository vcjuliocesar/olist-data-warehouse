import unittest
from unittest.mock import Mock

from app.exceptions import DataQualityError
from app.services.quality_service import QualityService


COUNT_COLUMNS = [
    "entity",
    "staging_count",
    "intermediate_count",
    "mart_count",
    "diff_staging_vs_intermediate",
    "diff_intermediate_vs_dim",
    "has_mismatch",
]


class QualityServiceTests(unittest.TestCase):
    def setUp(self) -> None:
        self.service = QualityService()
        self.service.repository = Mock()

    def test_count_validation_checks_every_entity(self) -> None:
        self.service.repository.execute_query_from_file.return_value = (
            COUNT_COLUMNS,
            [
                ("customers", 10, 10, 10, 0, 0, False),
                ("products", 8, 7, 7, 1, 0, True),
            ],
        )

        with self.assertRaises(DataQualityError):
            self.service.validate_counts()

    def test_warning_does_not_fail_row_validation(self) -> None:
        self.service.repository.execute_query_from_file.return_value = (
            ["check_name", "total_nulls", "severity"],
            [("optional_column", 2, "warning")],
        )

        self.service.validate_nulls()

    def test_error_fails_row_validation(self) -> None:
        self.service.repository.execute_query_from_file.return_value = (
            ["check_name", "total_nulls", "severity"],
            [("required_column", 1, "error")],
        )

        with self.assertRaises(DataQualityError):
            self.service.validate_nulls()
