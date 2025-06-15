-- Script for creating Library Database
-- Author: Abdelwahab Shandy
-- Description: This script creates a database named Library_DB to manage library operations, including books, users, borrowing records, fines, and reservations.
-- If you benefit from something, do not forget to pray for me and my parents.

Create DataBase Library_DB;
go
use Library_DB;
go

Create Table Settings(
	DefualtBorrrowDays tinyInt ,
	DefaultFinePerDay tinyInt
);

Create Table Books(
	BookID Int Primary Key Identity(1,1),
	Title nvarchar(255) Not Null ,
	ISBN nvarchar(50) Not Null ,
	PublicationDate Datetime2,
	Genre nvarchar(50) not null ,
	AdditionalDetails nvarchar(Max) not null
); 

Create Table Users(
	UserID int primary key identity(1,1) ,
	Name nvarchar(100) not null ,
	ContactInformation nvarchar(255),
	LibraryCardNumber nvarchar(50)
);

Create Table BookCopies(
	CopyID int primary key ,
	BookID int foreign key references Books(BookID)
);

Create Table BorrowingRecords(
	BorrowingRecordID int Primary Key ,
	CopyID int foreign key references BookCopies(CopyID),
	UserID int foreign key references Users(UserID),
	BorrowingDate DateTime2 ,
	DueDate DateTime2 ,
	ActualReturnDate DateTime2 
);

Create Table Fines(
	FineID int Primary Key ,
	UserID int foreign key references Users(UserID),
	BorrowingRecordID int foreign key references BorrowingRecords(BorrowingRecordID),
	NumberOfLateDays smallint ,
	FineAmount decimal ,
	PaymentStatus bit
);

Create table Reservations(
	ReservationID int Primary Key ,
	ReservationDate datetime,
	UserID int foreign key references Users(UserID),
	CopyID int foreign key references BookCopies(CopyID),
);
