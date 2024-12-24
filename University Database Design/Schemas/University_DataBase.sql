-- Script for creating University Database
-- Author: Abdelwahab Shandy
-- Description: This script creates a database named University_DataBase and its related tables for managing university data, including persons, professors, students, courses, and enrollments.

Create DataBase University_DataBase;

Use University_DataBase ;

Create Table Persons(
	Person_ID int Identity(1,1) Primary Key,
	First_Name nvarchar(150) Not Null ,
	Mid_Name nvarchar(150) Null ,
	Last_Name nvarchar(150) Not Null ,
	Birth_Date nvarchar(50) Not Null ,
	Gender nvarchar(1) Not Null ,
);

Create Table Phone(
	Phone_ID int Identity(1,1) Primary Key,
	Person_ID INT REFERENCES Persons(Person_ID),
);

Create Table Professors(
	Professor_ID int Identity(1,1) Primary Key,
	Salary Real Not Null ,
	Person_ID INT REFERENCES Persons(Person_ID)
);

Create Table Students(
	Student_ID int Identity(1,1) Primary Key ,
	Person_ID INT REFERENCES Persons(Person_ID),
	Professor_ID INT REFERENCES Professors(Professor_ID)
);

Create Table Courses(
	Course_ID int Identity(1,1) Primary Key ,
	Name nvarchar(150) Not Null ,
	Credit_Hours int Not Null ,
	Professor_ID INT REFERENCES Professors(Professor_ID)
);

Create Table Enrolled (
	Enroll_Date int Not Null ,
	Student_ID INT REFERENCES Students(Student_ID),
	Course_ID INT REFERENCES Courses(Course_ID)
);

-- Abdelwahab Shandy
