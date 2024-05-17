SELECT
  EXTRACT(MONTH FROM created_at) AS order_month,
  SUM(sale_price) AS total_sales
FROM orders
GROUP BY order_month
ORDER BY order_month