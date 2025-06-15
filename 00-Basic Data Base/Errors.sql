--Errors 
--===========================
From  =>> Where  =>> Select  =>> Order By =>> OFFSET =>> FETCH NEXT 10 Rows Only


--===========================
--Cannot execute as the database principal because the principal "dbo" does not exist, this type of principal cannot be impersonated,or you do not have permission. (Framework Microsoft SqlClient Data Provider) 

use [YourDatabaseName] EXEC sp_changedbowner 'sa' 

--===========================
-----------------------------------------------------------
--Created By Abdelwahab Shandy
--Don't Forget To Pray For Me And My Parents