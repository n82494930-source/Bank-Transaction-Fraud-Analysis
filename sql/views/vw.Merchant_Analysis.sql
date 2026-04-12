/*
Step: Merchant Risk Analysis
Purpose: Identify high-risk merchant categories
*/
CREATE VIEW dbo.vw_merchant_fraud_analysis
AS
SELECT
    merchant_category,
    COUNT(*) AS total_transactions,
    SUM(CAST(is_fraud AS INT)) AS fraud_transactions,
    CAST(SUM(CAST(is_fraud AS INT)) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS fraud_rate
FROM dbo.Bank_Transaction_Fraud_Detection
GROUP BY merchant_category
HAVING COUNT(*) > 500;
GO









































-- 3. Check NULL values in critical columns
SELECT
    SUM(CASE WHEN transaction_amount IS NULL THEN 1 ELSE 0 END) AS null_amount,
    SUM(CASE WHEN account_balance IS NULL THEN 1 ELSE 0 END) AS null_balance,
    SUM(CASE WHEN merchant_category IS NULL THEN 1 ELSE 0 END) AS null_merchant,
    SUM(CASE WHEN device_type IS NULL THEN 1 ELSE 0 END) AS null_device
FROM Bank_Transaction_Fraud_Detection;
SELECT
    SUM(CASE WHEN merchant_category = '' THEN 1 ELSE 0 END) AS empty_merchant,
    SUM(CASE WHEN device_type = '' THEN 1 ELSE 0 END) AS empty_device
FROM Bank_Transaction_Fraud_Detection;
