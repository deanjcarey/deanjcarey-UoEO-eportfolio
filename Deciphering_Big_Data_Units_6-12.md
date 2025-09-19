# Deciphering Big Data - Units 6-12

Reflections and any outputs/artifacts for activities can be seen in the unit sections below.

## Unit 6 - Database Design and Normalisation

This unit taught me the basics of relational design and why normalisation matters for integrity and auditability. The Unit 6 reading complemented this by showing practical work with real datasets - JSON and CSV handling, counting, filtering and grouping, wrangling and cleaning and using pandas, matplotlib and seaborn for visualisation and inspection. 

Working on the Clinical Trials DB proposal helped us apply some of those ideas - we mapped logical tables to a physical schema, chose Third Normal Form to reduce redundancy and planned keys and constraints to protect relational integrity. We identified primary keys and considered where indexes or selective denormalisation might help performance but during the assignment we limited implementation to the core keys and constraints. We could consider adding further indexes or denormalisation after analysing query performance.

I also practised writing and testing SQL and validated my skills with a W3Schools quiz (23/25, 92%) which is included as evidence below:

- [SQL Activity - Quiz](/images/sql_activity.png)

Note: Lecturecast lesson 7 of 9 has a "Consent of the Class" which appears to be from a different topic/subject entirely - have submitted feedback via the link at end of lecturecast.



## Unit 7 - Constructing Normalised Tables and Database Build

This unit taught me how to turn a flat file into a reliable relational model by demonstrating 1NF, 2NF and 3NF and by building a working database from the normalised tables. The normalisation work clarified functional dependencies and let me split the dataset into Students, Courses and Enrolments so each non-key attribute sits with the entity it depends on.

I implemented the 3NF schema and loaded the normalised datasets (exported to CSV for SQL import) into a relational database - this sets out the next layer of work: recording the DBMS name and version, hardware specs, data volumes and key DBMS parameters and writing a small set of test queries with EXPLAIN plans to profile joins and indices. Taipalus (2024) warns that “performance is usually tested in a way that does not reflect real-world use cases”. Taipalus also notes that many published tests “lack sufficient detail for reproducibility” which reinforces the need to document the environment and test steps before making optimisation decisions. My next actions are to capture the environment details, create and run the test queries, capture EXPLAIN output and only add indexes or denormalise if the tests show they help.

### References

Taipalus, T. (2024) ‘Database management system performance comparisons: A systematic literature review’, Journal of Systems & Software, 208, p. 111872. doi:10.1016/j.jss.2023.111872. (Accessed: 19/09/2025)

- [Normalisation task summary of steps](/pdf/Normalisation_Task.pdf)
- [Normalisation data](/pdf/Student_Data_Normalisation_Task_v1.xlsx)
- [Data Build Activity](/images/data_build_activity.PNG)

## Unit 8 - Compliance and Regulatory Framework for Managing Data


## Unit 9 - Database Management Systems (DBMS) and Models


## Unit 10 - More on APIs (Application Programming Interfaces) for Data Parsing


## Unit 11 - DBMS Transaction and Recovery


## Unit 12 - Future of Big Data Analytics


