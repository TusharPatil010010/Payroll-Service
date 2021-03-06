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
    -> ('Terissa', 'F',6000000.00,'2010-01-02');
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

#UC9
alter table employee_payroll_service RENAME COLUMN salary to basic_pay;
alter table employee_payroll_service add deductions double NOT NULL after basic_pay;
alter table employee_payroll_service add taxable_pay double NOT NULL after deductions;
alter table employee_payroll_service add tax double NOT NULL after taxable_pay;
alter table employee_payroll_service add net_pay double NOT NULL after tax;

#UC10
update employee_payroll_service set department = 'Sales' where name = 'Terissa';
insert into employee_payroll_service(name,department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) 
                             values ('Terissa','Marketing','F',3000000,1000000,1000000,100000,6000000,'2010-01-02');

#UC12
alter table employee_payroll_service rename to employee;
alter table employee rename column id to employeeId;
alter table employee add payroll_id int not null after gender;
create table department (employeeId int not null, departmentName varchar(100) not null,
                         foreign key (employeeId) references employee(employeeId));
create table payroll ( payroll_id int not null, basic_pay double not null, deductions double not null,
                      taxable_pay double not null, tax double not null, net_pay double not null, primary key (payroll_id));

alter table employee add foreign key(payroll_id) payroll(payroll_id);
create table phone_numbers (employeeId int not null, phone numeric(10) not null,
                            foreign key (employeeId) references employee(employeeId));
alter table employee drop column basic_pay, drop column deductions, drop column taxable_pay, drop column tax, drop column net_pay;

#UC13
select employee.employeeId, employee.name, phone_numbers.phone, employee.address, department.departmentName, employee.gender,
payroll.basic_pay, payroll.deductions, payroll.taxable_pay, payroll.tax, payroll.net_pay, employee.start
from employee 
inner join phone_numbers on employee.employeeId = phone_numbers.employeeId 
inner join employee_dept on employee.employeeId = department.employeeId
inner join payroll on employee.payroll_id = payroll.payroll_id;