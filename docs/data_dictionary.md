# Data Dictionary: Bank Churn Analytics Data Warehouse

## 1. Overview
Tài liệu này mô tả chi tiết từ điển dữ liệu cho bảng thực thể chính/view đã phân tích `v_bank_churn_transformed` nằm trong Data Warehouse (`data_warehouse`). Bảng bao gồm thông tin định danh khách hàng, hành vi giao dịch, phân khúc rủi ro và trạng thái rời bỏ (Churn)[cite: 1].

---

## 2. Field Definitions

### A. Customer Profile (Thông tin Định danh & Nhân khẩu học)
| Column Name | Data Type | Description | Example / Values |
| :--- | :--- | :--- | :--- |
| `id` | Integer | Mã định danh duy nhất của khách hàng (Primary Key) | `1`, `2`, `3` |
| `full_name` | String | Họ và tên khách hàng | `Đặng Văn Vũ` |
| `gender` | String | Giới tính khách hàng | `male`, `female` |
| `age` | Integer | Độ tuổi khách hàng (tính đến thời điểm hiện tại) | `45`, `55` |
| `age_group` | String | Phân nhóm độ tuổi khách hàng | `Under 30`, `30-45`, `46-60`, `Over 60` |
| `occupation` | String | Nghề nghiệp của khách hàng | `Chủ Doanh nghiệp nhỏ`, `Nội trợ/Sinh viên` |
| `married` | String | Tình trạng hôn nhân | `Yes`, `No` |
| `address` | String | Địa chỉ liên hệ hiện tại | `Phường An Hội (BT)` |
| `origin_province` | String | Tỉnh/Thành phố quê quán hoặc nơi mở tài khoản | `TP. Hồ Chí Minh`, `Đồng Nai` |

---

### B. Financial Profile & Engagement (Tài chính & Mức độ Gắn kết)
| Column Name | Data Type | Description | Example / Values |
| :--- | :--- | :--- | :--- |
| `credit_score` | Integer | Điểm tín dụng của khách hàng | `689`, `725` |
| `credit_score_group` | String | Phân loại nhóm điểm tín dụng | `Poor`, `Fair`, `Good`, `Excellent` |
| `balance` | Decimal/Int | Số dư hiện tại trong tài khoản ngân hàng (VND) | `177,306,004` |
| `balance_group` | String | Nhóm quy mô số dư tài khoản | `Low Balance`, `Medium Balance`, `High Balance` |
| `monthly_income` | Decimal/Int | Thu nhập bình quân hàng tháng (VND) | `121,000,000` |
| `tenure_years` | Integer | Số năm thâm niên sử dụng dịch vụ ngân hàng | `0`, `3`, `5` |
| `nums_card` | Integer | Số lượng thẻ ngân hàng đang sở hữu | `1`, `3`, `4` |
| `nums_service` | Integer | Số lượng dịch vụ/sản phẩm ngân hàng đang dùng | `2`, `8` |
| `customer_segment` | String | Phân khúc khách hàng theo tài sản/thu nhập | `Mass`, `Affluent`, `Priority` |

---

### C. Behavioral & Risk Indicators (Hành vi Số & Đánh giá Rủi ro)
| Column Name | Data Type | Description | Example / Values |
| :--- | :--- | :--- | :--- |
| `active_member` | String / Enum | Trạng thái hoạt động thường xuyên | `Yes` (Active), `No` (Inactive) |
| `digital_behavior` | String | Kênh giao dịch ưa thích chính | `mobile`, `web`, `branch` |
| `engagement_score` | Integer | Điểm số đánh giá độ tương tác (Scale 1–100) | `63`, `90` |
| `loyalty_level` | String | Cấp độ thành viên trung thành | `Bronze`, `Silver`, `Gold`, `Platinum` |
| `risk_score` | Float | Chỉ số xác suất rủi ro rời bỏ (Scale 0.0 – 1.0) | `0.04`, `0.27` |
| `risk_segment` | String | Phân loại nhóm rủi ro gốc | `Low`, `Medium`, `High` |
| `calculated_risk_segment` | String | Phân đoạn rủi ro được tính toán lại qua ETL | `High Risk`, `Low Risk` |
| `cluster_group` | Integer | Mã nhóm phân tích gom cụm khách hàng (Clustering) | `1`, `2`, `3`, `4` |

---

### D. Activity Dates & Target Variable (Biến Mục tiêu & Thời gian)
| Column Name | Data Type | Description | Example / Values |
| :--- | :--- | :--- | :--- |
| `created_date` | Date | Ngày mở tài khoản tại ngân hàng | `27/02/2025` |
| `last_active_date` | Date | Ngày phát sinh giao dịch/tương tác gần nhất | `2025-03-04` |
| `last_transaction_month` | Integer | Giá trị/Số tháng tương tác gần đây | `3255569` |
| `exit` | String | **Biến mục tiêu (Target):** Khách hàng rời bỏ hay ở lại | `Yes` (Churned), `No` (Retained) |
| `exit_num` | Integer | Cờ nhị phân phản ánh trạng thái churn | `1` (Churned), `0` (Retained) |

---

## 🛠️ 3. Data Transformation & Mapping Rules
1. **Trạng thái Active Status:** 
   * `active_member = 'Yes'` $\rightarrow$ Cập nhật label UI thành **`Active`**.
   * `active_member = 'No'` $\rightarrow$ Cập nhật label UI thành **`Inactive`**.
2. **Trạng thái Churn:** 
   * `exit = 'Yes'` (hoặc `exit_num = 1`) $\rightarrow$ Khách hàng đã rời bỏ (**`Churned`**).
   * `exit = 'No'` (hoặc `exit_num = 0`) $\rightarrow$ Khách hàng ở lại (**`Retained`**).