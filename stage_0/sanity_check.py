from pathlib import Path
import duckdb

DATABASE_DIRECTORY = Path(__file__).parent.parent / "data" / "databases"
DATABASE_PATH = DATABASE_DIRECTORY / "sanity_check.db"


def duckdb_environment():
    duckdb.sql("PRAGMA version").show()
    duckdb.sql("PRAGMA platform").show()


def inspect_remote_table():
    duckdb.sql(
        "DESCRIBE TABLE 'https://blobs.duckdb.org/data/Star_Trek-Season_1.csv'"
    ).show()
    duckdb.sql(
        "SUMMARIZE TABLE 'https://blobs.duckdb.org/data/Star_Trek-Season_1.csv'"
    ).show()


def create_simple_database():
    # create database directory
    DATABASE_DIRECTORY.mkdir(parents=True, exist_ok=True)
    # delete the database if it exists
    DATABASE_PATH.unlink(missing_ok=True)
    # create the database
    connection = duckdb.connect(str(DATABASE_PATH))
    print(f"Created a persistent database at: {DATABASE_PATH}")

    # create and insert into a table
    connection.sql("CREATE TABLE integers (i INTEGER)")
    connection.sql("INSERT INTO integers VALUES (42)")
    connection.sql("SHOW ALL TABLES").show()

    # return the query result in the terminal
    connection.sql("SELECT * FROM integers").show()

    # convert the query result to a dataframe
    results = connection.sql("SELECT * FROM integers").df()
    print(type(results))
    print(results.shape)
    print(results)


if __name__ == "__main__":
    duckdb_environment()
    inspect_remote_table()
    create_simple_database()
    print("✅ Sanity check successful!")
