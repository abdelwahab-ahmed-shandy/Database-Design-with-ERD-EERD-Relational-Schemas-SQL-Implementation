--You can find the databases I work on here under the name : VehicleMakesDB
--You can download it from here : https://drive.google.com/drive/u/0/folders/1sSap4wyzDt6raKqxWlcSopo5LNfTTOeE
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

-- ================================================
-- Section 28: Get all vehicles that their body is 'Sport Utility' and Year > 2020
-- ================================================
Select 
	Bodies.BodyName ,
	VehicleDetails.*
From 
	VehicleDetails
Inner Join 
	Bodies ON  VehicleDetails.BodyID = Bodies.BodyID
Where 
	Bodies.BodyName = 'Sport Utility' And VehicleDetails.Year > 2020;

-- ================================================
-- Section 29: Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'
-- ================================================
Select 
	Bodies.BodyName ,
	VehicleDetails.*
From 
	VehicleDetails
Inner Join 
	Bodies ON  VehicleDetails.BodyID = Bodies.BodyID
Where 
	Bodies.BodyName IN ('Coupe','Hatchback','Sedan');
--==========
Select 
	Bodies.BodyName ,
	VehicleDetails.*
From 
	VehicleDetails
Inner Join 
	Bodies ON  VehicleDetails.BodyID = Bodies.BodyID
Where 
	Bodies.BodyName = 'Coupe' OR Bodies.BodyName = 'Hatchback' OR  Bodies.BodyName = 'Sedan';

-- ================================================
-- Section 30: Get all vehicles that their body is 'Coupe' or 'Hatchback' or 'Sedan' and manufactured in year 2008 or 2020 or 2021
-- ================================================
Select 
	Bodies.BodyName ,
	VehicleDetails.*
From 
	VehicleDetails
Inner Join 
	Bodies ON  VehicleDetails.BodyID = Bodies.BodyID
Where 
	Bodies.BodyName IN ('Coupe','Hatchback','Sedan')
	AND
	VehicleDetails.Year IN (2008,2020,2021);

-- ================================================
-- Section 31: Return found=1 if there is any vehicle made in year 1950
-- ================================================
Select Found = 1
Where 
Exists
(
	Select Top 1 * From VehicleDetails Where VehicleDetails.Year = 1950	
);

-- ================================================
-- Section 32: Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words, and if door is null display 'Not Set'
-- ================================================
Select
	Vehicle_Display_Name ,
	NumDoors,
	DoorDescribe = 
	Case 
		When NumDoors = 0 Then 'Zero Doors'
		When NumDoors = 1 Then 'One Doors'
		When NumDoors = 2 Then 'Two Doors'
		When NumDoors = 3 Then 'Three Doors'
		When NumDoors = 4 Then 'Four Doors'
		When NumDoors = 5 Then 'Five Doors'
		When NumDoors = 6 Then 'Six Doors'
		When NumDoors = 8 Then 'Eight Doors'
		When NumDoors IS NULL Then 'NOT SET'
		Else 'UNKNOWN' 
	End
From
	VehicleDetails;

-- ================================================
-- Section 33: Get all Vehicle_Display_Name, year and add extra column to calcuate the age of the car then sort the results by age desc.
-- ================================================
Select 
	Vehicle_Display_Name,
	Year ,
	Age = YEAR(GETDATE()) - VehicleDetails.Year
From 
	VehicleDetails
Order By 
	Age Desc;
-- ================================================
-- Section 34: Get all Vehicle_Display_Name, year, Age for vehicles that their age between 15 and 25 years old 
-- ================================================
Select 
	Vehicle_Display_Name,
	Year ,
	Age = YEAR(GETDATE()) - VehicleDetails.Year
From 
	VehicleDetails
Where
	YEAR(GETDATE()) - VehicleDetails.Year Between 15 And 25;
--===========
Select * From
( 
	Select 
		VehicleDetails.Vehicle_Display_Name,
		Year,
		Age = YEAR(GetDate()) - VehicleDetails.year
	From 
		VehicleDetails
) vAge

Where Age Between 15 And 25;

-- ================================================
-- Section 35: Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles
-- ================================================
Select 
	MaximumEngineCC = Max(VehicleDetails.Engine_CC),
	MinimumEngineCC = Min(VehicleDetails.Engine_CC),
	AverageEngineCC = Avg(VehicleDetails.Engine_CC)
From 
	VehicleDetails;
--===================
Select 
	 Max(VehicleDetails.Engine_CC) AS MaximumEngineCC,
	 Min(VehicleDetails.Engine_CC) AS MinimumEngineCC,
	 Avg(VehicleDetails.Engine_CC) AS AverageEngineCC
From 
	VehicleDetails;

-- ================================================
-- Section 36: Get all vehicles that have the minimum Engine_CC
-- ================================================
Select * 
From
	VehicleDetails
Where 
	(select Min(Engine_CC) AS MinimumEngineCC From VehicleDetails) = Engine_CC;

-- ================================================
-- Section 37: Get all vehicles that have the Maximum Engine_CC
-- ================================================
Select * 
From 
	VehicleDetails
Where 
	Engine_CC = ( select  Max(Engine_CC) AS MinEngineCC  From VehicleDetails );

-- ================================================
-- Section 38: Get all vehicles that have Engin_CC below average
-- ================================================
Select * 
From 
	VehicleDetails
Where 
	Engine_CC < ( select  Avg(Engine_CC) AS AverageEngineCC  From VehicleDetails );

-- ================================================
-- Section 39: Get total vehicles that have Engin_CC above average
-- ================================================
Select COUNT(*) AS NumberOfVehiclesAverageEngineCC From
(
Select * 
From 
	VehicleDetails
Where 
	Engine_CC > ( select  Avg(Engine_CC) AS AverageEngineCC  From VehicleDetails )
)VnumberOfAverageEngineCC

