
/*
Step: Time-Based Fraud Analysis
Purpose: Identify peak fraud hours
*/

SELECT
    DATEPART(HOUR, transaction_time) AS transaction_hour,
    COUNT(*) AS total_transactions,
    SUM(CAST(is_fraud AS INT)) AS fraud_transactions
FROM Bank_Transaction_Fraud_Detection
GROUP BY DATEPART(HOUR, transaction_time)
ORDER BY fraud_transactions DESC;