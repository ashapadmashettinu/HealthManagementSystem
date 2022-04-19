USE HMS;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROCEDURE INSERT_UPDATE_PATIENT_PRIMARY_CONTACT
(
	@fullname as varchar(255),
	@phonenumber as bigint,
	@patientid as int
)
AS BEGIN

--SET @outputpatientid = @patientid

IF EXISTS(SELECT 1 FROM PatientPrimaryContact WHERE PatientID = @patientid)
		   UPDATE PatientPrimaryContact 
		   set fullname = ISNULL(@fullname, fullname),
			   phonenumber = ISNULL(@phonenumber, phonenumber)
		   where PatientID = @patientid

		   ELSE 
			INSERT INTO PatientPrimaryContact VALUES (@patientid,@fullname, @phonenumber);
END