--Author: Filmon Gebreyesus
--08/24/2015
--Solution for problem 3: 
-------------------------
-- The script uses intermediate table "final_table" to select the diagnosis code attributes
-- one by one along with "patient_id" and "age_bracket" attributes and union all them 
--to merge them together in one table "result_temp_2"
CREATE TABLE IF NOT EXISTS result_temp_2(patient_id int,diag_code string,age_bracket string);

INSERT OVERWRITE TABLE result_temp_2
SELECT patient_id,primary_diag_code,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
FROM final_table
UNION ALL
SELECT patient_id,addl_diag_code_1,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
FROM final_table
UNION ALL
SELECT patient_id,addl_diag_code_2,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
FROM final_table
UNION ALL
SELECT patient_id,addl_diag_code_3,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
FROM final_table
UNION ALL
SELECT patient_id,addl_diag_code_4,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
FROM final_table
UNION ALL
SELECT patient_id,addl_diag_code_5,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
FROM final_table
UNION ALL
SELECT patient_id,addl_diag_code_6,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
FROM final_table
UNION ALL
SELECT patient_id,addl_diag_code_7,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
FROM final_table
UNION ALL
SELECT patient_id,addl_diag_code_8,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
FROM final_table
;

--The following is for getting the final result for the third problem, where 
-- all the diagnosis codes are combined together (as shown in the above) and
-- thus to get the number of patients it groups by diagnosis code and age bucket 
--and count number of patients in each diagnosis code and "age_bracket"


CREATE TABLE IF NOT EXISTS result_3(diag_code string,age_bracket string,num_patients int);

INSERT OVERWRITE TABLE result_3
SELECT p.diag_code,p.age_bracket,count(p.patient_id)
FROM result_temp_2 p
GROUP BY p.diag_code,p.age_bracket
ORDER BY p.diag_code,p.age_bracket

