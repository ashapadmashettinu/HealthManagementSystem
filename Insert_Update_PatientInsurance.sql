USE HMS;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
