SELECT
  COUNT(*)
FROM users AS T1
INNER JOIN orders AS T2
  ON T1.id = T2.user_id
WHERE
  T2.created_at >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month' AND T2.created_at < DATE_TRUNC('month', CURRENT_DATE)