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

-----------------------------------------------------------------------------------------------------------

USE data_warehouse;

-- Tạo hoặc đè lên View nếu đã tồn tại
CREATE OR REPLACE VIEW v_bank_churn_transformed AS
SELECT 
    c.*,
    
    -- 1. Nhóm độ tuổi (Age Group)
    CASE 
        WHEN c.age < 30 THEN 'Under 30'
        WHEN c.age BETWEEN 30 AND 45 THEN '30-45'
        WHEN c.age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Over 60'
    END AS age_group,

    -- 2. Nhóm số dư (Balance Group)
    CASE 
        WHEN c.balance = 0 THEN 'Zero Balance'
        WHEN c.balance < 50000 THEN 'Low Balance'
        WHEN c.balance BETWEEN 50000 AND 120000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS balance_group,

    -- 3. Nhóm điểm tín dụng (Credit Score Group)
    CASE 
        WHEN c.credit_score < 500 THEN 'Poor'
        WHEN c.credit_score BETWEEN 500 AND 650 THEN 'Fair'
        WHEN c.credit_score BETWEEN 651 AND 750 THEN 'Good'
        ELSE 'Excellent'
    END AS credit_score_group,

    -- 4. Đánh giá phân khúc rủi ro Churn (Risk Segment)
    CASE 
    WHEN c.age BETWEEN 46 AND 60 AND c.active_member = 0 THEN 'High Risk'
    WHEN (c.nums_service + c.nums_card) >= 4 THEN 'High Risk'  -- Tổng số thẻ + dịch vụ >= 4
    WHEN c.balance = 0 AND c.active_member = 0 THEN 'Medium Risk'
    ELSE 'Low Risk'
END AS calculated_risk_segment

FROM fact_bank_churn c;

SELECT f.customer_id, v.age_group, .balance_group, v.calculated_risk_segment, f.exited 
FROM v_bank_churn_transformed v
JOIN fact_bank_churn f ON 
LIMIT 10;