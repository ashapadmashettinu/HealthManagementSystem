
CREATE DATABASE HMS_Temp;

USE HMS_Temp;

-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'hms_team4';

-- Create certificate to protect symmetric key
CREATE CERTIFICATE HMSCertificate
WITH SUBJECT = 'HMS Test Certificate',
EXPIRY_DATE = '2026-10-31';

-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY HMSSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE HMSCertificate;

-- Open symmetric key
OPEN SYMMETRIC KEY HMSSymmetricKey
DECRYPTION BY CERTIFICATE HMSCertificate;
-- Create a demo table
-- Use VARBINARY as the data type for the encrypted column


----Do not remove this statements--------------

/* Lookup tables (Static Data) */

drop table if exists PharmacyLookup;
drop table if exists Specialization;
drop table if exists AllergyTypes;
drop table if exists RolesLookup;
drop table if exists AppointmentType;

drop table if exists PatientInsurance;
drop table if exists PatientPrimaryContact;
drop table if exists PatientWishlistPharmacy;
drop table if exists PatientAllergies;
drop table if exists LoginSessions;
drop table if exists LoginInformation;
drop table if exists PatientVisitHistory;
drop table if exists Appointments;
drop table if exists PatientPersonalInformation;
drop table if exists AdminInformation;
drop table if exists DoctorInformation;
drop table if exists PatientAddress;
drop table if exists DoctorSpecialization;

drop table if exists [Address];


/* look up tables */

Create Table PharmacyLookup
	(
	PharmacyID int not null IDENTITY primary key,
	PharmacyName varchar(255) not null,
	PharmacyStreetName varchar(255) not null,
	PharmacyState varchar(255) not null,
	PharmacyCity varchar(255) not null,
	PharmacyZip int not null,
	ContactNumber BIGINT not null
	);


Create table AllergyTypes
	(
	AllergyTypeID int not null IDENTITY primary key,
	Allergyname varchar(255) not null,
	[Description] varchar(255) not null
	);


Create Table RolesLookup
	(
	RoleID Int not null IDENTITY primary key,
	RoleType varchar(255) not null
	);

Create Table Specialization
	(
	SpecializationID int not null IDENTITY primary key,
	SpecializationName varchar(255) not null
	);

Create Table AppointmentType
	(
	AppointmentTypeID int not null IDENTITY primary key,
	AppointmentType varchar(255),
	DurationMin int
	);

/* End of lookups */


Create table PatientAddress 
	(
	AddressID int not null IDENTITY primary key,
	Street varchar(255) not null,
	[State] varchar(255) not null,
	City varchar(255) not null,
	ZipCode int not null,
	PhoneNumber BigInt not null,
	EmailID varchar(255)
	);


create Table PatientPersonalInformation
	(
	PatientID int not null IDENTITY(1000,2) primary key,
	VerificationID int not null,  --Must be unique
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	DOB date not null,
	AddressID int  NOT NULL FOREIGN KEY
        REFERENCES dbo.PatientAddress(AddressID)
	);


Create Table PatientInsurance
	(
	InsuranceID int not null IDENTITY primary key,
	PatientID int Foreign key 
		references PatientPersonalInformation(PatientID),
	InsuranceProvider varchar(255) not null
	);
	

Create table PatientPrimaryContact
	(
	PatientID int NOT NULL Primary Key,
	Foreign key(PatientID) 
		references PatientPersonalInformation(PatientID),
	FullName varchar(255) not null,
	PhoneNumber BIGINT not null
	);
	

Create Table PatientWishlistPharmacy
    (
	PatientID int NOT NULL,
	PharmacyID int NOT NULL,
	PRIMARY KEY CLUSTERED ( PatientID, PharmacyID),
	Foreign key(PatientID)
		references PatientPersonalInformation(PatientID),
	Foreign key(PharmacyID)
		references PharmacyLookup(PharmacyID)
	);
	

create table PatientAllergies
	(
	PatientID int NOT NULL,
	AllergyTypeID int NOT NULL,
	PRIMARY KEY CLUSTERED ( PatientID, AllergyTypeID),
	Foreign key(PatientID)
		references PatientPersonalInformation(PatientID),
	Foreign key(AllergyTypeID)
		references AllergyTypes(AllergyTypeID)
	);


