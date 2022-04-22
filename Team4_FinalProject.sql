--drop database HMS_Temp;

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
    ('Patient');

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
End;


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
END;


--DROP FUNCTION IF EXISTS ufAdminCount;
create or alter function ufAdminCount ()
returns int
begin
   declare @count int;
   select  @count = count(*)
      from AdminInformation
   return @count;
end;


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
end;

-- Table Level Constraints/ Triggers / Computational Columns

--To restrict the PatientPersonalInformation to have unique VerificationID s

ALTER TABLE PatientPersonalInformation
ADD CONSTRAINT Unique_VerificatioID UNIQUE (VerificationID);

-- computation column (calculating age based on dob)
ALTER TABLE PatientPersonalInformation
ADD Age as dbo.calculateAge(DOB);

ALTER TABLE DoctorInformation
ADD Age as dbo.calculateAge(DOB);

ALTER TABLE AdminInformation
ADD Age as dbo.calculateAge(DOB);

--table level constraint(admin table to have 99 users)
alter table AdminInformation add CONSTRAINT Check_Admin_Count_100 CHECK (dbo.ufAdminCount 
() <= 99);

--trigger (To restrict creating an appointment for the same date and time with same doctor)
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
        RAISERROR ('The appointment Date and Time with this doctor is already booked ! Choose a different Doctor or Date or Time', 16, 1);
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
    @country as varchar(255),
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
                    [AddressLine2] = ISNULL(@addressLine2, [AddressLine2]),
                    Country = isnull(@country,Country)
                     where AddressID = @addressid or PhoneNumber= @PhoneNumber
        select @id= addressid from Address where PhoneNumber = @PhoneNumber
        set @outputaddressid= @id;
        return @outputaddressid
        END
    ELSE    
        BEGIN
             Insert into [Address](Street, [State], City, ZipCode, PhoneNumber, EmailID, Addressline2, Country)
             values(@Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2, @country)

            SET @outputaddressid = SCOPE_IDENTITY()
            return @outputaddressid
        END
END ;


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
    EXECUTE dbo.INSERT_UPDATE_ADDRESS @Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2, @country, null, @AddressID output

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
END ;


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
END;



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
	
            INSERT INTO PatientWishlistPharmacy(PatientID,PharmacyID)
	    	VALUES (@PatientID,@PharmacyID);
	    select @output as UserID
    END
END;


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
END;


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
END;


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

END CATCH
END;


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
END;

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
END;


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
        
        select UserId
        , isnull(isnull(p.FirstName, d.FirstName), a.FirstName) as [FirstName], isnull(isnull(P.LastName, d.LastName),a.LastName) as [LastName], isnull(isnull(P.DOB, d.DOB), a.DOB) as [DOB]
        from LoginInformation l 
        left join PatientPersonalInformation p on p.PatientId = l.UserID
        left join DoctorInformation d on d.doctorId =l.UserID
        left join AdminInformation a on a.AdminId =l.UserID
         where USERId =@UserID

    END
    ELSE
        SELECT Null as [User]
    CLOSE SYMMETRIC KEY HMSSymmetricKey;
END;



EXECUTE [dbo].[RegisterPatient]
	25212, 'Alexi', 'Gemson', '1987-11-16', 'fP0UbM', 'Erie', 'Georgia', 'Atlanta', '30323', 6784497970, 'agemson0@bravesites.com', 'Alexi Gemson', 2105784182, 3, 8, 'Bode-Schuster';
EXECUTE [dbo].[RegisterPatient]
	35851, 'Sadella', 'Cubberley', '1996-11-20', 'cX2ZCJHCosM', 'Warrior', 'Texas', 'Amarillo', '79116', 8063366118, 'scubberley1@yale.edu', 'Sadella Cubberley', 5022582792, 4, 1, 'Bode-Schuster';
EXECUTE [dbo].[RegisterPatient]
	65587, 'Bibby', 'Ferreiro', '1993-11-03', 'ujX1W8', 'Sutherland', 'Florida', 'Naples', '34102', 9419596207, 'bferreiro2@blogger.com', 'Bibby Ferreiro', 5638956520, 2, 5, 'Daugherty, Roob and Dicki';
EXECUTE [dbo].[RegisterPatient]
	65847, 'Lissi', 'Haglinton', '1964-09-11', '9Erf0QE4Zs2U', 'Lighthouse Bay', 'Illinois', 'Schaumburg', '60193', 8474180638, 'lhaglinton3@illinois.edu', 'Lissi Haglinton', 5208114461, 10, 2, 'Rohan-Koelpin';
