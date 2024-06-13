SELECT
  *
FROM public.distribution_centers
WHERE
  country = 'USA'
ORDER BY
  state ASC,
  town ASC
LIMIT 10