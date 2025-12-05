### PHASE II: BUSINESS PROCESS MODELING
## Project: Chronic Diseases Medication Adherence Monitoring System (PL/SQL Capstone)
# Scope of the Business Process
Process Name:Chronic Medication Monitoring Workflow
Domain: Healthcare MIS
Purpose: To track chronic disease patients’ medication adherence using a database-driven monitoring system.
Actors (Users)
# Actor	Role & Responsibilities
Nurse / Healthcare Provider	Registers patients enters adherence logs, reviews reports
Pharmacist	Adds medication schedules, updates dosage/frequency
Doctor: checks patien'ts health condition and take decisions 
System Administrator	Manages users, system privileges, database integrity
Patient	Provides medication compliance information
![screenshot](screenshot/bpmn.png)

## EXPLANATION (For GitHub / Report)

Below is a clean, polished one-page text you can paste directly into your project:

Business Process Explanation — Medication Adherence Monitoring System

This business process models how chronic disease patients are monitored for proper medication adherence using a healthcare MIS built with Oracle SQL and PL/SQL. The process begins when a patient visits the healthcare facility. The nurse collects patient information and registers the patient in the database. The pharmacist reviews the patient’s condition and enters the required medication schedule into the system.

Once medication begins, the patient is expected to take doses daily. The nurse records whether each dose was taken or missed. These adherence logs are saved into the database through the ADHERENCE_LOG table.

PL/SQL triggers automatically detect missed doses and generate alerts, helping healthcare providers intervene early. A PL/SQL function calculates adherence percentage for each patient. Weekly and monthly reports are automatically generated, supporting clinical decisions and long-term disease management.

This MIS improves accuracy of patient records, strengthens follow-up, and supports data-driven healthcare. The stored data also enables analytics such as identifying high-risk patients, predicting adherence trends, and evaluating medication effectiveness. The entire process ensures coordinated work across Nursing, Pharmacy, and IT departments while supporting efficient and reliable chronic disease management.

## Entity-Relationship (ER) Model Design
 # Entities, Attributes, and Keys



| Entity            | Attributes                                                                                                             | PK               | FK                        | Notes                               |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------- | ---------------- | ------------------------- | ----------------------------------- |
| Patient           | Patient_ID (NUMBER), Name (VARCHAR2), Age (NUMBER), Gender (CHAR), Chronic_Disease (VARCHAR2), Contact_Info (VARCHAR2) | Patient_ID       | -                         | Patient logs medications            |
| Medication        | Medication_ID (NUMBER), Name (VARCHAR2), Dose (VARCHAR2), Frequency (VARCHAR2), Duration (NUMBER)                      | Medication_ID    | -                         | Prescribed medications              |
| Adherence_Log     | Log_ID (NUMBER), Patient_ID (NUMBER), Medication_ID (NUMBER), Date_Taken (DATE), Status (VARCHAR2)                     | Log_ID           | Patient_ID, Medication_ID | Tracks if patient took the medicine |
| Nurse_Review      | Review_ID (NUMBER), Patient_ID (NUMBER), Log_ID (NUMBER), Review_Date (DATE), Notes (VARCHAR2)                         | Review_ID        | Patient_ID, Log_ID        | Nurse checks adherence              |
| Doctor_Review     | Doctor_Review_ID (NUMBER), Patient_ID (NUMBER), Review_Date (DATE), Diagnosis (VARCHAR2), Prescription (VARCHAR2)      | Doctor_Review_ID | Patient_ID                | Doctor reviews condition            |
| Pharmacist_Advice | Advice_ID (NUMBER), Patient_ID (NUMBER), Medication_ID (NUMBER), Advice_Date (DATE), Notes (VARCHAR2)                  | Advice_ID        | Patient_ID, Medication_ID | Pharmacist recommends adjustments   |
| Report            | Report_ID (NUMBER), Report_Type (VARCHAR2), Generated_Date (DATE), Content (CLOB)                                      | Report_ID        | -                         | MIS reports                         |

The following diagram is the ERD for the project
![erd](screenshot/erd.jpeg)

# Cardinalities / Relationships

Patient → Adherence_Log: 1:N (a patient can have many logs)

Medication → Adherence_Log: 1:N (a medication can be logged many times)

Patient → Nurse_Review: 1:N (a patient can have multiple reviews)

Patient → Doctor_Review: 1:N

Patient → Pharmacist_Advice: 1:N

Adherence_Log → Nurse_Review: 1:1 (each log reviewed by nurse)
# Normalization
1NF (Eliminate repeating groups)

Each table has atomic attributes (e.g., no multiple medications in one field).

2NF (Eliminate partial dependencies)