EXECUTE [dbo].[RegisterPatient]
	07220, 'Maryanna', 'De Zamudio', '2000-05-25', 'RSZbj6hAI', 'Jenna', 'Florida', 'Miami', '33129', 7865969303, 'mde4@msn.com', 'Maryanna De Zamudio', 9102294396, 3, 7, 'Hermiston and Sons';
EXECUTE [dbo].[RegisterPatient]
	06168, 'Shani', 'Linebarger', '1974-11-30', 'PA5E1O', 'Chinook', 'Indiana', 'Fort Wayne', '46852', 2607686951, 'slinebarger5@samsung.com', 'Shani Linebarger', 2021665175, 6, 4, 'Daugherty, Roob and Dicki';
EXECUTE [dbo].[RegisterPatient]
	74569, 'Ava', 'Bennike', '1976-07-16', 'v6YClOzl', 'Kipling', 'Florida', 'Bonita Springs', '34135', 9419348313, 'abennike6@marriott.com', 'Ava Bennike', 4341494277, 9, 9, 'Rohan-Koelpin';
EXECUTE [dbo].[RegisterPatient]
	96607, 'Nessy', 'Martinets', '1993-08-04', 'FEFgYHh', 'Fisk', 'Utah', 'Salt Lake City', '84115', 8011916388, 'nmartinets7@smugmug.com', 'Nessy Martinets', 2534154725, 10, 2, 'Veum, Crona and Ullrich';
EXECUTE [dbo].[RegisterPatient]
	82821, 'Bambi', 'Hasluck', '1978-02-02', '2FA8T5T', 'Erie', 'Idaho', 'Boise', '83757', 2083332704, 'bhasluck8@homestead.com', 'Bambi Hasluck', 9018493826, 1, 4, 'Rohan-Koelpin';
EXECUTE [dbo].[RegisterPatient]
	08850, 'Vida', 'Yegorshin', '1998-03-31', 'DxfxyT', 'Dryden', 'District of Columbia', 'Washington', '20036', 2021193169, 'vyegorshin9@icio.us', 'Vida Yegorshin', 8623251130, 10, 5, 'Ebert, Homenick and Braun';
EXECUTE [dbo].[RegisterPatient]
	17589, 'Adriena', 'Imrie', '1970-10-06', 'YjYPUMjEcZq', 'Packers', 'South Carolina', 'Spartanburg', '29319', 8646209029, 'aimriea@storify.com', 'Adriena Imrie', 2081172656, 9, 5, 'Aufderhar and Sons';
EXECUTE [dbo].[RegisterPatient]
	60385, 'Elfrieda', 'Enion', '1967-08-31', 'Un3xdaYqt3vs', 'Alpine', 'Hawaii', 'Honolulu', '96840', 8083400155, 'eenionb@apache.org', 'Elfrieda Enion', 2178144280, 4, 10, 'Heathcote-Armstrong';
EXECUTE [dbo].[RegisterPatient]
	77719, 'Bryana', 'Ruppel', '1993-04-14', 'UbrW5WoMXG', 'Monument', 'Pennsylvania', 'Pittsburgh', '15274', 4127702570, 'bruppelc@purevolume.com', 'Bryana Ruppel', 2028608642, 8, 8, 'Wunsch, Raynor and Miller';
EXECUTE [dbo].[RegisterPatient]
	76991, 'Nora', 'Garioch', '2002-03-10', 'LJEhIBknPq', 'Brown', 'District of Columbia', 'Washington', '20067', 2023814574, 'ngariochd@unc.edu', 'Nora Garioch', 2061944410, 1, 7, 'Dach Inc';
EXECUTE [dbo].[RegisterPatient]
	63570, 'Stephine', 'Snoddon', '1972-02-03', 'QGBIYw9gxHl', 'Talisman', 'New York', 'Mount Vernon', '10557', 9145378037, 'ssnoddone@intel.com', 'Stephine Snoddon', 3038457317, 3, 3, 'McCullough-Brekke';


