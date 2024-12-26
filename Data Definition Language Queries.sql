--Created By Abdelwahab Shandy
--Don't Forget To Pray For Me And My Parents
--Data Definition Language 

--CREATE DATABASE Statement :
Create DataBase koko;

--Switch Databases
Use koko ;

--SQL DROP DATABASE Statement
DROP DATABASE koko;
ALTER DATABASE [koko] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Delete Column in a Table
ALTER TABLE koko
DROP COLUMN soso;

--CREATE DATABASE IF NOT EXISTS
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'koko')
  BEGIN
    CREATE DATABASE koko;
  END;

--Drop DATABASE IF EXISTS
IF EXISTS(SELECT * FROM sys.databases WHERE name = 'koko')
  BEGIN
    Drop DATABASE koko;
  END;

--SQL CREATE TABLE Statement

CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
   ....
);

--SQL DROP TABLE Statement
DROP TABLE table_name;

--Alter Table Statement :

--  Add Column
ALTER TABLE table_name
ADD soso char(1);

-- Rename Column in a Table (Most Databases)
exec sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';

-- Rename a Table
exec sp_rename 'old_table_name', 'new_table_name';

--Modify Column in a Table (Data type)
ALTER TABLE table_name
ALTER COLUMN soso VARCHAR(100);