Create table [Address] 
	(
	AddressID int not null IDENTITY primary key,
	Street varchar(255) not null,
	AddressLine2 varchar(255),
	City varchar(255) not null,
	State varchar(255) not null,
	Country varchar(255),
	ZipCode int not null,
	PhoneNumber BIGINT not null,
	EmailID varchar(255)
	);


Create table AdminInformation
	(
	AdminID int not null IDENTITY(11,1) primary key,
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	DOB Date,
    AddressID int  NOT NULL FOREIGN KEY
        REFERENCES dbo.Address(AddressID)
    );
  	

Create table DoctorInformation
	(
	DoctorID int not null IDENTITY(1001, 2) primary key,
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	DOB date,
	AddressID int  NOT NULL FOREIGN KEY
        REFERENCES dbo.Address(AddressID)
	);

Create Table LoginInformation
	(
	UserID int not null primary key,
	[password] varchar(255) not null,  -- EncryptByKey(Key_GUID(N'HMSSymmetricKey'), convert(varbinary, password))
	RoleID int NOT NULL FOREIGN KEY
        REFERENCES dbo.RolesLookup(RoleID)
	);


Create Table LoginSessions
	(
	SessionID int not null IDENTITY primary key,
	SessionTime Date  not null,
	UserID int NOT NULL FOREIGN KEY
        REFERENCES dbo.LoginInformation(UserID)
	);
	

Create table Appointments
	(
	 AppointmentID int not null IDENTITY primary key,
	 PatientID int Foreign key 
		references PatientPersonalInformation(PatientID),
     DoctorID int Foreign key 
		references  DoctorInformation(DoctorID),
	 AppointmentTypeID int Foreign key
		references AppointmentType(AppointmentTypeID),
	 ProblemDescription varchar (255) not null,
	 AppointmentDate Date,
	 AppointmentTime Time
	 );

Create Table PatientVisitHistory
	 (
	 AppointmentID int Foreign key
		references Appointments(AppointmentID),
	 Temperature float Not null,
	 BloodPressure int, 
	 HeartRate int, 
	 RespiratoryRate int,
	 Height float, 
	 [Weight] float
	 );

	

Create table DoctorSpecialization
	(
	DoctorID int NOT NULL,
	SpecializationID int NOT NULL,
	PRIMARY KEY CLUSTERED ( DoctorID, SpecializationID),
	Foreign key(DoctorID)
		references DoctorInformation(DoctorID),
	Foreign key(SpecializationID)
		references Specialization(SpecializationID)
	);
	
-- End of Create Tables

-- Data insertion to Look up tables

INSERT INTO RolesLookup (RoleType)
VALUES
    ('Admin'),
    ('Doctor'),
    ('Paitent');

INSERT INTO PharmacyLookup (PharmacyName ,PharmacyStreetName ,PharmacyState ,PharmacyCity ,PharmacyZip ,ContactNumber)
VALUES
    ('CVS', '91 Seaport Blvd', 'MA', 'Boston', '02210', '8573504646'),
    ('CVS', '423 W Broadway', 'MA', 'South Boston', '02127', '6172697656'),
    ('Star Market Pharmacy', '45 Morrissey Blvd', 'MA', 'Dorchester', '02125', '6172657911'),
    ('CVS', '333 Washington St', 'MA', 'Boston', '02108', '6177420783'),
    ('CVS', '7000 Atlantic Ave', 'MA', 'Boston', '02111', '6177377232'),
    ('CVS', '631 Washington St', 'MA', 'Boston', '02118', '6173380128'),
    ('Walgreens', '710 E Broadway', 'MA', 'South Boston', '02127', '6172695788'),
    ('Walgreens', '24 School St', 'MA', 'Boston', '02108', '6173728156'),
    ('Walgreens', '841 Boylston St', 'MA', 'Boston', '02116', '6172361692'),
    ('Default Pharmacy', '587 Boylston St', 'MA', 'Boston', '02116', '6174378414');
	
	
