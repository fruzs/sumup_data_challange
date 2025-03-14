{{ config(materialized='incremental'
          , unique_key='store_id') }}

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

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- aggregate functions are not allowed in WHERE statements in PG, this is why I chose this solution

where to_timestamp(created_at,'MM/DD/YYYY HH:MI:SS') 
  >= (select to_timestamp(created_at,'MM/DD/YYYY HH:MI:SS') from {{ this }} 
     order by 1 desc
     limit 1)

{% endif %}