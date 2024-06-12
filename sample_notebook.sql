SELECT
  EXTRACT(YEAR FROM order_date) AS order_year,
  EXTRACT(MONTH FROM order_date) AS order_month,
  EXTRACT(DAY FROM order_date) AS order_day,
  RANK() OVER (ORDER BY order_date) AS order_cohort
FROM (
  SELECT
    DATE_TRUNC('day', order_date) AS order_date,
    COUNT(id) AS order_count
  FROM public.orders
  GROUP BY 1
) AS T
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days'