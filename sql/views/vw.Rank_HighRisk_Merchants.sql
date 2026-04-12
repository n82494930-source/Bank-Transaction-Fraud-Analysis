
/*
Purpose: Rank high-risk merchants using window functions
*/
CREATE VIEW dbo.vw_top_5_risky_merchants
AS
WITH MerchantRisk AS (
    SELECT
        merchant_category,
        SUM(CAST(is_fraud AS INT)) AS fraud_transactions,
        RANK() OVER (ORDER BY SUM(CAST(is_fraud AS INT)) DESC) AS risk_rank
    FROM dbo.Bank_Transaction_Fraud_Detection
    GROUP BY merchant_category
)
SELECT
    merchant_category,
    fraud_transactions,
    risk_rank
FROM MerchantRisk
WHERE risk_rank <= 5;
GO
