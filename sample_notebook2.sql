SELECT
  EXTRACT(YEAR FROM delivered_at) AS year,
  EXTRACT(MONTH FROM delivered_at) AS month,
  AVG(delivered_at - shipped_at) AS avg_delivery_time
FROM order_items
GROUP BY 1, 2
ORDER BY 1, 2