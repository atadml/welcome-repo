SELECT
  EXTRACT(YEAR FROM created_at) AS cohort,
  EXTRACT(MONTH FROM created_at) AS cohort_month,
  COUNT(*) AS active_users
FROM users
GROUP BY 1, 2
HAVING cohort >= EXTRACT(YEAR FROM DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 months')
AND cohort < EXTRACT(YEAR FROM DATE_TRUNC('month', CURRENT_DATE))
AND cohort_month >= EXTRACT(MONTH FROM DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 months')
AND cohort_month < EXTRACT(MONTH FROM DATE_TRUNC('month', CURRENT_DATE))
UNION ALL
SELECT
  EXTRACT(YEAR FROM created_at) AS cohort,
  EXTRACT(MONTH FROM created_at) AS cohort_month,
  COUNT(*) AS active_users
FROM users
GROUP BY 1, 2
HAVING cohort >= EXTRACT(YEAR FROM DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '18 months')
AND cohort < EXTRACT(YEAR FROM DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '12 months')
AND cohort_month >= EXTRACT(MONTH FROM DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '18 months')
AND cohort_month < EXTRACT(MONTH FROM DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '12 months')