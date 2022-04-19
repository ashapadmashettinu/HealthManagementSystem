USE HMS;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROCEDURE INSERT_UPDATE_PATIENT_INSURANCE
(
	
	@insuranceid as int,
	@patientid as int,
	@provider as varchar(255),
)
AS BEGIN


IF EXISTS(SELECT 1 FROM PatientInsurance WHERE PatientID = @patientid)
		   UPDATE PatientInsurance 
		   set InsuranceId = ISNULL(@insuranceid, InsuranceId),
			   InsuranceProvider = ISNULL(@provider, InsuranceProvider)
		   where PatientID = @patientid

		   ELSE 
			INSERT INTO PatientInsurance (InsuranceId,PatientId,InsuranceProvider)
				VALUES (@insuranceid,@patientid, @provider);
END
