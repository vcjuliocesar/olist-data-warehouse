from pathlib import Path

def get_csv_files(raw_dir: str = "data/raw") -> list[Path]:
    path = Path(raw_dir)
    
    
    if not path.exists():
        raise FileNotFoundError(f"Raw data directory not found: {raw_dir}")
    
    return sorted(path.glob("*.csv"))