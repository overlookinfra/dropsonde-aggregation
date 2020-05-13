-- This will generate an aggregate table of all modules and versions used.
SELECT modules.slug, modules.version, count(*) as count
FROM `bto-dataops-datalake-prod.dujour.community_metrics`, UNNEST(modules) as modules
GROUP BY modules.slug, modules.version
