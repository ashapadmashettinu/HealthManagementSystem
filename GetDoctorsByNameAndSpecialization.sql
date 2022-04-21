-- -- Example  of Execution
-- select * from  uf_GetDoctorsByNameAndSpecialization('General', 'Ash')

CREATE or alter FUNCTION uf_GetDoctorsByNameAndSpecialization  
(@specialization  as varchar(255),
 @doctorName as varchar(255)) 
RETURNS @table TABLE
(
    DoctorID int,
    FIRSTName varchar(255),
    LastName varchar(255),
    SpecializationId int,
    SpecializationName VARCHAR(255) 
)
AS BEGIN
    INSERT into @table
    SELECT d.DoctorID,  FIRSTName, LASTName, ds.SpecializationID, SpecializationName
        FROM DoctorInformation d
        JOIN DoctorSpecialization ds on d.DoctorID = ds.DoctorID
        JOIN Specialization s on s.SpecializationID = ds.SpecializationID
        WHERE FirstName like  @doctorName +'%' or LastName like  @doctorName +'%'
        ORDER BY FirstName, LastName;
        return 
END
