{{ config(materialized='table') }}

select 
    transaction_id
    , device_id
    , product_sku
from {{ref('stg_transaction')}}