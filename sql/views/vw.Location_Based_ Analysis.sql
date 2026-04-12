/*
Step: Location-Based Fraud Analysis
Purpose: Identify high-risk locations
*/

CREATE VIEW dbo.vw_bank_branch_fraud_analysis
AS
SELECT
    Bank_Branch,
    COUNT(*) AS total_transactions,
    SUM(CAST(is_fraud AS INT)) AS fraud_transactions
FROM dbo.Bank_Transaction_Fraud_Detection
GROUP BY Bank_Branch
HAVING SUM(CAST(is_fraud AS INT)) > 50;
GO

