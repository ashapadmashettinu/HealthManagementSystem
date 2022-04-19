--Example  of Execution

-- DECLARE @outputa int

-- -- TODO: Set parameter values here.

-- EXECUTE [dbo].[INSERT_UPDATE_PATIENT_ADDRESS] 
--    'Street 13'
--   ,'MA'
--   ,'Boston'
--   ,01223
--   ,8989888384
--   ,'a.p@gmail.com'
--   ,null
--   ,@outputa OUTPUT


CREATE or ALTER PROCEDURE INSERT_UPDATE_PATIENT_ADDRESS
(   @Street  as varchar(255),
	@State as varchar(255),
	@City as varchar(255),
	@ZipCode  as int,
	@PhoneNumber as BIGINT,
    @emailid as VARCHAR(255) = null,
    @addressid as int = null,
    @outputaddressid int OUTPUT) 
AS BEGIN 
    -- TRY
    -- BEGIN
    SET @outputaddressid = @addressid
    IF exists(select 1 from PatientAddress where AddressID=@addressid)
       BEGIN
            update PatientAddress 
            set Street = ISNULL(@Street, Street),
            [State] = ISNULL(@State,[State]), 
            City = ISNULL(@City, City),
            ZipCode = ISNULL(@ZipCode, ZipCode),
            PhoneNumber = ISNULL(@PhoneNumber, PhoneNumber),
            EmailID = ISNULL(@emailid, EmailID)
            where AddressID = @addressid

            select @outputaddressid
        END
    ELSE    
        BEGIN
            Insert into PatientAddress(Street, [State], City, ZipCode, PhoneNumber, EmailID)
             values(@Street, @State, @City, @ZipCode, @PhoneNumber, @emailid)

            SET @outputaddressid = SCOPE_IDENTITY()
            select @outputaddressid
        END
        
                
    -- END
    -- CATCH
    --     return "Error Occured";
    -- END
END 
GO


---