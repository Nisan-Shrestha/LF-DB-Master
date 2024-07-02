-- create tablel
CREATE TABLE
  Employees (emp_id INT primary key, emp_name VARCHAR(60) not null, Email varchar(60) unique, salary decimal(10, 2) check (salary > 25000), department VARCHAR DEFAULT 'UNKNOWN', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

create table
  Location (location_id INT primary key, emp_id int, city varchar(69), state varchar(69), foreign key (emp_id) references Employees (emp_id));

alter table Location
drop column location_id;

alter table Location
add column location_id serial primary key;

insert into
  Employees (emp_id, emp_name, Email, salary, department, created_at)
values
  (1, 'Billy Biaggi', 'bbiaggi0@economist.com', 57901.87, 'Support', '12/30/2023'),
  (2, 'Faustine Canavan', 'fcanavan1@wiley.com', 39530.59, 'Sales', null),
  (3, 'Charil Dionisetti', 'cdionisetti2@adobe.com', 28188.69, 'Business Development', null),
  (4, 'Kamillah Nassy', 'knassy3@google.it', 28113.98, 'Services', null),
  (5, 'Rachel Prime', 'rprime4@so-net.ne.jp', 70822.19, 'Engineering', '1/4/2024'),
  (6, 'Leena Brader', 'lbrader5@ihg.com', 28243.6, 'Sales', '8/7/2023'),
  (7, 'Ludovico Carrodus', 'lcarrodus6@toplist.cz', 99534.59, 'Engineering', null),
  (8, 'Ajay Asple', 'aasple7@baidu.com', 59442.74, 'Support', null),
  (9, 'Kenneth Fluck', 'kfluck8@istockphoto.com', 26670.36, 'Sales', null),
  (10, 'Sutton Valens-Smith', 'svalenssmith9@cafepress.com', 34288.58, null, '11/8/2023'),
  (11, 'Carolin Simka', 'csimkaa@umn.edu', 79912.96, 'Training', '8/22/2023'),
  (12, 'Davina Bloxham', 'dbloxhamb@addthis.com', 61053.82, 'Sales', '1/9/2024'),
  (13, 'Thorndike Macvey', 'tmacveyc@symantec.com', 33425.19, 'Business Development', '2/16/2024'),
  (14, 'Thebault Cobson', 'tcobsond@hp.com', 65091.83, 'Marketing', '6/26/2024'),
  (15, 'Tomlin McKinless', 'tmckinlesse@unicef.org', 40228.84, 'Sales', '3/28/2024');

insert into
  Location (emp_id, city, state)
values
  (1, 'San Diego', 'California'),
  (2, 'Moreno Valley', 'California'),
  (2, 'Detroit', 'Michigan'),
  (4, 'Jeffersonville', 'Indiana'),
  (6, 'Wilmington', 'Delaware'),
  (6, 'Carson City', 'Nevada'),
  (7, 'Athens', 'Georgia'),
  (8, 'Trenton', 'New Jersey'),
  (9, 'Fresno', 'California'),
  (10, 'Warren', 'Michigan');

-- Write an SQL query to retrieve employees whose salary is between 30000 and 50000.
select
  *
from
  employees
where
  salary > 30000
  AND salary < 50000
  -- Write an SQL query to increase the salary of all employees by 5000 units.
update Employees
set
  salary = salary + 5000
  -- Retrieve employees who work in the 'Sales' department.
select
  *
from
  Employees
where
  department = 'Sales';

-- Retrieve employees whose email starts with 'j'.
select * from Employees where email Like 'j%';

-- Calculate the average , minimum and maximum salary for each department.
select department, Avg(salary) as Average, min(salary) as Minimum, max(salary) as Maximum from Employees group by department


-- Calculate Total Number of Locations per City
select city ,count(city) as a from Location group by city


-- Calculate Total Number of Locations per State
select state, count(state) as a from Location group by state
