{{config(schema = 'bank_marts', alias = 'dim_time', materialized = 'table')}}

WITH time_table AS (
SELECT DISTINCT
    transaction_time AS time,

    EXTRACT(HOUR FROM transaction_time) AS hour,
    EXTRACT(MINUTE FROM transaction_time) AS minute,
    EXTRACT(SECOND FROM transaction_time) AS second,

    CASE 
        WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 6 AND 11 THEN 'MORNING'
        WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
        WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 18 AND 23 THEN 'EVENING'
        ELSE 'NIGHT'
    END AS time_of_day

FROM {{ ref('int_transactions') }}
)

SELECT * 
FROM time_table