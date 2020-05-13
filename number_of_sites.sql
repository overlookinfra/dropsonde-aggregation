-- just a single number of how many sites have checked in. Useful for calculating
-- percentages or determining confidence value of results.
SELECT count(*) as count
FROM `bto-dataops-datalake-prod.dujour.community_metrics`
