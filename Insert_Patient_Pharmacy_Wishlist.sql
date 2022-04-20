USE HMS;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
