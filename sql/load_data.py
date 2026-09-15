import pandas as pd
from sqlalchemy import create_engine
import urllib.parse

# 1. Credentials
user = "root"
raw_password = "Smasqlp@ss987"  # Put your exact password here (even if it has @)
host = "localhost"
port = "3306"
database = "olist_ecommerce"

# 2. Encode the password to safely handle special characters like '@'
safe_password = urllib.parse.quote_plus(raw_password)

# 3. Create SQLAlchemy connection engine
connection_string = f"mysql+pymysql://{user}:{safe_password}@{host}:{port}/{database}"
engine = create_engine(connection_string)
# 2. Path to your CSV file
csv_file_path = 'C:/Users/User/Desktop/Data Analyst/E-Commerce Sales & Customer Analytics Dashboard/data/processed/customers_clean.csv'  # Update path if needed

print("Reading CSV file...")
df = pd.read_csv(csv_file_path)

print(f"Loaded {len(df)} rows into memory. Importing into MySQL...")

# 3. Write dataframe directly to MySQL table
df.to_sql(
    name="customers",          # Target table name in MySQL
    con=engine, 
    if_exists="replace",    # Replaces the broken/incomplete table
    index=False, 
    chunksize=5000          # Uploads in 5,000-row fast batches
)

print("Import complete!")