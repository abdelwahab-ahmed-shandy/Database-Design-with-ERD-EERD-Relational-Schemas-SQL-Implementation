-- Created By Abdelwahab Shandy
-- Prescription System for Barwon Health
--=========================================================================================
--=========================================================================================
--=========================================================================================
-- Enter only 100 for the trial :
--=========================================================================================

--Enter data into the Persons table :
DECLARE @Counter INT = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO Persons (FirstName, MidName, LastName, Email, Gender, DateOfBirth, LanguagePreference, Nationality, Photo, MaritalStatus, DateCreated, Notes)
    VALUES (
        CONCAT('FirstName', @Counter), 
        CONCAT('MidName', @Counter), 
        CONCAT('LastName', @Counter), 
        CONCAT('user', @Counter, '@example.com'), 
        CASE WHEN @Counter % 2 = 0 THEN 'M' ELSE 'F' END, 
        DATEADD(YEAR, -(@Counter % 50 + 18), GETDATE()), 
        'English', 
        'Australian', 
        NULL, 
        CASE WHEN @Counter % 3 = 0 THEN 'Single' ELSE 'Married' END, 
        GETDATE(), 
        'Auto-generated'
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Phones table:
SET @Counter = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO Phones (PhoneNumber, PersonID)
    VALUES (
        CONCAT('0400', RIGHT('000' + CAST(@Counter AS NVARCHAR(4)), 4)), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Emergency Contacts table :
SET @Counter = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO EmergencyContacts (EmergencyPhone, EmergencyEmail, PersonID)
    VALUES (
        CONCAT('0411', RIGHT('000' + CAST(@Counter AS NVARCHAR(4)), 4)), 
        CONCAT('emergency', @Counter, '@example.com'), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Addresses table:
SET @Counter = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO Addresses (City, Street, ApartmentNumber, PersonID)
    VALUES (
        CONCAT('City', @Counter), 
        CONCAT('Street', @Counter), 
        @Counter, 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Patients table :
SET @Counter = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO Patients (MedicalHistory, Midicare, PersonID)
    VALUES (
        CONCAT('MedicalHistory', @Counter), 
        CONCAT('Medicare', @Counter), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Doctors table :
SET @Counter = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO Doctors (Specialization, YearOfExperience, LicenseNumber, PersonID)
    VALUES (
        CONCAT('Specialization', @Counter), 
        @Counter % 40, 
        CONCAT('License', @Counter), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;

-- Enter data into the Pharmaceutical Companies table :
SET @Counter = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO PharmaceuticalCompanies (CompanyName, Address, PhoneNumber)
    VALUES (
        CONCAT('PharmaCompany', @Counter), 
        CONCAT('Address', @Counter), 
        CONCAT('0299', RIGHT('000' + CAST(@Counter AS NVARCHAR(4)), 4))
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Drugs table :
SET @Counter = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO Drugs (TradeName, DrugStrength, CompanyID)
    VALUES (
        CONCAT('Drug', @Counter), 
        CAST((@Counter % 500) + 10 AS REAL), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;

-- Enter data into the Prescriptions table. :
SET @Counter = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO Prescriptions (Name, Note, Quantity, History, PrescriptionDate, DoctorID, PatientURNumber)
    VALUES (
        CONCAT('Prescription', @Counter), 
        CONCAT('Note', @Counter), 
        CONCAT(@Counter, ' tablets'), 
        CONCAT('History', @Counter), 
        GETDATE(), 
        @Counter, 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;

-- Enter data into the Prescription Drug table.
SET @Counter = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO PrescriptionDrug (Dosage, DosageDate, DrugsID, PrescriptionID)
    VALUES (
        CONCAT(@Counter, ' mg daily'), 
        GETDATE(), 
        @Counter, 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;

--=========================================================================================
--=========================================================================================
--=========================================================================================
-- Here I changed the numbers to make the rows up to 1000 rows.

--Enter data into the Persons table :
DECLARE @Counter INT = 100;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO Persons (FirstName, MidName, LastName, Email, Gender, DateOfBirth, LanguagePreference, Nationality, Photo, MaritalStatus, DateCreated, Notes)
    VALUES (
        CONCAT('FirstName', @Counter), 
        CONCAT('MidName', @Counter), 
        CONCAT('LastName', @Counter), 
        CONCAT('user', @Counter, '@example.com'), 
        CASE WHEN @Counter % 2 = 0 THEN 'M' ELSE 'F' END, 
        DATEADD(YEAR, -(@Counter % 50 + 18), GETDATE()), 
        'English', 
        'Australian', 
        NULL, 
        CASE WHEN @Counter % 3 = 0 THEN 'Single' ELSE 'Married' END, 
        GETDATE(), 
        'Auto-generated'
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Phones table:
SET @Counter = 100;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO Phones (PhoneNumber, PersonID)
    VALUES (
        CONCAT('0400', RIGHT('000' + CAST(@Counter AS NVARCHAR(4)), 4)), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Emergency Contacts table :
SET @Counter = 100;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO EmergencyContacts (EmergencyPhone, EmergencyEmail, PersonID)
    VALUES (
        CONCAT('0411', RIGHT('000' + CAST(@Counter AS NVARCHAR(4)), 4)), 
        CONCAT('emergency', @Counter, '@example.com'), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Addresses table:
SET @Counter = 100;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO Addresses (City, Street, ApartmentNumber, PersonID)
    VALUES (
        CONCAT('City', @Counter), 
        CONCAT('Street', @Counter), 
        @Counter, 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Patients table :
SET @Counter = 100;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO Patients (MedicalHistory, Midicare, PersonID)
    VALUES (
        CONCAT('MedicalHistory', @Counter), 
        CONCAT('Medicare', @Counter), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Doctors table :
SET @Counter = 100;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO Doctors (Specialization, YearOfExperience, LicenseNumber, PersonID)
    VALUES (
        CONCAT('Specialization', @Counter), 
        @Counter % 40, 
        CONCAT('License', @Counter), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;

-- Enter data into the Pharmaceutical Companies table :
SET @Counter = 100;

WHILE @Counter <= 10000
BEGIN
    INSERT INTO PharmaceuticalCompanies (CompanyName, Address, PhoneNumber)
    VALUES (
        CONCAT('PharmaCompany', @Counter), 
        CONCAT('Address', @Counter), 
        CONCAT('0299', RIGHT('000' + CAST(@Counter AS NVARCHAR(4)), 4))
    );

    SET @Counter = @Counter + 1;
END;


-- Enter data into the Drugs table :
SET @Counter = 100;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO Drugs (TradeName, DrugStrength, CompanyID)
    VALUES (
        CONCAT('Drug', @Counter), 
        CAST((@Counter % 500) + 10 AS REAL), 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;

-- Enter data into the Prescriptions table. :
SET @Counter = 100;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO Prescriptions (Name, Note, Quantity, History, PrescriptionDate, DoctorID, PatientURNumber)
    VALUES (
        CONCAT('Prescription', @Counter), 
        CONCAT('Note', @Counter), 
        CONCAT(@Counter, ' tablets'), 
        CONCAT('History', @Counter), 
        GETDATE(), 
        @Counter, 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;

-- Enter data into the Prescription Drug table.
SET @Counter = 100;

WHILE @Counter <= 1000
BEGIN
    INSERT INTO PrescriptionDrug (Dosage, DosageDate, DrugsID, PrescriptionID)
    VALUES (
        CONCAT(@Counter, ' mg daily'), 
        GETDATE(), 
        @Counter, 
        @Counter
    );

    SET @Counter = @Counter + 1;
END;

