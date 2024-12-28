--Created By Abdelwahab Shandy
--If you benefit from something, do not forget to pray for me and my parents.
--Error 
--===========================
From  =>> Where  =>> Select  =>> Order By =>> OFFSET =>> FETCH NEXT 10 Rows Only


--===========================
--Cannot execute as the database principal because the principal "dbo" does not exist, this type of principal cannot be impersonated,or you do not have permission. (Framework Microsoft SqlClient Data Provider) 

use [YourDatabaseName] EXEC sp_changedbowner 'sa' 

--===========================
