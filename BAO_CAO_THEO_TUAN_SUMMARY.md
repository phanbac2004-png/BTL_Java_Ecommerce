# Tóm tắt báo cáo doanh thu theo tuần

## Các file đã tạo

### 1. SQL Query mẫu
- **File**: `db/weekly_revenue_query.sql`
- Chứa SQL query mẫu để lấy doanh thu theo tuần

### 2. Entity Model
- **File**: `src/java/entity/WeeklyRevenue.java`
- Model với 2 field:
  - `int weekNumber`: Số tuần (1-5)
  - `double revenue`: Doanh thu

### 3. DAO Method
- **File**: `src/java/dao/DAO.java`
- Hàm: `List<WeeklyRevenue> getRevenueByWeek(int month, int year)`
- Tách tuần theo yêu cầu:
  - Tuần 1: ngày 1-7
  - Tuần 2: ngày 8-14
  - Tuần 3: ngày 15-21
  - Tuần 4: ngày 22-28
  - Tuần 5: ngày 29-31

### 4. Controller
- **File**: `src/java/control/ReportWeeklyController.java`
- **URL**: `/admin/report-weekly`
- Xử lý:
  - Nhận tham số month, year
  - Gọi DAO để lấy dữ liệu
  - Sắp xếp theo doanh thu giảm dần
  - Forward sang JSP

### 5. JSP Page
- **File**: `web/report-weekly.jsp`
- Tính năng:
  - Form chọn tháng/năm
  - Bảng hiển thị doanh thu từng tuần
  - Biểu đồ Chart.js hiển thị trực quan
  - Sắp xếp giảm dần theo doanh thu

## Cách sử dụng

1. **Build project**: Clean & Build trong NetBeans
2. **Truy cập**: `http://localhost:16905/ShopTreEmChinhThuc/admin/report-weekly`
3. **Chọn tháng/năm** và nhấn "Xem báo cáo"

## SQL Query mẫu

```sql
SELECT 
    CASE 
        WHEN DAY(orderDate) BETWEEN 1 AND 7 THEN 1
        WHEN DAY(orderDate) BETWEEN 8 AND 14 THEN 2
        WHEN DAY(orderDate) BETWEEN 15 AND 21 THEN 3
        WHEN DAY(orderDate) BETWEEN 22 AND 28 THEN 4
        WHEN DAY(orderDate) >= 29 THEN 5
    END AS week_number,
    COALESCE(SUM(totalPrice), 0) AS total_revenue
FROM orders
WHERE status != 'Cancelled'
  AND YEAR(orderDate) = 2024
  AND MONTH(orderDate) = 11
GROUP BY week_number
ORDER BY week_number;
```

## Lưu ý

- Servlet tự động sắp xếp theo doanh thu giảm dần
- Bảng hiển thị tuần có doanh thu cao nhất ở trên
- Biểu đồ hiển thị tất cả 5 tuần
- Tuần 5 chỉ có dữ liệu nếu tháng có ngày 29-31

