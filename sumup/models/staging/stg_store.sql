{{ config(materialized='view') }}

select
  id as store_id
  , name as store_name
  , address
  , city
  , country
  , to_timestamp(created_at,'MM/DD/YYYY HH:MI:SS') as store_created_at
  , typology
  , customer_id
  , created_at -- to us it for incremental load
from {{ source('sumup', 'store') }}