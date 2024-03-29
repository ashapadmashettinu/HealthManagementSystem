-- Encrypt Table Columns
-- Demo different data types
-- Create New DB

/*
----Order of Tables----
Patient Address
Patient personal information
Patient Insurance
Patient Primary Contact
Pharmacy Lookup
PatientWhishlistPharmacy
AllergyTypes
PatientAllergies
Roles Lookup
Login Information
Login Sessions
AppointmentType
Address
AdminInformation
DoctorInformation
Appointments
PatientVisitHistory
DoctorSpecialization
Specialization
*/

CREATE DATABASE HMS;

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


USE HMS;

----Do not remove this statements--------------

/* Lookup tables (Static Data) */
--drop table if exists PharmacyLookup;
-- drop table if exists Specialization;
-- drop table if exists AllergyTypes;
-- drop table if exists RolesLookup;
-- drop table if exists AppointmentType;

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
	

