/* This table contains all information regarding transactions that are valid, 
which is that their status is accepted
*/
{{ config(materialized='incremental'
          , unique_key='transaction_id') 
          , merge_update_columns = ['status']}}

with valid_transactions as (
    select
        transaction_id
        , amount
        , status
        , transaction_created_at
        , device_id
        , product_id
        , store_id
    from {{ref('fct_transactions')}}

    where status = 'accepted'
    {% if is_incremental() %}
        --filtering in the CTE in case of the incremental load to make sure we don't load unnecesary data
        and transaction_created_at 
        >= (select transaction_created_at from {{ this }} 
            order by 1 desc
            limit 1)

    {% endif %}
)

, dim_product as (
    select
        product_id
        , product_sku
        , product_name
        , category_name
    from {{ref('dim_product')}}
)
, dim_device as (
    select
        device_id
        , device_type
        , store_id
    from {{ref('dim_device')}}
)

, dim_store as (
    select
        store_id
        , typology
        , country
        , store_created_at
    from {{ref('dim_store')}}
)

select 
    valid_transactions.transaction_id
    , valid_transactions.amount
    , valid_transactions.status
    , valid_transactions.transaction_created_at
    , dim_product.product_sku
    , dim_product.product_name
    , dim_device.device_id
    , dim_device.device_type
    , dim_store.store_id
    , dim_store.typology
    , dim_store.country
    , dim_store.store_created_at

from valid_transactions 
left join dim_product on valid_transactions.product_id = dim_product.product_id
left join dim_device on valid_transactions.device_id = dim_device.device_id
left join dim_store on valid_transactions.store_id=dim_store.store_id



