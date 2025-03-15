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
# Solution #
## Assumptions ##
I assume that the answers are only interested in valid transactions, where the status is accepted. This is why I created a separate mart which contains valid transactions and their relevant attributes that can answer the above question.

## Table design ##
Following star schema principles
<img width="718" alt="Screen Shot 2025-03-15 at 9 57 24 PM" src="https://github.com/user-attachments/assets/f48d7030-b46e-4140-add5-739890dc6542" />
I created the staging tables as views for less storage, and as tables in fct and mart tables. In fct_transaction i applied incremental load. 
## Lineage and validation ##
<img width="1257" alt="Screen Shot 2025-03-15 at 11 13 42 PM" src="https://github.com/user-attachments/assets/cd1b0f27-382f-4166-8e96-4ff7087326f1" />

I created unique tests on primary keys and not_null tests on other values on other tests - after further investigation it can be decided if some of the tests can be warning instead of error tests, so that it doesn't fail the job
<img width="853" alt="Screen Shot 2025-03-15 at 11 07 14 PM" src="https://github.com/user-attachments/assets/88351238-fb68-4b09-874c-ea8f3be7fbdc" />


# Answers #

## Area for further analysis ## 
It would be interesting to look into the distribution of not accepted transactions.Does it concentrate to certain type of stores, or certain devices?

## Area for further improving the dbt project ##
1. Adding primary key / foreign key constraints
2. utilzing dbt_util tests, eg.: relationships_where, unique combination of values.
3. 

