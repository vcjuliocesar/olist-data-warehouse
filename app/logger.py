import logging
import sys
from pathlib import Path


LOG_DIRECTORY = Path(__file__).resolve().parent / "logs"


def setup_logger(
    name: str = __name__,
    log_file: str = "etl.log",
    level: int = logging.DEBUG,
) -> logging.Logger:
    """Return a consistently configured application logger."""
    logger = logging.getLogger(name)
    logger.setLevel(level)

    # Avoid opening unused file descriptors when this logger already exists.
    if logger.handlers:
        return logger

    log_format = logging.Formatter(
        "%(asctime)s - %(name)s - [%(levelname)s] - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    LOG_DIRECTORY.mkdir(parents=True, exist_ok=True)
    file_handler = logging.FileHandler(
        LOG_DIRECTORY / log_file,
        mode="a",
        encoding="utf-8",
    )
    file_handler.setFormatter(log_format)
    file_handler.setLevel(level)

    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(log_format)
    console_handler.setLevel(level)

    logger.addHandler(file_handler)
    logger.addHandler(console_handler)
    return logger


# Backwards-compatible alias for callers using the original misspelled name.
setuo_logger = setup_logger
