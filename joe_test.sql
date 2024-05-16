SELECT
  T1.id AS warehouse_id,
  SUM(T2.cost * T2.quantity) AS total_cost
FROM distribution_centers AS T1
INNER JOIN inventory_items AS T2
ON T1.id = T2.distribution_center_id
GROUP BY
  T1.id