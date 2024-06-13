SELECT
  *
FROM (
  SELECT
    order_cohort,
    order_day,
    order_month,
    order_year,
    RANK() OVER (PARTITION BY order_cohort, order_month ORDER BY order_day) AS rank
  FROM dbt_target_schema.sample_notebook
) AS ranks
WHERE rank = 1