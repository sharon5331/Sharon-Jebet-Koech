-- Employee Database Analysis Project
-- Author: Sharon Jebet Koech
-- Skills: CREATE TABLE, JOIN, GROUP BY, HAVING, Subqueries

-- 1. Create Tables
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_id INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE salaries (
    emp_id INT,
    salary DECIMAL(10,2),
    from_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- 2. Insert Sample Data
INSERT INTO departments VALUES 
(1, 'ICT'), (2, 'Finance'), (3, 'HR');

INSERT INTO employees VALUES 
(101, 'John Kamau', 1, '2023-01-15'),
(102, 'Mary Wanjiku', 1, '2023-03-20'),
(103, 'Peter Omondi', 2, '2022-11-05'),
(104, 'Grace Akinyi', 3, '2024-02-10');

INSERT INTO salaries VALUES 
(101, 80000.00, '2024-01-01'),
(102, 95000.00, '2024-01-01'),
(103, 120000.00, '2024-01-01'),
(104, 75000.00, '2024-01-01');

-- 3. Analysis Queries

-- Q1: Find 2nd highest salary in the company
SELECT MAX(salary) AS second_highest_salary
FROM salaries
WHERE salary < (SELECT MAX(salary) FROM salaries);

-- Q2: Find 2nd highest salary per department
SELECT d.dept_name, MAX(s.salary) AS second_highest_salary
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary < (
    SELECT MAX(s2.salary) 
    FROM salaries s2 
    JOIN employees e2 ON s2.emp_id = e2.emp_id 
    WHERE e2.dept_id = d.dept_id
)
GROUP BY d.dept_name;

-- Q3: Count employees per department
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;
