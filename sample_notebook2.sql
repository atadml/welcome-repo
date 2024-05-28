SELECT
  COUNT(*)
FROM public.orders
WHERE
  user_id IN (SELECT user_id FROM public.orders WHERE created_at >= '2017-01-01' AND created_at < '2018-01-01' GROUP BY user_id HAVING COUNT(*) > 1)