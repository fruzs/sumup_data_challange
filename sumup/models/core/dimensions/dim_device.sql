{{ config(materialized='table'
          , sort_type='compound'
          , sort='device_id'
          , dist='device_id',) }}

select
  device_id
  , device_type
  , store_id
from {{ ref('stg_device') }}