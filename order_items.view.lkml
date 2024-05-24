SELECT
  COUNT(*)
FROM orders
WHERE
  created_at > DATE_ADD(CURDATE(), INTERVAL -14 day)