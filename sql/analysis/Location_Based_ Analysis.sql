/*
Step: Location-Based Fraud Analysis
Purpose: Identify high-risk locations
*/

SELECT
   Bank_Branch,
    COUNT(*) AS total_transactions,
    SUM(cast(is_fraud AS int)) AS fraud_transactions
FROM Bank_Transaction_Fraud_Detection
GROUP BY Bank_Branch
HAVING SUM(CAST(is_fraud AS INT)) > 50
ORDER BY fraud_transactions DESC;
