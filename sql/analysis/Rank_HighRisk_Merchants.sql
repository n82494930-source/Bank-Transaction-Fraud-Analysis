
/*
Purpose: Rank high-risk merchants using window functions
*/

WITH MerchantRisk AS (
    SELECT
        merchant_category,
        SUM(CAST(is_fraud AS INT)) AS fraud_transactions,
        RANK() OVER (ORDER BY SUM(CAST(is_fraud AS INT)) DESC) AS risk_rank
    FROM Bank_Transaction_Fraud_Detection
    GROUP BY merchant_category
)
SELECT *
FROM MerchantRisk
WHERE risk_rank <= 5;