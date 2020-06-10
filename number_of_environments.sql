-- This will generate an aggregate table consisting of the number of environments
-- exist in infrastructures and how many occurrences of that count there are.
SELECT environment_count, count(1) AS occurrences
FROM `dataops-puppet-public-data.community.community_metrics`
GROUP BY environment_count
