/* Probably there is also a product raw table 
but now I just create the dim from transactions.
since some of the skus have different product names and categories
I will take the latest available value of them
*/

{{ config(materialized='table') }}
with product_ranking as (
select 
    product_id
    , product_sku
    , product_name
    , category_name
    , row_number() over (partition by product_sku order by transaction_created_at desc) as product_rank_number
from {{ref('stg_transaction')}}
)
-- selecting the latest product name and category by SKU
select
    product_id
    , product_sku
    , product_name
    , category_name
from product_ranking
where product_rank_number=1