Create DataBase Airlines_DataBase;

Use Airlines_DataBase ;

Create Table Employees(
	EmployeeID Int Not Null Primary Key,
	FirstName nvarchar(100) Not Null,
	LastName nvarchar(100) Not Null, 
	Address nvarchar(150) ,
	Position nvarchar(100) Not NUll ,
	Qualifications nvarchar(255) Not Null ,
	Gender nvarchar Not Null ,
	DateOfBirth Datetime2 
);

Create Index idx_pname
On Employees (LastName,FirstName)

Create Table Airlines(
	AirlineID Int Not Null Primary Key ,
	Name nvarchar(150) Not Null ,
	Address nvarchar(100) ,
	ContactPerson nvarchar(255) not null ,
	EmployeeID Int Foreign Key References Employees(EmployeeID)
);

Create Table TelephoneNumbers(
	IDTelephoneNumbers Int Not Null Primary Key ,
	AirlineID int foreign key references Airlines(AirlineID)
);

Create Table Transactions(
	IdTransaction int identity(1,1) Primary Key Not Null ,
	Date datetime2 Not Null ,
	Amount real not null ,
	Description nvarchar(255) Not Null ,
	AirlineID int foreign key references Airlines(AirlineID)
);

Create table Routes(
	RoutID int identity(1,1) Primary Key Not Null ,
	Domestic nvarchar(100) ,
	International NVArCHAR(100) ,
	Distance nvarchar(100),
	Destination nvarchar(255),
	Origin nvarchar(100)
);

create table Crews(
	CrewID int Primary key identity(1,1) not null ,
	MajorPilot nvarchar(150) ,
	AssistantPilot nvarchar(150) ,
    Hostesses nvarchar(150) ,
);

create table Aircrafts(
	AircraftID int Primary Key not null ,
	Model nvarchar(100) not null ,
	Capacity nvarchar(100) not null ,
	AirlineID int foreign key references Airlines(AirlineID),
	CrewID int foreign key references Crews(CrewID)
);

Create Table Assigneds(
	AssignedID int Primary Key identity(1,1) not null ,
	TravelTime DateTime2 not null ,
	ArrivalDate datetime2 not null ,
	Assigned nvarchar(190) not null ,
	PricePerPassenger decimal not null ,
	PassengersCount int not null ,
	RoutID int foreign key references Routes(RoutID),
	AircraftID int foreign key references Aircrafts(AircraftID)
);


