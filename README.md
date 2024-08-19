# duckdb-dbt

This repo is an example of using [duckdb](https://duckdb.org/) and [dbt](https://docs.getdbt.com/) to build data.

## Setup

### Python

> [!NOTE]
> Use of python version 3.12 and a virtual environment is recommended. We like to use [`pyenv`](https://github.com/pyenv/pyenv) and [`pyenv-virtualenv`](https://realpython.com/intro-to-pyenv/#virtual-environments-and-pyenv).

Install the required python packages:

```bash
python3 -m pip install --requirement setup/requirements.txt
```

Confirm packages listed in `setup/requirements.in` are installed:

```bash
pip list
```

> [!TIP]
> Use `pip freeze | xargs pip uninstall -y` to uninstall all python packages.

## Stage 0: Sanity Check

Run a python script to confirm everything is setup:

```bash
python3 -m stage_0.sanity_check
```

## Stage 1: Explore data

Load and explore data from various sources

- PLUTO from the NYC Department of City Planning ([source](https://data.cityofnewyork.us/d/64uk-42ks/))
- NYC Airbnb data ([source](https://insideairbnb.com/get-the-data/))
- Trip record data from the NYC Taxi and Limousine Commission (TLC) ([source](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page))

### Steps

1. Download PLUTO from NYC Open Data [here](https://data.cityofnewyork.us/d/64uk-42ks/) by navigating to `Actions` -> `API` -> `Download file` -> `Export format: CSV`
2. Move the downloaded csv file to `data/source_data/`
3. Run a python script to load all source data into a database:

   ```bash
   python3 -m stage_1.load
   ```

4. Use the Jupyter notebook `stage_1/explore.ipynb` to explore the data

## Stage 2: Pipeline

Use a data pipeline to load and transform data from various sources

...

## Stage 3: dbt pipeline

Use dbt to build a data pipeline

...
