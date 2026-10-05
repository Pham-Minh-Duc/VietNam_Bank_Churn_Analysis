# 📊 EXECUTIVE SUMMARY: BANK CHURN ANALYTICS & RETENTION STRATEGY

> 🔗 **Quick Access Resources:**
> * **Live Interactive Financial Model (Google Sheets):** [Executive Summary & What-If Analysis](https://docs.google.com/spreadsheets/d/1F1jtjFdicCSO-IEV_Mwm4GL5nalJ68-FpJ1Y-bmoWq4/edit?hl=vi&gid=1736678425#gid=1736678425)
> * **Offline Data Summary (Excel):** `reports/bank_churn_financial_pivot_summary.xlsx`
> * **Interactive Power BI Dashboard File:** `reports/Bank_Churn_Analytics.pbix`

---

## 🚨 1. Context & Business Problem Statement
Trong kỳ phân tích, ngân hàng ghi nhận tỷ lệ khách hàng rời bỏ (Churn Rate) ở mức **18.00%**, gây rò rỉ nguồn vốn tài sản ròng lớn (**$282.38M Lost Balance**). 

* **Mục tiêu dự án:** Phân tích nguyên nhân gốc rễ (Root Cause) gây churn và thiết lập mô hình Retention giúp đưa Churn Rate về **dưới 12%** (mức an toàn/chuẩn mực ngành), qua đó cứu vãn tối thiểu **~$94.1M+** tài sản ròng bị thất thoát.

---

## 🔍 2. Core Data Insights (Phát hiện chính)

1. **Nhóm khách hàng thụ động (`Inactive Members`) có nguy cơ Churn cao gấp 3.2 lần:**
   * Tỷ lệ rời bỏ ở nhóm `Inactive` chạm mức **21.14%**, trong khi nhóm `Active` chỉ ở mức **6.50%**.
2. **Nhóm tiệm cận hưu trí (40–60 tuổi) có số dư tài khoản cao nhưng Rủi ro Churn lớn:**
   * Khách hàng thuộc phân khúc 40–50 và 50–60 tuổi tập trung phần lớn tài sản bị thất thoát và bị hệ thống phân loại vào nhóm `High Risk`.
3. **Phân khúc khách hàng trẻ (<30 tuổi) có tỷ lệ churn cao nhất:**
   * Tỷ lệ rời bỏ ở nhóm Under 30 lên đến **25.51%** do thiếu sự ràng buộc sản phẩm và trải nghiệm ứng dụng số chưa đủ hấp dẫn.
4. **Mức độ gắn kết sản phẩm (Product Bundling):**
   * Khách hàng chỉ dùng 1–2 dịch vụ có tỷ lệ chuyển đổi sang ngân hàng đối thủ cao vượt trội so với nhóm sử dụng từ 3 sản phẩm trở lên.

---

## 💡 3. Actionable Business Recommendations (4 Chiến lược Trọng tâm)

* **Strategy 1: Retention cho nhóm Tiệm cận hưu trí (40–50+):**
  * Thiết kế các gói tiết kiệm dưỡng già, sản phẩm bảo hiểm liên kết đầu tư (Bancassurance) và cung cấp dịch vụ chăm sóc khách hàng ưu tiên (Priority Banking 1-1).
* **Strategy 2: Cấu trúc lại phí & Ưu đãi Bó sản phẩm (Bundle 3+ Products):**
  * Miễn/giảm phí quản lý tài khoản cho khách hàng sử dụng đồng thời 3+ sản phẩm nhằm gia tăng chi phí chuyển đổi (Switching Cost).
* **Strategy 3: Hệ thống Cảnh báo Tự động (Early Warning System for Inactive):**
  * Tự động phát hiện tài khoản không phát sinh giao dịch trong 30–60 ngày để kích hoạt ngay các chiến dịch Re-engagement cá nhân hóa (hoàn tiền, voucher, nhắc thanh toán tự động).
* **Strategy 4: Tối ưu App & Gamification cho giới trẻ (<30):**
  * Nâng cấp UI/UX Mobile Banking App, tích hợp công cụ quản lý tài chính cá nhân (PFM) và chương trình hoàn tiền (Cashback) liên kết hệ sinh thái.

---

## 💰 4. Financial Impact & KPI Metrics

| Chỉ số Đo lường (Metric) | Trạng thái Hiện tại | Mục tiêu Strategy (KPI) | Tác động Tài chính Dự kiến |
| :--- | :--- | :--- | :--- |
| **Overall Churn Rate** | **18.00%** | **< 12.00%** | Giảm 33.3% lượng khách hàng rời bỏ |
| **Protected Balance** | $0M | **~$94.1M+** | Giữ lại tối thiểu $94.1M tài sản ròng |
| **Inactive Re-activation** | — | **25%** | Tái kích hoạt dòng tiền giao dịch nhóm Inactive |

---

*Báo cáo được tổng hợp bởi **Phạm Minh Đức** — VietNam Bank Churn Analytics Project.*