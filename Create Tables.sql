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
AppointmentType
Address
AdminInformation
DoctorInformation
Login Information
Login Sessions
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
DROP TABLE IF EXISTS PatientInsurance;
DROP TABLE IF EXISTS PatientPrimaryContact;
DROP TABLE IF EXISTS PatientWishlistPharmacy;
DROP TABLE IF EXISTS PharmacyLookup;
DROP TABLE IF EXISTS PatientAllergies;
DROP TABLE IF EXISTS AllergyTypes;
DROP TABLE IF EXISTS LoginSessions;
DROP TABLE IF EXISTS LoginInformation;
DROP TABLE IF EXISTS RolesLookup;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS AppointmentType;
DROP TABLE IF EXISTS PatientPersonalInformation;
DROP TABLE IF EXISTS AdminInformation;
DROP TABLE IF EXISTS DoctorInformation;
DROP TABLE IF EXISTS PatientAddress;
DROP TABLE IF EXISTS PatientVisitHistory;
DROP TABLE IF EXISTS DoctorSpecialization;
DROP TABLE IF EXISTS Specialization;
DROP TABLE IF EXISTS [Address];


CREATE TABLE PatientAddress 
  (
     addressid   INT IDENTITY NOT NULL PRIMARY KEY,
     street      VARCHAR(255) NOT NULL,
     [state]     VARCHAR(255) NOT NULL,
     city        VARCHAR(255) NOT NULL,
     zipcode     INT NOT NULL,
     phonenumber BIGINT NOT NULL,
     emailid     VARCHAR(255) NOT NULL
  ); 


CREATE TABLE PatientPersonalInformation
  (
     patientid      INT NOT NULL PRIMARY KEY,
     verificationid INT NOT NULL,--Must be unique
     firstname      VARCHAR(255) NOT NULL,
     lastname       VARCHAR(255) NOT NULL,
     dob            DATE NOT NULL,
     addressid      INT NOT NULL 
	 FOREIGN KEY REFERENCES dbo.patientaddress(addressid)
  ); 


CREATE TABLE PatientInsurance
  (
     insuranceid       INT IDENTITY NOT NULL PRIMARY KEY,
     patientid         INT FOREIGN KEY REFERENCES patientpersonalinformation(
     patientid),
     insuranceprovider VARCHAR(255) NOT NULL
  ); 
	
CREATE TABLE PatientPrimaryContact
  (
     patientid   INT IDENTITY NOT NULL PRIMARY KEY,
          FOREIGN KEY(patientid) REFERENCES PatientPersonalInformation(patientid
     ),
     fullname    VARCHAR(255) NOT NULL,
     phonenumber INT NOT NULL
  ); 
	

CREATE TABLE PharmacyLookup
  (
     pharmacyid         INT NOT NULL PRIMARY KEY,
     pharmacyname       VARCHAR(255) NOT NULL,
     pharmacystreetname VARCHAR(255) NOT NULL,
     pharmacystate      VARCHAR(255) NOT NULL,
     pharmacycity       VARCHAR(255) NOT NULL,
     pharmacyzip        INT NOT NULL,
     contactnumber      INT NOT NULL
  );


CREATE TABLE PatientWishlistPharmacy
  (
     patientid  INT IDENTITY NOT NULL,
     pharmacyid INT NOT NULL,
     PRIMARY KEY CLUSTERED ( patientid, pharmacyid),
     FOREIGN KEY(patientid) REFERENCES PatientPersonalInformation(patientid),
     FOREIGN KEY(pharmacyid) REFERENCES PharmacyLookup(pharmacyid)
  ); 
	

CREATE TABLE AllergyTypes
  (
     allergytypeid INT IDENTITY NOT NULL PRIMARY KEY,
     allergyname   VARCHAR(255) NOT NULL,
     [description] VARCHAR(255) NOT NULL
  ); 


CREATE TABLE PatientAllergies
  (
     patientid     INT NOT NULL,
     allergytypeid INT NOT NULL,
     PRIMARY KEY CLUSTERED ( patientid, allergytypeid),
     FOREIGN KEY(patientid) REFERENCES PatientPersonalInformation(patientid),
     FOREIGN KEY(allergytypeid) REFERENCES AllergyTypes(allergytypeid)
  ); 


