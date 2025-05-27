--Created By Abdelwahab Shandy
--Don't Forget To Pray For Me And My Parents
--Constraints 

-- Identity Field (Auto Increment)
--====================================
Create Table Departments(
	ID int Identity(1,1) NOT NULL, 
	Name nvarchar(50) NOT Null,
	primary key (ID)
);

-----------------
--PRIMARY KEY
-----------------
--SQL PRIMARY KEY on CREATE TABLE
--Ex :
CREATE TABLE Persons (
   ID int NOT NULL PRIMARY KEY,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int
);
-----------------------------------
CREATE TABLE Persons (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int,
    CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
);
----------------------------------
--SQL PRIMARY KEY on ALTER TABLE

ALTER TABLE Persons
ADD PRIMARY KEY (ID);
----------------------------------
ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);
----------------------------------
DROP a PRIMARY KEY Constraint
=========================
ALTER TABLE Persons
DROP CONSTRAINT PK_Person;

-----------------
--FOREIGN KEY
-----------------
--SQL FOREIGN KEY on CREATE TABLE

CREATE TABLE Orders (
   OrderID int NOT NULL PRIMARY KEY,
   OrderNumber int NOT NULL,
   PersonID int FOREIGN KEY REFERENCES Persons(PersonID)
);
-----------------------------------------------------------
CREATE TABLE Orders (
   OrderID int NOT NULL,
   OrderNumber int NOT NULL,
   PersonID int,

    PRIMARY KEY (OrderID),
    CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID)
    REFERENCES Persons(PersonID)

------------------------------------
-- SQL FOREIGN KEY on ALTER TABLE
------------------------------------
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
---------------------------------------------------------
ALTER TABLE Orders
ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
------------------------------------
DROP a FOREIGN KEY Constraint
------------------------------------
ALTER TABLE Orders
DROP CONSTRAINT FK_PersonOrder;

------------------------------------
--NOT NULL
------------------------------------
--SQL NOT NULL on CREATE TABLE
---------------------------------
CREATE TABLE Persons (
   ID int NOT NULL,
    LastName varchar(255) NOT NULL,
   FirstName varchar(255) NOT NULL,
   Age int
);

-------------------------------
--SQL NOT NULL on ALTER TABLE :
-------------------------------
ALTER TABLE Persons
ALTER COLUMN Age int NOT NULL;

----------------------------
-- DEFAULT : 
----------------------------
--SQL DEFAULT on CREATE TABLE
-----------------------------
CREATE TABLE Persons (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int,
   City varchar(255) DEFAULT 'Amman'
);
--------------------------------------------
--The DEFAULT constraint can also be used to insert system values, by using functions like GETDATE():
--GETDATE() == Carant Date

CREATE TABLE Orders (
   ID int NOT NULL,
   OrderNumber int NOT NULL,
   OrderDate date DEFAULT GETDATE()
);

----------------------------
--SQL DEFAULT on ALTER TABLE
----------------------------
--To create a DEFAULT constraint on the "City" column when the table is already created, use the following SQL:

ALTER TABLE Persons
ADD CONSTRAINT df_City
DEFAULT 'Amman' FOR City;

----------------------------
--DROP a DEFAULT Constraint
----------------------------
To drop a DEFAULT constraint, use the following SQL:

ALTER TABLE Persons
DROP Constraint  df_City;

----------------------------
-- CHECK  
----------------------------
--SQL CHECK on CREATE TABLE
----------------------------
CREATE TABLE Persons (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int CHECK (Age>=18)
);
-------------------------------------
CREATE TABLE Persons (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int,
   City varchar(255),
    CONSTRAINT CHK_Person CHECK (Age>=18 AND City='Amman')
);

----------------------------
-- DROP a CHECK Constraint
----------------------------
ALTER TABLE Persons
DROP CONSTRAINT CHK_Person;

----------------------------
-- Unique   
----------------------------

-------------------------------------------
--SQL UNIQUE Constraint on CREATE TABLE :
-------------------------------------------
CREATE TABLE Persons (
   ID int NOT NULL UNIQUE,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int
);
--------------------------------------
CREATE TABLE Persons (
   ID int NOT NULL,
   LastName varchar(255) NOT NULL,
   FirstName varchar(255),
   Age int,
    CONSTRAINT UC_Person UNIQUE (ID,LastName)
);

----------------------------------------
-- SQL UNIQUE Constraint on ALTER TABLE :
----------------------------------------
ALTER TABLE Persons
ADD UNIQUE (ID);
---------------------
ALTER TABLE Persons
ADD CONSTRAINT UC_Person UNIQUE (ID,LastName);
-----------------------------------------------------
--------------------------------
-- DROP a UNIQUE Constraint :
--------------------------------
ALTER TABLE Persons
DROP CONSTRAINT UC_Person;
----------------------------
-- INDEX    
----------------------------


--CREATE INDEX Syntax :
CREATE INDEX index_name
ON table_name (column1, column2, ...);

--CREATE UNIQUE INDEX Syntax :
CREATE UNIQUE INDEX index_name
ON table_name (column1, column2, ...);
----------------------------------------
-- EX:
CREATE INDEX idx_lastname
ON Persons (LastName);

CREATE INDEX idx_pname
ON Persons (LastName, FirstName);

--DROP INDEX Statement : 
DROP INDEX table_name.index_name;
--===============================================================

--Type Of Index :
--================
--Clustered Index :
CREATE CLUSTERED INDEX idx_id ON users(id);

--Non-Clustered Index :
CREATE NONCLUSTERED INDEX idx_name ON users(name);

--Composite Index :
CREATE INDEX idx_name_date ON users(name, date_of_birth);

--Unique Index :
CREATE UNIQUE INDEX idx_email ON users(email);

--Full-text Index :
CREATE FULLTEXT INDEX idx_content ON articles(content);

--Bitmap Index :
CREATE BITMAP INDEX idx_status ON employees(status);

--Reverse Key Index :
CREATE INDEX idx_reverse_key ON users(REVERSE(id));
