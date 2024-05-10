SELECT
  *
FROM (
  SELECT
    T1.id AS order_id,
    T1.created_at AS order_created_at,
    T2.id AS user_id,
    T2.created_at AS user_created_at,
    ROW_NUMBER() OVER (PARTITION BY T1.id ORDER BY T2.created_at) AS user_sequence
  FROM orders AS T1
  INNER JOIN users AS T2
    ON T1.user_id = T2.id
) AS T
WHERE T.user_sequence = 1