SELECT
  EXTRACT(YEAR FROM created_at) AS year,
  SUM(sale_price * sale_quantity) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1 DESC
LIMIT 3