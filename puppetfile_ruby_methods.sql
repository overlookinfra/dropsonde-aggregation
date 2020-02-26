-- This will generate an aggregate table of all Ruby methods used in Puppetfiles
-- and the summed count of how many times each method is used.
SELECT methods.name AS name, SUM(methods.count) AS count
FROM `platform-dujour-dev.module_classes.checkins`, UNNEST(puppetfile_ruby_methods) AS methods
GROUP BY methods.name
LIMIT 1000
