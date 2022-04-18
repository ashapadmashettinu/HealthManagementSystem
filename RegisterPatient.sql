CREATE PROCEDURE RegisterPatient(
    @VerificationID as int,
	@FirstName as varchar(255),
	@LastName as varchar(255),
	@DOB as date,
    @password as varchar(255), 
    @Street varchar(255),
	@State as varchar(255),
	@City as varchar(255),
	@ZipCode as int,
	@PhoneNumber as int,
    @emailid as VARCHAR(255) = null,
    @addressLine2 as varchar(255) = null,
    @addressid as int = null)
AS BEGIN

DECLARE @output VARCHAR(20);
DECLARE @UserID Varchar(255)
-- Checks if user exists and skips the insertion. 
IF EXISTS(SELECT 1 FROM users WHERE VerificationID = @VerificationID)
    SET @output = 'User already exists';
ELSE
    DECLARE @AddressID int;
    EXECUTE dbo.INSERT_UPDATE_PATIENT_ADDRESS @Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2, @AddressID output

    INSERT INTO PatientPersonalInformation(VerificationID, FirstName, LastName, DOB) 
    values(@VerificationID, @FirstName, @LastName, @DOB)

    SET @output =  "User Registered"; 
END IF;




END