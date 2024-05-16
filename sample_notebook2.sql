SELECT
  *
FROM order_items
WHERE order_id IN (
  SELECT
    order_id
  FROM order_items
  WHERE EXTRACT(WEEK FROM created_at) = EXTRACT(WEEK FROM CURRENT_DATE) - 1
  GROUP BY order_id
  ORDER BY COUNT(*) DESC
  LIMIT 5
)