EXECUTE [dbo].[RegisterDoctor]
	'Catherin', 'Chastang', '1991-08-09', 'imWHtkwS', 'Sachtjen', 'Kentucky', 'Lexington', 40591, 8594119684, 'General', 'cchastang0@goodreads.com', '6 David Drive', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Armando', 'Dumbare', '1979-01-24', 'e2FVRATG1', 'Northland', 'Minnesota', 'Saint Paul', 55188, 6511896199, 'Surgery', 'adumbare1@dailymotion.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Hubey', 'Dight', '1981-07-18', 'lVNxgvXt', 'Algoma', 'California', 'Sacramento', 95818, 5302984047, 'Internal medicine', 'hdight2@bandcamp.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Gayelord', 'Petera', '1977-08-26', 'GGVn4dbUnQ', 'Wayridge', 'New York', 'New York City', 10280, 3473184742, 'Psychiatry', 'gpetera3@wired.com', '11 Pine View Alley', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Greg', 'Crush', '1990-08-27', 'm6KjVqr', 'Killdeer', 'California', 'Santa Ana', 92725, 7147071850, 'General', 'gcrush4@sohu.com', '305 Fordem Terrace', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Laure', 'Ortet', '1954-12-03', 'myWiJTUIa', 'Garrison', 'Texas', 'Dallas', 75210, 9724834853, 'Dermatology', 'lortet5@sfgate.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Malia', 'Pummery', '1959-08-13', 'kpeQ0yn1I', 'Moose', 'Wisconsin', 'Milwaukee', 53220, 4145125203, 'Internal medicine', 'mpummery6@vistaprint.com', '2 Anzinger Lane', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Dixie', 'Siccombe', '1972-08-07', 'ScPTS3oN', 'Bonner', 'Mississippi', 'Gulfport', 39505, 2287762703, 'Neruology', 'dsiccombe7@howstuffworks.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Dukey', 'Rex', '1995-02-09', 'L2nBchi8L', 'Grim', 'Colorado', 'Denver', 80279, 3039535076, 'Surgery', 'drex8@reverbnation.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Mohandas', 'Hub', '1979-03-03', 'QsgXrkYNuZ90', 'Eagan', 'Texas', 'Austin', 78744, 3614299557, 'Dentist', 'mhub9@dot.gov', '838 Stuart Drive', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Viviyan', 'Manvelle', '1977-12-07', 'DclCee4G5r', 'Nova', 'Idaho', 'Pocatello', 83206, 2082187792, 'Anesthesiology', 'vmanvellea@opera.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Janifer', 'McGhie', '1969-01-27', 'h6eHOsYUz', 'La Follette', 'Minnesota', 'Saint Cloud', 56372, 3206193651, 'Pediatrics', 'jmcghieb@chronoengine.com', '92 Pankratz Junction', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Danna', 'Hartshorne', '1978-12-26', '5nVFExYKrQES', 'Northridge', 'New York', 'New York City', 10275, 2128050075, 'Internal medicine', 'dhartshornec@chron.com', '853 Burning Wood Place', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Pasquale', 'Burrow', '1985-01-29', 'lIsy5LSA8', 'Manley', 'Georgia', 'Atlanta', 30328, 6787733405, 'Radiology', 'pburrowd@wikia.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Ines', 'Yurocjhin', '1994-09-21', 'zhZGc6y5Au', 'Moulton', 'Virginia', 'Norfolk', 23520, 7576858206, 'Allergy and immunology', 'iyurocjhine@thetimes.co.uk', '0 Kensington Lane', 'United States';



DECLARE @outputa int;
EXECUTE [dbo].[Insert_Update_Appointment]
	1000, 1001, 'Out Patient Visit', 'Fever', '7/3/2021', '18:55',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1006, 1007, 'General', 'Bodyache', '3/25/2022', '17:58',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1018, 1009, 'General', 'Chestpain', '7/22/2021', '10:12',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1008, 1003, 'General', 'Fever', '4/4/2022', '4:37',null,@outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1004, 1005, 'Out Patient Visit', 'Fever', '9/14/2021', '21:18',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1002, 1001, 'Out Patient Visit', 'ENT', '2/2/2022', '10:15',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1002, 1009, 'General', 'Fever', '3/14/2022', '21:08',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1000, 1013, 'General', 'ENT', '8/9/2021', '18:42',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1010, 1015, 'Out Patient Visit', 'Pain in the Eye', '9/15/2021', '14:41',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1012, 1019, 'Out Patient Visit', 'Fever', '11/18/2021', '7:37',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1016, 1015, 'Out Patient Visit', 'Headache', '9/4/2021', '11:55',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1020, 1021, 'General', 'Headache', '5/26/2021', '22:46',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1002, 1007, 'Out Patient Visit', 'Fever', '2/15/2022', '9:44',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1004, 1003, 'General', 'ThroatPain', '1/6/2022', '18:22',null,@outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1006, 1009, 'Out Patient Visit', 'Fever', '10/8/2021', '20:07',null,@outputa OUTPUT;

-- Inserting Data to the tables

