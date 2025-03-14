
/*
  This table is materialized as table as there is no timestamp you can implement on.
  If there were a timestamp (eg device being installed in the store) we could add incremental here.
*/

{{ config(materialized='table'
          , sort_type='compound'
          , sort='device_id'
          , dist='device_id',) }}

select
  id as device_id
  , type as device_type
  , store_id
from {{ source('sumup', 'device') }}


