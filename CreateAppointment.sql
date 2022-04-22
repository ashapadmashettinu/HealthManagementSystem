--Example  of Execution
-- --select * from  uf_GetDoctorsByNameAndSpecialization('General', 'Ash') -- gets the doctor id and spec id.
DECLARE @outputa int
EXECUTE [dbo].[Insert_Update_Appointment] 
   1000
  ,1001
  ,'Out Patient Visit'
  ,'Fever'
  ,'2022-05-28'
  ,'13:00'
  ,null
  ,@outputa OUTPUT

CREATE or ALTER PROCEDURE Insert_Update_Appointment
(   @patientid  as varchar(255),
	@doctorID as varchar(255),
	@appointmenttype as varchar(255) = 'Out Patient Visit',
    @problemdescription as varchar(255),
    @Date as date,
    @time as time,
    @appointmentId as int,
    @appointmentidOutput int OUTPUT
) 
AS BEGIN  
BEGIN TRY
    DECLARE @appointmentTypeID int;
    Select @appointmentTypeID = AppointmentTypeID from AppointmentType where AppointmentType = @appointmenttype;

    set @appointmentidOutput = @appointmentID

    IF Isnull(@appointmentID,'') != '' or exists(select 1 from Appointments where AppointmentId = @appointmentID)
       BEGIN
            update Appointments 
            set DoctorID = ISNULL(@doctorID, DoctorID),
            AppointmentTypeID = ISNULL(@appointmentTypeID, AppointmentTypeID), 
            ProblemDescription = ISNULL(@problemdescription, ProblemDescription),
            AppointmentDate = ISNULL(@Date, AppointmentDate),
            AppointmentTime = ISNULL(@time, AppointmentTime)
            where appointmentID = @appointmentID and PatientId = @patientid

            select @appointmentidOutput as ApointmentID
        END
    ELSE    
        BEGIN
            Insert into Appointments(PatientId, DoctorID, AppointmentTypeID, ProblemDescription, AppointmentDate, AppointmentTime)
             values(@patientid, @doctorID, @appointmentTypeID, @problemdescription, @Date, @time)

            SET @appointmentidOutput = SCOPE_IDENTITY()
            select @appointmentidOutput as ApointmentID
        END       
    END TRY
    BEGIN CATCH
        select ERROR_MESSAGE() as ErrorMessage;
    END CATCH 
END


-- EXECUTE [dbo].[Insert_Update_Appointment] 
--    1000
--   ,1001
--   ,'Out Patient Visit'
--   ,'Fever'
--   ,'2022-05-28'
--   ,'13:00'
--   ,null
--   ,@outputa OUTPUT