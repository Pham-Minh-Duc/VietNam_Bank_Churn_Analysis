CREATE DATABASE IF NOT EXISTS Data_Warehouse;

USE Data_Warehouse;

CREATE TABLE IF NOT EXISTS bank_churn_data(
	id INT PRIMARY KEY,
    full_name VARCHAR(255),
    credit_score INT,
    gender VARCHAR(20),
    age INT,
    occupation VARCHAR(100),
    balance DECIMAL(15, 2),
    monthly_income DECIMAL(15, 2),
    address VARCHAR(255),
    origin_province VARCHAR(100),
    tenure_years INT,
    married VARCHAR(20),
    nums_card INT,
    nums_service INT,
    active_member VARCHAR(20),
    last_active_date VARCHAR(50),
    last_transaction_month INT,
    created_date VARCHAR(50),
    `exit` VARCHAR(20),
    customer_segment VARCHAR(100),
    engagement_score DECIMAL(10, 2),
    loyalty_level VARCHAR(50),
    digital_behavior VARCHAR(100),
    risk_score DECIMAL(10, 2),
    risk_segment VARCHAR(50),
    cluster_group VARCHAR(50)
)