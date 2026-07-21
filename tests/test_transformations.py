import unittest
from unittest.mock import call, patch

from app.transform.sql_transformer import run_transformations


class TransformationTests(unittest.TestCase):
    @patch("app.transform.sql_transformer.run_sql_file")
    def test_runs_transformation_files_in_dependency_order(self, run_sql_file) -> None:
        run_transformations()

        self.assertEqual(
            run_sql_file.call_args_list,
            [
                call("sql/transformations/001_load_intermediate.sql"),
                call("sql/transformations/002_load_dimensions.sql"),
                call("sql/transformations/003_load_facts.sql"),
            ],
        )
