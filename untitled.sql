SELECT
  EXTRACT(YEAR FROM created_at) AS year,
  EXTRACT(MONTH FROM created_at) AS month,
  SUM(sale_price * sale_quantity) AS total_orders
FROM orders
GROUP BY 1, 2
ORDER BY 1, 2 DESC
LIMIT 3