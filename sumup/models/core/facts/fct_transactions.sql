{{ config(materialized='table') }}

select
    transaction_id
    , amount
    , status
from {{ref('stg_transaction')}}