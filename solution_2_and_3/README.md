About the files
--------------
* As the previous problem: provider table has not been considered as it has no use in solving the problem given. The common join method used in the previous question (#1) can't solve the problem (gives error in Cluster of 4 m3.large instances with 8G memory) if table size of patient is around 10M and beyond, claim around 40M records and beyond and service_line is around 100M records and beyond.
* **create_tables.sql**: is for creating temporary/external tables before join
* **intermediate_join.sql**: script to join "claim" table and "service_line" table on "claim.id" and "service_line.claim_id" and form intermediate table called "service_line_claim" which inturn is an intermediate table clustered  by "service_line_claim.patient_id" into 100 buckets so that it can be joined optimally to "patient" table.
* **final_join.sql**:This script joins the final "service_line_claim" intermediate table, which is already  bucketed on "service_line_claim.patient_id" and "patient" table (which is also bucketed ) on "patient.id" to make optimized join (using mapjoin) as the file size is too big to do the formal join

* **aggregate_solution_2.sql(Solution for question 2)**: Script to aggregate i.e. get the age bracket and finally get sum of number of patients by grouping it based on "service_line.primary_diag_code" and "age_bracket". The aggregation (solution) and age bracket formatting is done using the previous intermediate joined table to get "final_table" also "result_temp". Recall, "final_table" is obtained by joining "patient", "claim" and "service_line" tables.
* **aggregate_solution_3.sql (Solution for question 3)**: Previous intermediate tables have been used but merging all the diagnosis_codes and are grouped to count the patients with in each group and age_bracket. 
* **drop_tables.sql**: This script is for droping tables (for sanitation purposes ONLY) 
