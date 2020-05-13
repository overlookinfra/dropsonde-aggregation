-- This will generate an aggregate table consisting of the number of modules
-- in and environment and how many instances of that count there are.
SELECT ARRAY_LENGTH(modules) count, COUNT(1) AS occurrences
FROM `bto-dataops-datalake-prod.dujour.community_metrics`
GROUP BY count
