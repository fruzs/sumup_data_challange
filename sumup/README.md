# Sumup data challange #

## Setup Steps: ##
Following dbt recommendation:

1. Set up a virtual environment: `python -m venv dbt-env`
2. Activeate the environment with `source dbt-env/bin/activate - activate the end`
3. run dbt installation with postgres: `pip install dbt-postgres`
4. run `dbt init` to initialize the project 
5. connecting with local db with setting up connection in `.dbt/profiles.yml`


# Questions to answer #
1. Top 10 stores per transacted amount
2. Top 10 products sold
3. Average transacted amount per store typology and country 
4. Percentage of transactions per device type 
5. Average time for a store to perform its 5 first transactions

