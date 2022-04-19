USE HMS;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Example  of Execution

DECLARE @outputa int

-- TODO: Set parameter values here.

EXECUTE [dbo].[INSERT_UPDATE_ADDRESS] 
   'Street 13'
  ,'MA'
  ,'Boston'
  ,01223
  ,8989888384
  ,'a.p@gmail.com'
  ,null
  ,null
  ,@outputa OUTPUT


CREATE or ALTER PROCEDURE [dbo].[INSERT_UPDATE_ADDRESS]
(   @Street  as varchar(255),
	@State as varchar(255),
	@City as varchar(255),
	@ZipCode  as int,
	@PhoneNumber as BigInt,
    @emailid as VARCHAR(255) = null,
    @addressLine2 as varchar(255) = null,
    @addressid as int = null,
    @outputaddressid int OUTPUT) 
AS BEGIN 
    SET @outputaddressid = @addressid
    IF isnull(@addressid,'') = ''
        BEGIN
            Insert into [Address](Street, [State], City, ZipCode, PhoneNumber, EmailID, Addressline2)
             values(@Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2)

            SET @outputaddressid = SCOPE_IDENTITY()
            return @outputaddressid
        END
    ELSE    
        BEGIN
            if exists(select 1 from [Address] where AddressID=@addressid)
                BEGIN
                    update [Address]
                    set Street = ISNULL(@Street, Street),
                    [State] = ISNULL(@State,[State]), 
                    City = ISNULL(@City, City),
                    ZipCode = ISNULL(@ZipCode, ZipCode),
                    PhoneNumber = ISNULL(@PhoneNumber, PhoneNumber),
                    EmailID = ISNULL(@emailid, EmailID), 
                    [AddressLine2] = ISNULL(@addressLine2, [AddressLine2])
                     where AddressID = @addressid
                END
            return @outputaddressid
        END
    
END 
GO
