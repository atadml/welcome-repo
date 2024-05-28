SELECT
  *
FROM public.distribution_centers
WHERE
  country = 'USA'
UNION ALL
SELECT
  *
FROM public.distribution_centers
WHERE
  country = 'Canada'