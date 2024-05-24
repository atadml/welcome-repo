SELECT
  T1.id,
  T1.first_name,
  T1.last_name,
  T1.email,
  T1.gender,
  T1.age,
  T1.city,
  T1.state,
  T1.country,
  T1.traffic_source,
  T1.zip,
  T1.latitude,
  T1.longitude,
  T2.created_at AS first_order_date,
  T3.created_at AS last_order_date,
  T3.created_at - T2.created_at AS days_to_convert
FROM users AS T1
INNER JOIN orders AS T2
  ON T1.id = T2.user_id
INNER JOIN orders AS T3
  ON T1.id = T3.user_id
WHERE T2.created_at = (
  SELECT MIN(created_at)
  FROM orders
  WHERE user_id = T1.id
)
AND T3.created_at = (
  SELECT MAX(created_at)
  FROM orders
  WHERE user_id = T1.id
)