INSERT INTO AllergyTypes(AllergyName,Description)
VALUES
    ('No Allergy', 'Default Allergy'),
    ('Peanuts', 'Peanuts'),
    ('Mold', 'Mold'),
    ('Penicillin ', 'Penicillin '),
    ('Pollen', 'Pollen'),
    ('Eggs', 'Eggs'),
    ('Dairy', 'Dairy'),
    ('Tree Nuts', 'Tree Nuts'),
    ('Dust', 'Dust'),
    ( 'Grass', 'Grass');


INSERT INTO Specialization (SpecializationName)
VALUES
    ('General'),
    ('Allergy and immunology'),
    ('Anesthesiology'),
    ('Dermatology'),
    ('Radiology'),
    ('Dentist'),
    ('Internal medicine'),
    ('Surgery'),
    ('Psychiatry'),
    ('Pediatrics'),
    ( 'Neruology');


INSERT INTO AppointmentType(AppointmentType,DurationMin) Values('Out Patient Visit', 20), ('General',15)


--Start of Functions


--DROP FUNCTION IF EXISTS calculateAge;
Create or alter function calculateAge(@DateOfBirth date) 
returns int 
as 
Begin 
	IF MONTH(@DateOfBirth) = MONTH(getdate()) and day(@DateOfBirth)>day(getdate()) 
		return datediff(MONTH,@DateOfBirth, getdate())/12 - 1
	return datediff(MONTH,@DateOfBirth, getdate())/12
End


--DROP FUNCTION IF EXISTS uf_GetDoctorsByNameAndSpecialization;
CREATE or alter FUNCTION uf_GetDoctorsByNameAndSpecialization  
(@specialization  as varchar(255),
 @doctorName as varchar(255)) 
RETURNS @table TABLE
(
    DoctorID int,
    FIRSTName varchar(255),
    LastName varchar(255),
    SpecializationId int,
    SpecializationName VARCHAR(255) 
)
AS BEGIN
    INSERT into @table
    SELECT d.DoctorID,  FIRSTName, LASTName, ds.SpecializationID, SpecializationName
        FROM DoctorInformation d
        JOIN DoctorSpecialization ds on d.DoctorID = ds.DoctorID
        JOIN Specialization s on s.SpecializationID = ds.SpecializationID
        WHERE FirstName like  @doctorName +'%' or LastName like  @doctorName +'%'
        ORDER BY FirstName, LastName;
        return 
END

--DROP FUNCTION IF EXISTS ufAdminCount;
create or alter function ufAdminCount ()
returns int
begin
   declare @count int;
   select  @count = count(*)
      from AdminInformation
   return @count;
end


--DROP FUNCTION IF EXISTS ufUserExists;
create or alter function ufUserExists (@userId int)
returns int
begin
   if exists(SELECT 1 from AdminInformation where AdminID = @userId)
    return 1;
    else if exists(SELECT 1 from DoctorInformation where DoctorId = @userId)
    return 1;
    else if exists(SELECT 1 from PatientPersonalInformation where PatientID = @userId)
    return 1;
    ELSE
    return 0;
    return 0;
end

-- Table Level Constraints/ Triggers / Computational Columns

--To restrict the PatientPersonalInformation to have unique VerificationID s
ALTER TABLE PatientPersonalInformation
ADD CONSTRAINT Unique_VerificatioID UNIQUE (VerificationID);

ALTER TABLE PatientPersonalInformation
ADD CONSTRAINT Unique_VerificatioID UNIQUE (VerificationID);

CREATE or ALTER TRIGGER AppointmentsInsertCheckTrigger
ON Appointments
FOR INSERT, UPDATE
AS
BEGIN

IF Exists(select 1 from appointments a 
            join inserted i on a.doctorId= i.doctorId and a.appointmentDate = i.appointmentDate and a.appointmentTime = i.appointmentTime 
            where a.appointmentid not in (i.AppointmentID))
    BEGIN
        ROLLBACK TRAN;
        RAISERROR ('The appointment Date and Time with this doctor is not already booked ! Choose a different Doctor or Date or Time', 16, 1);
    END

END;




--- Start of Create Procedures

--INSERT_UPDATE_ADDRESS

CREATE or ALTER PROCEDURE [dbo].[INSERT_UPDATE_ADDRESS]
(   @Street  as varchar(255),
	@State as varchar(255),
	@City as varchar(255),
	@ZipCode  as int,
	@PhoneNumber as BigInt,
    @emailid as VARCHAR(255) = null,
    @addressLine2 as varchar(255) = null,
    @addressid as int = null,
    @outputaddressid int OUTPUT) 
