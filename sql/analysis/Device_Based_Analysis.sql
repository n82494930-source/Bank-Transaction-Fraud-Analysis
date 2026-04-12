
 /*
Step: Device-Based Fraud Analysis
Purpose: Identify devices with higher fraud rates
*/

SELECT
    device_type,
    COUNT(*) AS total_transactions,
    SUM(CAST(is_fraud AS INT)) AS fraud_transactions,
    CAST(SUM(CAST(is_fraud AS INT)) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS fraud_rate
FROM Bank_Transaction_Fraud_Detection
GROUP BY device_type
ORDER BY fraud_rate DESC;