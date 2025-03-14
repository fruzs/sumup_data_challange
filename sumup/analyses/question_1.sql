-- Top 10 stores per transacted amount
with amount_per_store as (
    select 
        store_id
        , sum(amount) as transacted_amount
    from {{ref("mart_valid_transactions")}}
    group by 1
)

select *
from amount_per_store
order by transacted_amount desc
limit 10