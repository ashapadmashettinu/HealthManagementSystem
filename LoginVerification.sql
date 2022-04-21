USE HMS;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- execute Login_Verification 1001,'124abert'

CREATE or ALTER PROCEDURE Login_Verification
    (
    @UserID as int,
    @password as varchar(255)
)
AS
BEGIN

    --SET @outputpatientid = @patientid
    OPEN SYMMETRIC KEY HMSSymmetricKey
            DECRYPTION BY CERTIFICATE HMSCertificate;


    IF EXISTS(SELECT 1
    FROM LoginInformation
    WHERE USERID = @UserID and DecryptByKey(password) =@password)
    BEGIN

        INSERT INTO LoginSessions(UserID, SessionTime) Values(@UserID, getDate())

        select UserId, p.FirstName, P.LastName, P.DOB
        from LoginInformation l join PatientPersonalInformation p on p.PatientId = l.UserID where USERId =@UserID

    END
    ELSE
        SELECT Null as [User]
    CLOSE SYMMETRIC KEY HMSSymmetricKey;
END