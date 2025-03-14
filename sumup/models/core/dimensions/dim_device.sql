{{ config(materialized='table'
          , sort_type='compound'
          , sort='device_id'
          , dist='device_id',) }}

select
  id as device_id
  , type
  , store_id
from {{ source('sumup', 'device') }}