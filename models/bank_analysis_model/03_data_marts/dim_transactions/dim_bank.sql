{{config(schema = 'bank_marts', alias = 'dim_bank', materialized = 'table')}}

WITH bank_table AS (
    SELECT DISTINCT
          bank_branch,
          account_type
     FROM {{ref('int_transactions')}}       
)
SELECT * 
FROM bank_table