CREATE DATABASE IF NOT EXISTS azure_company;
USE azure_company;

CREATE TABLE employee(
	Fname varchar(15) NOT NULL,
    Minit char,
    Lname varchar(15) NOT NULL,
    Ssn char(9) NOT NULL, 
    Bdate date,
    Address varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int NOT NULL,
    CONSTRAINT chk_salary_employee CHECK (Salary> 2000.0),
    CONSTRAINT pk_employee PRIMARY KEY (Ssn)
);

ALTER TABLE employee
ADD CONSTRAINT fk_employee
FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE employee MODIFY Dno int NOT NULL DEFAULT 1;

DESC employee;

CREATE TABLE departament (
    Dname varchar(15) NOT NULL,
    Dnumber int NOT NULL,
    Mgr_ssn char(9) NOT NULL,
    Mgr_start_date date, 
    Dept_create_date date,
    CONSTRAINT chk_date_dept CHECK (Dept_create_date < Mgr_start_date),
    CONSTRAINT pk_dept PRIMARY KEY (Dnumber),
    CONSTRAINT unique_name_dept UNIQUE (Dname),
    FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
);

ALTER TABLE departament 
ADD CONSTRAINT fk_dept
FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
ON UPDATE CASCADE;

DESC departament;

CREATE TABLE dept_locations (
    Dnumber int NOT NULL,
    Dlocation varchar(15) NOT NULL,
    CONSTRAINT pk_dept_locations PRIMARY KEY (Dnumber, Dlocation),
    CONSTRAINT fk_dept_locations FOREIGN KEY (Dnumber) REFERENCES departament (Dnumber)
);

ALTER TABLE dept_locations DROP fk_dept_locations;

ALTER TABLE dept_locations 
ADD CONSTRAINT fk_dept_locations
FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

CREATE TABLE project (
    Pname varchar(15) NOT NULL,
    Pnumber int NOT NULL,
    Plocation varchar(15),
    Dnum int NOT NULL,
    PRIMARY KEY (Pnumber),
    CONSTRAINT unique_project UNIQUE (Pname),
    CONSTRAINT fk_project FOREIGN KEY (Dnum) REFERENCES departament(Dnumber)
);


CREATE TABLE works_on (
    Essn char(9) NOT NULL,
    Pno int NOT NULL,
    Hours decimal(3,1) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    CONSTRAINT fk_employee_works_on FOREIGN KEY (Essn) REFERENCES employee(Ssn),
    CONSTRAINT fk_project_works_on FOREIGN KEY (Pno) REFERENCES project(Pnumber)
);

CREATE TABLE dependent (
    Essn char(9) NOT NULL,
    Dependent_name varchar(15) NOT NULL,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    PRIMARY KEY (Essn, Dependent_name),
    CONSTRAINT fk_dependent FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);

DESC dependent;
