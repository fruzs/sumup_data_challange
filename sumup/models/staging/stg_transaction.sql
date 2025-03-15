{{ config(materialized='view') }}

select
  id as transaction_id
  , device_id
  , {{ dbt_utils.generate_surrogate_key(['product_sku']) }} as product_id
  , product_sku
  , product_name
  , category_name
  , amount
  , status
  , MD5(card_number::text) as card_number
  , MD5(cvv::text) as cvv
  , to_timestamp(created_at,'MM/DD/YYYY HH:MI:SS') as transaction_created_at
  , to_timestamp(happened_at,'MM/DD/YYYY HH:MI:SS') as transaction_happened_at
  , happened_at -- to make incremental on it

from {{ source('sumup', 'transaction') }}