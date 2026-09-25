# src/db.py
import os
import urllib.parse
from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()

def get_db_engine(DB_NAME_DATALAKE):

    DB_USER = os.getenv('DB_USER')
    DB_PASSWORD = os.getenv('DB_PASSWORD')
    DB_HOST = os.getenv('DB_HOST', 'localhost')
    DB_PORT = os.getenv('DB_PORT', '3306')
    DB_NAME_DATALAKE = os.getenv('DB_NAME_DATALAKE')

    SAFE_PASSWORD = urllib.parse.quote_plus(DB_PASSWORD) if DB_PASSWORD else ''

    connection_string = (
        f"mysql+pymysql://{DB_USER}:{SAFE_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME_DATALAKE}"
    )
    engine = create_engine(connection_string)

    return engine