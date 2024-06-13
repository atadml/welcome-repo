SELECT
  order_cohort,
  order_day,
  order_month,
  order_year,
  RANK() OVER (PARTITION BY order_cohort ORDER BY order_year, order_month) AS rank
FROM __dbt_target_schema__.sample_notebook
ORDER BY order_cohort, order_year, order_month