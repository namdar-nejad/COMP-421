
vax_data = LOAD '/data/vaccination-data.csv' USING PigStorage(',') AS (country:CHARARRAY, iso3:CHARARRAY, region:CHARARRAY, numVax:INT);

vax_regions = GROUP vax_data BY region;

vax_count = FOREACH vax_regions GENERATE $0,COUNT(vax_data.country), SUM(vax_data.numVax);

ordered = ORDER vax_count BY $0;

DUMP ordered;
