SELECT
  EXTRACT(YEAR FROM created_at) AS order_year,
  EXTRACT(MONTH FROM created_at) AS order_month,
  COUNT(id) AS order_count
FROM public.orders
GROUP BY 1, 2
ORDER BY 1, 2