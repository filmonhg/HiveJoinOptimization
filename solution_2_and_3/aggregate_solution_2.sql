--Author: Filmon H. Gebreyesus
--08/24/2015
--Solution for problem 2:
--------------------------
--Script to aggregate i.e. get the age bracket and finally get sum of number of patients by grouping it
--based on "service_line.primary_diag_code" and "age_bracket".
--The aggregation (solution) and age bracket formatting is done by the previous intermediate joined table 
--to get "final_table" also "result_temp". 
--Recall, "final_table" is obtained by joining "patient", "claim" and "service_line" tables.


--This is the temporary "result_temp" table to create table with age bracket format from the "final_table"
CREATE TABLE IF NOT EXISTS result_temp(patient_id int,primary_diag_code string,age_bracket string);

FROM
(SELECT patient_id,year_of_birth,primary_diag_code
 FROM final_table) p
INSERT OVERWRITE TABLE result_temp
SELECT p.patient_id,p.primary_diag_code,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),p.year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),p.year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),p.year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
;
--The actual aggreagation (Solution for question 2) to get "num_patients" happens here by grouping
-- using "primary_diag_code" and "age_bracket"
CREATE TABLE IF NOT EXISTS result_2(primary_diag_code string,age_bracket string,num_patients int);

INSERT OVERWRITE TABLE result_2
SELECT p.primary_diag_code,p.age_bracket,count(p.patient_id)
FROM result_temp p
GROUP BY p.primary_diag_code,p.age_bracket
ORDER BY p.primary_diag_code,p.age_bracket
