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
