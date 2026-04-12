{{config(schema = 'bank_stage_layer',alias = 'stg_transactions', materialized = 'incremental')}}    

WITH stage_layer AS (
    SELECT 
     Customer_ID AS customer_id,
     Customer_Name AS customer_name,
     Gender AS gender,
     Age AS age,
     State AS state,
     City AS city,
     Bank_Branch AS bank_branch,
     Account_Type AS account_type,
     Transaction_ID AS transaction_id,
     Transaction_Date AS transaction_date,
     Transaction_Time AS transaction_time,
     Transaction_Amount AS transaction_amount,
     Merchant_ID  AS merchant_id,
     Transaction_Type AS transaction_type,
     Merchant_Category AS merchant_category,
     Account_Balance AS account_balance,
     Transaction_Device AS transaction_device,
     Transaction_Location AS transaction_location, 
     Device_Type AS device_type,
     Is_Fraud AS is_fraud,
     Transaction_Currency AS transaction_currency,
     Customer_Contact AS customer_contact,
     Transaction_Description AS transaction_description,
     Customer_Email AS customer_email
    FROM {{source('bank_data', 'banking_data')}}
)

SELECT * from stage_layer
