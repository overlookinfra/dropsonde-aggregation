-- This will generate an aggregate table of all classes used and their counts.
SELECT CURRENT_DATE() AS date, classes.name, classes.count
FROM `bto-dataops-datalake-prod.dujour.community_metrics`, UNNEST(classes) as classes
GROUP BY classes.name, classes.count
