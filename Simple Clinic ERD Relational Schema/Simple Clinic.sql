Create DataBase Simple_Clinic;

Use Simple_Clinic;

Create Table Persons(
	PersonID Int Identity(1,1) Primary Key ,
	FirstName nvarchar(150) Not Null ,
	LastName nvarchar(150) Not Null ,
	DateOfBirth DateTime2 Not Null ,
	Gender nvarchar(1) Not Null ,
	PhoneNumber nvarchar(15) Not Null ,
	Email nvarchar(150) not Null ,
	Addrees nvarchar(150)
);

Create Table Patierts(
	PatiertID INT Identity(1,1) Primary Key ,
	PersonID INT References Persons(PersonID) Not Null 
);

Create Table Doctors(
	DoctorID int Identity(1,1) Primary Key ,
	PersonID INT REferences Persons(PersonID) Not Null 
);

Create Table Payments(
	PaymentID int Identity(1,1) Primary Key ,
	PaymentDate DateTime2 Not Null ,
	PaymentMethod nvarchar(255) Null ,
	AmountPaid Real Not Null ,
	AdditionNotes nvarchar(255) Null 
);

Create table MedicalRecords(
	MedicalRecordID int identity(1,1) Primary Key ,
	VisitDescription nvarchar(255) Not Null ,
	Diagnosis nvarchar(255) Not Null ,
	AdditionNotes nvarchar(255) Null 
);

Create Table Appointments(
	AppointmentID INT IDENTITY(1,1) Primary Key ,
	PatiertID INT REFERENCES Patierts(PatiertID) not Null ,
	DoctorID INT References Doctors(DoctorID) Not Null ,
	AppointmentDateTime Datetime2 Not Null ,
	AppointmentStatus Tinyint not null ,
	PaymentID Int References Payments(PaymentID) Not Null ,
	MedicalRecordID int References MedicalRecords(MedicalRecordID) not Null 
);

Create table Prescriptions(
	PrescriptionID int Identity(1,1) Primary Key ,
	MedicalRecordID int references MedicalRecords(MedicalRecordID) Not Null ,
	MedicalName nvarchar(255) Not Null ,
	Dosage nvarchar(255) Not Null ,
	Frequency nvarchar(255) Not Null ,
	Speciallnstructions nvarchar(255) Not Null ,
	StartDate Datetime2 Not null ,
	EndDate Datetime2 Not Null
);