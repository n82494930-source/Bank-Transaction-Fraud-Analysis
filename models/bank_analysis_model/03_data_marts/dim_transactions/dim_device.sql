{{config(schema = 'bank_marts', alias = 'dim_device', materialized = 'table')}}

WITH device_table AS (
    SELECT DISTINCT
          device_type,
          transaction_device
    FROM {{ ref('int_transactions') }}      
)
SELECT * 
FROM device_table