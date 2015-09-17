--Author: Filmon Gebreyesus
--08/24/2015
--Solution for question 1:
---------------------------
--For question 1, relatively smaller size files have been used
--3M rows for "patient", 6M rows for "claim" and 10M rows for "service_line"
--The following join (Common join) works with out being careful
--for optimization except making sure the largest file "service_line"
--to be the last table to join. This is because hive by default streams the 
--last joined table and attempts to catch the smaller files

--using the intermediate tables created (patient_3) and join
--it to "patient" on (patient.id=patient_3.id) and join
--"service_line" with "claim" on "claim.id=service_line.claim_id"
SELECT s.primary_diag_code,p.age_range,count(p.id)
FROM patient_3 p
JOIN claim c
ON (p.id=c.patient_id)
JOIN service_line s
ON (s.claim_id=c.id)
GROUP BY s.primary_diag_code,p.age_range



