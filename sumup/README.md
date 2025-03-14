# Sumup data challange #

## Setup Steps: ##
Following dbt recommendation:
1, set up a virtual environment: `python -m venv dbt-env`
2, activeate the environment with `source dbt-env/bin/activate - activate the end`
3, run dbt installation with postgres: `pip install dbt-postgres`
4, run `dbt init` to initialize the project 
5, connecting with local db with setting up connection in `.dbt/profiles.yml`


# Questions to answer #
● Top 10 stores per transacted amount --> fct_transaction
● Top 10 products sold --> fct_transaction
● Average transacted amount per store typology and country --> fct_transaction
● Percentage of transactions per device type --> fct_transaction
● Average time for a store to perform its 5 first transactions  --> fct_transaction

