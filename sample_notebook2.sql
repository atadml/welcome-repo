SELECT
  T1.product_id
  FROM inventory_items AS T1
FROM inventory_items AS T1

INNER JOIN order_items AS T2

  ON T1.id = T2.inventory_item_id
INNER JOIN orders AS T3
  ON T2.order_id = T3.id
WHERE
  T3.created_at >= '2023-01-01' AND T3.created_at < '2024-01-01'
GROUP BY
  T1.product_id
ORDER BY
  SUM(T2.sale_quantity) DESC
LIMIT 1