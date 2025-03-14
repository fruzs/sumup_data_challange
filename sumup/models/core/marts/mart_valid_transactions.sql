/* This table contains all information regarding transactions that are valid, 
which is that their status is accepted
*/
{{ config(materialized='incremental'
          , unique_key='transaction_id') }}

with valid_transactions as (
    select
        transaction_id
        , amount
        , status
        , transaction_created_at
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
, dim_transaction as (
    select 
        transaction_id
        , device_id
        , product_sku
    from {{ref('dim_transaction')}}

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
, dim_product as (
    select
        product_sku
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
left join dim_transaction on dim_transaction.transaction_id = valid_transactions.transaction_id
left join dim_product on dim_product.product_sku = dim_transaction.product_sku
left join dim_device on dim_device.device_id = dim_transaction.device_id
left join dim_store on dim_store.store_id=dim_device.store_id



