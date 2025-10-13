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

This unit looked at compliance rules and the security responsibilities that come with handling personal and organisational data. We examined who is responsible for the data, the rights people have under GDPR and the standards that affect how databases are designed and run. Working through the DreamHome case study from the seminar notes and the previous database build activities showed that compliance should be included at every stage of the project - from gathering requirements to design testing and day-to-day operation.  

The lecturecast pointed out that “compliance does not equal security” and that security needs good processes and a security-aware culture as well as technical measures. It also listed four practical goals - control access by process not job function, secure data at rest, protect cryptographic keys and tighten security across all the software components. These goals connect directly to database work such as deciding which fields to encrypt, how to keep keys separate from data and what user roles can read or write which tables. 

Linking compliance to the normalisation and database build work brought out three main points. First, a clean, normalised schema makes it easier to find and protect sensitive data because each piece of information is stored in one clear place. Second, when you move from the logical design to the physical database you must also include the security steps - decide which columns need encryption which tables need restricted access and which audit fields to add for traceability. Third, testing should check privacy and security as well as functionality - for example test role-based access, confirm data is encrypted at rest and run a few sample data deletion or retention checks required by GDPR.  

The recommended reading from McKinney (2022) supports these ideas and gives practical tips for pipelines and checks. Chapter 11 covers working with dates and times in pandas - things like timestamps resampling and rolling windows that are useful when handling time-stamped records.  Chapter 12 shows how to prepare data for models and how to separate transformation code from model code - useful when you build features for anomaly detection or forecasting.  Chapter 13 brings those steps together with examples of loading, cleaning, transforming, grouping and visualising data - these examples are handy templates when you build repeatable pipelines and simple visual checks for a security test plan, as an example.

Taken together and expanding on Unit 7 activities, the Unit 8 materials and the McKinney chapters point to a clear approach - make the data correct first by normalising and documenting the schema then make it possible to monitor by adding time-aware steps, preparing the data for analysis and creating simple charts to spot problems. That way data stays auditable secure and useful as it moves from the database through the processing pipeline to analysis. 

### References

McKinney, W. (2022) Python for Data Analysis: Data Wrangling with Pandas, NumPy, and Jupyter. 3rd edn. Sebastopol, California: O'Reilly.

## Unit 9 - Database Management Systems (DBMS) and Models

This unit gave a clear overview of database systems - how they are designed why different models exist and what trade-offs each model brings. The lecturecast contrasted the old flat-file approach with the database approach and explained why a DBMS is useful for controlling redundancy keeping data consistent and allowing multiple applications to share the same data. I also reviewed transaction management and concurrency issues such as lost updates and dirty reads which show why databases need careful rules when many users read and write at the same time.

Putting this into practice reinforced the theory. The normalisation work from Unit 7 - turning a flat student table into Students Courses and Enrolments - made it easier to see how logical design supports integrity and simpler application logic. Building the relational database from those normalised tables then showed the physical side - schema DDL keys and foreign keys and the kinds of constraints you must test for in real systems. These practical steps make the Unit 9 ideas concrete because they show how design choices affect maintenance query cost and concurrency behaviour.

Unit 9 also covered different database models and usage contexts - relational SQL systems for strong consistency and structured data and non-relational systems (NoSQL, data lakes, Hadoop) for scale and flexible schemas. The key lesson is to pick the model that fits the problem - use relational systems where integrity and transactions matter and use non-relational or specialised stores when scale latency or schema flexibility are the top priorities.

Overall I feel more confident to evaluate DB design choices - I can explain why we normalised the student dataset how that helps consistency and where we might later adjust the physical design e.g. indexing to meet performance or scale needs.

## Unit 10 - More on APIs (Application Programming Interfaces) for Data Parsing

This unit covered APIs and how systems exchange and parse data and the security and operational challenges of running APIs in production. I completed my contribution to the unit discussion which focused on GDPR/ICO security concerns - the summary post highlighted identifying and minimising personal data, carrying out risk assessments and DPIAs for higher-risk processing and documenting retention and provenance so subject requests can be answered. It also recommended applying engineering controls such as pseudonymisation, encryption and least-privilege access. The unit materials also covered practical API and adapter issues - including the need for clear API contracts, strong authentication, input validation, throttling and monitoring - and introduced tools such as IBM QRadar Pipe and DSM which help convert varied incoming messages into a consistent format and run early checks before data is moved. For data scientists this means going beyond model accuracy - carry out risk assessments, apply data minimisation and pseudonymisation where possible, build testing and monitoring into pipelines, document provenance and retention choices and work with engineers so encryption and access controls are in place before data analysis and reporting.

## Unit 11 - DBMS Transaction and Recovery

This unit looked at how database systems keep data safe when things go wrong and how they make sure transactions either finish completely or do not happen at all. We examined transaction processing and the ACID properties - atomic, consistent, isolated and durable - and how each property protects the database during the transaction cycle. The material explained how scheduled transactions are interleaved in busy systems, why a transaction manager is needed to coordinate commits and rollbacks and how mechanisms such as write-ahead logging, checkpoints and recovery procedures restore a consistent state after system or media failures.

## Unit 12 - Future of Big Data Analytics


