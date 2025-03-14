{{ config(materialized='incremental'
          , unique_key='store_id') }}

select
  store_id
  , store_name
  , address
  , city
  , country
  , store_created_at
  , typology
  , customer_id
from {{ref('stg_store')}}

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- aggregate functions are not allowed in WHERE statements in PG, this is why I chose this solution

where store_created_at
  >= (select store_created_at from {{ this }} 
     order by 1 desc
     limit 1)

{% endif %}