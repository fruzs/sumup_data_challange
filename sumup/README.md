# Sumup data challange #

## Setup Steps with Postgres: ##

Following dbt recommendation:

1. Set up a virtual environment: `python -m venv dbt-env`
2. Activeate the environment with `source dbt-env/bin/activate - activate the end`
3. run dbt installation with postgres: `pip install dbt-postgres`
4. run `dbt init` to initialize the project 
5. connecting with local db with setting up connection in `.dbt/profiles.yml`

I chose to setup dbt with postgres as an easy and free tool to spin up local development environment. For production case I would follow Airbyte integration with Airflow and Snowflake, found in this repo: https://github.com/airbytehq.


# Questions to answer #
1. Top 10 stores per transacted amount
2. Top 10 products sold
3. Average transacted amount per store typology and country 
4. Percentage of transactions per device type 
5. Average time for a store to perform its 5 first transactions

# Assumptions #

# Table design #
Following star schema principles
<img width="718" alt="Screen Shot 2025-03-15 at 9 57 24 PM" src="https://github.com/user-attachments/assets/f48d7030-b46e-4140-add5-739890dc6542" />

# Answers #

# Area for further analysis # 

