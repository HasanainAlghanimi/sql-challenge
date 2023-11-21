SELECT * FROM dept_emp

CREATE TABLE departments (
    dept_no VARCHAR PRIMARY KEY,
    dept_name VARCHAR NOT NULL
);


CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


CREATE TABLE dept_manager (
    dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


CREATE TABLE titles (
	title_id VARCHAR PRIMARY KEY NOT NULL,
    title VARCHAR NOT NULL
);



select * from employees
select * from salaries

-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no;


-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT employees.hire_date, employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE EXTRACT(YEAR FROM employees.hire_date) = 1986;


-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT
    departments.dept_no,
    departments.dept_name,
    dept_manager.emp_no,
    employees.last_name,
    employees.first_name 
FROM
    departments 
JOIN
    dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN
    employees ON dept_manager.emp_no = employees.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT
    employees.emp_no,
    employees.last_name,
    employees.first_name,
    departments.dept_name,
    dept_emp.dept_no
FROM
    employees
JOIN
    dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN
    departments ON dept_emp.dept_no = departments.dept_no;


-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT
    first_name,
    last_name,
    sex
FROM
    employees
WHERE
    first_name = 'Hercules'
    AND last_name LIKE 'B%';
	
-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT
    employees.emp_no AS employee_number,
    employees.last_name,
    employees.first_name
FROM
    employees
JOIN
    dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN
    departments ON dept_emp.dept_no = departments.dept_no
WHERE
    departments.dept_name = 'Sales';
	
-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
    employees.emp_no,
    employees.last_name,
    employees.first_name,
    departments.dept_name
FROM
    employees
JOIN
    dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN
    departments ON dept_emp.dept_no = departments.dept_no
WHERE
    departments.dept_name IN ('Sales', 'Development');
	
-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT
    last_name,
    COUNT(*) AS frequency_count
FROM
    employees
GROUP BY
    last_name
ORDER BY
    frequency_count DESC;











