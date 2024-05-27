SELECT
  CAST(created_at AS DATE) AS order_date,
  COUNT(id) AS total_orders
FROM orders
GROUP BY 1