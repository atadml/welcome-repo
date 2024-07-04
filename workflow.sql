SELECT
  T1.id AS id,
  T1.name AS name,
  T2.return_rate AS return_rate
FROM public.distribution_centers AS T1
INNER JOIN __dbt_target_schema__.sample_notebook2 AS T2
  ON T1.id = T2.state