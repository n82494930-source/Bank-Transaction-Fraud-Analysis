{{config(schema = 'bank_marts', alias = 'dim_customers', materialized = 'table')}}
WITH customers AS (
SELECT DISTINCT
    customer_id,
    customer_name,
    gender,
    age,
    state,
    city,
    customer_contact,
    customer_email,
    account_type
FROM {{ ref('int_transactions') }}
) 
SELECT * 
FROM customers




