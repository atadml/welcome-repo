SELECT
  *
FROM public.distribution_centers
WHERE
  country = 'USA'
ORDER BY
  id
LIMIT 10