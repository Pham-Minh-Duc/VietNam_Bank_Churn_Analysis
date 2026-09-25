### (REQ-1)
#### 1. Đặt vấn đề & Mục tiêu (REQ-1)
##### Bối cảnh: Ngân hàng nhận thấy tỷ lệ khách hàng ngưng sử dụng dịch vụ (Exited = 1) có xu hướng gia tăng, gây thất thoát doanh thu và chi phí quản lý tài sản.

##### Mục tiêu dự án:

##### Xác định chân dung nhóm khách hàng có rủi ro rời bỏ cao nhất.

##### Đo lường tổng giá trị tài sản/số dư tiền gửi bị thất thoát do Churn.
##### Đề xuất các chiến lược giữ chân khách hàng (Customer Retention) dựa trên dữ liệu.

##### Bộ câu hỏi cốt lõi (Core Business Questions):

##### Tỷ lệ Churn Rate tổng thể của ngân hàng hiện tại là bao nhiêu?
##### Độ tuổi, số lượng sản phẩm (NumOfProducts), và trạng thái hoạt động (IsActiveMember) ảnh hưởng như thế nào đến rủi ro rời bỏ?
##### Nhóm khách hàng có số dư cao (Balance) rời bỏ tập trung ở phân khúc nào?

#### 2. Tiêu chí thành công & Kết quả bàn giao (REQ-2)
##### KPIs đo lường thành công:

##### Xác định chính xác top 3 yếu tố hàng đầu dẫn đến Churn.
##### Phân loại được danh sách khách hàng rủi ro cao để chuyển cho bộ phận chăm sóc khách hàng.

##### Bộ deliverables bàn giao:

##### 1_data_cleaning_and_transformation.sql: File chứa script SQL làm sạch và tạo View analytics.
##### 2_eda_churn_analysis.ipynb: File Jupyter Notebook chứa câu lệnh Python/SQL phân tích EDA.
##### 3_Bank_Churn_Report.xlsx: Báo cáo Excel tĩnh gồm Pivot Tables, mô phỏng tài chính What-If và bộ công cụ tra cứu rủi ro Customer_Lookup.
##### 4_Bank_Churn_Dashboard.pbix: Dashboard Power BI tương tác đa chiều.