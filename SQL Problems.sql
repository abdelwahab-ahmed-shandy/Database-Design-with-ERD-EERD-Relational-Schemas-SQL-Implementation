--You can find the databases I work on here under the name : VehicleMakesDB
--You can download it from here : https://drive.google.com/file/d/1tuGQe3WTkJhK8DeQ680ll602tVYP7ZLE/view?usp=sharing
--You can restore it to the format stored in the file
--Doing all this queries and looking at the results and solving the problems yourself.
--If you benefit from something, do not forget to pray for me and my parents.

--================================================
-- Section 1: Restore Database And Using
--================================================
Restore DataBase VehicleMakesDB
from disk = 'E:\1- DB\Back up DB\VehicleMakesDB.bak';
Go 
Use VehicleMakesDB;
Go
-- ================================================
-- Section 2: Set Database Owner
-- ================================================
--Error "New DataBase Diagrams":
----Cannot execute as the database principal because the principal "dbo" does not exist, this type of principal cannot be impersonated,or you do not have permission. (Framework Microsoft SqlClient Data Provider) 
use VehicleMakesDB EXEC sp_changedbowner 'sa' ;

-- ================================================
-- Section 3: Create the master view
-- ================================================
Select * From VehicleDetails;
Select * From VehicleMasterDetails;
-- first
CREATE VIEW VehicleMasterDetailsTask AS 
SELECT 
    VehicleDetails.ID, 
    VehicleDetails.MakeID, 
    Makes.Make, 
    VehicleDetails.ModelID, 
    MakeModels.ModelName, 
    VehicleDetails.SubModelID, 
    SubModels.SubModelName, 
    VehicleDetails.BodyID, 
    Bodies.BodyName, 
    VehicleDetails.Vehicle_Display_Name, 
    VehicleDetails.Year, 
    VehicleDetails.DriveTypeID, 
    DriveTypes.DriveTypeName, 
    VehicleDetails.Engine, 
    VehicleDetails.Engine_CC, 
    VehicleDetails.Engine_Cylinders, 
    VehicleDetails.Engine_Liter_Display, 
    VehicleDetails.FuelTypeID, 
    FuelTypes.FuelTypeName, 
    VehicleDetails.NumDoors
FROM 
    VehicleDetails
JOIN 
    Makes ON VehicleDetails.MakeID = Makes.MakeID
JOIN 
    MakeModels ON VehicleDetails.ModelID = MakeModels.ModelID
JOIN 
    SubModels ON VehicleDetails.SubModelID = SubModels.SubModelID
JOIN 
    Bodies ON VehicleDetails.BodyID = Bodies.BodyID
JOIN 
    DriveTypes ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
JOIN 
    FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID;

--second 
CREATE VIEW VehicleMasterDetailsTask2 AS
SELECT 
    ID, 
    MakeID, 
    MakeName = (SELECT TOP 1 Makes.Make FROM Makes WHERE VehicleDetails.MakeID = Makes.MakeID),
    ModelID, 
    ModelName = (SELECT TOP 1 ModelName FROM MakeModels WHERE VehicleDetails.ModelID = MakeModels.ModelID),
    SubModelID, 
    SubModelName = (SELECT TOP 1 SubModelName FROM SubModels WHERE VehicleDetails.SubModelID = SubModels.SubModelID),
    BodyID, 
    BodyName = (SELECT TOP 1 BodyName FROM Bodies WHERE VehicleDetails.BodyID = Bodies.BodyID),
    Vehicle_Display_Name, 
    VehicleDetails.Year, 
    DriveTypeID, 
    DriveTypeName = (SELECT TOP 1 DriveTypeName FROM DriveTypes WHERE VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID),
    Engine, 
    Engine_Cylinders, 
    Engine_Liter_Display, 
    FuelTypeID, 
    FuelTypeName = (SELECT TOP 1 FuelTypes.FuelTypeName FROM FuelTypes WHERE VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID),
    NumDoors
FROM 
    VehicleDetails;

---- Retrieve data from the First And second master view
Select * From VehicleMasterDetailsTask;
Select * From VehicleMasterDetailsTask2;

-- ================================================
-- Section 4: Get all vehicles made between 1950 and 2000
-- ================================================
Select * 
From VehicleDetails
Where Year Between 1950 And 2000
Order By Year ;

-- ================================================
-- Section 5: Get number vehicles made between 1950 and 2000
-- ================================================
Select NumberOfVehicle = Count(*)
From VehicleDetails
Where Year Between 1950 And 2000 ;

-- ================================================
-- Section 6:  Get number vehicles made between 1950 and 2000 per make and order them by Number Of Vehicles Descending
-- ================================================
SELECT 
    NumberOfVehicle = COUNT(VehicleDetails.MakeID),
    Makes.Make
FROM 
    VehicleDetails
JOIN 
    Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE 
    VehicleDetails.Year BETWEEN 1950 AND 2000
GROUP BY 
    Makes.Make
ORDER BY 
    NumberOfVehicle ;

