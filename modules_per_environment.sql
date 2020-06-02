-- This will generate an aggregate table consisting of the number of modules
-- in and environment and how many instances of that count there are.
-- The subselect ensures uniqueness without exposing site_id
SELECT count, COUNT(1) AS occurrences
FROM (
  SELECT DISTINCT(site_id), ARRAY_LENGTH(modules) as count FROM `bto-dataops-datalake-prod.dujour.community_metrics`
)
GROUP BY count
