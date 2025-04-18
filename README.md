# duckdb-dbt

This repo is an example of using [duckdb](https://duckdb.org/) and [dbt](https://docs.getdbt.com/) to build data.

The code is organized into three stages to show a progression of from simple queries to a modern data pipeline.

A toy dataset was created for the purposes of this repo called Farm To Market: a dataset about local agriculture.

## Farm To Market

### Dataset description

Farm To Market captures where local food is sold and might be grown in New York City.

This dataset combines the locations of farmers markets and potential farms (community gardens) to highlight availability and potential local suppliers of healthy produce in NYC.

> [!WARNING]
> This dataset's design is in-progress and the data dictionary below may not represent the final columns of a build.

### Data Dictionary

`farm_to_market` table

Each row is a market and farm pair

- `market_name`
- `farm_name`
- `suitability_score`
- `distance_ft`
- `line_geometry_wgs84`

`markets` table

Each row is a farmers market

- `market_name`
- `accepts_ebt`
- `distributes_health_bucks`
- `open_year_round`
- `address`
- `borough`
- `latitude`
- `longitude`
- `geometry_is_in_nyc`
- `point_geometry_wgs84`

`farms` table

Each row is a potential farm

- `type`
- `farm_name`
- `area_sqft`
- `whole_lot`
- `address`
- `borough`
- `bbl`
- `latitude`
- `longitude`
- `point_geometry_wgs84`
- `polygon_geometry_wgs84`

### Source data

Source data:

- NYC Borough Boundaries [[source](https://data.cityofnewyork.us/City-Government/Borough-Boundaries/tqmj-j8zm)]
- NYC Farmers Markets [[source](https://data.cityofnewyork.us/Health/NYC-Farmers-Markets/8vwk-6iz2/about_data)]
- GreenThumb Garden Info [[source](https://data.cityofnewyork.us/dataset/GreenThumb-Garden-Info/p78i-pat6/about_data)]
- GreenThumb Block-Lot [[source](https://data.cityofnewyork.us/dataset/GreenThumb-Block-Lot/fsjc-9fyh/about_data)]
<!-- - https://data.cityofnewyork.us/City-Government/Suitability-of-City-Owned-and-Leased-Property-for-/4e2n-s75z/about_data -->

## Development

### Installations

- VS Code [[link](https://code.visualstudio.com/)] for an integrated development environment
- git [[link](https://git-scm.com/downloads)] for cloning this repo and installing `bash` terminal
- Python 3.12 [[link](https://www.python.org/downloads/release/python-3120/)] for running python code

### Setup

1. Setup a python virtual environment named `.venv` either using `python -m venv .venv` or using the VS Code command `Python: create environment`

2. Activate the virtual environment

   ```bash
   source .venv/Scripts/activate
   ```

3. Install packages and confirm setup

   ```bash
   python -m pip install --requirement setup/requirements.txt
   pip list
   ```

> [!IMPORTANT]
> For NYC government employees, most work computers access the internet through a firewall. This causes issues when writing and running code (e.g. `pip install` fails).
>
> See instructions below to allow code to access the internet on a city-issued PC.
>
> 1. Search for an select `Edit environment variables for your account` in the Start menu
>
> 2. Add two environment variables with the same value of `http://bcpxy.nycnet:8080`:
>    - `http_proxy`
>    - `https_proxy`

## Stage 0: Sanity Check

Run a python script to confirm everything is setup

```bash
python -m stage_0.sanity_check
```

## Stage 1: Load and explore data

Load and explore data from various sources

### Source data

These datasets were chosen to show some of the ways source data can be imported with DuckDB.

- PLUTO from the NYC Department of City Planning ([source](https://data.cityofnewyork.us/d/64uk-42ks/))
- NYC Airbnb data ([source](https://insideairbnb.com/get-the-data/))
- Trip record data from the NYC Taxi and Limousine Commission (TLC) ([source](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page))

### Steps

1. Download PLUTO from NYC Open Data [here](https://data.cityofnewyork.us/d/64uk-42ks/) by navigating to `Actions` -> `API` -> `Download file` -> `Export format: CSV`
2. Rename the downloaded csv file to `pluto.csv` and move it to `data/source_data/`.
3. Run a python script to download the other 2 datasets programmatically and load all source data into a database:

   ```bash
   python -m stage_1.load
   ```

4. Use the Jupyter notebook `stage_1/explore.ipynb` to explore the data

## Stage 2: Pipeline

Use a data pipeline to build Farm To Market

1. Download all source data from their Open Data pages by navigating to `Actions` -> `API` -> `Download file` -> `Export format: CSV`

   > [!TIP]
   > NYC Borough Boundaries must be downloaded as a geojson file by navigating to `Export` -> `Download Geospatial Data` -> `GeoJSON`.

2. Move the downloaded csv file to `data/source_data/`
3. . Run a python script to load all source data into a database:

   ```bash
   python -m stage_2.load
   ```

4. (Optional) Use the Jupyter notebook `stage_2/explore.ipynb` to explore the source data
5. Run python scripts to transform and export data:

   ```bash
   python -m stage_2.transform
   python -m stage_2.export
   ```

6. Use the Jupyter notebook `stage_2/analyze.ipynb` to review and analyze the dataset

## Stage 3: dbt pipeline

Use dbt to build to build Farm To Market

1. Install dbt packages and confirm setup:

   ```bash
   dbt deps
   dbt debug
   ```

2. Test source data:

   ```bash
   dbt test --select "source:*"
   ```

3. Build the dataset:

   ```bash
   dbt build
   ```
