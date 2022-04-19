-- --to execute
-- EXECUTE [dbo].[RegisterPatient]
--     434333456
-- 	,'Asha'
-- 	,'Padmashetti'
-- 	,'1994-12-01'
-- 	,'1234qwert'
--     ,'Street 13'
--   ,'MA'
--   ,'Boston'
--   ,01223
--   ,8989888384
--   ,'a.p@gmail.com'

CREATE OR ALTER PROCEDURE RegisterPatient(
    @VerificationID as int,
    @FirstName as varchar(255),
    @LastName as varchar(255),
    @DOB as DATE,
    @password as varchar(255),
    @Street varchar(255),
    @State as varchar(255),
    @City as varchar(255),
    @ZipCode as int,
    @PhoneNumber as BigInt,
    @emailid as VARCHAR(255) = null,
    @PharmacyID int =null,
    @AllergyId int =null
)
AS
BEGIN

BEGIN TRY  
  
    DECLARE @output VARCHAR(20);
    DECLARE @UserID INT;
    -- Varchar(255)
    -- Checks if user exists and skips the insertion. 

    IF EXISTS(SELECT 1
    FROM PatientPersonalInformation
    WHERE VerificationID = @VerificationID)
    BEGIN
        --select 'hetg 1' + @VerificationID
        SELECT @UserID = PatientID
        FROM PatientPersonalInformation
        WHERE VerificationID = @VerificationID
        SET @output = @UserID
    END
ELSE
BEGIN
        DECLARE @AddressID int;
        DECLARE @RoleId int;
        EXECUTE dbo.INSERT_UPDATE_PATIENT_ADDRESS @Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, null, @AddressID output

        IF ISNULL(@AddressID,'') != ''
    BEGIN
            INSERT INTO PatientPersonalInformation
                (VerificationID, FirstName, LastName, DOB, AddressID)
            values(@VerificationID, @FirstName, @LastName, @DOB, @AddressID)

            SET @UserID = SCOPE_IDENTITY()

            SELECT @RoleId = RoleId
            from RolesLookup
            where RoleType = 'Patient';

            OPEN SYMMETRIC KEY HMSSymmetricKey
            DECRYPTION BY CERTIFICATE HMSCertificate;

            INSERT INTO LoginInformation
                (UserID, password ,RoleID)
            VALUES(@UserID, EncryptByKey(Key_GUID(N'HMSSymmetricKey'), @password) , @RoleId)

            CLOSE SYMMETRIC KEY HMSSymmetricKey;

            --INSERT INTO LoginSessions(UserID, Time)VALUES(@UserID, getDate())

            -- EXECUTE Allergy, Wishlist, Insurance

            SET @output =  @UserID;
        END
    END;
    select @output as UserID

END TRY  
BEGIN CATCH  
    
    SELECT ERROR_MESSAGE() AS ErrorMessage;  

END CATCH; 
END
