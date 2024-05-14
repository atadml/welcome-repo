SELECT
  *
FROM (
  SELECT
    T1.id AS order_id,
    T1.user_id AS user_id,
    T1.created_at AS created_at,
    T1.status AS status,
    T2.id AS order_item_id,
    T2.inventory_item_id AS inventory_item_id,
    T2.sale_price AS sale_price,
    T2.sale_quantity AS sale_quantity,
    T2.shipped_at AS shipped_at,
    T2.delivered_at AS delivered_at,
    T2.returned_at AS returned_at,
    T2.status AS status
  FROM public.orders AS T1
  INNER JOIN public.order_items AS T2
    ON T1.id = T2.order_id
) AS T
WHERE T.status = 'delivered'
GROUP BY T.order_id, T.user_id, T.created_at, T.status, T.order_item_id, T.inventory_item_id, T.sale_price, T.sale_quantity, T.shipped_at, T.delivered_at, T.returned_at, T.status
HAVING SUM(T.sale_quantity) > 1