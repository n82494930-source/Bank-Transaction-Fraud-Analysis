{{config(schema = 'bank_int_layer',alias = 'int_transactions',materialized = 'incremental',unique_key = 'transaction_id')}}


WITH base AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY transaction_id
               ORDER BY transaction_date DESC, transaction_time DESC
           ) AS rn
    FROM {{ ref('stg_transactions') }}
),

dedup AS (
    SELECT *
    FROM base
    WHERE rn = 1
),

int_layer AS (
    SELECT *,
        (
            CASE WHEN transaction_amount > 90000 THEN 40 ELSE 0 END +
            CASE WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 1 AND 4 THEN 30 ELSE 0 END +
            CASE WHEN device_type = 'new_device' THEN 20 ELSE 0 END +
            CASE WHEN transaction_location != city THEN 10 ELSE 0 END
        ) AS fraud_score,

        AVG(transaction_amount) OVER (PARTITION BY customer_id) AS customer_avg_txn,

        AVG(account_balance) OVER (PARTITION BY bank_branch) AS avg_account_balance,

        AVG(transaction_amount) OVER (
            PARTITION BY customer_id
            ORDER BY transaction_date, transaction_time
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS rolling_avg_3_txn,
        AVG(transaction_amount) OVER (PARTITION BY customer_id
                                       ORDER BY transaction_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_avg_7days,
        CASE 
            WHEN COUNT(*) OVER (PARTITION BY customer_id) > 1 THEN
            (transaction_amount - AVG(transaction_amount) OVER (PARTITION BY customer_id))
            / NULLIF(STDDEV(transaction_amount) OVER (PARTITION BY customer_id), 0)  
            ELSE 0 END AS amount_zscore

    FROM dedup
)

SELECT *,
CASE 
    WHEN fraud_score >= 70 THEN 'HIGH_RISK'
    WHEN fraud_score BETWEEN 50 AND 69 THEN 'MEDIUM_RISK'
    ELSE 'LOW_RISK'
END AS risk_level,

CASE 
    WHEN ABS(amount_zscore) <= 1 THEN 'NORMAL'
    WHEN ABS(amount_zscore) <= 2 THEN 'SLIGHTLY_UNUSUAL'
    WHEN ABS(amount_zscore) <= 3 THEN 'MODERATE_RISK'
    ELSE 'HIGHLY_SUSPICIOUS'
END AS zscore_category

FROM int_layer