Adherence_Log depends on both Patient_ID and Medication_ID, not just one, so we separate entities properly.

3NF (Eliminate transitive dependencies)

Attributes like Doctor prescription notes only depend on Doctor_Review_ID, not on Patient_ID directly.

Nurse notes depend on Review_ID, not Patient_ID directly.
# Data Dictionary Example (Partial)
| Table         | Column     | Data Type     | Constraint                           | Description                     |
| ------------- | ---------- | ------------- | ------------------------------------ | ------------------------------- |
| Patient       | Patient_ID | NUMBER        | PK                                   | Unique patient identifier       |
| Patient       | Name       | VARCHAR2(100) | NOT NULL                             | Full patient name               |
| Adherence_Log | Status     | VARCHAR2(10)  | CHECK (Status IN ('Taken','Missed')) | Whether patient took medication |
| Doctor_Review | Diagnosis  | VARCHAR2(200) | NULLABLE                             | Doctor’s diagnosis              |
| Report        | Content    | CLOB          | NOT NULL                             | Generated adherence report      |

# BI Considerations

Fact tables: Adherence_Log (measures patient adherence)

Dimension tables: Patient, Medication, Nurse, Doctor, Pharmacist

Slowly Changing Dimensions: Track patient chronic disease changes over time

Aggregation Levels: Weekly, monthly, yearly adherence summaries

Audit Trails: Use triggers to log inserts/updates/deletes in Adherence_Log
## PHASE IV: Database Creation
 # create pdb
 ```sql
CREATE PLUGGABLE DATABASE wed_27717_gloire_chronic_medication_tracker_DB
ADMIN USER gloire_admin IDENTIFIED BY Gloire
ROLES = (DBA)
DEFAULT TABLESPACE cdm_data
DATAFILE 'C:\oracle\oradata\ORCL\wed_27717_gloire_chronic_medication_tracker_DB_data01.dbf'
    SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 500M
FILE_NAME_CONVERT = (
    'C:\oracle\oradata\ORCL\PDBSEED\',
    'C:\oracle\oradata\ORCL\wed_27717_gloire_chronic_medication_tracker_DB\'
);```

   # open pdb
```sql
ALTER PLUGGABLE DATABASE wed_27717_gloire_chronic_medication_tracker_DB OPEN;

ALTER PLUGGABLE DATABASE wed_27717_gloire_chronic_medication_tracker_DB SAVE STATE;
```
# creating table spaces

```sql
SET ECHO ON

CREATE TABLESPACE cdm_data
DATAFILE 'C:\oracle\oradata\ORCL\wed_27717_gloire_chronic_medication_tracker_DB_cdm_data01.dbf'
SIZE 200M
AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE cdm_index
DATAFILE 'C:\oracle\oradata\ORCL\wed_27717_gloire_chronic_medication_tracker_DB_cdm_index01.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL;


CREATE TEMPORARY TABLESPACE cdm_temp
TEMPFILE 'C:\oracle\oradata\ORCL\wed_27717_gloire_chronic_medication_tracker_DB_cdm_temp01.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


SELECT tablespace_name, contents, status FROM dba_tablespaces WHERE tablespace_name IN ('CDM_DATA','CDM_INDEX','CDM_TEMP');
```
output:
![screenshot](screenshot/table_space.png)

# create admin user
```sql
SET ECHO ON

CREATE USER gloire_admin IDENTIFIED BY "Gloire"
  DEFAULT TABLESPACE cdm_data
  TEMPORARY TABLESPACE cdm_temp
  QUOTA UNLIMITED ON cdm_data;

GRANT CONNECT, RESOURCE TO gloire_admin;
GRANT DBA TO gloire_admin;

SELECT username, default_tablespace, temporary_tablespace
FROM dba_users
WHERE username = 'GLOIRE_ADMIN';
```
output:
![screenshot](screenshot/admin_user.png)

 # init params
```sql
SET ECHO ON

ALTER SYSTEM SET sga_target = 512M SCOPE=SPFILE;
ALTER SYSTEM SET pga_aggregate_target = 256M SCOPE=SPFILE;

ALTER SYSTEM SET memory_max_target = 768M SCOPE=SPFILE;
```
output:
![screenshot](screenshot/init_para.png)


# enable archive log

```sql

SET ECHO ON

ALTER DATABASE ARCHIVELOG;


ALTER DATABASE ADD LOGFILE GROUP 3 ('C:\oracle\oradata\ORCL\redo03.log') SIZE 50M;

ALTER DATABASE OPEN;


ARCHIVE LOG LIST;
```
output:
![screenshot](screenshot/savelog.png)