AS BEGIN 
    DECLARE @id int;
    SET @outputaddressid = @addressid
    IF isnull(@addressid,'') != '' or exists(select 1 from address where PhoneNumber = @PhoneNumber)
        BEGIN
        update [Address]
                    set Street = ISNULL(@Street, Street),
                    [State] = ISNULL(@State,[State]), 
                    City = ISNULL(@City, City),
                    ZipCode = ISNULL(@ZipCode, ZipCode),
                    PhoneNumber = ISNULL(@PhoneNumber, PhoneNumber),
                    EmailID = ISNULL(@emailid, EmailID), 
                    [AddressLine2] = ISNULL(@addressLine2, [AddressLine2])
                     where AddressID = @addressid or PhoneNumber= @PhoneNumber
        select @id= addressid from Address where PhoneNumber = @PhoneNumber
        set @outputaddressid= @id;
        return @outputaddressid
        END
    ELSE    
        BEGIN
             Insert into [Address](Street, [State], City, ZipCode, PhoneNumber, EmailID, Addressline2)
             values(@Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2)

            SET @outputaddressid = SCOPE_IDENTITY()
            return @outputaddressid
        END
END 
GO


-- RegisterAdmin
CREATE OR ALTER PROCEDURE RegisterAdmin(
    @FirstName as varchar(255),
    @LastName as varchar(255),
    @DOB as date,
    @password as varchar(255),
    @Street varchar(255),
    @State as varchar(255),
    @City as varchar(255),
    @ZipCode as int,
    @PhoneNumber as bigint,
    @emailid as VARCHAR(255) = null,
    @addressLine2 as VARCHAR(255) = null,
    @country as VARCHAR(255) = null
)
AS
BEGIN TRY  
    DECLARE @output VARCHAR(20);
    DECLARE @UserID INT;
    -- Varchar(255)
    -- Checks if user exists and skips the insertion. 
    DECLARE @AddressID int;
    DECLARE @RoleId int;
    DECLARE @specializationID int;
    EXECUTE dbo.INSERT_UPDATE_ADDRESS @Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2, null, @AddressID output

    IF ISNULL(@AddressID, '') != ''
    BEGIN

        IF NOT exists(select 1 from AdminInformation d join [address] a on a.AddressID=d.AddressID 
        where a.PhoneNumber = @PhoneNumber and d.FirstName=@FirstName and d.LastName = @LastName)
        BEGIN 
        INSERT INTO AdminInformation
            (FirstName, LastName, DOB, AddressID) -- VerificationID)
        values(@FirstName, @LastName, @DOB, @AddressID) --   , @VerificationID)

        SET @UserID = SCOPE_IDENTITY()


        SELECT @RoleId = RoleId
        from RolesLookup
        where RoleType = 'Admin';


        OPEN SYMMETRIC KEY HMSSymmetricKey
        DECRYPTION BY CERTIFICATE HMSCertificate;

        INSERT INTO LoginInformation
            (UserID, [password] ,RoleID)
        VALUES(@UserID, EncryptByKey(Key_GUID('HMSSymmetricKey'), @password) , @RoleId)
        CLOSE SYMMETRIC KEY HMSSymmetricKey;
        --INSERT INTO LoginSessions(UserID, Time)VALUES(@UserID, getDate())

        SET @output =  @UserID;

        END
        ELSE
            select 'User Exists!' as 'Message'
    END
     select @output as UserId
END TRY  
BEGIN CATCH  
    SELECT ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  


--RegisterDoctor


