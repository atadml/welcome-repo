SELECT
  SUM(T1.sale_quantity)
FROM order_items AS T1
INNER JOIN orders AS T2
  ON T1.order_id = T2.id
INNER JOIN users AS T3
  ON T2.user_id = T3.id
WHERE
  T3.country = 'United States'