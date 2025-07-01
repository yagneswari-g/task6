use example_DB;
select * from employees  limit 5;
-- 1. Scalar Subquery in SELECT
SELECT first_name, last_name, salary,
       (SELECT AVG(salary) FROM employees) AS company_avg_salary
FROM employees;
-- 2.Subquery in WHERE Clause
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
-- 3. Correlated Subquery
SELECT first_name, last_name, salary, department_id FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
-- 4.Subquery in FROM Clause 
SELECT dept_avg.department_id, dept_avg.avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg;
-- 5.Subquery using IN
SELECT first_name, last_name, department_id, salary FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) > 15000
);
-- 6.Subquery using EXISTS
SELECT first_name, last_name, employee_id FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees
    WHERE manager_id = e.employee_id
);
-- 7.Employees Without Manager (Using IS NULL)
SELECT first_name, last_name
FROM employees
WHERE manager_id IS NULL;
