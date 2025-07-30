use hrdp2019;
select database();

select emp_id, emp_name, dept_id, salary
from employee;

select 
	row_number() over() AS rno,
    emp_id, emp_name, dept_id, salary FROM employee WHERE dept_id = 'SYS';
    
--
SELECT * FROM employee;
SELECT emp_id, emp_name, salary, (salary*0.2) AS "bonus" FROM employee;
DESC employee;

--
SELECT
    dept_id,
	dept_name,
	unit_id,
	start_date
From department;
DESC department;