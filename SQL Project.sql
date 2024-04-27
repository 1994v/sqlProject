create database employee_mgnt_DB;
use employee_mgnt_DB;

-------------------------------------------------------------------- DDL and DML
create table emp_info (emp_Name varchar(22), emp_ID int, emp_deptName varchar(22) primary key, emp_hireDate date);
insert into emp_info values ('suhani',1,'production','2019-08-12'),('gauri',2,'admin','2022-12-05'),
('vinamy',3,'civil','2023-09-01'),('virang',4,'medical','2021-12-06'),('shivay',5,'HR','2020-05-05'),('varad',6,'quality','2023-01-08');
select* from emp_info;
drop table emp_info; 

create table emp_table(empName varchar(22), empId int primary key);
insert into emp_table values('Vaibhav',1),('Dipali',2),('Divit',3);
select* from emp_table;

create table emp_dept(deptId int, empId int , foreign key(empId) references emp_table(empId),dept_Name varchar(22));
insert into emp_dept values(101,1,'MECH'),(102,2,'IT'),(100,3,'CS');
select* from emp_dept;

create table emp_department(dept_Id int, emp_deptName varchar(22) , foreign key(emp_deptName) references emp_info (emp_deptName));
insert into emp_department values(101,'production'),(122,'admin'),
(131,'civil'),(105,'medical'),(111,'HR'),(141,'quality');
select* from emp_department;


-------------------------------------------------------------------- DQL
select emp_Name from emp_info where emp_deptName in ('production','admin','civil','medical','HR','quality');
select e.emp_Name, d.emp_deptName from emp_info e  join emp_department d on e.emp_deptName = d.emp_deptName;
select emp_Name,emp_deptName from emp_info;
update emp_info set  emp_hireDate = '2023-10-01' where emp_Name = 'vinamy';
update emp_info set  emp_hireDate = '2023-12-06' where emp_Id = 4 ;
select emp_Name , emp_hireDate  from emp_info where emp_hireDate >= date_sub(curdate(),interval 6 month);

alter table emp_info add column emp_salary bigint;
update emp_info set  emp_salary = 8000 where emp_Id = 1 ;
update emp_info set  emp_salary = 12000 where emp_Id = 2 ;
update emp_info set  emp_salary = 11500 where emp_Id = 3 ;
update emp_info set  emp_salary = 12000 where emp_Id = 4 ;
update emp_info set  emp_salary = 12500 where emp_Id = 5 ;
update emp_info set  emp_salary = 50000 where emp_Id = 6 ;
rollback;
commit;
select * from emp_info;
rollback;
alter table emp_info add column job_title varchar(22);
begin;
update emp_info set  emp_salary = 75000 where emp_Id = 6 ;
rollback;

select emp_name,emp_salary from emp_info where emp_salary>=40000;
-------------------------------------------------------------------- TCL
begin ;
update emp_info set  job_title = 'jr.office' where emp_Id = 1 ;
update emp_info set  job_title = 'sr.office' where emp_Id = 2 ;
update emp_info set  job_title = 'jr.engineer' where emp_Id = 3 ;
update emp_info set  job_title = 'Manager' where emp_Id = 4 ;
update emp_info set  job_title = 'engineer' where emp_Id = 5 ;
update emp_info set  job_title = 'assistant engineer' where emp_Id = 6 ;
begin ;
update emp_info set job_title = 'sr.VP' , emp_salary = emp_salary *15 where emp_Id=4;
commit;
update emp_info set job_title = 'sr.VP' , emp_salary = emp_salary *10 where emp_Id=4;
commit;
rollback;
update emp_info set job_title = 'sr.VP' , emp_salary = emp_salary  +200000000 where emp_Id=4;
rollback;
update emp_info set job_title = '' , emp_salary = 20000 where emp_Id=4;




-------------------------------------------------------------------- JOINS
create table  emp_info1  (emp_Name varchar(22), emp_ID int, emp_deptName varchar(22) primary key, emp_hireDate date, emp_salary bigint , job_title varchar(22));
insert into emp_info1 select * from emp_info where emp_Name in (select emp_Name from emp_info) ;
select* from emp_info1;
create table emp_department1 (dept_Id int, emp_deptName varchar(22) , foreign key(emp_deptName) references emp_info1 (emp_deptName));
insert into emp_department1 select * from emp_department where emp_deptName in (select emp_deptName from emp_department);
select* from emp_department1;
insert into emp_info1 values ('devansh',7,'operation','2017-08-20',18000,'sr.engineer'),
('vaishu',8,'accounts','2019-11-12',14000,'jr.accountant'),('vidya',9,'sales','2021-10-05',19500,'sr.accountant');

