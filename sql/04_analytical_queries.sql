USE data_warehouse;

CREATE OR REPLACE VIEW v_bank_churn_analytics AS
SELECT 
    v.*,
    
    -- Xếp hạng khách hàng theo số dư tài khoản giảm dần
    RANK() OVER (
        ORDER BY v.balance DESC
    ) AS rank_by_balance,
    
    -- Xếp hạng số dư theo từng nhóm độ tuổi (Age Group)
    DENSE_RANK() OVER (
        PARTITION BY v.age_group 
        ORDER BY v.balance DESC
    ) AS rank_in_age_group,
    
    -- Số dư trung bình của nhóm độ tuổi tương ứng (để so sánh cá nhân với trung bình nhóm)
    AVG(v.balance) OVER (
        PARTITION BY v.age_group
    ) AS avg_balance_by_age_group,
    
    -- Mức chênh lệch số dư của khách hàng so với trung bình nhóm độ tuổi
    (v.balance - AVG(v.balance) OVER (PARTITION BY v.age_group)) AS diff_from_age_avg_balance

FROM v_bank_churn_transformed v;

SELECT 
    *, 
    ROUND(avg_balance_by_age_group, 2) AS avg_age_balance,
    `exit`
FROM v_bank_churn_analytics
ORDER BY rank_by_balance ASC
LIMIT 10;




-- ====================================================================
-- QUERY 1: Tỷ lệ Churn theo Nhóm độ tuổi (Age Group)
-- Giúp nhận diện độ tuổi nào có nguy cơ đóng tài khoản cao nhất.
-- ====================================================================
SELECT 
    age_group,
    COUNT(id) AS total_customers,
    SUM(CASE WHEN `exit` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN `exit` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(id), 2) AS churn_rate_pct,
    ROUND(AVG(balance), 2) AS avg_balance_vnd
FROM v_bank_churn_transformed
GROUP BY age_group
ORDER BY age_group ASC;


-- ====================================================================
-- QUERY 2: Tỷ lệ Churn theo Giới tính (Gender)
-- So sánh hành vi rời bỏ giữa khách hàng Nam và Nữ.
-- ====================================================================
SELECT 
    gender,
    COUNT(id) AS total_customers,
    SUM(CASE WHEN `exit` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN `exit` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(id), 2) AS churn_rate_pct,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income_vnd
FROM v_bank_churn_transformed
GROUP BY gender
ORDER BY churn_rate_pct DESC;


-- ====================================================================
-- QUERY 3: Tỷ lệ Churn theo Tỉnh / Thành phố gốc (Origin Province)
-- Phát hiện khu vực thị trường đang có chất lượng dịch vụ hoặc tỷ lệ giữ chân kém.
-- ====================================================================
SELECT 
    origin_province,
    COUNT(id) AS total_customers,
    SUM(CASE WHEN `exit` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN `exit` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(id), 2) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN `exit` = 'Yes' THEN balance ELSE 0 END), 2) AS total_lost_balance_vnd
FROM v_bank_churn_transformed
GROUP BY origin_province
HAVING COUNT(id) >= 50 -- Bỏ qua các tỉnh thành có quá ít khách hàng để tránh nhiễu
ORDER BY churn_rate_pct DESC;



-- ====================================================================
-- 1. Churn Rate theo Số lượng Dịch vụ (nums_service)
-- ====================================================================
SELECT 
    nums_service,
    COUNT(id) AS total_customers,
    SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(id), 2) AS churn_rate_pct
FROM v_bank_churn_transformed
GROUP BY nums_service
ORDER BY nums_service ASC;

-- ====================================================================
-- 2. Churn Rate theo Trạng thái Hoạt động (active_member)
-- ====================================================================
SELECT 
    CASE WHEN active_member = 'Yes' THEN 'Active Member' ELSE 'Inactive Member' END AS member_status,
    COUNT(id) AS total_customers,
    SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(id), 2) AS churn_rate_pct,
    ROUND(AVG(balance), 2) AS avg_balance_vnd
FROM v_bank_churn_transformed
GROUP BY active_member;

-- ====================================================================
-- 3. Churn Rate theo Nhóm Điểm Tín Dụng (credit_score_group)
-- ====================================================================
SELECT 
    credit_score_group,
    COUNT(id) AS total_customers,
    SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(id), 2) AS churn_rate_pct
FROM v_bank_churn_transformed
GROUP BY credit_score_group
ORDER BY churn_rate_pct DESC;



-- ====================================================================
-- [EDA-3] TỔNG HỢP THIỆT HẠI TÀI CHÍNH & CHỦYỂN ĐỔI CHURN
-- ====================================================================
SELECT 
    COUNT(id) AS total_customers,
    SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN 1 ELSE 0 END) AS total_churned_customers,
    ROUND(SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(id), 2) AS overall_churn_rate_pct,
    
    -- Tổng tiền gửi của toàn bộ ngân hàng
    ROUND(SUM(balance), 2) AS total_bank_balance_vnd,
    
    -- Tổng số tiền gửi bị mất do khách hàng rời bỏ (Financial Loss)
    ROUND(SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN balance ELSE 0 END), 2) AS total_lost_balance_vnd,
    
    -- Tỷ lệ tiền gửi bị thất thoát so với tổng tài sản tiền gửi (%)
    ROUND(
        SUM(CASE WHEN `exit` = 1 OR `exit` = 'Yes' THEN balance ELSE 0 END) * 100.0 / SUM(balance), 
        2
    ) AS lost_balance_pct
FROM v_bank_churn_transformed;