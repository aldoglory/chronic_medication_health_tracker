-- analytics_queries.sql

-- 1. Average salary per department
SELECT d.dept_name,
       ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees e
JOIN projects p ON e.emp_id = (SELECT emp_id FROM employee_projects WHERE project_id = p.project_id AND ROWNUM = 1)
JOIN departments d ON p.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 2. Highest paid employees
SELECT first_name || ' ' || last_name AS employee_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- 3. Total employees per department
SELECT d.dept_name,
       COUNT(DISTINCT ep.emp_id) AS total_employees
FROM departments d
LEFT JOIN projects p ON d.dept_id = p.dept_id
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY d.dept_name;

