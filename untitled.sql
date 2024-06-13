SELECT
  *
FROM public.distribution_centers
WHERE
  id IN (SELECT id FROM public.distribution_centers ORDER BY id LIMIT 1)