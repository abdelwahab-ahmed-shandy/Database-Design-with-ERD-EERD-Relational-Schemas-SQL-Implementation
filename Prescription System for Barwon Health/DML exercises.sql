-- DML exercises
--============================================================================================================
-- 1.	SELECT: Retrieve all columns from the Doctor table.
--============================================================================================================
Select * From Doctors;

-- OR

Select 
	Persons.FirstName,
	Doctors.*
From
	Doctors
Inner Join 
	Persons On Doctors.DoctorID = Persons.PersonID ;
--============================================================================================================
-- 2.	ORDER BY: List patients in the Patient table in ascending order of their ages.

Select 
	Patients.*,
	Persons.DateOfBirth
From 
	Patients
Inner Join 
	Persons ON Patients.PatientURNumber = Persons.PersonID
Order By 
	Persons.DateOfBirth ;

--OR

Select 
	Patients.*,
	Persons.DateOfBirth ,
	Datediff(Year, Persons.DateOfBirth ,GetDate()) AS Age
From 
	Patients
Inner Join 
	Persons ON Patients.PatientURNumber = Persons.PersonID
Order By 
	Persons.DateOfBirth ;
--============================================================================================================
-- 3.	OFFSET FETCH: Retrieve the first 10 patients from the Patient table, starting from the 5th record.

Select * 

From
	Patients
Order By 
	Patients.PatientURNumber
Offset 5 Rows
Fetch Next 10 Rows Only ;

--============================================================================================================
-- 4.	SELECT TOP: Retrieve the top 5 doctors from the Doctor table.
Select top 5 
	Doctors.DoctorID,
	Doctors.YearOfExperience
From 
	Doctors
Order by 
	Doctors.YearOfExperience Desc;	

--============================================================================================================
-- 5.	SELECT DISTINCT: Get a list of unique address from the Patient table.
Select Distinct
	Patients.*,
	Addresses.ApartmentNumber,
	Addresses.City,
	Addresses.Street
From 
	Addresses
inner join 
	Patients On Addresses.AddressID = Patients.PersonID

--============================================================================================================
-- 6.	WHERE: Retrieve patients from the Patient table who are aged 25.
Select * ,
		Datediff(Year, Persons.DateOfBirth ,GetDate()) AS Age
From 
	Patients 
inner join 
	Persons On Persons.PersonID = Patients.PersonID
Where 
	Datediff(Year, Persons.DateOfBirth ,GetDate()) = 25;

--============================================================================================================
-- 7.	NULL: Retrieve patients from the Patient table whose email is not provided.
Select * 
From 
	Patients 
inner join 
	Persons On Persons.PersonID = Patients.PersonID
Where 
	Persons.Email is Null;

--============================================================================================================
-- 8.	AND: Retrieve doctors from the Doctor table who have experience greater than 5 years and specialize in 'Cardiology'.
Select Doctors.*, Persons.FirstName, Persons.LastName From Doctors
inner join Persons ON Persons.PersonID = Doctors.DoctorID 
Where Doctors.YearOfExperience > 5 And Doctors.Specialization = 'Cardiology';

--============================================================================================================
-- 9.	IN: Retrieve doctors from the Doctor table whose speciality is either 'Dermatology' or 'Oncology'.
Select Doctors.*, Persons.FirstName, Persons.LastName From Doctors
inner join Persons ON Persons.PersonID = Doctors.DoctorID 
Where Doctors.Specialization  IN ('Dermatology','Oncology');

--============================================================================================================
-- 10.	BETWEEN: Retrieve patients from the Patient table whose ages are between 18 and 30.
Select 
	Patients.*,
	Persons.FirstName, 
	Persons.LastName ,
	Persons.DateOfBirth,
	DateDiff(Year,Persons.DateOfBirth,GetDate()) AS Age 
From Patients
inner join Persons ON Persons.PersonID = Patients.PersonID 
Where DateDiff(Year,Persons.DateOfBirth,GetDate()) Between 18 And 30 ;

