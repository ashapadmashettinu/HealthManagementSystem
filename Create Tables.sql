-- Encrypt Table Columns
-- Demo different data types
-- Create New DB
CREATE DATABASE HMS;
drop database hms

USE HMS;

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


USE HMS


Create table Address 
	(AddressID int not null primary key,
	Street varchar(255) not null,
	AddressLine2 varchar(255) not null,
	City varchar(255) not null,
	State varchar(255) not null,
	Country varchar(255) not null,
	ZipCode int not null,
	PhoneNumber int not null,
	EmailID varchar(255) not null)


Create table PatientAddress 
	(AddressID int not null primary key,
	Street varchar(255) not null,
	AddressLine2 varchar(255) not null,
	City varchar(255) not null,
	State varchar(255) not null,
	Country varchar(255) not null,
	ZipCode int not null,
	PhoneNumber int not null,
	EmailID varchar(255) not null)
drop table PatientPersonalInformation
CREATE TABLE [dbo].[PatientPersonalInformation] (
    [PatientID]      INT           NOT NULL,
    [VerificationID] INT           NOT NULL,
    [FirstName]      VARCHAR (255) NOT NULL,
    [LastName]       VARCHAR (255) NOT NULL,
    [DOB]            DATE          NOT NULL,
    [AddressID]      INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([PatientID] ASC, [VerificationID] ASC),
    FOREIGN KEY ([AddressID]) REFERENCES [dbo].[PatientAddress] ([AddressID]),
    PRIMARY KEY CLUSTERED ([PatientID] ASC, [VerificationID] ASC),
    FOREIGN KEY ([AddressID]) REFERENCES [dbo].[PatientAddress] ([AddressID])
);



create Table PatientPersonalInfo
	(PatientID int not null primary key,
	VerificationID int not null,  -- primary key Must be unique
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	DOB date not null,
	AddressID int  NOT NULL FOREIGN KEY
        REFERENCES dbo.PatientAddress(AddressID))



Create table AdminInformation
	(AdminID int not null primary key,
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	DOB Date,
    AddressID int  NOT NULL FOREIGN KEY
        REFERENCES dbo.Address(AddressID)
    )
    
Create table DoctorInfo
	(DoctorID int not null primary key,
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	DOB date,
	AddressID int  NOT NULL FOREIGN KEY
        REFERENCES dbo.Address(AddressID)
	)


Create Table RolesLookup
	(RoleID Int not null primary key,
	RoleType varchar(255) not null)
	

Create Table LoginInformation
	(UserID int not null primary key,
	password varchar(255) not null,  -- EncryptByKey(Key_GUID(N'HMSSymmetricKey'), convert(varbinary, password))
	RoleID int NOT NULL FOREIGN KEY
        REFERENCES dbo.RolesLookup(RoleID))


Create Table LoginSessions
	(SessionID int not null primary key,
	SessionTime Date  not null,
	UserID int NOT NULL FOREIGN KEY
        REFERENCES dbo.LoginInformation(UserID)
	)

------------------------
-- Above all are done
-- Pending 
-------------------------

Create Table PharmacyLookup
	(PharmacyID int not null primary key,
	PharmacyName varchar(255) not null,
	PharmacyStreetName varchar(255) not null,
	PharmacyState varchar(255) not null,
	PharmacyCity varchar(255) not null,
	PharmacyZip int not null,
	ContactNumber int not null)

	
Create Table PatientWishlistPharmacy
	PatientID int Foreign key references PatientPersonalInfo(PatientID),
	PharmacyID references PharmacyLookup(PharmacyID))
	
Create table PatientPrimaryContact
	(Foreign key(PatientID) references PatientPersonalInfo(PatientID),
	FullName varchar(255) not null,
	PhoneNumber int not null)
	
Create Table PatientInsurance
	(InsuranceID int not null primary key,
	Foreign key(PatientID) references PatientPersonalInfo(PatientID),
	InsuranceProvider varchar(255) not null)
	
Create Table PatientAddress
	(Foreign key(AddressID) references Address(AddressID),
	PatientStreet varchar(255) not null,
	PatientState varchar(255) not null,
	PatientCity varchar(255) not null,
	PatientZip varchar(255) not null,
	IsPrimary binary not null,
	PhoneNumber int not null,
	EmailID varchar(255) not null)
	
Create table AllergyTypes
	(AllergyTypeID int not null primary key,)
	allergyname varchar(255) not null,
	description varchar(255) not null)
	
create table PatientAllergies
	(Foreign key(PatientID) references PatientPersonalInfo(PatientID),
	Foreign key(AllergyTypeID) references AllergyTypes(AllergyTypeID)

	
Create table Appointments
	(AppointmentID int not null primary key,
	 Foreign key(PatientID) references PatientPersonalInfo(PatientID),
	 Foreign key(DoctorID) references DoctorInfo(DoctorID),
	 Foreign key(AppointmentTypeID) references AppointmentType(AppointmentTypeID),
	 ProblemDescription varchar (255) not null,
	 Date Date,
	 Time Time)
	
Create Table PatientVisitHistory
	 (Foreign key(AppointmentID) references Appointments(AppointmentID),
	 Temperature int,
	 BloodPressure int, 
	 HeartRate int, 
	 RespiratoryRate int,
	 Height int, 
	 Weight int)

Create Table AppointmentType
	(AppointmentTypeID int not null primary key,
	AppointmentType varchar(255),
	DurationMin int)
	
Create table AdminInformation
	(AdminID int not null primary key,
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
    Foreign key(AddressID) references Address(AddressID),
    DOB Date)
    
Create table DoctorInfo
	(DoctorID int not null primary key,
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	Foreign key(AddressID) references Address(AddressID),
	DOB date)

Create table DoctorSpecialization
	(Foreign key(DoctorID) references DoctorInfo(DoctorID),
	Foreign key(SpecializationID) references Specialization(SpecializationID))

Create Table Specialization
	(SpecializationID int not null primary key,
	 SpecializationName varchar(255) not null)







	
	
	
	
	
	
	
	
	




