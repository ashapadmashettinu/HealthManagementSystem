create or alter function ufUserExists (@userId int)
returns int
begin
   if exists(SELECT 1 from AdminInformation where AdminID = @userId)
    return 1;
    else if exists(SELECT 1 from DoctorInformation where DoctorId = @userId)
    return 1;
    else if exists(SELECT 1 from PatientPersonalInformation where PatientID = @userId)
    return 1;
    ELSE
    return 0;
    return 0;
end

alter table LoginInformation add CONSTRAINT FK_Login_Constraint CHECK (dbo.ufUserExists 
(UserID) = 1);