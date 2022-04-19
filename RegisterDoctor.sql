CREATE OR ALTER PROCEDURE RegisterDoctor(
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
    @addressLine2 as VARCHAR(255) = null
    )
AS BEGIN

DECLARE @output VARCHAR(20);
DECLARE @UserID INT; -- Varchar(255)
-- Checks if user exists and skips the insertion. 
    DECLARE @AddressID int;
    DECLARE @RoleId int;
    EXECUTE dbo.INSERT_UPDATE_ADDRESS @Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2, @AddressID output

    INSERT INTO DoctorInformation(FirstName, LastName, DOB, AddressID) 
    values(@FirstName, @LastName, @DOB, @AddressID)

    SET @UserID = SCOPE_IDENTITY()

    SELECT @RoleId = RoleId from RolesLookup where RoleType = 'Patient';

    INSERT INTO LoginInformation(UserID, password ,RoleID) VALUES(@UserID, EncryptByKey(Key_GUID(N'TestSymmetricKey'), @password) , @RoleId)

    --INSERT INTO LoginSessions(UserID, Time)VALUES(@UserID, getDate())

    SET @output =  @UserID; 

select @output

END