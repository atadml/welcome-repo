SELECT
  *
FROM public.distribution_centers
WHERE
  country = 'United States'
ORDER BY
  id
LIMIT 10