{{config(schema = 'bank_marts', alias = 'dim_date', materialized = 'table')}}


WITH date_table AS(
SELECT DISTINCT
    transaction_date AS date,
    EXTRACT(DAY FROM transaction_date) AS day,
    EXTRACT(MONTH FROM transaction_date) AS month,
    EXTRACT(YEAR FROM transaction_date) AS year,
    EXTRACT(QUARTER FROM transaction_date) AS quarter,
    EXTRACT(DAYOFWEEK FROM transaction_date) AS day_of_week
FROM {{ ref('stg_transactions') }}
)

SELECT *
FROM date_table