CREATE OR ALTER PROCEDURE RegisterDoctor(
    -- @VerificationID as int,
    @FirstName as varchar(255),
    @LastName as varchar(255),
    @DOB as date,
    @password as varchar(255),
    @Street varchar(255),
    @State as varchar(255),
    @City as varchar(255),
    @ZipCode as int,
    @PhoneNumber as bigint,
    @specialization varchar(100) = 'General',
    @emailid as VARCHAR(255) = null,
    @addressLine2 as VARCHAR(255) = null,
    @country as VARCHAR(255) = null
)
AS
BEGIN TRY  
    DECLARE @output VARCHAR(20);
    DECLARE @UserID INT;
    -- Varchar(255)
    -- Checks if user exists and skips the insertion. 
    DECLARE @AddressID int;
    DECLARE @RoleId int;
    DECLARE @specializationID int;
    EXECUTE dbo.INSERT_UPDATE_ADDRESS @Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2, @Country, null, @AddressID output

    IF ISNULL(@AddressID, '') != ''
    BEGIN

        IF NOT exists(select 1 from DoctorInformation d join [address] a on a.AddressID=d.AddressID 
        where a.PhoneNumber = @PhoneNumber and d.FirstName=@FirstName and d.LastName = @LastName)
        BEGIN 
        INSERT INTO DoctorInformation
            (FirstName, LastName, DOB, AddressID) -- VerificationID)
        values(@FirstName, @LastName, @DOB, @AddressID) --   , @VerificationID)

        SET @UserID = SCOPE_IDENTITY()

        if isnull(@specialization,'') = ''
        BEGIN
            set @specialization = 'General'
        END
        select @specializationID = SpecializationID from Specialization where SpecializationName = @specialization
        
        If ISNULL(@specializationID,'') !=''
        BEGIN
            INSERT INTO DoctorSpecialization (DoctorID,SpecializationID)
            VALUES (@UserID, @specializationID);
        END


        SELECT @RoleId = RoleId
        from RolesLookup
        where RoleType = 'Doctor';


        OPEN SYMMETRIC KEY HMSSymmetricKey
        DECRYPTION BY CERTIFICATE HMSCertificate;

        INSERT INTO LoginInformation
            (UserID, [password] ,RoleID)
        VALUES(@UserID, EncryptByKey(Key_GUID('HMSSymmetricKey'), @password) , @RoleId)
        CLOSE SYMMETRIC KEY HMSSymmetricKey;
        --INSERT INTO LoginSessions(UserID, Time)VALUES(@UserID, getDate())

        SET @output =  @UserID;

        END
        ELSE
            select 'User Exists!' as 'Message'
    END
     select @output as UserId
END TRY  
BEGIN CATCH  
    SELECT ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  


-- INSERT_UPDATE_PATIENT_ADDRESS

CREATE or ALTER PROCEDURE INSERT_UPDATE_PATIENT_ADDRESS
(   @Street  as varchar(255),
	@State as varchar(255),
	@City as varchar(255),
	@ZipCode  as int,
	@PhoneNumber as BIGINT,
    @emailid as VARCHAR(255) = null,
    @addressid as int = null,
    @outputaddressid int OUTPUT) 
AS BEGIN 
    -- TRY
    -- BEGIN
    SET @outputaddressid = @addressid
    IF exists(select 1 from PatientAddress where AddressID=@addressid or PhoneNumber=@PhoneNumber)
       BEGIN
            update PatientAddress 
            set Street = ISNULL(@Street, Street),
            [State] = ISNULL(@State,[State]), 
            City = ISNULL(@City, City),
            ZipCode = ISNULL(@ZipCode, ZipCode),
            PhoneNumber = ISNULL(@PhoneNumber, PhoneNumber),
            EmailID = ISNULL(@emailid, EmailID)
            where AddressID = @addressid

            select @outputaddressid
        END
    ELSE    
        BEGIN
            Insert into PatientAddress(Street, [State], City, ZipCode, PhoneNumber, EmailID)
             values(@Street, @State, @City, @ZipCode, @PhoneNumber, @emailid)

            SET @outputaddressid = SCOPE_IDENTITY()
            select @outputaddressid
        END
        
                
    -- END
    -- CATCH
    --     return "Error Occured";
    -- END
END 
GO


--INSERT_UPDATE_PATIENT_PRIMARY_CONTACT
CREATE or ALTER PROCEDURE INSERT_UPDATE_PATIENT_PRIMARY_CONTACT
(
	@fullname as varchar(255),
	@phonenumber as bigint,
	@patientid as int
)
AS BEGIN

--SET @outputpatientid = @patientid

