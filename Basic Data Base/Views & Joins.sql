--Created By Abdelwahab Shandy
--Don't Forget To Pray For Me And My Parents
--Views & Joins

-- Views
--Views are not Tables, always remember that they are stored queries and are executed only when called.
---------------------------------------
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
---------------------------------------

Create View ActiveEmployees As
Select * From Employees
Where ExitDate IS  Null ;

Select * From ActiveEmployees;
----------------------------------------

Create View ResignedEmployees As
Select * From Employees
Where ExitDate IS not Null ;

Select * From ResignedEmployees;
-----------------------------------------

Create View ShortDetiledEmployees AS
Select ID , FirstName , LastName , Gendor  From Employees ;

Select * From ShortDetiledEmployees;

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
--Joins
--------------
--Inner Join
--------------
SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM Customers 
INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID

--------------
--Left Join
--------------
SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM Customers 
LEFT OUTER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID

--------------
--Right Join
--------------
SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM Customers 
RIGHT OUTER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID

--------------
--Full Join
--------------
SELECT Customers.CustomerID, Customers.Name, Orders.Amount
FROM Customers 
FULL OUTER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID

