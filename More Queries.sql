--Created By Abdelwahab Shandy
--Don't Forget To Pray For Me And My Parents
--More Queries
  
--	EXISTS 
-----------
--Syntax: 
SELECT column_name(s)
FROM table_name
WHERE EXISTS
(SELECT column_name FROM table_name WHERE condition);

-------------------

select X='yes'
where  exists 
   ( 
	select * from Orders
	where customerID= 3 and Amount < 600
	)


select * from Customers T1
where 
  exists 
   ( 
	select * from Orders
	where customerID= T1.CustomerID and Amount < 600
	)

--More optimized and faster
select * from Customers T1
where 
  exists 
   ( 
	select top 1 * from Orders
	where customerID= T1.CustomerID and Amount < 600
	)


--More optimized and faster
select * from Customers T1
where 
  exists 
   ( 
	select top 1 R='Y'  from Orders
	where customerID= T1.CustomerID and Amount < 600
	)


------------------
--	Union 
------------------

select * from ActiveEmployees

select * from ResignedEmployees


select * from ActiveEmployees
Union
select * from ResignedEmployees

--this will remove the redundancy from the resultset (distinct results only)
select * from Departments
union 
select * from Departments;

--this will append data regardeless of any redundancy
select * from Departments
union ALL
select * from Departments;


------------------
-	Case
------------------
Select ID ,FirstName , LastName ,
GendorTitle =
Case 
	When Gendor ='M' Then 'Male'
	When Gendor ='F' Then 'Female'
	Else 'UNKNOWN'
End 
 
From Employees
--------------------------------------

Select ID ,FirstName , LastName ,
GendorTitle =
Case 
	When Gendor ='M' Then 'Male'
	When Gendor ='F' Then 'Female'
	Else 'UNKNOWN'
End ,
Status = Case 
	When ExitDate Is Null Then 'Active'
	When Gendor Is Not Null Then 'Resigned'
End
From Employees
--------------------------------------------------

select ID, FirstName, LastName,MonthlySalary,

NewSalaryToBe =
CASE
    WHEN Gendor='M' THEN MonthlySalary * 1.1
    WHEN Gendor='F' THEN MonthlySalary * 1.15
   
END
from Employees

--===========================================================================================
-- Common Table Expression
--===========================================================================================
-- Sub-phrase
Select * From Sales.Employees
Where Salary > (Select AVG(Salary) From Sales.Employees);

-- Variables
DECLARE @AvgSalary DECIMAL;
SELECT @AvgSalary = AVG(Salary) FROM Sales.Employees;
SELECT *
FROM Sales.Employees
WHERE Salary > @AvgSalary;

-- CTE
With AverageSalary   As(
	select AVG(Salary) AS AvgSalary From Sales.Employees
)
Select * From Sales.Employees 
Where Salary > (Select AvgSalary From AverageSalary );

--====================================
-- OFFSET FETCH
--====================================
SELECT columns
FROM table_name
ORDER BY column_name
OFFSET number_of_rows_to_skip ROWS
FETCH NEXT number_of_rows_to_return ROWS ONLY;

-- EX :
-- Retrieve the first 10 patients from the Patient table, starting from the 5th record.
Select * 

From
	Patients
Order By 
	Patients.PatientURNumber
Offset 5 Rows
Fetch Next 10 Rows Only ;