IF EXISTS(SELECT 1 FROM PatientPrimaryContact WHERE PatientID = @patientid)
BEGIN
		   UPDATE PatientPrimaryContact 
		   set fullname = ISNULL(@fullname, fullname),
			   phonenumber = ISNULL(@phonenumber, phonenumber)
		   where PatientID = @patientid
END
		   ELSE 
		   BEGIN
			INSERT INTO PatientPrimaryContact (PatientId, FullName, PhoneNumber) VALUES (@patientid, @fullname, @phonenumber);
			END
END



--INSERT_Patient_Pharmacy_Wishlist
CREATE or ALTER PROCEDURE INSERT_Patient_Pharmacy_Wishlist
(
     @PatientID INT,
     @PharmacyID INT
)
AS BEGIN
DECLARE @output VARCHAR(20);
IF EXISTS(SELECT 1 FROM PatientWishlistPharmacy WHERE PatientID = @patientid)
    BEGIN
            UPDATE PatientWishlistPharmacy 
                SET PharmacyID= @PharmacyID 
                WHERE PatientID = @PatientID;
    END
ELSE 
    BEGIN
	SET @output='I am here';
            INSERT INTO PatientWishlistPharmacy(PatientID,PharmacyID)
	    	VALUES (@PatientID,@PharmacyID);
	    select @output as UserID
    END
END


--INSERT_UPDATE_PATIENT_INSURANCE

CREATE or ALTER PROCEDURE INSERT_UPDATE_PATIENT_INSURANCE
(
	@patientid as int,
	@provider as varchar(255)
)
AS BEGIN


IF EXISTS(SELECT 1 FROM PatientInsurance WHERE PatientID = @patientid)
		   UPDATE PatientInsurance 
		   set InsuranceProvider = ISNULL(@provider, InsuranceProvider)
		   where PatientID = @patientid

		   ELSE 
			INSERT INTO PatientInsurance (PatientId,InsuranceProvider)
				VALUES (@patientid, @provider);
END


--INSERT_Patient_Allergies
CREATE or ALTER PROCEDURE INSERT_Patient_Allergies
(
	 @PatientID INT,
     @AllergyTypeID INT
)
AS BEGIN
DECLARE @output VARCHAR(20);
BEGIN
        SET @output=@PatientID;
        INSERT INTO PatientAllergies(PatientID, AllergyTypeID)
		VALUES (@PatientID,@AllergyTypeID);
        select @output as UserID
END
END


---RegisterPatient

CREATE OR ALTER PROCEDURE RegisterPatient(
    @VerificationID as int,
    @FirstName as varchar(255),
    @LastName as varchar(255),
    @DOB as DATE,
    @password as varchar(255),
    @Street varchar(255),
    @State as varchar(255),
    @City as varchar(255),
    @ZipCode as int,
    @PhoneNumber as BigInt,
    @emailid as VARCHAR(255) = null,
    @primarycontactfullname varchar(255)= null,
    @primarycontactnumber bigint = null,
    @PharmacyID int =null,
    @AllergyId int =null,
    @insurancprovider as VARCHAR(255) = null
)
AS
BEGIN

BEGIN TRY  
  
    DECLARE @output VARCHAR(20);
    DECLARE @UserID INT;
    -- Varchar(255)
    -- Checks if user exists and skips the insertion. 

    IF EXISTS(SELECT 1
    FROM PatientPersonalInformation
    WHERE VerificationID = @VerificationID)
    BEGIN
        --select 'hetg 1' + @VerificationID
        SELECT @UserID = PatientID
        FROM PatientPersonalInformation
        WHERE VerificationID = @VerificationID
        SET @output = @UserID
    END
