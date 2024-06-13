SELECT
  T1.state AS state,
  SUM(CASE WHEN T2.status = 'Returned' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN T2.status = 'Shipped' THEN 1 ELSE 0 END), 0) AS return_rate
FROM public.users AS T1
INNER JOIN public.orders AS T2
  ON T1.id = T2.user_id
GROUP BY
  T1.state