-- ================================================
-- Section 7:  Get All Makes that have manufactured more than 12000 Vehicles in years 1950 to 2000
-- ================================================
SELECT 
    NumberOfVehicle = COUNT(VehicleDetails.MakeID),
    Makes.Make
FROM 
    VehicleDetails
JOIN 
    Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE 
    VehicleDetails.Year BETWEEN 1950 AND 2000 
GROUP BY 
    Makes.Make
Having
	Count(*) > 12000;
--============================
-- Without Having :
Select * From
(
SELECT 
    NumberOfVehicle = COUNT(VehicleDetails.MakeID),
    Makes.Make
FROM 
    VehicleDetails
JOIN 
    Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE 
    VehicleDetails.Year BETWEEN 1950 AND 2000 
GROUP BY 
    Makes.Make
)R1
Where  NumberOfVehicle > 12000 

--=================================
SELECT  distinct top 3  
COUNT(*) AS NumberOfVehicles,
Makes.Make
FROM
	VehicleDetails 
JOIN
    Makes ON VehicleDetails.MakeID = Makes.MakeID
where
	VehicleDetails.Year between 1950 and 2000 
GROUP BY 
	Makes.Make
ORDER BY 
	NumberOfVehicles DESC;

-- ================================================
-- Section 8: Get number of vehicles made between 1950 and 2000 per make and add total vehicles column beside
-- ================================================
SELECT 
	TotalVehicle = (Select COUNT(*) From VehicleDetails),
    NumberOfVehicle = COUNT(VehicleDetails.MakeID),
    Makes.Make
FROM 
    VehicleDetails
JOIN 
    Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE 
    VehicleDetails.Year BETWEEN 1950 AND 2000
GROUP BY 
    Makes.Make
ORDER BY 
    NumberOfVehicle desc;

-- ================================================
-- Section 9: Get number of vehicles made between 1950 and 2000 per make and add total vehicles column beside it, then calculate it's percentage
-- ================================================
SELECT 
	TotalVehicle = (Select COUNT(*) From VehicleDetails),
    NumberOfVehicle = COUNT(VehicleDetails.MakeID),
	Makes.Make,
	Perc = CAST(COUNT(VehicleDetails.MakeID) AS FLOAT) / CAST((SELECT COUNT(*) FROM VehicleDetails) AS FLOAT)
FROM 
    VehicleDetails
JOIN 
    Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE 
    VehicleDetails.Year BETWEEN 1950 AND 2000
GROUP BY 
    Makes.Make
ORDER BY 
    NumberOfVehicle desc;

--=====================================
Select * , Cast(NumberOfVehicle As float) / Cast(TotalVehicle As float) As Prec
From
(Select 
	TotalVehicle = (Select COUNT(*) From VehicleDetails),
    NumberOfVehicle = COUNT(VehicleDetails.MakeID),
	Makes.Make
From 
	VehicleDetails
Join 
	Makes ON VehicleDetails.MakeID = Makes.MakeID
Where 
	VehicleDetails.Year Between 1950 And 2000
Group By 
	Makes.Make
) R1
Order By NumberOfVehicle Desc;
	
-- ================================================
-- Section 10: Get Make, FuelTypeName and Number of Vehicles per FuelType per Make
-- ================================================
Select
	Makes.Make,
	FuelTypes.FuelTypeName,
	NoumberOfVehicle = COUNT(*)
From 
	VehicleDetails
Join 
	Makes ON VehicleDetails.MakeID = Makes.MakeID
Join
	FuelTypes ON  VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
Where 
	VehicleDetails.Year Between 1950 And 2000
Group By 
	Makes.Make,
	FuelTypes.FuelTypeName
Order By 
	Makes.Make;

-- ================================================
-- Section 11: Get all vehicles that runs with GAS
-- ================================================
Select 
	VehicleDetails.*, 
	FuelTypes.FuelTypeName 
From 
	VehicleDetails
Inner Join 
	FuelTypes On VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
Where 
	FuelTypes.FuelTypeName = N'Gas';

-- ================================================
-- Section 12: Get all Makes that runs with GAS
-- ================================================
Select Distinct
	Makes.Make,
	FuelTypes.FuelTypeName
From 
	VehicleDetails
Inner Join 
	FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
Inner Join 
	Makes ON VehicleDetails.MakeID = Makes.MakeID
Where 
	FuelTypes.FuelTypeName = N'Gas';

-- ================================================
-- Section 13: Get Total Makes that runs with GAS
-- ================================================
Select 
	TotalMakesRunOnGas = COUNT(DISTINCT Makes.MakeID)
From 
	VehicleDetails
Inner Join 
	FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
Inner Join 
	Makes ON VehicleDetails.MakeID = Makes.MakeID
Where 
	FuelTypes.FuelTypeName = N'Gas';
--===========
Select COUNT(*) AS TotalMakesRunOnGas
From(
Select Distinct
	Makes.Make,
	FuelTypes.FuelTypeName
From 
	VehicleDetails
Inner Join 
	FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
Inner Join 
	Makes ON VehicleDetails.MakeID = Makes.MakeID
Where 
	FuelTypes.FuelTypeName = N'Gas'
)VTotalMakesRunOnGas

