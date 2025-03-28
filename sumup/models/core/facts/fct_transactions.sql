{{ config(materialized='incremental'
          , unique_key='transaction_id'
          , merge_update_columns = ['status']) }}

with transactions as (
select
    transaction_id
    , device_id
    , product_id
    , amount
    , status
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
)
, devices as (
  select 
    device_id
    , store_id
  from {{ref('stg_device')}}
)
, stores as (
  select 
    store_id
    , customer_id
  from {{ref('stg_store')}}
)


--- joining devices to get store id and store to get customer id
select 
    transactions.transaction_id
    , transactions.device_id
    , transactions.product_id
    , transactions.amount
    , transactions.status
    , transactions.transaction_created_at
    , stores.store_id
    , stores.customer_id
from transactions 
left join devices on devices.device_id = transactions.device_id
left join stores on stores.store_id=devices.store_id