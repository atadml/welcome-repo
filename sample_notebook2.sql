SELECT
  T1.product_id
FROM public.inventory_items AS T1
INNER JOIN public.order_items AS T2
  ON T1.id = T2.inventory_item_id
INNER JOIN public.orders AS T3
  ON T2.order_id = T3.id
WHERE
  T3.order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY
  T1.product_id
ORDER BY
  SUM(T2.sale_quantity) DESC
LIMIT 1