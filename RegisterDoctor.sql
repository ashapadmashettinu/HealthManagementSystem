-- EXECUTE [dbo].[RegisterDoctor]
-- 	'Asha'
-- 	,'Padmashetti'
-- 	,'1994-12-01'
-- 	,'124abert'
--     ,'Street 13'
--   ,'MA'
--   ,'Boston'
--   ,01223
--   ,8989888384
--   ,'a.p@gmail.com'

CREATE OR ALTER PROCEDURE RegisterDoctor(
    @FirstName as varchar(255),
    @LastName as varchar(255),
    @DOB as date,
    @password as varchar(255),
    @Street varchar(255),
    @State as varchar(255),
    @City as varchar(255),
    @ZipCode as int,
    @PhoneNumber as bigint,
    @emailid as VARCHAR(255) = null,
    @addressLine2 as VARCHAR(255) = null,
    @country as VARCHAR(255) = null
)
AS
BEGIN TRY  
    DECLARE @output VARCHAR(20);
    DECLARE @UserID INT;
    -- Varchar(255)
    -- Checks if user exists and skips the insertion. 
    DECLARE @AddressID int;
    DECLARE @RoleId int;
    EXECUTE dbo.INSERT_UPDATE_ADDRESS @Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2, @Country, null, @AddressID output

    IF ISNULL(@AddressID, '') != ''
    BEGIN
        INSERT INTO DoctorInformation
            (FirstName, LastName, DOB, AddressID)
        values(@FirstName, @LastName, @DOB, @AddressID)

        SET @UserID = SCOPE_IDENTITY()

        SELECT @RoleId = RoleId
        from RolesLookup
        where RoleType = 'Doctor';

        OPEN SYMMETRIC KEY HMSSymmetricKey
        DECRYPTION BY CERTIFICATE HMSCertificate;

        INSERT INTO LoginInformation
            (UserID, [password] ,RoleID)
        VALUES(@UserID, EncryptByKey(Key_GUID('HMSSymmetricKey'), @password) , @RoleId)
        CLOSE SYMMETRIC KEY HMSSymmetricKey;
        --INSERT INTO LoginSessions(UserID, Time)VALUES(@UserID, getDate())

        SET @output =  @UserID;
    END
     select @output
END TRY  
BEGIN CATCH  
    SELECT ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
