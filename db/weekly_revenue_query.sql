-- SQL Query mẫu để lấy doanh thu theo tuần trong một tháng
-- Input: month = 11, year = 2024
-- Tách tuần:
--   Tuần 1: ngày 1-7
--   Tuần 2: ngày 8-14
--   Tuần 3: ngày 15-21
--   Tuần 4: ngày 22-28
--   Tuần 5: ngày 29-31 (nếu có)

-- Query cho Tuần 1 (ngày 1-7)
SELECT 1 AS week_number, COALESCE(SUM(totalPrice), 0) AS total_revenue
FROM orders
WHERE status != 'Cancelled'
  AND YEAR(orderDate) = 2024
  AND MONTH(orderDate) = 11
  AND DAY(orderDate) BETWEEN 1 AND 7

UNION ALL

-- Query cho Tuần 2 (ngày 8-14)
SELECT 2 AS week_number, COALESCE(SUM(totalPrice), 0) AS total_revenue
FROM orders
WHERE status != 'Cancelled'
  AND YEAR(orderDate) = 2024
  AND MONTH(orderDate) = 11
  AND DAY(orderDate) BETWEEN 8 AND 14

UNION ALL

-- Query cho Tuần 3 (ngày 15-21)
SELECT 3 AS week_number, COALESCE(SUM(totalPrice), 0) AS total_revenue
FROM orders
WHERE status != 'Cancelled'
  AND YEAR(orderDate) = 2024
  AND MONTH(orderDate) = 11
  AND DAY(orderDate) BETWEEN 15 AND 21

UNION ALL

-- Query cho Tuần 4 (ngày 22-28)
SELECT 4 AS week_number, COALESCE(SUM(totalPrice), 0) AS total_revenue
FROM orders
WHERE status != 'Cancelled'
  AND YEAR(orderDate) = 2024
  AND MONTH(orderDate) = 11
  AND DAY(orderDate) BETWEEN 22 AND 28

UNION ALL

-- Query cho Tuần 5 (ngày 29-31) - chỉ áp dụng cho các tháng có ngày 29-31
SELECT 5 AS week_number, COALESCE(SUM(totalPrice), 0) AS total_revenue
FROM orders
WHERE status != 'Cancelled'
  AND YEAR(orderDate) = 2024
  AND MONTH(orderDate) = 11
  AND DAY(orderDate) BETWEEN 29 AND 31

ORDER BY week_number;

-- Hoặc sử dụng cách tối ưu hơn với CASE WHEN:
SELECT 
    CASE 
        WHEN DAY(orderDate) BETWEEN 1 AND 7 THEN 1
        WHEN DAY(orderDate) BETWEEN 8 AND 14 THEN 2
        WHEN DAY(orderDate) BETWEEN 15 AND 21 THEN 3
        WHEN DAY(orderDate) BETWEEN 22 AND 28 THEN 4
        WHEN DAY(orderDate) BETWEEN 29 AND 31 THEN 5
    END AS week_number,
    COALESCE(SUM(totalPrice), 0) AS total_revenue
FROM orders
WHERE status != 'Cancelled'
  AND YEAR(orderDate) = 2024
  AND MONTH(orderDate) = 11
GROUP BY 
    CASE 
        WHEN DAY(orderDate) BETWEEN 1 AND 7 THEN 1
        WHEN DAY(orderDate) BETWEEN 8 AND 14 THEN 2
        WHEN DAY(orderDate) BETWEEN 15 AND 21 THEN 3
        WHEN DAY(orderDate) BETWEEN 22 AND 28 THEN 4
        WHEN DAY(orderDate) BETWEEN 29 AND 31 THEN 5
    END
ORDER BY week_number;

