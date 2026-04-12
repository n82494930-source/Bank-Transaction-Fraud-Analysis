/*
Step: Key Business Metrics
Purpose: Measure overall fraud exposure
*/

-- Overall fraud metrics
SELECT
    COUNT(*) AS total_transactions,
    SUM(CAST(is_fraud AS INT)) AS fraud_transactions,
    CAST(SUM(CAST(is_fraud AS INT)) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS fraud_rate_percent
FROM Bank_Transaction_Fraud_Detection;