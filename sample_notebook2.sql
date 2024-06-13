SELECT
  EXTRACT(YEAR FROM order_date) AS order_year,
  EXTRACT(MONTH FROM order_date) AS order_month,
  AVG(delivered_at - shipped_at) AS avg_delivery_time
FROM public.orders
GROUP BY 1, 2
ORDER BY 1, 2