-- ================================================
-- Section 40: Get all unique Engin_CC and sort them Desc
-- ================================================
Select Distinct 
	Engine_CC
From 
	VehicleDetails
Order By 
	Engine_CC Desc;

-- ================================================
-- Section 41: Get the maximum 3 Engine CC
-- ================================================
Select Distinct Top 3
	VehicleDetails.Vehicle_Display_Name,
	 VehicleDetails.Engine_CC
From 
	VehicleDetails
Order By 
	Engine_CC Desc;

-- ================================================
-- Section 41: Get all vehicles that has one of the Max 3 Engine CC
-- ================================================
SELECT 
    Vehicle_Display_Name
FROM 
    VehicleDetails
WHERE 
    Engine_CC IN 
	(
        SELECT DISTINCT TOP 3 Engine_CC 
        FROM VehicleDetails
        ORDER BY Engine_CC DESC
    );

-- ================================================
-- Section 42: Get all Makes that manufactures one of the Max 3 Engine CC
-- ================================================
Select Distinct 
	Makes.Make
From
	VehicleDetails
Inner Join 
	Makes On VehicleDetails.MakeID = Makes.MakeID
Where 
	(VehicleDetails.Engine_CC 
		In 
		(
		Select Distinct Top 3 Engine_CC
		From VehicleDetails
		Order By Engine_CC DESC	
		))
Order By 
	Make ;		
	
-- ================================================
-- Section 43: Get a table of unique Engine_CC and calculate tax per Engine CC
-- ================================================
-- 0 to 1000    Tax = 100
-- 1001 to 2000 Tax = 200
-- 2001 to 4000 Tax = 300
-- 4001 to 6000 Tax = 400
-- 6001 to 8000 Tax = 500
-- Above 8000   Tax = 600
-- Otherwise    Tax = 0

Select 
	Engine_CC, 
	CASE
		When Engine_CC Between 0 And 1000 Then 100
		When Engine_CC Between 1001 And 2000 Then 200
		When Engine_CC Between 2001 And 4000 Then 300
		When Engine_CC Between 4001 And 6000 Then 400
		When Engine_CC Between 6001 And 8000 Then 500
		When Engine_CC > 8000 Then 600
		Else 0
	END AS Tax
From 
(
	Select Distinct Engine_CC From VehicleDetails
)Vtax
Order By
	Engine_CC;

-- ================================================
-- Section 44: Get Make and Total Number Of Doors Manufactured Per Make
-- ================================================
Select 
	Makes.Make,
	TotalNumDoors = Sum(VehicleDetails.NumDoors)
From
	VehicleDetails
Inner Join 
	Makes On VehicleDetails.MakeID = Makes.MakeID
Group By
	Make
Order By 
	TotalNumDoors Desc;

-- ================================================
-- Section 45: Get Total Number Of Doors Manufactured by 'Ford'
-- ================================================
Select 
	Makes.Make,
	TotalNumDoors = Sum(VehicleDetails.NumDoors)
From
	VehicleDetails
Inner Join 
	Makes On VehicleDetails.MakeID = Makes.MakeID
Group By
	Make
Having
	Make = 'Ford';

-- ================================================
-- Section 46: Get Number of Models Per Make
-- ================================================
SELECT       
	Makes.Make, 
	NumberOfModels = COUNT(*)
FROM            
	Makes 
INNER JOIN
    MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY 
	Makes.Make
Order By 
	NumberOfModels Desc;


-- ================================================
-- Section 47: Get the highest 3 manufacturers that make the highest number of models
-- ================================================
 SELECT Top 3    
	Makes.Make, 
	NumberOfModels = COUNT(*)
FROM            
	Makes 
INNER JOIN
    MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY 
	Makes.Make
Order By 
	NumberOfModels Desc;

-- ================================================
-- Section 48: Get the highest number of models manufactured
-- ================================================
Select MAX(NumberOfModels) AS MaxNumOfModel
From (
SELECT    
	Makes.Make, 
	NumberOfModels = COUNT(*)
FROM            
	Makes 
INNER JOIN
    MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY 
	Makes.Make
	)VMaxNumOfModel

-- ================================================
-- Section 49: Get the highest Manufacturers manufactured the highest number of models , 
--remember that they could be more than one manufacturer have the same high number of models
-- ================================================
SELECT        
	Makes.Make,
	NumberOfModels = COUNT(*)
FROM            
	Makes 
INNER JOIN
	MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY
	Makes.Make
Having 
	COUNT(*) = (select Max(NumberOfModels) as MaxNumberOfModels
				from
					(
						SELECT   
							MakeID,
							NumberOfModels = COUNT(*)
						FROM       
							MakeModels
						GROUP BY 
							MakeID							
					) R1
				)

-- ================================================
-- Section 50: Get the Lowest Manufacturers manufactured the lowest number of models ,
-- remember that they could be more than one manufacturer have the same lowest number of models
-- ================================================
SELECT        
	Makes.Make,
	NumberOfModels = COUNT(*)
FROM            
	Makes 
INNER JOIN
	MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY
	Makes.Make
Having 
	COUNT(*) = (select Min(NumberOfModels) as MaxNumberOfModels
				from
					(
						SELECT   
							MakeID,
							NumberOfModels = COUNT(*)
						FROM       
							MakeModels
						GROUP BY 
							MakeID							
					) R1
				)

-- ================================================
-- Section 51: Get all Fuel Types , each time the result should be showed in random order
-- ================================================
Select *
From
	FuelTypes
Order By 
	NEWID();


