CREATE or ALTER TRIGGER AppointmentsCheckTrigger
ON Appointments
FOR INSERT
AS
BEGIN

DECLARE @prevDate Date;
-- DECLARE @currDate Date;
DECLARE @prevtime Time;
-- DECLARE @currtime Time;
Declare @prevDoc int;
-- Declare @currDoc int;
Declare @prevAppointment int;
-- Declare @currAppointment int;

select @prevAppointment=AppointmentID, @prevDoc = DoctorID, @prevDate = appointmentDate, @prevtime = AppointmentTime  from Inserted;
-- select @currAppointment=AppointmentID, @currDoc = DoctorID, @currDate = appointmentDate, @currtime = AppointmentTime from deleted;

-- select @prevAppointment, @currAppointment, @prevDate, @currDate, @prevtime, @currtime;
-- if ISNULL(@currAppointment,'') =''
-- BEGIN
-- Trigger for inserting
IF Exists(select 1 from appointments where doctorId= @prevDoc and  appointmentDate = @prevDate and appointmentTime = @prevtime and appointmentid not in (@prevAppointment))
    BEGIN
        ROLLBACK TRAN;
        RAISERROR ('The appointment Date and Time with this doctor is not already booked ! Choose a different Doctor or Date or Time', 16, 1);
    END

-- END
-- if @prevtime = @currtime

--     if exists(SELECT 1
--     FROM Appointments
--     where DoctorId=
--     BEGIN
--         ROLLBACK TRAN;
--         RAISERROR ('The appointment Date and Time with this doctor is not already booked ! Choose a different Doctor or Date or Time', 16, 1);
--     END
END;

select *
from Appointments

update Appointments set AppointmentTypeID =1


DECLARE @outputa int
EXECUTE [dbo].[Insert_Update_Appointment] 
   1
  ,1
  ,'Out Patient Visit'
  ,'Fever'
  ,'2022-05-28'
  ,'13:00'
  ,null
  ,@outputa OUTPUT

select * from PatientpersonalInformation

CREATE TRIGGER trig_Salary
ON Employee
FOR UPDATE
AS 
BEGIN
    DECLARE @change float = 0.0;
    DECLARE @diff FLOAT = 0.0;

   

END;
