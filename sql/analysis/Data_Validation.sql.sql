/*
Project: Bank Transaction Fraud Analysis
Step: Data Validation & Understanding
Tool: SQL Server (SSMS)
*/

USE Bank_Fraud_Detection
GO
-- 1. Total number of transactions
SELECT COUNT(*) AS total_transactions
FROM Bank_Transaction_Fraud_Detection;
-- 2. Fraud vs Non-Fraud distribution
SELECT 
    is_fraud,
    COUNT(*) AS transaction_count
FROM Bank_Transaction_Fraud_Detection
GROUP BY is_fraud;
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