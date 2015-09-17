--Author: Filmon Gebreyesus
--08/24/2015
--Purpose: Script to create temporary/intermediate external tables
--that point to the hdfs or managed tables as an intermediate table and prepare it to join

--As the previous problem: provider table has not been considered as it has no use 
--in solving the problem given. The common join method used in the previous question (#1)
--can't solve the problem (gives error in Cluster of 4 m3.large instances with 8G memory)
-- if table size of patient is around 10M and beyond, claim around 40M records and beyond 
-- and service_line is around 100M records and beyond.

--Thus using clustering when creating "patient" table on "patiend.id" with bucket size 10
-- and clustering "claim" table on "claim.id" with bucket size 10
--and clustering "service_line" table on "service_line.claim_id" with bucket size 100

--The aim is to join "claim" and "service_line" tables on "claim.id=service_line.claim_id" to make
--intermediate "service_line_claim table" followed by joining "service_line_claim" table
-- with "patient" table  on "patient.id"="service_line_claim.patient_id"

--N.B: Bucket sizes on join participating tables should be multiples of each other

--DROP TABLE patient;

--hive enforcing bucket for joining 
set hive.enforce.bucketing=true;

--external table to point to hdfs for "patient" table clustered by "patient.id"
CREATE EXTERNAL TABLE IF NOT EXISTS patient(id int,year_of_birth date, gender string, zip string)
CLUSTERED BY(id) INTO 10 BUCKETS
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\054" LINES TERMINATED BY "\n"
STORED AS TEXTFILE LOCATION '/user/patient_small';

--DROP TABLE claim;

--creating external table for "claim" clustered on "claim.id" into 10 buckets
set hive.enforce.bucketing=true;
CREATE EXTERNAL TABLE IF NOT EXISTS claim(id int,patient_id int,claim_date date)
CLUSTERED BY (id) INTO 10 BUCKETS
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\054" LINES TERMINATED BY "\n"
STORED AS TEXTFILE LOCATION '/user/claim_small';

--DROP TABLE service_line;

--creating external table for "service_line" clustered on "service_line.claim_id" into 100 buckets
CREATE EXTERNAL TABLE IF NOT EXISTS service_line(id int,claim_id int,primary_diag_code string,addl_diag_code_1 string,addl_diag_code_2 string, addl_diag_code_3 string, addl_diag_code_4 string, addl_diag_code_5 string, addl_diag_code_6 string, addl_diag_code_7 string, addl_diag_code_8 string)
CLUSTERED BY (claim_id) INTO 100 BUCKETS
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\054" LINES TERMINATED BY "\n"
STORED AS TEXTFILE LOCATION '/user/service_line_small';


