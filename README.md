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
