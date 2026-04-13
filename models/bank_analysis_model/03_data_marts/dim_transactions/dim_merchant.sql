{{config(schema = 'bank_marts', alias = 'dim_merchant', materialized = 'table')}}

WITH merchant_table AS (
    SELECT DISTINCT
          merchant_id,
          merchant_category
    FROM {{ ref('int_transactions') }}      
)
SELECT * FROM merchant_table