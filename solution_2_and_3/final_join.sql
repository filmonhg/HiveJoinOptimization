--Author: Filmon Gebreyesus
--08/28/2014
--This script joins the final "service_line_claim" intermediate table 
--(which is already  bucketed on "service_line_claim.patient_id" and
--"patient" table (which is also bucketed ) on "patient.id" to make 
--optimized join (using mapjoin) as the file size is too big to do the formal join
--
--enforce optimize bucket prior to populating it
set hive.optimize.bucketmapjoin=true;
CREATE TABLE IF NOT EXISTS final_table(patient_id int,year_of_birth date,claim_id int,primary_diag_code string,addl_diag_code_1 string,addl_diag_code_2 string,addl_diag_code_3 string,addl_diag_code_4 string,addl_diag_code_5 string,addl_diag_code_6 string,addl_diag_code_7 string,addl_diag_code_8 string);
INSERT OVERWRITE TABLE final_table
SELECT /*+mapjoin(p,s_c)*/ s_c.patient_id,p.year_of_birth,s_c.claim_id,s_c.primary_diag_code,s_c.addl_diag_code_1,s_c.addl_diag_code_2,s_c.addl_diag_code_3,s_c.addl_diag_code_4,s_c.addl_diag_code_5,s_c.addl_diag_code_6,s_c.addl_diag_code_7,s_c.addl_diag_code_8
FROM patient p
JOIN service_line_claim s_c
on(p.id=s_c.patient_id)
;


