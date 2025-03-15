{{ config(materialized='incremental'
          , unique_key='transaction_id') }}

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

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- aggregate functions are not allowed in WHERE statements in PG, this is why I chose this solution

where to_timestamp(happened_at,'MM/DD/YYYY HH:MI:SS') 
  >= (select to_timestamp(happened_at,'MM/DD/YYYY HH:MI:SS') from {{ this }} 
     order by 1 desc
     limit 1)

{% endif %}