CREATE TABLE RolesLookup
  (
     roleid   INT IDENTITY NOT NULL PRIMARY KEY,
     roletype VARCHAR(255) NOT NULL
  ); 

CREATE TABLE AppointmentType
  (
     appointmenttypeid INT NOT NULL PRIMARY KEY,
     appointmenttype   VARCHAR(255),
     durationmin       INT
  ); 


CREATE TABLE [Address]
  (
     addressid    INT IDENTITY NOT NULL PRIMARY KEY,
     street       VARCHAR(255) NOT NULL,
     addressline2 VARCHAR(255) NOT NULL,
     city         VARCHAR(255) NOT NULL,
     state        VARCHAR(255) NOT NULL,
     country      VARCHAR(255) NOT NULL,
     zipcode      INT NOT NULL,
     phonenumber  INT NOT NULL,
     emailid      VARCHAR(255) NOT NULL
  ); 


CREATE TABLE AdminInformation
  (
     adminid   INT NOT NULL PRIMARY KEY,
     firstname VARCHAR(255) NOT NULL,
     lastname  VARCHAR(255) NOT NULL,
     dob       DATE,
     addressid INT NOT NULL 
	 FOREIGN KEY REFERENCES dbo.Address(addressid)
  ); 
  	

CREATE TABLE DoctorInformation
  (
     doctorid  INT NOT NULL PRIMARY KEY,
     firstname VARCHAR(255) NOT NULL,
     lastname  VARCHAR(255) NOT NULL,
     dob       DATE,
     addressid INT NOT NULL 
	 FOREIGN KEY REFERENCES dbo.Address(addressid)
  ); 


CREATE TABLE LoginInformation
  (
     userid   INT NOT NULL PRIMARY KEY,
          FOREIGN KEY(userid) REFERENCES PatientPersonalInformation(patientid),
          FOREIGN KEY(userid) REFERENCES AdminInformation(adminid),
          FOREIGN KEY(userid) REFERENCES DoctorInformation(doctorid),
     [password] VARCHAR(255) NOT NULL, --EncryptByKey(Key_GUID(N'HMSSymmetricKey'), convert(varbinary, password))
     roleid   INT NOT NULL FOREIGN KEY REFERENCES dbo.RolesLookup(roleid)
  ); 


CREATE TABLE LoginSessions
  (
     sessionid   INT IDENTITY NOT NULL PRIMARY KEY,
     sessiontime DATE NOT NULL,
     userid      INT NOT NULL 
	 FOREIGN KEY REFERENCES dbo.LoginInformation(userid)
  ); 
	


CREATE TABLE Appointments
  (
     appointmentid      INT IDENTITY NOT NULL PRIMARY KEY,
     patientid          INT 
	 FOREIGN KEY REFERENCES PatientPersonalInformation(patientid),
     doctorid           INT 
	 FOREIGN KEY REFERENCES DoctorInformation(doctorid),
     appointmenttypeid  INT 
		FOREIGN KEY REFERENCES AppointmentType(appointmenttypeid),
     problemdescription VARCHAR (255) NOT NULL,
     appointmentdate    DATE,
     appointmenttime    TIME
  ); 
	
CREATE TABLE PatientVisitHistory
  (
     appointmentid   INT 
		FOREIGN KEY REFERENCES Appointments(appointmentid),
     temperature     FLOAT,
     bloodpressure   INT,
     heartrate       INT,
     respiratoryrate INT,
     height          FLOAT,
     [weight]        FLOAT
  ); 


	
CREATE TABLE Specialization
  (
     specializationid   INT IDENTITY NOT NULL PRIMARY KEY,
     specializationname VARCHAR(255) NOT NULL
  );

CREATE TABLE DoctorSpecialization
  (
     doctorid         INT NOT NULL,
     specializationid INT NOT NULL,
     PRIMARY KEY CLUSTERED ( doctorid, specializationid),
     FOREIGN KEY(doctorid) REFERENCES DoctorInformation(doctorid),
     FOREIGN KEY(specializationid) REFERENCES Specialization(specializationid)
  ); 


