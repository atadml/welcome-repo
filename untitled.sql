SELECT
  T1.id AS user_id,
  T1.first_name,
  T1.last_name,
  T2.id AS order_id,
  T2.created_at AS order_created_at,
  T2.status AS order_status
FROM users T1
INNER JOIN orders T2 ON T1.id = T2.user_id
WHERE T2.status = 'delivered'
GROUP BY 1, 2, 3, 4, 5, 6