ELSE
BEGIN
        DECLARE @AddressID int;
        DECLARE @RoleId int;
        EXECUTE dbo.INSERT_UPDATE_PATIENT_ADDRESS @Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, null, @AddressID output

        IF ISNULL(@AddressID,'') != ''
    BEGIN
            INSERT INTO PatientPersonalInformation
                (VerificationID, FirstName, LastName, DOB, AddressID)
            values(@VerificationID, @FirstName, @LastName, @DOB, @AddressID)

            SET @UserID = SCOPE_IDENTITY()

            SELECT @RoleId = RoleId
            from RolesLookup
            where RoleType = 'Patient';

            OPEN SYMMETRIC KEY HMSSymmetricKey
            DECRYPTION BY CERTIFICATE HMSCertificate;

            INSERT INTO LoginInformation
                (UserID, password ,RoleID)
            VALUES(@UserID, EncryptByKey(Key_GUID(N'HMSSymmetricKey'), @password) , @RoleId)

            CLOSE SYMMETRIC KEY HMSSymmetricKey;

            --INSERT INTO LoginSessions(UserID, Time)VALUES(@UserID, getDate())

            -- EXECUTE Allergy, Wishlist, Insurance
            EXECUTE INSERT_UPDATE_PATIENT_PRIMARY_CONTACT @primarycontactfullname, @primarycontactnumber, @UserID
            EXECUTE INSERT_Patient_Pharmacy_Wishlist @UserID,@PharmacyID
	    EXECUTE INSERT_UPDATE_PATIENT_INSURANCE @UserID, @insurancprovider
            EXECUTE INSERT_Patient_Allergies @UserID,@AllergyId
            SET @output =  @UserID;
        END
    END;
    select @output as UserID

END TRY  
BEGIN CATCH  
    
    SELECT ERROR_MESSAGE() AS ErrorMessage;  

END CATCH; 
END


-- Insert_Update_Appointment

CREATE or ALTER PROCEDURE Insert_Update_Appointment
(   @patientid  as varchar(255),
	@doctorID as varchar(255),
	@appointmenttype as varchar(255) = 'Out Patient Visit',
    @problemdescription as varchar(255),
    @Date as date,
    @time as time,
    @appointmentId as int,
    @appointmentidOutput int OUTPUT
) 
AS BEGIN  
BEGIN TRY
    DECLARE @appointmentTypeID int;
    Select @appointmentTypeID = AppointmentTypeID from AppointmentType where AppointmentType = @appointmenttype;

    set @appointmentidOutput = @appointmentID

    IF Isnull(@appointmentID,'') != '' or exists(select 1 from Appointments where AppointmentId = @appointmentID)
       BEGIN
            update Appointments 
            set DoctorID = ISNULL(@doctorID, DoctorID),
            AppointmentTypeID = ISNULL(@appointmentTypeID, AppointmentTypeID), 
            ProblemDescription = ISNULL(@problemdescription, ProblemDescription),
            AppointmentDate = ISNULL(@Date, AppointmentDate),
            AppointmentTime = ISNULL(@time, AppointmentTime)
            where appointmentID = @appointmentID and PatientId = @patientid

            select @appointmentidOutput as ApointmentID
        END
    ELSE    
        BEGIN
            Insert into Appointments(PatientId, DoctorID, AppointmentTypeID, ProblemDescription, AppointmentDate, AppointmentTime)
             values(@patientid, @doctorID, @appointmentTypeID, @problemdescription, @Date, @time)

            SET @appointmentidOutput = SCOPE_IDENTITY()
            select @appointmentidOutput as ApointmentID
        END       
    END TRY
    BEGIN CATCH
        select ERROR_MESSAGE() as ErrorMessage;
    END CATCH 
END


--INSERT_Patient_Visit_History

CREATE or ALTER PROCEDURE INSERT_Patient_Visit_History
(
     @AppointmentID INT,
     @Temperature float,
     @BloodPressure INT,
     @HeartRate INT,
     @RespiratoryRate INT,
     @Height float,
     @Weight float
)
AS BEGIN
DECLARE @output VARCHAR(20);

	IF Exists(select 1 from PatientVisitHistory where AppointmentId = @AppointmentID)
       BEGIN
			SET @output= @AppointmentID;
            update PatientVisitHistory 
            set 
            Temperature = ISNULL(@Temperature, Temperature), 
            BloodPressure = ISNULL(@BloodPressure, BloodPressure),
            HeartRate = ISNULL(@HeartRate, HeartRate),
            RespiratoryRate = ISNULL(@RespiratoryRate, RespiratoryRate),
			Height = ISNULL(@Height, Height),
			[Weight] = ISNULL(@Weight, Weight)
            where AppointmentID = @AppointmentID
            select @output as ApointmentID
        END
	ELSE
		BEGIN
				SET @output= @AppointmentID;
				INSERT INTO PatientVisitHistory(AppointmentID,Temperature,BloodPressure,HeartRate,RespiratoryRate,Height,Weight)
				VALUES (@AppointmentID,@Temperature,@BloodPressure,@HeartRate,@RespiratoryRate,@Height,@Weight);
				select @output as AppointmentID
		END
