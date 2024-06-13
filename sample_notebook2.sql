SELECT
  EXTRACT(YEAR FROM created_at) AS registration_year,
  EXTRACT(MONTH FROM created_at) AS registration_month,
  AVG(order_value) AS avg_order_value
FROM public.users AS u
INNER JOIN public.orders AS o ON u.id = o.user_id
GROUP BY 1, 2
ORDER BY 1, 2