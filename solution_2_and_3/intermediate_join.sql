--Author: Filmon Gebreyesus
--08/24/2015
--script to join "claim" table and "service_line" table on "claim.id" and "service_line.claim_id" 
--and form intermediate table called "service_line_claim" which inturn is a table which is 
--clustered  "service_line_claim" by "service_line_claim.patient_id" into 100 buckets 
--so that it can be joined optimally to "patient" table.

--enforcing bucket and create external table "service_line_claim"
set hive.enforce.bucketing=true;
CREATE TABLE IF NOT EXISTS service_line_claim(patient_id int,claim_id int,primary_diag_code string,addl_diag_code_1 string,addl_diag_code_2 string,addl_diag_code_3 string,addl_diag_code_4 string,addl_diag_code_5 string,addl_diag_code_6 string, addl_diag_code_7 string,addl_diag_code_8 string)
CLUSTERED BY(patient_id) INTO 100 BUCKETS;

--"populate table "service_line_claim" using mapjoin using the bucketed (clustered) attribute
set hive.optimize.bucketmapjoin=true;
INSERT OVERWRITE TABLE service_line_claim
SELECT /*+mapjoin(p,c)*/ c.patient_id,s.claim_id,s.primary_diag_code,s.addl_diag_code_1,s.addl_diag_code_2,s.addl_diag_code_3,s.addl_diag_code_4,s.addl_diag_code_5,s.addl_diag_code_6,s.addl_diag_code_7,s.addl_diag_code_8
FROM claim c
JOIN service_line s
on (c.id=s.claim_id)




