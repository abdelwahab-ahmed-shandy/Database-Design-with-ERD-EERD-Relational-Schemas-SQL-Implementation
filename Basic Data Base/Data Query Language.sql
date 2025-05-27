--Created By Abdelwahab Shandy
--Don't Forget To Pray For Me And My Parents
--Data Query Language (DQL) 

-- SELECT
--==========
-- All Columns :
--===============
Select * from Employees;
-- OR
Select Employees.* From Employees;

-- Specify a set of columns within the Table 
SELECT ID, FirstName , LastName , MonthlySalary FROM Employees; 

--Select Distinct Statement
Select DepartmentID From Employees;
Select Distinct DepartmentID From Employees;
Select Distinct DepartmentID , FirstName = 'Oliver' From Employees;
Select Distinct FirstName , DepartmentID = 7 From Employees;

--AND Syntax :
SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND condition3 ...;

--OR Syntax :
SELECT column1, column2, ...
FROM table_name
WHERE condition1 OR condition2 OR condition3 ...;

--NOT Syntax :
SELECT column1, column2, ...
FROM table_name
WHERE NOT condition;

--"In" Operator
--===============
 --IN Syntax
SELECT column_name(s)
FROM table_name
WHERE column_name IN (value1, value2, ...);
--OR:
SELECT column_name(s)
FROM table_name
WHERE column_name IN (SELECT STATEMENT);

---    Sorting : Order By 
--==========================
--Syntax :
ORDER BY Syntax
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;

--EX:
select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName , MonthlySalary ;

select ID, FirstName,MonthlySalary from Employees
where DepartmentID=1
Order By FirstName ASC, MonthlySalary Desc;

--    Select Top Statement 
--============================
--Syntax:

SELECT TOP number|percent column_name(s)
FROM table_name
WHERE condition;

-- This will show top 5 employees.
Select top 5 * from Employees;
-- this will show the all salaries ordered from the heighest to lowest.
select  MonthlySalary from employees
order by MonthlySalary Desc;
--This will show all employees who takes one of the Lowest 3 salaries.
select ID , FirstName, MonthlySalary from Employees where MonthlySalary In
(
	select  distinct  top 3 MonthlySalary from employees
	order by MonthlySalary ASC
)
Order By MonthlySalary ASC
-- This will show top 10% of the data.
select top 10 percent * from Employees;

--     Select As
--=============
--Syntax
SELECT column_name AS alias_name
FROM table_name;
--EX :
Select ID ,  
FullName = FirstName +' '+ LastName ,
BonusAmount = MonthlySalary * BonusPerc ,
YearlySalary = MonthlySalary * 12,
Age = DATEDIFF(Year , DateOfBirth,getDate())
From Employees;

-- Between Operator  
--==================
--Syntax: 
SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value1 AND value2;
--EX :
--NOT Use
select * from Employees 
where (MonthlySalary >= 500 And MonthlySalary <= 1000);
--Using :
Select * from Employees where
MonthlySalary Between 500 and 1000;

--    Count, Sum, Avg, Min, Max Functions  
--=========================================
--The COUNT() function returns the number of rows that matches a specified criterion.
--COUNT() Syntax
SELECT COUNT(column_name)
FROM table_name
WHERE condition;

--The AVG() function returns the average value of a numeric column. 
--AVG() Syntax
SELECT AVG(column_name)
FROM table_name
WHERE condition;

--The SUM() function returns the total sum of a numeric column. 
--SUM() Syntax
SELECT SUM(column_name)
FROM table_name
WHERE condition;

--The MIN() function returns the smallest value of the selected column.
MIN() Syntax
SELECT MIN(column_name)
FROM table_name
WHERE condition;

--The MAX() function returns the largest value of the selected column.
--MAX() Syntax
SELECT MAX(column_name)
FROM table_name
WHERE condition;

--EX :
select  TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees;

--  Group By     
--=================
--GROUP BY Syntax :
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);
--EX
select DepartmentID, TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees
           Group By DepartmentID
	   order by DepartmentID

-- Having
--=======================
-- Having is a where Stetment in a Group by 
select DepartmentID ,TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees
	   Group By DepartmentID
	   Having  Count(MonthlySalary) >100 ;

-- Same solution without having :-)
select * from 
(

   select DepartmentID, TotalCount=Count(MonthlySalary), 
	   TotalSum=Sum(MonthlySalary),
	   Average=Avg(MonthlySalary),
	   MinSalary=Min(MonthlySalary),
	   MaxSalary=Max(MonthlySalary) 
	   
	   from Employees
	
       Group By DepartmentID
	  
) R1

where R1.TotalCount> 100;

--===========================
-- Like :
--============================
select * from Employees;

--Finds any values that start with "a"
select ID, FirstName from Employees
where FirstName like 'a%';


--Finds any values that end with "a"
select ID, FirstName from Employees
where FirstName like '%a';

--Finds any values that have "tell" in any position
select ID, FirstName from Employees
where FirstName like '%tell%';

--	Finds any values that start with "a" and ends with "a"
select ID, FirstName from Employees
where FirstName like 'a%a';

--Finds any values that have "a" in the second position
select ID, FirstName from Employees
where FirstName like '_a%';

--Finds any values that have "a" in the third position
select ID, FirstName from Employees
where FirstName like '__a%';

--Finds any values that start with "a" and are at least 3 characters in length
select ID, FirstName from Employees
where FirstName like 'a__%';

--Finds any values that start with "a" and are at least 4 characters in length
select ID, FirstName from Employees
where FirstName like 'a___%';

--Finds any values that start with "a"
select ID, FirstName from Employees
where FirstName like 'a%' or FirstName like 'b%' ;

--===================================
--     SQL Wildcard Characters :
--===================================
select ID, FirstName, LastName from Employees
Where firstName = 'Mohammed' or FirstName ='Mohammad'; 

-- will search form Mohammed or Mohammad
select ID, FirstName, LastName from Employees
Where firstName like 'Mohamm[ae]d';

--You can use Not 
select ID, FirstName, LastName from Employees
Where firstName Not like 'Mohamm[ae]d';
