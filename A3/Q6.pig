popcsv = LOAD '/data/pop.csv' USING PigStorage(',') AS (country:CHARARRAY, population:INT);
vax_data = LOAD '/data/vaccination-data.csv' USING PigStorage(',') AS (country:CHARARRAY, iso3:CHARARRAY, region:CHARARRAY, numVax:INT);
vax_meta = LOAD '/data/vaccination-metadata.csv' USING PigStorage(',') AS (iso3:CHARARRAY, v_name:CHARARRAY, p_name:CHARARRAY, c_name:CHARARRAY);

highpop = FILTER popcsv BY population > 100000;

joined1 = JOIN highpop BY country, vax_data BY country;

country_info = FOREACH joined1 GENERATE highpop::country, highpop::population, vax_data::iso3, (float)(((float)vax_data::numVax/(float)(highpop::population*1000)) * 100) AS percent_vaxed;

brands = GROUP vax_meta BY iso3;

num_brands = FOREACH brands GENERATE $0 AS iso3, COUNT(vax_meta.p_name) AS num;

joined2 = JOIN country_info BY iso3, num_brands BY iso3;

final = FOREACH joined2 GENERATE country_info::highpop::country, country_info::highpop::population, ROUND_TO(country_info::percent_vaxed,3), num_brands::num;

ordered = ORDER final BY country_info::highpop::population DESC;

DUMP ordered;
