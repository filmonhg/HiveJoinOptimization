--Author: Filmon Gebreyesus
--08/24/2015
--The script creates external table from files of very small size
--to run common joins and hive runs well.
--File size used were 3M rows for "patient",6M rows for "claim" and
--10M rows for "service_line"

--The following script creates external table that points to hdfs 
--and creates temporary/intermediate managed formatted tables and 
--make it ready for common join.



--DROP TABLE patient;
--creates external table for patient that points to HDFS
CREATE EXTERNAL TABLE IF NOT EXISTS patient(id int,year_of_birth date, gender string, zip string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\054" LINES TERMINATED BY "\n"
STORED AS TEXTFILE LOCATION '/user/tiny/patient_tiny';

--another patient table with age calculated
CREATE TABLE IF NOT EXISTS patient_2(id int,age int);

FROM
(SELECT id,year_of_birth 
 FROM patient) p
INSERT OVERWRITE TABLE patient_2
SELECT p.id,FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),p.year_of_birth))/365);

--another patient table with age_bracket format
CREATE TABLE IF NOT EXISTS patient_3(id int,age_range string);
FROM
(SELECT id,year_of_birth
 FROM patient) p
INSERT OVERWRITE TABLE patient_3
SELECT p.id,
CASE
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),p.year_of_birth))/365) < 5 THEN '\"0-4\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),p.year_of_birth))/365) < 10 THEN '\"5-9\"'
WHEN FLOOR((DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()),p.year_of_birth))/365) < 15 THEN '\"10-14\"'
ELSE '\"15-100\"'
END
;
--DROP TABLE claim;
--creates external table for "claim" that points to HDFS
CREATE EXTERNAL TABLE IF NOT EXISTS claim(id int,patient_id int,claim_date date)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\054" LINES TERMINATED BY "\n"
STORED AS TEXTFILE LOCATION '/user/tiny/claim_tiny';

--DROP TABLE service_line;
--creates external table for "service_line" table that points to HDFS
CREATE EXTERNAL TABLE IF NOT EXISTS service_line(id int,claim_id int,primary_diag_code string,addl_diag_code_1 string,addl_diag_code_2 string, addl_diag_code_3 string, addl_diag_code_4 string, addl_diag_code_5 string, addl_diag_code_6 string, addl_diag_code_7 string, addl_diag_code_8 string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\054" LINES TERMINATED BY "\n"
STORED AS TEXTFILE LOCATION '/user/tiny/service_line_tiny';

