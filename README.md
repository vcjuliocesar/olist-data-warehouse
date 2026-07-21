# Olist Data Warehouse

A PostgreSQL ETL pipeline that loads the Olist CSV dataset into staging tables,
normalizes it into an intermediate layer, builds dimensional marts, and runs data
quality checks.

## Setup

1. Copy `.env.example` to `.env` and adjust the credentials.
2. Put the Olist CSV files in `data/raw/`.
3. Start PostgreSQL with `docker compose up -d postgres`.
4. Create a virtual environment and install `requirements.txt`.
5. Run the pipeline from the repository root with `python -m app.main`.

The application writes logs to `app/logs/etl.log`.

## Tests

The test suite uses only Python's standard library:

```sh
python -m unittest discover -s tests
```

The SQL transformations and quality queries require a populated PostgreSQL
database for end-to-end validation; the unit tests do not connect to the database.
