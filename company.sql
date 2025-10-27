DROP SCHEMA IF EXISTS company;
create schema if not exists company;

-- create domain D_num as int check()

select * from information_schema.table_constraints where constraint_schema = 'company';

-- drop table company,employee;

ALTER TABLE company.employee
ADD CONSTRAINT chk_salary_employee check(Salary>2000);

ALTER TABLE company.employee
DROP PRIMARY KEY;

ALTER TABLE company.employee
ADD CONSTRAINT pk_employee primary key (Ssn);

create table company.employee(
	fname varchar(15) NOT NULL,
	Mname char,
	Lname varchar(25) NOT NULL,
	Ssn char(9) NOT NULL,
	Bdate DATE,
	Address varchar(30),
	sex char,
	Salary decimal(10,2),
	Super_ssn char(9),
	Dno int NOT NULL,
    constraint chk_salary_employee check(Salary>2000),
	constraint pk_employee primary key (Ssn)
);

use company;
create table departament(
	Dname varchar(15) NOT NULL UNIQUE,
    Dnumber int NOT NULL,
    Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique(Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

use company;
create table dep_locations(
	Dnumber int NOT NULL,
    Dlocation varchar(15) NOT NULL,
    primary key (Dnumber, Dlocation),
    foreign key (Dnumber) references departament(Dnumber)
);

use company;
create table project(
	Pname varchar(15) NOT NULL UNIQUE,
    Pnumber int NOT NULL,
    Plocation varchar(15),
    Dnum int NOT NULL,
    primary key(Pnumber),
    foreign key(Dnum) references departament(Dnumber)
);

use company;
create table works_on(
	Essn char(9) NOT NULL,
    Pno int NOT NULL,
    Hours decimal(3,1) NOT NULL,
    primary key(Essn, Pno),
    foreign key(Essn) references employee(Ssn),
    foreign key(Pno) references project(Pnumber)
);

use company;
create table dependent(
	Essn char(9) NOT NULL,
    Dependent_name varchar(15) NOT NULL,
    Sex char,
    Bdate date,
    Relatinship varchar(8),
    primary key(Essn, Dependent_name),
    foreign key (Essn) references employee(Ssn) 
);

SHOW TABLES;
DESC departament;

select * from company.employee;
select * from company.departament;
select * from company.dep_locations;
select * from company.project;
select * from company.works_on;
select * from company.dependent;