drop table emp_department1;

select emp_info1.emp_deptName , emp_info1.emp_Name , emp_department1.dept_Id from emp_info1 inner join emp_department1 on emp_info1.emp_deptName = emp_department1.emp_deptName;
select emp_info1.emp_Name, emp_info1.emp_deptName, emp_department1.dept_Id from emp_info1 left join emp_department1 on emp_info1.emp_deptName = emp_department1.emp_deptName;
select emp_info1.emp_Name, emp_info1.emp_deptName, emp_department1.dept_Id from emp_info1 right join emp_department1 on emp_info1.emp_deptName = emp_department1.emp_deptName;
select emp_info1.emp_Name, emp_info1.emp_deptName,emp_department1.dept_Id from emp_info1 cross join emp_department1 where emp_info1.emp_deptName = emp_department1.emp_deptName;
select emp_info1.emp_Name, emp_info1.emp_deptName, emp_department1.dept_Id from emp_info1 left join emp_department1 on emp_info1.emp_deptName = emp_department1.emp_deptName union 
select emp_info1.emp_Name, emp_info1.emp_deptName, emp_department1.dept_Id from emp_info1 right join emp_department1 on emp_info1.emp_deptName = emp_department1.emp_deptName;


-------------------------------------------------------------------- CASE STUDY INTEGRATION
create table employees (emp_Id int primary key , emp_Name varchar(22) , department varchar(22));
insert into employees values(1,'john','IT'),(2,'jane','HR'),(3,'bob','Finance'),(4,'siri','Quality'),(5,'alex','Admin');
select * from employees;
drop table employees;

create  table training_sessions(session_Id int primary key , dession_Name varchar(22) , session_date date , trainer_Name varchar(22));
insert into training_sessions values(101, 'SQL basics','2023-01-01','Vaibhav'),
(102,'soft skills','2023-10-02','smith'),(103,'project management','2023-05-20','charlie'),(104,'project management','2022-01-04','divit'),(105,'soft skills','2023-01-06','dipali');
alter table training_sessions rename column dession_Name to session_Name;
select * from training_sessions;
drop table training_sessions;
select concat(session_Name,trainer_Name) as details from training_sessions;

create table employee_enrollment(enrollment_Id int primary key , emp_Id int ,foreign key(emp_Id) references employees(emp_Id) , 
session_Id int ,foreign key(session_Id) references training_sessions(session_Id) , enrollment_date date);
insert into employee_enrollment values(201,1,101,'2023-01-10') , (202,2,105,'2023-01-06') , (203,3,103,'2023-02-24'),(204,2,104,'2022-01-04'),(205,5,105,'2023-01-06');
select * from employee_enrollment;
drop table employee_enrollment;


select ee.enrollment_Id , e.emp_Name , ts.session_Name , ee.enrollment_date from employee_enrollment ee join employees e on ee.emp_Id = e.emp_Id 
join training_sessions ts on ee.session_Id = ts.session_Id;

select employee_enrollment.enrollment_Id,employees.emp_Name , training_sessions.session_Name from employee_enrollment inner join employees on employee_enrollment.emp_Id = employees.emp_Id
inner join training_sessions on employee_enrollment.session_Id = training_sessions.session_Id;

select employee_enrollment.enrollment_Id,employees.emp_Name , training_sessions.session_Name from employee_enrollment left join employees on employee_enrollment.emp_Id = employees.emp_Id
left join training_sessions on employee_enrollment.session_Id = training_sessions.session_Id;

select employee_enrollment.enrollment_Id,employees.emp_Name , training_sessions.session_Name from employee_enrollment right join employees on employee_enrollment.emp_Id = employees.emp_Id
right join training_sessions on employee_enrollment.session_Id = training_sessions.session_Id;

select employee_enrollment.enrollment_Id,employees.emp_Name , training_sessions.session_Name from employee_enrollment left join employees on employee_enrollment.emp_Id = employees.emp_Id
left join training_sessions on employee_enrollment.session_Id = training_sessions.session_Id union 
select employee_enrollment.enrollment_Id,employees.emp_Name , training_sessions.session_Name from employee_enrollment right join employees on employee_enrollment.emp_Id = employees.emp_Id
right join training_sessions on employee_enrollment.session_Id = training_sessions.session_Id;


