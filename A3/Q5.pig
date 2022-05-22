vax_info = LOAD '/data/vaccination-metadata.csv' USING PigStorage(',') AS (iso3:CHARARRAY, v_name:CHARARRAY, p_name:CHARARRAY, c_name:CHARARRAY);

countries = GROUP vax_info by c_name;

sum_countries = FOREACH countries GENERATE $0, COUNT(vax_info.iso3) AS num_countries;

ordered = ORDER sum_countries BY num_countries DESC;

limit_vals = LIMIT ordered 10; 

DUMP limit_vals;