--============================================================================================================
-- 11.	LIKE: Retrieve doctors from the Doctor table whose names start with 'Dr.'.
Select Doctors.*,FullName=Persons.FirstName +' '+Persons.LastName From Doctors
inner join Persons On Persons.PersonID = Doctors.DoctorID
Where Persons.FirstName +' '+Persons.LastName Like 'Dr.%';

--============================================================================================================
--12.	Column & Table Aliases: Select the name and email of doctors, aliasing them as 'DoctorName' and 'DoctorEmail'.
Select 
	Doctors.*,
	DoctorName = Persons.FirstName +' '+Persons.LastName ,
	Persons.Email AS DoctorEmail	
From Doctors
inner join Persons On Persons.PersonID = Doctors.DoctorID;

--============================================================================================================
-- 13.	Joins: Retrieve all prescriptions with corresponding patient names.
Select 
	PrescriptionDrug.*,
	Patients.PersonID ,
	Persons.FirstName +' '+Persons.MidName +' '+Persons.LastName As FullName
From PrescriptionDrug
Inner Join Patients ON PrescriptionDrug.PrescriptionDrugID = Patients.PersonID
Inner Join Persons ON Persons.PersonID = Patients.PersonID;

--============================================================================================================
-- 14.	GROUP BY: Retrieve the count of patients grouped by their cities.
Select Addresses.City , Count(*) AS PatientsTotal From Persons
inner join Patients On Persons.PersonID = Patients.PersonID
inner join Addresses On Addresses.AddressID = Patients.PersonID
Group By Addresses.City;

--============================================================================================================
-- 15.	HAVING: Retrieve cities with more than 3 patients.
Select 
	Addresses.City,
	Count(*) AS PatientsTotal,
	DateDiff(Year,Persons.DateOfBirth,GetDate()) AS Age  
From Persons
inner join Patients On Persons.PersonID = Patients.PersonID
inner join Addresses On Addresses.AddressID = Patients.PersonID
Group By GROUPING Sets 
(
(Addresses.City),
(Persons.DateOfBirth)
);

-- OR 
Select 
	Addresses.City,
	Count(*) AS PatientsTotal,
	DateDiff(Year,Persons.DateOfBirth,GetDate()) AS Age  
From Persons
inner join Patients On Persons.PersonID = Patients.PersonID
inner join Addresses On Addresses.AddressID = Patients.PersonID
Group By GROUPING Sets 
(
Addresses.City,
Persons.DateOfBirth
)
Having Count (*) > 3;

--============================================================================================================
-- 17.	CUBE: Retrieve counts of patients considering all possible combinations of city and age.
Select 
	Addresses.City,
	DateDiff(Year,Persons.DateOfBirth,GetDate()) AS Age,  
	Count(*) AS PatientsTotal
From Persons
inner join Patients On Persons.PersonID = Patients.PersonID
inner join Addresses On Addresses.AddressID = Patients.PersonID
Group By Cube (
Addresses.City,
 DATEDIFF(YEAR, Persons.DateOfBirth, GETDATE())
);

--============================================================================================================
-- 18.	ROLLUP: Retrieve counts of patients rolled up by city.
Select 
	Addresses.City,
	Count(*) AS PatientsTotal
From Persons
inner join Patients On Persons.PersonID = Patients.PersonID
inner join Addresses On Addresses.AddressID = Patients.PersonID
Group By Rollup(Addresses.City);

--============================================================================================================
-- 19.	EXISTS: Retrieve patients who have at least one prescription.
Select Persons.FirstName, Persons.LastName , Patients.PersonID From Persons
inner join Patients ON Persons.PersonID = Patients.PersonID
Where Exists
(Select 1
From PrescriptionDrug 
Where Patients.PersonID = PrescriptionDrug.PrescriptionDrugID
);

--============================================================================================================
-- 20.	UNION: Retrieve a combined list of doctors and patients.
-- 
Select  Doctors.DoctorID , 'Doctor' AS Role From Doctors
union
Select Patients.PatientURNumber , 'Patient' AS Role From Patients;

--============================================================================================================
-- 21.	Common Table Expression (CTE): Retrieve patients along with their doctors using a CTE.
With DoctorsPatients AS (
Select Doctors.Specialization AS DoctorSpecial ,Patients.MedicalHistory AS PatientHistory From Doctors
inner join Patients On Doctors.DoctorID = Patients.PatientURNumber
)
Select DoctorSpecial , PatientHistory
From DoctorsPatients;

