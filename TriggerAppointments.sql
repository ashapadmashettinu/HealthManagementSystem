CREATE or ALTER TRIGGER AppointmentsInsertCheckTrigger
ON Appointments
FOR INSERT, UPDATE
AS
BEGIN

IF Exists(select 1 from appointments a 
            join inserted i on a.doctorId= i.doctorId and a.appointmentDate = i.appointmentDate and a.appointmentTime = i.appointmentTime 
            where a.appointmentid not in (i.AppointmentID))
    BEGIN
        ROLLBACK TRAN;
        RAISERROR ('The appointment Date and Time with this doctor is not already booked ! Choose a different Doctor or Date or Time', 16, 1);
    END

END;



-- select *
-- from Appointments

-- update Appointments set AppointmentTime ='15:00' where appointmentId=10


-- DECLARE @outputa int
-- EXECUTE [dbo].[Insert_Update_Appointment] 
--    1000
--   ,1001
--   ,'Out Patient Visit'
--   ,'Fever'
--   ,'2022-05-28'
--   ,'13:00'
--   ,null
--   ,@outputa OUTPUT
