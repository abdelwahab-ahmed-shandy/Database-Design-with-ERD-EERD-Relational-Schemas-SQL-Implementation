-- Created By Abdelwahab Shandy
-- Prescription System for Barwon Health
-- You will find a file called Diagram_0 inside the database inside the Database Diagram folder.
-- You will find a backup file before adding any data into the database in this file called "The full code to create this database.sql"

-- Create PrescriptionSystemDB DataBase
Create DataBase PrescriptionSystemDB;
GO
-- Use the created database
Use PrescriptionSystemDB;
GO

-- Create a Persons table to store people information.
Create Table Persons(
	PersonID Int Primary Key Identity(1,1),
	FirstName nvarchar(100) Not Null ,
	MidName nvarchar(100) Null ,
	LastName nvarchar(100) Not Null ,
	Email nvarchar(255) UNIQUE Not Null ,
	Gender nvarchar(1) Not Null ,
	DateOfBirth DateTime2 Not Null ,
	LanguagePreference nvarchar(255) Not Null ,
	Nationality nvarchar(255) Not Null ,
	Photo varbinary(Max) ,
	MaritalStatus nvarchar(255) Not Null ,
	DateCreated DateTime2 Not Null ,
	Notes nvarchar(255) 
);

-- Create a Phones table to store phone numbers.
Create Table Phones(
	PhoneID Int Primary Key Identity(1,1),
	PhoneNumber nvarchar(15) Not Null ,
	PersonID Int Foreign Key References Persons(PersonID) Not Null 
);

-- Create an EmergencyContacts table to store emergency contacts information.
Create Table EmergencyContacts(
	EmergencyID Int Primary Key Identity(1,1),
	EmergencyPhone nvarchar(15) Not Null,
	EmergencyEmail nvarchar(255) Not Null,
	PersonID Int Foreign Key References Persons(PersonID) Not Null 
);

-- Create a table Addresses to store addresses.
Create Table Addresses(
	AddressID Int Primary Key Identity(1,1),
	City nvarchar(255) Not Null,
	Street nvarchar(255) Not Null,
	ApartmentNumber Int Not Null ,
	PersonID Int Foreign Key References Persons(PersonID) Not Null 
);

-- Create a Patients table to store patient data.
Create Table Patients(
	PatientURNumber Int Primary Key Identity(1,1),
	MedicalHistory nvarchar(255) Not Null,
	Midicare nvarchar(255) Not Null,
	PersonID Int Foreign Key References Persons(PersonID) Not Null
);

-- Create a Doctors table to store doctors' data.
Create Table Doctors(
	DoctorID Int Primary Key Identity(1,1),
	Specialization nvarchar(255) Not Null,
	YearOfExperience Int Not Null ,
	LicenseNumber nvarchar(255) Unique Not Null ,
	PersonID Int Foreign Key References Persons(PersonID) Not Null
);

-- Create a Prescriptions table to store prescriptions.
Create Table Prescriptions(
	PrescriptionID Int Primary Key Identity(1,1),
	Name nvarchar(255) Not Null,
	Note nvarchar(255) Not Null,
	Quantity nvarchar(255) Not Null,
	History	nvarchar(255) Not Null,
	PrescriptionDate Datetime2 Not Null,
	DoctorID Int Foreign Key References Doctors(DoctorID) Not Null ,
	PatientURNumber Int Foreign Key References Patients(PatientURNumber) Not Null
);

-- Create a PharmaceuticalCompanies table to store pharmaceutical companies data.
Create Table PharmaceuticalCompanies(
	CompanyID Int Primary Key Identity(1,1),
	CompanyName nvarchar(255) Not Null,
	Address nvarchar(255) Not Null,
	PhoneNumber nvarchar(255) Not Null,
);

-- Create a Drugs table to store drug data.
Create Table Drugs(
	DrugsID Int Primary Key Identity(1,1),
	TradeName nvarchar(255) Not Null,
	DrugStrength Real Not Null ,
	CompanyID Int Foreign Key References PharmaceuticalCompanies(CompanyID) Not Null 
);

-- Create a PrescriptionDrug table to store the relationship between drugs and prescriptions.
Create Table PrescriptionDrug(
	PrescriptionDrugID Int Primary Key Identity(1,1),
	Dosage nvarchar(255) Not Null,
	DosageDate DateTime2 Not Null,
	DrugsID Int Foreign Key References Drugs(DrugsID) Not Null ,
	PrescriptionID Int Foreign Key References Prescriptions(PrescriptionID)  Not Null
);