--============================================================================================================
-- 22.	INSERT: Insert a new doctor into the Doctor table.
INSERT INTO Persons (FirstName,  LastName, Email, Gender, DateOfBirth, LanguagePreference, Nationality, MaritalStatus, DateCreated)
VALUES ('Mohmed', 'Ahmed', 'john.doe@example.com', 'M', '1985-10-15', 'A', 'Egypt','Single', GETDATE());

INSERT INTO Doctors (Specialization, YearOfExperience, LicenseNumber, PersonID)
VALUES 
('Cardiology', 10, 'LMohmed', (SELECT PersonID FROM Persons WHERE Email = 'john.doe@example.com'));

--============================================================================================================
-- 23.	INSERT Multiple Rows: Insert multiple patients into the Patient table.
INSERT INTO Patients (MedicalHistory, Midicare, PersonID)
VALUES
('No significant medical history', 'Medicare123', 1),
('Hypertension', 'Medicare456', 2),
('Diabetes', 'Medicare789', 3),
('Asthma', 'Medicare101', 4);

--============================================================================================================
-- 24.	UPDATE: Update the phone number of a doctor.
UPDATE Phones
SET PhoneNumber = '123-456-7890' 
WHERE PersonID = (SELECT PersonID FROM Doctors WHERE DoctorID = 5);

--============================================================================================================
-- 25.	UPDATE JOIN: Update the city of patients who have a prescription from a specific doctor.
UPDATE Addresses
SET City = 'New City Name'
FROM Addresses
INNER JOIN Persons ON Addresses.PersonID = Persons.PersonID
INNER JOIN Patients ON Persons.PersonID = Patients.PersonID
INNER JOIN Prescriptions ON Patients.PatientURNumber = Prescriptions.PatientURNumber
INNER JOIN Doctors ON Prescriptions.DoctorID = Doctors.DoctorID
WHERE Doctors.DoctorID = 1; 

--============================================================================================================
-- 26.	DELETE: Delete a patient from the Patient table.
DELETE FROM Patients
WHERE PatientURNumber = 1;

--============================================================================================================
-- 28.	View: Create a view that combines patient and doctor information for easy access.
CREATE VIEW PatientDoctorInfo AS
SELECT 
    PatientPersons.FirstName AS PatientFirstName,
    PatientPersons.LastName AS PatientLastName,
    PatientPersons.Email AS PatientEmail,
    PatientPersons.Gender AS PatientGender,
    PatientPersons.DateOfBirth AS PatientDOB,
    Patients.MedicalHistory,
    Patients.Midicare AS PatientMedicare,
    DoctorPersons.FirstName AS DoctorFirstName,
    DoctorPersons.LastName AS DoctorLastName,
    DoctorPersons.Email AS DoctorEmail,
    DoctorPersons.Gender AS DoctorGender,
    DoctorPersons.DateOfBirth AS DoctorDOB,
    Doctors.Specialization,
    Doctors.YearOfExperience,
    Doctors.LicenseNumber
FROM Patients
JOIN Persons PatientPersons ON Patients.PersonID = PatientPersons.PersonID
JOIN Prescriptions Prescriptions ON Patients.PatientURNumber = Prescriptions.PatientURNumber
JOIN Doctors Doctors ON Prescriptions.DoctorID = Doctors.DoctorID
JOIN Persons DoctorPersons ON Doctors.PersonID = DoctorPersons.PersonID;

SELECT * FROM PatientDoctorInfo;
--============================================================================================================
-- 29.	Index: Create an index on the 'phone' column of the Patient table to improve search performance.
ALTER TABLE Patients
ADD Phone nvarchar(15) NULL;

-- Clustered Already available in PatientURNumber
CREATE  Nonclustered Index IDX_Patients_Phone
ON Patients(Phone);

--============================================================================================================
-- 30.	Backup: Perform a backup of the entire database to ensure data safety.

BACKUP DATABASE PrescriptionSystemDB
TO DISK = 'E:\1- DB\Back up DB\PrescriptionSystemDB.bak'
