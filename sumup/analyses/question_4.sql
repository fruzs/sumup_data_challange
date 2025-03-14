--Percentage of transactions per device type 
with transaction_per_device_type as (
    select device_type
        , count(distinct transaction_id) as transaction_count
    from {{ref('mart_valid_transactions')}}
    group by 1
) 

select device_type
    , transaction_count
    , sum(transaction_count) over (rows between unbounded preceding and unbounded following) AS total_amount
    , (transaction_count/
        sum(transaction_count) over (rows between unbounded preceding and unbounded following))*100 as transaction_ratio 
from transaction_per_device_type