-- ================================================
-- Section 14: Count Vehicles by make and order them by NumberOfVehicles from high to low.
-- ================================================
Select 
	Makes.Make,
	COUNT(*) AS NumberOfVehicles
From
	VehicleDetails
Inner Join Makes On VehicleDetails.MakeID = Makes.MakeID
Group By 
	Makes.Make
Order By
	NumberOfVehicles DESC;

-- ================================================
-- Section 15: Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles
-- ================================================
Select 
	Makes.Make,
	COUNT(*) AS NumberOfVehicles
From
	VehicleDetails
Inner Join Makes On VehicleDetails.MakeID = Makes.MakeID
Group By 
	Makes.Make
Having
	Count(*) > 20000
Order By
	NumberOfVehicles DESC;

-- ================================================
-- Section 16: Get all Makes with make starts with 'B'
-- ================================================
Select * 
From 
	Makes
Where 
	Makes.Make Like 'B%';

-- ================================================
-- Section 17: Get all Makes with make ends with 'W'
-- ================================================
Select * 
From 
	Makes
Where 
	Makes.Make Like '%W';

-- ================================================
-- Section 18: Get all Makes that manufactures DriveTypeName = FWD
-- ================================================
Select Distinct
	DriveTypes.DriveTypeName,
	Makes.Make
From 
	DriveTypes
Inner Join  
	VehicleDetails On DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID
Inner Join 
	Makes On VehicleDetails.MakeID = Makes.MakeID
Where
	DriveTypes.DriveTypeName = 'FWD';

-- ================================================
-- Section 19: Get total Makes that Mantufactures DriveTypeName=FWD
-- ================================================
Select Count(*) AS MakeFWM
From
(
Select Distinct
	DriveTypes.DriveTypeName,
	Makes.Make
From 
	DriveTypes
Inner Join  
	VehicleDetails On DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID
Inner Join 
	Makes On VehicleDetails.MakeID = Makes.MakeID
Where
	DriveTypes.DriveTypeName = 'FWD'
)Result


-- ================================================
-- Section 20: Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc
-- ================================================
SELECT distinct 
	Makes.Make,
	DriveTypes.DriveTypeName,
	Count(*) AS Total
FROM            
	DriveTypes 
INNER JOIN VehicleDetails 
	ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID 
INNER Join Makes 
	ON VehicleDetails.MakeID = Makes.MakeID
Group By 
	Makes.Make, DriveTypes.DriveTypeName
Order By 
	Make ASC, Total Desc;

-- ================================================
-- Section 21: Get total vehicles per DriveTypeName Per Make then filter only results with total > 10,000
-- ================================================
SELECT distinct 
	Makes.Make,
	DriveTypes.DriveTypeName,
	Count(*) AS Total
FROM            
	DriveTypes 
INNER JOIN VehicleDetails 
	ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID 
INNER Join Makes 
	ON VehicleDetails.MakeID = Makes.MakeID
Group By 
	Makes.Make, DriveTypes.DriveTypeName
Having 
	Count(*) > 10000
Order By 
	Make ASC, Total Desc;

-- ================================================
-- Section 22: Get all Vehicles that number of doors is not specified
-- ================================================
Select * 
From
	VehicleDetails
Where 
	VehicleDetails.NumDoors Is Null;

-- ================================================
-- Section 23: Get Total Vehicles that number of doors is not specified
-- ================================================
Select 
	TotalOfNoSpecifiedDoors = Count(*) 
From
	VehicleDetails
Where 
	VehicleDetails.NumDoors Is Null;

-- ================================================
-- Section 24: Get percentage of vehicles that has no doors specified
-- ================================================
Select 
	(
		CAST((Select Count(*) As TotalWithNoSpecifiedDoors From VehicleDetails
		Where 
			NumDoors is Null) As float)

		/
		
		CAST( (Select Count(*)as TotalVehicles from VehicleDetails ) as float)
	
	)* 100 PercentageOfNoDoorsSpecified

-- ================================================
-- Section 25: Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'
-- ================================================
Select Distinct
	VehicleDetails.MakeID,
	Makes.Make,
	SubModels.SubModelName
From 
	VehicleDetails
Inner Join 
	Makes On VehicleDetails.MakeID = Makes.MakeID
Inner Join 
	SubModels On VehicleDetails.SubModelID = SubModels.SubModelID
Where 
	SubModels.SubModelName = N'Elite';

-- ================================================
-- Section 26: Get all vehicles that have Engines > 3 Liters and have only 2 doors
-- ================================================
Select 
	*
From 
	VehicleDetails
Where 
	VehicleDetails.Engine_Liter_Display > 3 And NumDoors = 2

-- ================================================
-- Section 27: Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4
-- ================================================
Select 
	*
From 
	VehicleDetails
Where 
	VehicleDetails.Engine Like N'%OHV%' And VehicleDetails.Engine_Cylinders = 4;
--================

SELECT         
	Makes.Make,
	VehicleDetails.*
FROM            
	VehicleDetails
INNER JOIN
    Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE        
	(VehicleDetails.Engine LIKE '%OHV%') AND (VehicleDetails.Engine_Cylinders = 4);




