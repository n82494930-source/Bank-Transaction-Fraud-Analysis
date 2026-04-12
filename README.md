Bank Transaction Fraud Detection Pipeline and analysis
(dbt + BigQuery)

Project Overview:
This project builds an end-to-end fraud detection analytics and bank analysis pipeline using dbt and BigQuery.  
It processes raw bank transaction data and applies business rules + statistical methods to identify suspicious transactions and customer behavior patterns and analysis.
It also contains some sql files which are related to metric based analysis(likedevice based_analysis, location_based analysis etc) in the project.

Data Pipeline Architecture

1.Staging Layer (stg_transactions)
  Raw data ingestion
  Data cleaning and standardization
  Type casting and basic transformations

2.Intermediate Layer (int_transactions)
This is the core transformation layer where analytics logic is applied:

 Fraud Scoring Logic
  High transaction amount ? risk points
  Unusual transaction time (1 AM – 4 AM)
  New device usage
  Location mismatch (transaction vs city)

 Analytical Features
  Customer average transaction amount
  Bank branch average account balance
  Rolling average (3 transactions)
  7-day rolling transaction trend
  Z-score normalization for anomaly detection

3.Data Mart Layer
  Dimension tables:
  - Customers
  - Date
  - Device
  - Merchant
  - Time
  Fact table:
  - Enriched transaction facts with fraud signals

 Fraud Detection Logic

  Fraud Score Classification
    70+ ? HIGH RISK 
    50–69 ? MEDIUM RISK 
    < 50 ? LOW RISK 

 Z-Score Anomaly Detection
    ? 1 ? Normal behavior
    1 – 2 ? Slightly unusual
    2 – 3 ? Moderate risk
    > 3 ? Highly suspicious
    < -2 ? Unusual low spending pattern


Tech Stack
- dbt (Data Build Tool)
- Google BigQuery
- SQL (Advanced window functions)
- Git & GitHub

Key Features
- Incremental dbt models for performance optimization
- Window functions for behavioral analytics
- Rule-based + statistical fraud detection
- Star schema design (Facts + Dimensions)
- Modular dbt architecture

---

Outcome
This project demonstrates a real-world fraud detection system and bank analysis used for:
- Identifying suspicious transactions
- Detecting abnormal customer behavior
- Supporting financial risk analysis
- Analysing transactions

Project Structure
models/
??? 01_stage/
??? 02_intermediate/
??? 03_data_marts/
macros/
tests/
seeds/
snapshots/