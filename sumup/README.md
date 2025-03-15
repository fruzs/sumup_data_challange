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
I saved the queries in the analysis folder. 


1. Top 10 stores per transacted amount:
<img width="303" alt="Screen Shot 2025-03-15 at 11 35 50 PM" src="https://github.com/user-attachments/assets/56c428fa-917a-4f53-a806-a76ed76547ea" />

2. Top 10 products sold
<img width="445" alt="Screen Shot 2025-03-15 at 11 39 08 PM" src="https://github.com/user-attachments/assets/c2cb982b-c7af-4600-86ad-ea63df7b53b0" />

3. Average transacted amount per store typology and country

| Typology   | Country        | Avg. Transacted Amount | 
|------------|----------------|------------------------| 
| Beauty     | Austria        | 584.7500000000000000   | 
| Beauty     | Brazil         | 435.0000000000000000   | 
| Beauty     | Ireland        | 558.0000000000000000   | 
| Beauty     | Italy          | 452.5000000000000000   | 
| Beauty     | Netherlands    | 373.6666666666666667   | 
| Beauty     | New Zealand    | 542.6666666666666667   | 
| Beauty     | Nigeria        | 442.3846153846153846   | 
| Beauty     | Norway         | 733.0000000000000000   | 
| Beauty     | South Africa   | 517.0769230769230769   | 
| Beauty     | Vietnam        | 961.0000000000000000   | 
| Florist    | Australia      | 372.1428571428571429   | 
| Florist    | Austria        | 651.6666666666666667   | 
| Florist    | Belgium        | 322.6666666666666667   | 
| Florist    | Brazil         | 534.6842105263157895   | 
| Florist    | China          | 522.0000000000000000   | 
| Florist    | France         | 583.2500000000000000   | 
| Florist    | Indonesia      | 380.8461538461538462   | 
| Florist    | Singapore      | 456.8571428571428571   | 
| Florist    | South Korea    | 578.5000000000000000   | 
| FoodTruck  | Australia      | 594.6000000000000000   | 
| FoodTruck  | Austria        | 422.0000000000000000   | 
| FoodTruck  | Costa Rica     | 469.1500000000000000   | 
| FoodTruck  | France         | 400.0400000000000000   | 
| FoodTruck  | India          | 700.5000000000000000   | 
| FoodTruck  | Nigeria        | 278.5000000000000000   | 
| FoodTruck  | Ukraine        | 513.2857142857142857   | 
| FoodTruck  | United Kingdom | 270.0000000000000000   | 
| Hotel      | Canada         | 350.0666666666666667   | 
| Hotel      | China          | 515.8571428571428571   | 
| Hotel      | Costa Rica     | 605.6000000000000000   | 
| Hotel      | Ireland        | 558.4545454545454545   | 
| Hotel      | Italy          | 872.0000000000000000   | 
| Hotel      | Netherlands    | 672.1666666666666667   | 
| Hotel      | New Zealand    | 613.2000000000000000   | 
| Hotel      | United States  | 696.0000000000000000   | 
| Other      | Germany        | 515.6111111111111111   | 
| Other      | India          | 822.0000000000000000   | 
| Other      | Indonesia      | 547.0000000000000000   | 
| Other      | Peru           | 749.0000000000000000   | 
| Other      | Singapore      | 282.0000000000000000   | 
| Other      | Spain          | 442.6666666666666667   | 
| Press      | Belgium        | 476.1111111111111111   | 
| Press      | Brazil         | 571.0833333333333333   | 
| Press      | Chile          | 101.0000000000000000   | 
| Press      | Mexico         | 534.2000000000000000   | 
| Press      | Netherlands    | 554.0952380952380952   | 
| Press      | Peru           | 425.9090909090909091   | 
| Press      | Poland         | 392.5000000000000000   | 
| Press      | United Kingdom | 399.5000000000000000   | 
| Restaurant | Austria        | 653.0000000000000000   | 
| Restaurant | Colombia       | 671.5000000000000000   | 
| Restaurant | India          | 540.3333333333333333   | 
| Restaurant | Ireland        | 136.0000000000000000   | 
| Restaurant | Netherlands    | 423.2857142857142857   | 
| Restaurant | Nigeria        | 610.8000000000000000   | 
| Restaurant | South Korea    | 222.0000000000000000   | 
| Restaurant | Sweden         | 413.5714285714285714   | 
| Service    | Australia      | 375.0000000000000000   | 
| Service    | Belgium        | 601.5000000000000000   | 
| Service    | Brazil         | 894.5000000000000000   | 
| Service    | Germany        | 346.0000000000000000   | 
| Service    | India          | 477.5000000000000000   | 
| Service    | Mexico         | 602.0000000000000000   | 
| Service    | Singapore      | 443.3333333333333333   | 
| Service    | South Africa   | 614.6666666666666667   | 
| Service    | Ukraine        | 387.2000000000000000   | 
| Service    | United Kingdom | 563.3750000000000000   | 


4. Percentage of transactions per device type
<img width="635" alt="Screen Shot 2025-03-15 at 11 42 34 PM" src="https://github.com/user-attachments/assets/e23bc9e4-2f56-4c8a-b2af-f50faedd6284" />

5. Average time for a store to perform its 5 first transactions: I only considered the shops that has reached 5 transactions, and the result is:`46 days 06:34:27.934783`. In case we want to consider shops that havent reached yet the 5 as part of the population we could coalesce the 5th transaction_created_at with current date. But since the last transaction in the dataset is 2023 it would largely skew the results
   
## Area for further analysis ## 
It would be interesting to look into the distribution of not accepted transactions.Does it concentrate to certain type of stores, or certain devices?

## Area for further improving the dbt project ##
1. Adding primary key / foreign key constraints
2. utilzing dbt_util tests, eg.: relationships_where, unique combination of values.

