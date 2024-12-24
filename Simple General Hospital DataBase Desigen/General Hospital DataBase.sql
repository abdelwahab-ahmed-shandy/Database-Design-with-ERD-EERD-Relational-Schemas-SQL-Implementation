-- Script for creating General Hospital Database
-- Author: Abdelwahab Shandy
-- Description: This script creates a database named General_Hospital_DB to manage hospital-related data, including drugs, wards, nurses, patients, consultants, and drug administration.

Create DataBase General_Hospital_DB;

Use General_Hospital_DB;

Create Table Drug(
	DrugCodeNumber int Primary Key ,
	Recommended nvarchar(200) not null
);

Create Table Brand(
	BrandID int Primary Key ,
	Name nvarchar(100) not null,
	DrugCodeNumber int foreign key references Drug(DrugCodeNumber)
);

Create Table Ward(
	WardID int Primary Key ,
	Name nvarchar(100) not null,
);

Create Table Nurse(
	NurseID int Primary Key ,
	Name nvarchar(100) not null,
	Phone nvarchar(100) not null,
	Address nvarchar(100) not null,
	WardID int foreign key references Ward(WardID)
);

Create Table DrugAdministration(
	DosageID int Primary Key ,
	Date nvarchar(6),
	Time Datetime2,
	NurseID int foreign key references Nurse(NurseID),
	DrugCodeNumber int foreign key references Drug(DrugCodeNumber)
);

Create Table Patients(
	PatientsID int Primary Key ,
	Name nvarchar(100) not null,
	DateOfBirth Datetime2,
	WardID int foreign key references Ward(WardID)
);

Create Table Consultants(
	ConsultantsID int Primary Key,
	Name nvarchar(100)
);

Create Table ExaminedBy(
	ConsultantsID int foreign key references Consultants(ConsultantsID),
	PatientsID int foreign key references Patients(PatientsID),
	OtherConsultantsID int 
);

