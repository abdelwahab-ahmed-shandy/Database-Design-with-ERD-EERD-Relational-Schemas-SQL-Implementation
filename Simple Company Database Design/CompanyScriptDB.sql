-- Script for creating Company Database
-- Author: Abdelwahab Shandy
-- Description: This script creates a database named Company_DataBase to manage company-related data, including employees, dependents, supervisors, departments, projects, and work assignments.

Create DataBase Company_DataBase ;

Use Company_DataBase ;

Create table Employees(
	EmployeeSSN int Primary Key , 
	FirstName nvarchar(150) not null ,
	LastName nvarchar(150) not null ,
	Gender nvarchar(1) ,
	BirthOfDate datetime2 ,
);

Create table Dependents(
	DependentName nvarchar(150) ,
	Gender nvarchar(1) ,
	BirthOfDate datetime2 ,
	EmployeeSSN int Foreign Key REFERENCES Employees(EmployeeSSN)
);

Create table Supervisors(
	SupervisorID int Primary Key ,
	FirstName nvarchar(150) not null ,
	LastName nvarchar(150) not null ,
);

Alter Table Employees
ADD SupervisorID int;

Alter Table Employees
ADD Foreign Key (SupervisorID) References Supervisors(SupervisorID);

Create Table Depertments(
	DepertmentID int Primary Key ,
	Name nvarchar(50) Not Null 
);

Create Table Mangers(
	MangerID int Primary Key ,
	HiringDate DateTime2 not Null,
	DepertmentID int Foreign Key References Depertments(DepertmentID)
);

Create Table Projects(
	ProjectID int Primary Key ,
	Name nvarchar(150) Not Null ,
	City nvarchar(50),
	StartProject datetime2 ,
	DepertmentID int Foreign Key References Depertments(DepertmentID)
);

Create Table Locations(
	LocationName nvarchar(100) ,
	ProjectID int foreign key references Projects(ProjectID)
);

Create Table WorkIn(
	Hours int not null ,
	ProjectID int foreign key references Projects(ProjectID),
	EmployeeSSN int Foreign Key REFERENCES Employees(EmployeeSSN)
);





