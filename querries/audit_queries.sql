-- audit_queries.sql

-- 1. Show all salary changes
SELECT log_id, emp_id, old_salary, new_salary, change_date
FROM audit_log
ORDER BY change_date DESC;

-- 2. Number of salary changes per employee
SELECT emp_id, COUNT(*) AS changes_count
FROM audit_log
GROUP BY emp_id;

-- 3. Salary changes in the last 30 days
SELECT *
FROM audit_log
WHERE change_date >= SYSDATE - 30
ORDER BY change_date DESC;

