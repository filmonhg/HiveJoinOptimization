About the files
--------------
* **create_tables.sql**: is for creating temporary/external tables before join
* **join_solution.sql(Solution for question 1)**: is the common join method for question 1. (Assuming I have small sized files). Tested in 4 node (8Gb each) cluster for file size of 3M rows for patient table, 6M rows for claims table and 10M rows for service_line table.
* **drop_tables.sql**: This script is for droping tables (for sanitation purposes ONLY) 
