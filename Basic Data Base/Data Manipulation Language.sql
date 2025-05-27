--Created By Abdelwahab Shandy
--Don't Forget To Pray For Me And My Parents
--Data Manipulation Language

-- INSERT INTO Statement : 

-- INSERT ONE RECORD AT A TIME'
Insert into Employess
values 
(1,'Emp1' ,'99998979',1000, 'M');

--INSERT MULTIPLE Record At a Time :
Insert Into Employess
values 
(2,'Emp2' ,'229998979',2000, 'F'),
(3,'Emp3' ,'339989793',3000, 'M');

-- INSERT Only Selected Fields :
Insert Into Employess (ID , Name )
values 
(4 , 'Emp4');

--  Update Statement
--==========================
--UPDATE Syntax :
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

-- This will Show all date in the table 
select * from Employess;

-- One Coulmn
Update Employess 
set Name = 'Abdelwahab Shandy'
Where ID = 1 ;

-- Mult Coulmn
Update Employess 
set Name = 'Anas' , Gender = 'F' 
Where ID = 4 ;

-- You Can Edit use Conditions 
Update Employess 
Set Salary = Salary + 200 
where Salary < 500 And Gender = 'F' ;

--   Delete Statement
--=============================

Delete From Employess
Where Salary is Null ;

Delete From Employess
Where ID = 5 ;

Delete From Employess
Where ID = 50 ;

--   Select Into Statement
--========================
--syntax :
SELECT *
INTO EmpoyeesCopy
FROM Employees;

-- Make a copy of the table
SELECT * 
INTO EmpCCopy1
FROM Employess;
Select * FRom EmpCCopy1;

-- Make a copy of parts of the Table
Select ID , Name 
INTO EMPCCopy2
From Employess;
Select * FRom EMPCCopy2;

-- Create a copy of the table without the values
SELECT * 
INTO Empcopy3
FROM Employess
Where 4=5; -- False 

SELECT * FROM Empcopy3;

---  Insert Into ..Select From Statement
--================================================
--syntax : 
insert into OldPersons
select  * from Persons 
where age >=30;

Select * FROm Employess
where Salary <= 3000 ;
 
insert into empty
select * From Employess
Where Salary <= 2000;
 
Select * From empty;

--Here, the SQL command copies all records from the Persons table to the OldPersons table.
--Note: To run this command,
--the database must already have a table named OldPersons
--the column names of the OldPersons table and the Persons table must match
--If we want to copy data to a new table (rather than copying in an existing table), we should use the SELECT INTO statement.

Copy all columns from one table to another table:

INSERT INTO table2
SELECT * FROM table1
WHERE condition;

Copy only some columns from one table into another table:

INSERT INTO table2 (column1, column2, column3, ...)
SELECT column1, column2, column3, ...
FROM table1
WHERE condition;

