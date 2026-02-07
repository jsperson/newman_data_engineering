import pandas as pd
import psycopg2
# Function to extract data from a PostgreSQL table
def extract_table_to_csv(db_config, table_name, csv_file):
    try:
        # Establish database connection
        conn = psycopg2.connect(
            host=db_config['host'],
            port=db_config['port'],
            database=db_config['database'],
            user=db_config['user'],
            password=db_config['password']
        )
        print(f"Connected to the database for table: {table_name}")
       
        # Define the SQL query
        query = f"SELECT * FROM {table_name};"
       
        # Execute query and load data into a pandas DataFrame
        data = pd.read_sql_query(query, conn)
       
        # Export DataFrame to CSV
        data.to_csv(csv_file, index=False)
        print(f"Data from {table_name} exported to {csv_file}.")
       
        # Close the connection
        conn.close()
    except Exception as e:
        print(f"Error extracting data from {table_name}: {e}")
        raise
# Main function to orchestrate the pipeline
def export_sales_tracker_tables_to_csv(db_config):
    print("Starting the data export pipeline...")
   
    # Define table-to-CSV mapping
    tables_to_export = {
        "products": "products_data.csv",
        "customers": "customers_data.csv",
        "orders": "orders_data.csv",
        "order_items": "order_items_data.csv"
    }
   
    # Export each table
    for table_name, csv_file in tables_to_export.items():
        extract_table_to_csv(db_config, table_name, csv_file)
   
    print("Data export pipeline completed.")
# Example usage
if __name__ == "__main__":
    # Database configuration
    db_config = {
        "host": "postgres_data_engineering",
        "port": 5432,
        "database": "salestracker",
        "user": "admin",
        "password": "admin"
    }
   
    # Execute the pipeline
    export_sales_tracker_tables_to_csv(db_config)