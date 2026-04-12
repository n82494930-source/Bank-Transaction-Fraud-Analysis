/*
Project: Bank Transaction Fraud Analysis
Step: Data Validation & Understanding
Tool: SQL Server (SSMS)
*/

USE Bank_Fraud_Detection
GO
-- 1. Total number of transactions
CREATE VIEW dbo.vw_total_transactions
AS
SELECT COUNT(*) AS total_transactions
FROM dbo.Bank_Transaction_Fraud_Detection;
GO

-- 2. Fraud vs Non-Fraud distribution
CREATE VIEW dbo.vw_fraud_distribution
AS
SELECT
    is_fraud,
    COUNT(*) AS transaction_count
FROM dbo.Bank_Transaction_Fraud_Detection
GROUP BY is_fraud;

-- 3. Check NULL values in critical columns
CREATE VIEW dbo.vw_data_quality_issues
AS
SELECT
    SUM(CASE WHEN transaction_amount IS NULL THEN 1 ELSE 0 END) AS null_amount,
    SUM(CASE WHEN account_balance IS NULL THEN 1 ELSE 0 END) AS null_balance,
    SUM(CASE WHEN merchant_category IS NULL OR merchant_category = '' THEN 1 ELSE 0 END) AS invalid_merchant,
    SUM(CASE WHEN device_type IS NULL OR device_type = '' THEN 1 ELSE 0 END) AS invalid_device
FROM dbo.Bank_Transaction_Fraud_Detection;
GO

