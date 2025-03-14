--- Average time for a store to perform its 5 first transactions
with transaction_per_store as (
    select store_id
        , store_created_at
        , transaction_id
        , transaction_created_at
        , row_number() over (partition by store_id order by transaction_created_at asc) as transaction_number_in_store
    from {{ref('mart_valid_transactions')}}
) 
, stores as (
    select
        store_id
        , store_created_at
    from {{ref('dim_store')}}
)

select avg(stores.store_created_at-transaction_per_store.transaction_created_at)
from stores
left join transaction_per_store on transaction_per_store.store_id = stores.store_id
 and transaction_number_in_store = 5

