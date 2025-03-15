{{ config(materialized='table') }}
/*
There must be a backend table with customers as well but now i will just use stores to create the table
This would be a table that can fill up customer information
ie: information how the customer was reached: 
  - salesforce lead info, or marketing  info
  - customer name, email etc for CRM or customer success purposes

*/
select distinct customer_id
from {{ref('stg_store')}}