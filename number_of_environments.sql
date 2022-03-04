-- This will generate an aggregate table consisting of the number of environments
-- exist in infrastructures and how many occurrences of that count there are.
SELECT CURRENT_DATE() AS date, environment_count, count(1) AS occurrences
FROM `bto-dataops-datalake-prod.dujour.community_metrics`
GROUP BY environment_count
