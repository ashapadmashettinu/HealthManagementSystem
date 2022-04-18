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
Appointments
PatientVisitHistory
AdminInformation
DoctorInformation
Address
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


Create table PatientAddress 
	(
	AddressID int not null primary key,
	Street varchar(255) not null,
	[State] varchar(255) not null,
	City varchar(255) not null,
	ZipCode int not null,
	PhoneNumber int not null,
	EmailID varchar(255) not null
	);


create Table PatientPersonalInformation
	(
	PatientID int not null primary key,
	VerificationID int not null,  --Must be unique
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	DOB date not null,
	AddressID int  NOT NULL FOREIGN KEY
        REFERENCES dbo.PatientAddress(AddressID)
	);



Create Table PatientInsurance
	(
	InsuranceID int not null primary key,
	PatientID int Foreign key 
		references PatientPersonalInfo(PatientID),
	InsuranceProvider varchar(255) not null
	);
	

Create table PatientPrimaryContact
	(
	PatientID int 
	Primary Key (PatientID),
	Foreign key (PatientID)
		references PatientPersonalInfo(PatientID),
	FullName varchar(255) not null,
	PhoneNumber int not null
	);
	

Create Table PharmacyLookup
	(
	PharmacyID int not null primary key,
	PharmacyName varchar(255) not null,
	PharmacyStreetName varchar(255) not null,
	PharmacyState varchar(255) not null,
	PharmacyCity varchar(255) not null,
	PharmacyZip int not null,
	ContactNumber int not null
	);


Create Table PatientWishlistPharmacy
    (
	PatientID int Foreign key 
		references PatientPersonalInfo(PatientID),
	PharmacyID int Foreign key 
		references PharmacyLookup(PharmacyID)
	);
	

Create table AllergyTypes
	(
	AllergyTypeID int not null primary key,
	Allergyname varchar(255) not null,
	[Description] varchar(255) not null
	);


create table PatientAllergies
	(
	PatientID int Foreign key 
		references PatientPersonalInfo(PatientID),
	AllergyTypeID int Foreign key
		references AllergyTypes(AllergyTypeID)
	);



Create Table RolesLookup
	(
	RoleID Int not null primary key,
	RoleType varchar(255) not null
	);

Create Table LoginInformation
	(
	UserID int not null primary key,
	password varchar(255) not null,  -- EncryptByKey(Key_GUID(N'HMSSymmetricKey'), convert(varbinary, password))
	RoleID int NOT NULL FOREIGN KEY
        REFERENCES dbo.RolesLookup(RoleID)
	);


Create Table LoginSessions
	(
	SessionID int not null primary key,
	SessionTime Date  not null,
	UserID int NOT NULL FOREIGN KEY
        REFERENCES dbo.LoginInformation(UserID)
	);
	


Create Table AppointmentType
	(
	AppointmentTypeID int not null primary key,
	AppointmentType varchar(255),
	DurationMin int
	);

Create table Appointments
	(
	 AppointmentID int not null primary key,
	 PatientID int Foreign key 
		references PatientPersonalInfo(PatientID),
     DoctorID int Foreign key 
		references  DoctorInfo(DoctorID),
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
	 Temperature float,
	 BloodPressure int, 
	 HeartRate int, 
	 RespiratoryRate int,
	 Height float, 
	 [Weight] float
	 );



Create table AdminInformation
	(
	AdminID int not null primary key,
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	DOB Date,
    AddressID int  NOT NULL FOREIGN KEY
        REFERENCES dbo.Address(AddressID)
    );
  	

Create table DoctorInformation
	(
	DoctorID int not null primary key,
	FirstName varchar(255) not null,
	LastName varchar(255) not null,
	DOB date,
	AddressID int  NOT NULL FOREIGN KEY
        REFERENCES dbo.Address(AddressID)
	);


Create table [Address] 
	(
	AddressID int not null primary key,
	Street varchar(255) not null,
	AddressLine2 varchar(255) not null,
	City varchar(255) not null,
	State varchar(255) not null,
	Country varchar(255) not null,
	ZipCode int not null,
	PhoneNumber int not null,
	EmailID varchar(255) not null
	);

	
Create Table Specialization
	(
	SpecializationID int not null primary key,
	SpecializationName varchar(255) not null
	);


Create table DoctorSpecialization
	(
	DoctorID int Foreign key
		references DoctorInfo(DoctorID),
	SpecializationID int Foreign key
		references Specialization(SpecializationID)
	);
	

















	
	
	
	
	
	
	
	
	




