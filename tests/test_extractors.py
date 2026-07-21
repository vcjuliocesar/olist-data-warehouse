import tempfile
import unittest
from pathlib import Path

from app.extract.csv_extractor import get_csv_files


class CsvExtractorTests(unittest.TestCase):
    def test_returns_only_csv_files_in_sorted_order(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "b.csv").touch()
            (root / "a.csv").touch()
            (root / "notes.txt").touch()

            self.assertEqual(
                get_csv_files(directory),
                [root / "a.csv", root / "b.csv"],
            )

    def test_missing_directory_raises_clear_error(self) -> None:
        with self.assertRaises(FileNotFoundError):
            get_csv_files("missing-directory")

    def test_file_path_is_rejected(self) -> None:
        with tempfile.NamedTemporaryFile() as file:
            with self.assertRaises(NotADirectoryError):
                get_csv_files(file.name)
