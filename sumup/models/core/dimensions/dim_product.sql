/* Probably there is also a product raw table 
but now I just create the dim from transactions
*/
{{ config(materialized='table') }}

SELECT DISTINCT
    product_sku
    , product_name
    , category_name
FROM {{ref('stg_transaction')}}