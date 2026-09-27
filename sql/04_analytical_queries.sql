USE data_warehouse;

-- 1. Tạo VIEW tổng hợp dữ liệu Analytics cho Excel & Power BI
-- Kết hợp Window Functions để xếp hạng và so sánh với mức trung bình
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

-- 2. Kiểm tra kết quả View vừa tạo
SELECT 
    *, 
    ROUND(avg_balance_by_age_group, 2) AS avg_age_balance,
    `exit`
FROM v_bank_churn_analytics
ORDER BY rank_by_balance ASC
LIMIT 10;