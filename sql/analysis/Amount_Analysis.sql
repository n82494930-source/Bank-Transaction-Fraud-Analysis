
/*
Step: Transaction Amount Risk Analysis
Purpose: Analyze fraud based on transaction value
*/

SELECT
    CASE
        WHEN transaction_amount < 100 THEN 'Low'
        WHEN transaction_amount BETWEEN 100 AND 1000 THEN 'Medium'
        ELSE 'High'
    END AS amount_bucket,
    COUNT(*) AS total_transactions,
    SUM(CAST(is_fraud AS INT)) AS fraud_transactions,
    CAST(SUM(CAST(is_fraud AS INT)) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS fraud_rate
FROM Bank_Transaction_Fraud_Detection
GROUP BY
    CASE
        WHEN transaction_amount < 100 THEN 'Low'
        WHEN transaction_amount BETWEEN 100 AND 1000 THEN 'Medium'
        ELSE 'High'
    END;
