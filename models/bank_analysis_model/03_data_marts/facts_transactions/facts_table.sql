{{config(schema = 'bank_marts', alias = 'facts_table',materialized = 'table')}}

WITh facts AS(
    SELECT 
          --Keys
          transaction_id,
          customer_id,
          bank_branch,
          device_type
          transaction_date,
          transaction_time,
          merchant_id,

          --Measures
          transaction_amount,
          account_balance,

          --Fraud_metrics
          fraud_score,
          customer_avg_txn,
          avg_account_balance,
          rolling_avg_3_txn,
          rolling_avg_7days,
          amount_zscore,
         
          --Labels
          is_fraud,
          risk_level,
          zscore_category,

          --others
          transaction_type,
          transaction_location,
          transaction_currency,
          transaction_description
    FROM {{ref('int_transactions')}} 
)
SELECT * FROM facts   