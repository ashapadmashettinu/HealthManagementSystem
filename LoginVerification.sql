USE HMS;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- execute Login_Verification 2,'1234qwert'

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

        select UserId, p.FirstName, P.LastName, P.DOB
        from LoginInformation l join PatientPersonalInformation p on p.PatientId = l.UserID
    END
    CLOSE SYMMETRIC KEY HMSSymmetricKey;
END


