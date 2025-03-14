-- Average transacted amount per store typology and country 

with avg_transaction_amount as (
    select typology
        , country
        , avg(amount) as avg_transaction_amount
    from {{ref('mart_valid_transactions')}}
    group by 1,2
    order by 1,2
) 

select *
from avg_transaction_amount