END


--Login_Verification
CREATE or ALTER PROCEDURE Login_Verification
    (
    @UserID as int,
    @password as varchar(255)
)
AS
BEGIN

    --SET @outputpatientid = @patientid
    OPEN SYMMETRIC KEY HMSSymmetricKey
            DECRYPTION BY CERTIFICATE HMSCertificate;


    IF EXISTS(SELECT 1
    FROM LoginInformation
    WHERE USERID = @UserID and DecryptByKey(password) =@password)
    BEGIN

        INSERT INTO LoginSessions(UserID, SessionTime) Values(@UserID, getDate())

        select UserId, p.FirstName, P.LastName, P.DOB
        from LoginInformation l join PatientPersonalInformation p on p.PatientId = l.UserID where USERId =@UserID

    END
    ELSE
        SELECT Null as [User]
    CLOSE SYMMETRIC KEY HMSSymmetricKey;
END


--Start of views

Create VIEW CurrentWeekUpcommingAppointments as
select  *
       from Appointments
       where year(AppointmentDate) = year(getdate()) 
               and datepart(wk, AppointmentDate) = datepart(wk, getdate()) 
               and datepart(d, AppointmentDate) >= datepart(d, getdate())


Create view [Patient Insurance] as
with temp as (
select 
	case 
		when InsuranceProvider is null then 'No Insurance'
		else 'Insurance' 
	end as 'InsuranceCheck',
	count(distinct ppi.PatientID) as 'CountofInsurance'
from PatientPersonalInformation ppi
left join PatientInsurance pi
	on ppi.PatientID = pi.PatientID
	group by InsuranceProvider)
	
select InsuranceCheck, 
	sum(CountofInsurance) as 'Count of Insurance'
from temp
group by insurancecheck



--- Top Pharma

Create view [Top Pharma] as
select pi.insuranceprovider, 
	count(distinct ppi.PatientID) as 'Count of Insurance'
from PatientPersonalInformation ppi
left join PatientInsurance pi
	on ppi.PatientID = pi.PatientID
group by insuranceprovider 


--- Busiest Doctor/Number of patients per doctor based on month or year

Create view [Patient Count] as
select Doctor, 
	[Jan],
	[Feb],
	[Mar],
	[Apr],
	[May],
	[Jun],
	[Jul],
	[Aug],
	[Sep],
	[Oct],
	[Nov],
	[Dec]
from
(select datename(month,appointmentdate) as 'AppointmentMonth',
	firstname + SPACE(1) + lastname as 'Doctor',
	a.patientid
from appointments a
join DoctorInformation d
	on a.DoctorID = d.DoctorID) as SourceTable
PIVOT 
	(count(PatientID)
	for AppointmentMonth  in ([Jan],
	[Feb],
	[Mar],
	[Apr],
	[May],
	[Jun],
	[Jul],
	[Aug],
	[Sep],
	[Oct],
	[Nov],
	[Dec])) as PivotTable


--- Number of Patients with Allergies/Fever/Blood Pressure/HeartRate
	
Create view [Patient Health] as 
select 
	case when Temperature > 98.6 then 'Fever'
		else 'No Fever'
	end as 'Fever',
	
	case when at.AllergyTypeID = 1 then 'No Allergies'
		else 'Has Allergies'
	end as 'Allergies',
	
	case when BloodPressure between 120 and 129 then 'Normal Blood Pressure'
	 	when BloodPressure > 129 then 'High Blood Pressure'
		else 'Low Blood Pressure'
	end as 'Blood Pressure', 

	case when HeartRate between 55 and 100 then 'Normal Heart Rate'
		else 'Tachycardia'
	end as 'Heart Rate' 

from PatientVisitHistory pvh 
join Appointments a 
	on pvh.AppointmentID = a.AppointmentID 
join PatientAllergies pa 
	on a.patientid = pa.PatientID 
join AllergyTypes at
	on pa.AllergyTypeID = at.AllergyTypeID 
