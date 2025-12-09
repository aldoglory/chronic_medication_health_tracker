# Business Intelligence Requirements

## Objective
Enable decision-making by providing actionable insights from the database.

## Key BI Goals
- Track medication compliance and adherence.
- Monitor employee/system audit activity.
- Analyze inventory trends and usage patterns.
- Generate KPIs for management reporting.

## Data Sources
- `patient_medication_log` (medication status, timestamps)
- `employees` (audit trail, activity logs)
- `inventory` (stock levels, usage)
- `audit_log` (system actions, user activity)

## Functional Requirements
1. Create aggregated views for reporting.
2. Provide pre-defined SQL queries for analysis.
3. Generate weekly and monthly reports.
4. Include filters by department, patient, or time period.
5. Support export to Excel or CSV for visualization.

## Non-functional Requirements
- Queries must be optimized for large datasets.
- Reports should be updateable via scheduled jobs.
- Ensure only authorized users can access BI data.