EXECUTE [dbo].[INSERT_Patient_Visit_History]
	1, 102, 126, 117, 93, 7.2, 120;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	2, 98, 139, 163, 93, 6.0, 134;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	3, 104, 108, 133, 97, 3.0, 66;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	4, 101, 134, 67, 95, 7.1, 99;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	5, 100, 112, 118, 93, 8.5, 136;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	6, 96, 139, 73, 94, 6.0, 96;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	7, 98, 88, 83, 91, 4.8, 84;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	8, 99, 112, 58, 92, 7.4, 12;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	9, 97, 87, 116, 97, 6.8, 113;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	10, 100, 122, 67, 94, 7.7, 13;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	11, 102, 84, 103, 96, 3.9, 82;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	12, 101, 129, 71, 98, 2.9, 144;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	13, 101, 103, 66, 91, 4.3, 104;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	14, 103, 91, 82, 92, 4.1, 135;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	15, 98, 139, 158, 100, 4.8, 98;


--Workflow Start

EXECUTE [dbo].[RegisterPatient]
	12345, 'PatientF', 'PatientL', '1877-10-16', 'pat1234', 'Erie', 'Georgia', 'Atlanta', '30323', 9988998899, 'pat0@bravesites.com', 'Alexi Gemson', 2105784199, 3, 8, 'Bode-Schuster';

--select * from PatientAddress;
--select * from PatientPersonalInformation;
--select * from PatientInsurance;
--select * from PatientPrimaryContact;
--select * from PatientWishlistPharmacy;
--select * from PatientAllergies;

EXECUTE [dbo].[RegisterDoctor]
    'DoctorF', 'DoctorL', '1978-08-09', 'doc1234', 'Sachtjen', 'Kentucky', 'Lexington', 40591, 8594117898, 'General', 'cchastang0@goodreads.com', '6 David Drive', 'United States';

--select * from Address;
--select * from DoctorInformation;
--Select * from LoginInformation;
--select * from DoctorSpecialization;

declare @temppatientid int;
select @temppatientid= PatientID from PatientPersonalInformation where VerificationID = 12345
declare @tempdocid int;
select @tempdocid= DoctorID from DoctorInformation d join Address a on d.AddressID = a.AddressID where PhoneNumber=8594117898

execute Login_Verification @temppatientid,'pat1234' --patient

declare @tempappointmentid int;
EXECUTE [dbo].[Insert_Update_Appointment] 
   @temppatientid  ,@tempdocid  ,'Out Patient Visit'  ,'Fever'  ,'2022-04-24'  ,'12:00'  ,null  ,@tempappointmentid OUTPUT

execute Login_Verification @tempdocid,'doc1234' --doctor

EXECUTE [dbo].[INSERT_Patient_Visit_History]
	@tempappointmentid, 98, 139, 158, 100, 4.8, 98;




--Start of views

Create or alter VIEW CurrentWeekUpcommingAppointments as
select  top 5 *
       from Appointments
       where year(AppointmentDate) = year(getdate()) 
               and datepart(wk, AppointmentDate) >= datepart(wk, getdate()) 
               and datepart(d, AppointmentDate) >= datepart(d, getdate())

--select * from CurrentWeekUpcommingAppointments

--Get the number os patient with and without insurance
Create or alter view [Patient Insurance] as
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


--select * from PatientInsurance
--delete from PatientInsurance where insuranceid=16

--select * from [Patient Insurance]


-- Top insurance 

Create or alter view [Top insurance] as
select pi.insuranceprovider, 
	count(distinct ppi.PatientID) as 'Count of Insurance'
from PatientPersonalInformation ppi
left join PatientInsurance pi
	on ppi.PatientID = pi.PatientID
group by insuranceprovider 


select * from [Top insurance] order by [Count of Insurance]
--- Busiest Doctor/Number of patients per doctor based on month or year

--select * from [Patient Count]
Create or alter view [Patient Count] as
select Doctor, 
	[January],
    [February],
    [March],
    [April],
    [May],
    [June],
    [July],
    [August],
    [September],
    [October],
    [November],
    [December]
from
(select datename(month,appointmentdate) as 'AppointmentMonth',
	firstname + SPACE(1) + lastname as 'Doctor',
	a.patientid
from appointments a
join DoctorInformation d
	on a.DoctorID = d.DoctorID) as SourceTable
PIVOT 
	(count(PatientID)
	for AppointmentMonth  in ([January],
    [February],
    [March],
    [April],
    [May],
    [June],
    [July],
    [August],
    [September],
    [October],
    [November],
    [December])) as PivotTable

--- Number of Patients with Allergies/Fever/Blood Pressure/HeartRate
	
Create or alter view [Patient Health] as 
select a.patientid,
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

--select * from [Patient Health]