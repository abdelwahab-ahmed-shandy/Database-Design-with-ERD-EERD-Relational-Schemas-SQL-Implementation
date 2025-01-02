--You can find the databases I work on here under the name : EmployeesDB
--You can download it from here : https://drive.google.com/drive/u/0/folders/1sSap4wyzDt6raKqxWlcSopo5LNfTTOeE

-- ================================================
-- Section 1: Restore this simple database first,
-- it contains only one table that represents employees and their managers in the same table.
-- ================================================

Restore DataBase EmployeesDB
From Disk = 'E:\1- DB\Back up DB\EmployeesDB.bak';

Use EmployeesDB;
Use EmployeesDB EXEC sp_changedbowner 'sa' ;

-- ================================================
-- Section 2: Get all employees that have manager along with Manager's name.
-- ================================================
-- Get all employees that have manager along with Manager's name.
-- this will select all data from employees that are managed by someone along with their manager name, 
-- employees that have no manager will not be selected because we used inner join 
-- Note we used inner join on the same table with diffrent alliace.

SELECT        
	Employees.Name,
	Employees.ManagerID,
	Employees.Salary,
	Managers.Name AS ManagerName
FROM 
	Employees
INNER JOIN
    Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID

-- ================================================
-- Section 3: Get all employees that have manager or does not have manager along with Manager's name,
-- incase no manager name show nullGet all employees that have manager or does not have manager along with Manager's name,
-- incase no manager name show null
-- ================================================
-- Get all employees that have manager or does not have manager along with Manager's name, incase no manager name show null
-- this will select all data from employees regardless if they have manager or not, note here we used left outer join 

SELECT        
	Employees.Name,
	Employees.ManagerID,
	Employees.Salary,
	Managers.Name AS ManagerName
FROM
	Employees 
Left JOIN
    Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID;

-- ================================================
-- Section 5: Get all employees that have manager or does not have manager along with Manager's name,
-- incase no manager name the same employee name as manager to himself
-- ================================================
-- Get all employees that have manager or does not have manager along with Manager's name, incase no manager name the same employee name as manager to himself
-- this will select all data from employees regardless if they have manager or not, note here we used left outer join 
SELECT        
	Employees.Name,
	Employees.ManagerID,
	Employees.Salary,  
  CASE
    WHEN Managers.Name is Null  THEN Employees.Name
    ELSE Managers.Name
	END AS ManagerName
FROM            
	Employees 
Left JOIN
    Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID;

-- ================================================
-- Get All Employees managed by 'Mohammed'
-- ================================================
Select 
	Employees.Name,
	Employees.ManagerID,
	Employees.Salary,
	Managers.Name As ManagerName 
From 
	Employees
Inner Join 
	Employees AS Managers On Employees.ManagerID = Managers.EmployeeID
Where 
	Managers.Name = 'Mohammed';
