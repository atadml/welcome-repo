SELECT
  T1.state AS state,
  CAST(SUM(CASE WHEN T2.status = 'Returned' THEN 1 ELSE 0 END) AS FLOAT) * 100 / COUNT(T2.status) AS return_rate
FROM users AS T1
INNER JOIN orders AS T2
  ON T1.id = T2.user_id
GROUP BY
  T1.state