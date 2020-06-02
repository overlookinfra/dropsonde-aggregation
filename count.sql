-- the number of how many sites have checked in and then number of modules used in
-- the field. Useful for calculating percentages or determining confidence value of results.
SELECT count(DISTINCT site_id) as sites, count(DISTINCT modules.name) as modules
FROM `bto-dataops-datalake-prod.dujour.community_metrics`, UNNEST(modules) as modules
