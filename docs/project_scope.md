# 🎯 Project Scope: Bank Churn Analytics & Retention Strategy

## 📌 1. Executive Summary & Business Problem
* **Bối cảnh:** Ngân hàng đang đối mặt với tỷ lệ khách hàng rời bỏ (Churn Rate) ở mức **18.00%**, gây thất thoát số dư tài sản ròng lớn (**$282.38M Lost Balance**).
* **Mục tiêu chiến lược:** Xây dựng hệ thống phân tích dữ liệu tập trung (Data Warehouse & Power BI Dashboard) nhằm nhận diện nhóm khách hàng có nguy cơ rời bỏ cao, từ đó đề xuất 4 chiến lược retention giúp đưa Churn Rate về **dưới 12%** và bảo vệ tối thiểu **$94M+** tài sản ròng.

---

## 🏗️ 2. End-to-End Technical Architecture
Dự án được xây dựng theo mô hình Modern Data Stack thu nhỏ với các giai đoạn:

1. **Data Ingestion & Lake:** Nạp dữ liệu thô (80,000 khách hàng) vào MySQL Data Lake.
2. **ETL & Data Warehouse:**
   * Sử dụng Python (`pandas`, `sqlalchemy`) & SQL Scripts để làm sạch, xử lý trùng lặp và biến đổi dữ liệu.
   * Tạo mô hình Star Schema / Analytical Views (`v_bank_churn_transformed`) phục vụ phân tích.
3. **Exploratory Data Analysis (EDA):** Sử dụng Jupyter Notebooks phân tích tương quan giữa thâm niên, độ tuổi, số dư, mức độ hoạt động với trạng thái Churn.
4. **BI Dashboard & Modeling (Power BI):** 
   * Xây dựng mô hình dữ liệu (Data Model), viết các chỉ số DAX measures.
   * Thiết kế Dashboard 3 tầng (3-tier layout: Header/Filters $\rightarrow$ KPI Row $\rightarrow$ Main Visuals/Detail Table) tối ưu trải nghiệm C-Level Executive.

---

## 🎯 3. In-Scope vs. Out-of-Scope

### ✅ In-Scope (Nằm trong phạm vi dự án)
* **Data Processing:** Xử lý và làm sạch dữ liệu khách hàng cá nhân (80,000 records).
* **Data Warehouse:** Xây dựng View tổng hợp `v_bank_churn_transformed` trong MySQL.
* **DAX & UI/UX:** Thiết kế 100% giao diện báo cáo tương tác trên Power BI với đầy đủ nhãn chuẩn (`Active/Inactive`, `Churned/Retained`).
* **Financial & What-If Modeling:** Xây dựng bảng Pivot & What-if Analysis trên Google Sheets/Excel.
* **Actionable Recommendations:** Đề xuất 4 giải pháp giữ chân khách hàng (Gói hưu trí 40–50t, Cấu trúc phí 3+ sản phẩm, Cảnh báo tự động KH thụ động, Tối ưu app giới trẻ).

### ❌ Out-of-Scope (Bên ngoài phạm vi dự án)
* **Real-time Streaming:** Chưa triển khai pipeline đọc dữ liệu thời gian thực (Kafka/Spark).
* **Machine Learning Deployment:** Dự án tập trung vào Descriptive & Diagnostic Analytics, chưa deploy mô hình MLOps dự báo tự động lên Cloud.
* **Automated Action Execution:** Chưa tích hợp trực tiếp API gửi email/SMS tự động đến khách hàng (chỉ dừng ở mức đề xuất giải pháp cho phòng Marketing/CRM).

---

## 📦 4. Key Deliverables (Sản phẩm bàn giao)
* `sql/`: Bộ script khởi tạo Database, ETL pipeline và Analytical Queries.
* `notebooks/`: File Jupyter Notebook EDA phân tích chuyên sâu.
* `reports/`: File báo cáo Power BI (`.pbix`), ảnh chụp Dashboard preview và file Excel Pivot Summary.
* `docs/`: Bộ tài liệu kỹ thuật hoàn chỉnh (`data_dictionary.md`, `project_scope.md`, `actionable_recommendations.md`).