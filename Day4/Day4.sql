-- creating table in db
CREATE TABLE
    employee_data (first_name VARCHAR(50), last_name VARCHAR(50), sex CHAR(1), doj DATE, date_current DATE, designation VARCHAR(50), age FLOAT, salary INT, unit VARCHAR(50), leaves_used FLOAT, leaves_remaining FLOAT, ratings FLOAT, past_exp INT);

-- COPY CSV TO DOCKER
-- docker cp data.csv postgres:/
-- copy from csv
-- \copy employee_data (first_name, last_name, sex, doj, date_current, designation, age, salary, unit, leaves_used, leaves_remaining, ratings, past_exp) FROM '/path/to/data.csv' DELIMITER ',' CSV HEADER;
-- Common Table Expressions (CTEs):
-- Question 1: Calculate the average salary by department for all Analysts.
WITH
    Analysts as (
        select
            *
        from
            employee_data
        where
            designation LIKE '%Analyst'
    )
SELECT
    avg(salary) as avg_salary,
    unit
from
    Analysts
group by
    unit;

-- Question 2: List all employees who have used more than 10 leaves.
SELECT
    CONCAT (first_name, ' ', last_name) as Name,
    leaves_used
from
    employee_data
where
    leaves_used > 10;

-- Views:
-- Question 3: Create a view to show the details of all Senior Analysts.
CREATE VIEW
    Seniors as
SELECT
    *
from
    employee_data
where
    designation = 'Senior Analyst';

    select * from Seniors

-- Materialized Views:
-- Question 4: Create a materialized view to store the count of employees by department.
CREATE MATERIALIZED VIEW Emp_count as
SELECT
    count(*),
    unit
from
    employee_data
group by
    unit;

-- Procedures (Stored Procedures):
-- Question 6: Create a procedure to update an employee's salary by their first name and last name.
CREATE
OR REPLACE PROCEDURE update_salary (firstName varchar(50), lastName varchar(50), newSalary INT) language plpgsql
as $$
BEGIN
Update employee_data
set
    salary = newSalary
where
    first_name = firstName
    AND last_name = lastName;
-- commit;
END;
$$;
CALL update_salary ('BELLE','ARDS', 30000);
-- Question 7: Create a procedure to calculate the total number of leaves used across all departments.
-- drop procedure total_leave;
CREATE OR REPLACE PROCEDURE total_leave(INOUT total_leave int default 0)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT sum(leaves_used) INTO total_leave
    FROM employee_data;
END;
$$;

call total_leave();