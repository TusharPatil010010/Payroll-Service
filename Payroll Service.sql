#UC1
CREATE DATABASE payroll_service;
SHOW DATABASES;
USE payroll_service;

#UC2:
CREATE TABLE employee_payroll_service(
    -> id               INT unsigned NOT NULL AUTO_INCREMENT,
    -> name             VARCHAR(150) NOT NULL,
    -> salary           Double NOT NULL,
    -> start            DATE NOT NULL,
    -> PRIMARY KEY      (id)
    -> );
describe employee_payroll_service;

#UC3:
INSERT INTO employee_payroll_service(name, salary, start) VALUES
    -> ('Ratan', 1000000.00, '1960-01-02'),
    -> ('Mukesh', 2000000.00, '2000-01-02'),
    -> ('Tushar', 30000000.00, '2020-01-02');

#UC4:
select * from employee_payroll_service;

#UC5:
select salary from employee_payroll_service where name = 'Mukesh';
select salary from employee_payroll_service where start between cast('1999-01-01' as date) and date(NOW());
select * from employee_payroll_service where start between cast('1999-01-01' as date) and date(NOW());

#UC6:
alter table employee_payroll_service add gender char(1) after name;
select * from employee_payroll_service;
update employee_payroll_service  set gender = 'M' where name = 'Ratan' OR name = 'Mukesh' OR name = 'Tushar';
select * from employee_payroll_service;
describe employee_payroll_service;

#UC7:
insert into employee_payroll_service(name, gender, salary, start) VALUES
    -> ('Eve', 'F',6000000.00,'2010-01-02');
select * from employee_payroll_service;
select gender, AVG(salary) from employee_payroll_service group by gender;
select gender, SUM(salary) from employee_payroll_service group by gender;
select gender, COUNT(salary) from employee_payroll_service group by gender;
select gender, MIN(salary) from employee_payroll_service group by gender;
select gender, MAX(salary) from employee_payroll_service group by gender;

#UC8
alter table employee_payroll_service add phone numeric(10) after name;
alter table employee_payroll_service add address varchar(250) after phone;
alter table employee_payroll_service add department varchar(150) NOT NULL after address;
alter table employee_payroll_service alter address SET DEFAULT 'India';