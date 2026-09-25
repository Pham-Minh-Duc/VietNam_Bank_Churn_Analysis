USE Data_Warehouse;

INSERT INTO fact_bank_churn (
    id,
    full_name,
    credit_score,
    gender,
    age,
    occupation,
    balance,
    monthly_income,
    address,
    origin_province,
    tenure_years,
    married,
    nums_card,
    nums_service,
    active_member,
    last_active_date,
    last_transaction_month,
    created_date,
    `exit`,
    customer_segment,
    engagement_score,
    loyalty_level,
    digital_behavior,
    risk_score,
    risk_segment,
    cluster_group
)
WITH clean_data AS (
    SELECT 
        CAST(id AS UNSIGNED) AS id,
        TRIM(COALESCE(full_name, 'Unknown')) AS full_name,
        CAST(COALESCE(credit_sco, 0) AS UNSIGNED) AS credit_score,
        TRIM(COALESCE(gender, 'Unknown')) AS gender,
        CAST(COALESCE(age, 0) AS UNSIGNED) AS age,
        TRIM(COALESCE(occupation, 'Unknown')) AS occupation,
        CAST(COALESCE(balance, 0) AS DECIMAL(15, 2)) AS balance,
        CAST(COALESCE(monthly_ir, 0) AS DECIMAL(15, 2)) AS monthly_income,
        TRIM(COALESCE(address, '')) AS address,
        TRIM(COALESCE(origin_province, 'Unknown')) AS origin_province,
        CAST(COALESCE(tenure_ye, 0) AS UNSIGNED) AS tenure_years,
        -- Chuyển dạng integer (0/1) sang text chuỗi ('Yes'/'No') cho phù hợp VARCHAR(20)
        CASE WHEN married = 1 THEN 'Yes' ELSE 'No' END AS married,
        CAST(COALESCE(nums_card, 0) AS UNSIGNED) AS nums_card,
        CAST(COALESCE(nums_service, 0) AS UNSIGNED) AS nums_service,
        CASE WHEN active_member = 1 THEN 'Yes' ELSE 'No' END AS active_member,
        COALESCE(last_active_date, '') AS last_active_date,
        CAST(COALESCE(last_transaction_month, 0) AS UNSIGNED) AS last_transaction_month,
        COALESCE(created_date, '') AS created_date,
        CASE WHEN `exit` = 1 THEN 'Yes' ELSE 'No' END AS `exit`,
        TRIM(COALESCE(customer_segment, 'Unknown')) AS customer_segment,
        CAST(COALESCE(engagement_score, 0) AS DECIMAL(10, 2)) AS engagement_score,
        TRIM(COALESCE(loyalty_level, 'Unknown')) AS loyalty_level,
        TRIM(COALESCE(digital_behavior, 'Unknown')) AS digital_behavior,
        CAST(COALESCE(risk_score, 0) AS DECIMAL(10, 2)) AS risk_score,
        TRIM(COALESCE(risk_segment, 'Unknown')) AS risk_segment,
        CAST(cluster_group AS CHAR(50)) AS cluster_group,
        ROW_NUMBER() OVER (
            PARTITION BY id 
            ORDER BY created_date DESC
        ) AS rn
    FROM data_lake.raw_bank_churn
)
SELECT 
    id, full_name, credit_score, gender, age, occupation,
    balance, monthly_income, address, origin_province, tenure_years,
    married, nums_card, nums_service, active_member, last_active_date,
    last_transaction_month, created_date, `exit`, customer_segment,
    engagement_score, loyalty_level, digital_behavior, risk_score,
    risk_segment, cluster_group
FROM clean_data
WHERE rn = 1;

-- Kiểm tra số lượng dòng đã chuyển đổi thành công
SELECT COUNT(*) AS total_dwh_records FROM fact_bank_churn;