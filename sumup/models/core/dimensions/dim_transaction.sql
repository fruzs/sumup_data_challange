{{ config(materialized='incremental'
          , unique_key='transaction_id') }}

select 
    transaction_id
    , device_id
    , product_sku
    , transaction_created_at
from {{ref('stg_transaction')}}

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- aggregate functions are not allowed in WHERE statements in PG, this is why I chose this solution

where transaction_created_at 
  >= (select transaction_created_at from {{ this }} 
     order by 1 desc
     limit 1)

{% endif %}