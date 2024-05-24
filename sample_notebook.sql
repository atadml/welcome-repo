SELECT
  COUNT(*)
FROM public.orders
WHERE
  user_id IN (SELECT id FROM public.users WHERE age > 30)