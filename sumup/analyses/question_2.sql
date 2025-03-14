-- Top 10 products sold

with sold_products as (
    select product_sku
        , product_name
        , count(transaction_id) as sold_items
    from {{ref('mart_valid_transactions')}}
    group by 1,2
) 

select *
from sold_products
order by sold_items desc
limit 10

