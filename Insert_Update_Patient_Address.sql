CREATE or ALTER PROCEDURE INSERT_UPDATE_PATIENT_ADDRESS
(   @Street  as varchar(255),
	@State as varchar(255),
	@City as varchar(255),
	@ZipCode  as int,
	@PhoneNumber as int,
    @emailid as VARCHAR(255) = null,
    @addressLine2 as varchar(255) = null,
    @addressid as int = null,
    @outputaddressid int OUTPUT) 
AS BEGIN 
    SET @outputaddressid = @addressid
    IF isnull(@addressid,'') = ''
        BEGIN
            Insert into PatientAddress(Street, [State], City, ZipCode, PhoneNumber, EmailID, Addressline2)
             values(@Street, @State, @City, @ZipCode, @PhoneNumber, @emailid, @addressLine2)

            SET @outputaddressid = SCOPE_IDENTITY()
            return @outputaddressid
        END
    ELSE    
        BEGIN
            if exists(select 1 from PatientAddress where AddressID=@addressid)
                BEGIN
                    update PatientAddress 
                    set Street = ISNULL(@Street, Street),
                    [State] = ISNULL(@State,[State]), 
                    City = ISNULL(@City, City),
                    ZipCode = ISNULL(@ZipCode, ZipCode),
                    PhoneNumber = ISNULL(@PhoneNumber, PhoneNumber),
                    EmailID = ISNULL(@emailid, EmailID), 
                    AddressLine2 = ISNULL(@addressLine2, AddressLine2)
                     where AddressID = @addressid
                END
            return @outputaddressid
        END
    
END 
GO

execute INSERT_UPDATE_PATIENT_ADDRESS 'Str1'