-- QUESTIONS:
--       Inner Join
-- Scenario: Retrieve employees along with their department names.
select
    emp_name,
    dept_name
from
    employees
    inner join departments on employees.emp_dept_id = departments.dept_id;

--      Left Join
-- Scenario: Retrieve all employees and their department names, including employees without assigned departments.
select
    emp_name,
    dept_name
from
    employees
    left join departments on employees.emp_dept_id = departments.dept_id;

-- Right Join
-- Scenario: Retrieve all departments and the names of their department heads, including departments without assigned heads.
select
    dept_name,
    emp_name
from
    employees
    right join departments on departments.dept_head_id = employees.emp_id;

--       Full Join
-- Scenario: Retrieve all employees and their assigned projects, including employees without assigned projects and projects without assigned employees.
select
    emp_name,
    project_name
from
    employees
    full join employee_projects on employees.emp_id = employee_projects.emp_id
    full join projects on employee_projects.project_id = projects.project_id;

--       Self Join
-- Scenario: Retrieve pairs of employees who work in the same department.
select
    E.emp_name,
    F.emp_name
from
    employees E
    inner join employees F on E.emp_dept_id = F.emp_dept_id
    AND E.emp_id < F.emp_id;

--      Cross Join
-- Scenario: Retrieve all possible combinations of employees and projects.
select
    emp_name,
    project_name
from
    employees
    cross join projects
    -- Extra: --retrieve all the employee whose depatment is not present in department table using join
select
    emp_name
from
    employees
where
    emp_name not in (
        select
            emp_name
        from
            employees
            inner join employee_projects on employees.emp_id = employee_projects.emp_id
            inner join projects on projects.project_id = employee_projects.project_id
    )
    -- Natural Join
    -- Scenario: Retrieve all records where there is a matching column name between employees and salaries.
select
    *
from
    employees
    natural join salaries
    -- 2nd highest salary
select
    *
from
    (
        select
            emp_name,
            salary_amount,
            DENSE_RANK() over (
                ORDER BY
                    salary_amount DESC
            ) as rank
        from
            employees
            natural join salaries
    )
where
    rank = 2