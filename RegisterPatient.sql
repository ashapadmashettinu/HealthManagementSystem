CREATE OR ALTER PROCEDURE RegisterPatient(
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
    @PharmacyID int =null,
    @AllergyId int =null
    )
AS BEGIN

DECLARE @output VARCHAR(20);
DECLARE @UserID INT; -- Varchar(255)
-- Checks if user exists and skips the insertion. 
IF EXISTS(SELECT 1  FROM PatientPersonalInformation WHERE VerificationID = @VerificationID)
    BEGIN
    SELECT @UserID = PatientID  FROM PatientPersonalInformation WHERE VerificationID = @VerificationID
    SET @output = @UserID
    END
ELSE
BEGIN
    DECLARE @AddressID int;
    DECLARE @RoleId int;
    EXECUTE dbo.INSERT_UPDATE_PATIENT_ADDRESS @Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @AddressID output

    INSERT INTO PatientPersonalInformation(VerificationID, FirstName, LastName, DOB, AddressID) 
    values(@VerificationID, @FirstName, @LastName, @DOB, @AddressID)

    SET @UserID = SCOPE_IDENTITY()

    SELECT @RoleId = RoleId from RolesLookup where RoleType = 'Patient';

    INSERT INTO LoginInformation(UserID, password ,RoleID) VALUES(@UserID, EncryptByKey(Key_GUID(N'TestSymmetricKey'), @password) , @RoleId)

    --INSERT INTO LoginSessions(UserID, Time)VALUES(@UserID, getDate())

    -- EXECUTE Allergy, Wishlist, Insurance

    SET @output =  @UserID; 
END;
select @output

END