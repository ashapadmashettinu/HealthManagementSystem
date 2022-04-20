USE HMS;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROCEDURE INSERT_Patient_Allergies
(
	 @PatientID INT,
     @AllergyTypeID INT
)
AS BEGIN
DECLARE @output VARCHAR(20);
BEGIN
        SET @output=@PatientID;
        INSERT INTO PatientAllergies VALUES (@PatientID,@AllergyTypeID);
        select @output as UserID
END
END