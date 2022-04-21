USE HMS;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON;
-- EXECUTE [dbo].[INSERT_Patient_Visit_History]
--       1
--       ,101
--       ,150
--       ,120
--       ,6
--       ,5.8
--       ,59.75
GO;

CREATE or ALTER PROCEDURE INSERT_Patient_Visit_History
(
     @AppointmentID INT,
     @Temperature float,
     @BloodPressure INT,
     @HeartRate INT,
     @RespiratoryRate INT,
     @Height float,
     @Weight float
)
AS BEGIN
DECLARE @output VARCHAR(20);

	IF Isnull(@appointmentID,'') != '' or exists(select 1 from PatientVisitHistory where AppointmentId = @AppointmentID)
       BEGIN
			SET @output= @AppointmentID;
            update PatientVisitHistory 
            set 
            Temperature = ISNULL(@Temperature, Temperature), 
            BloodPressure = ISNULL(@BloodPressure, BloodPressure),
            HeartRate = ISNULL(@HeartRate, HeartRate),
            RespiratoryRate = ISNULL(@RespiratoryRate, RespiratoryRate),
			Height = ISNULL(@Height, Height),
			[Weight] = ISNULL(@Weight, Weight)
            where AppointmentID = @AppointmentID
            select @output as ApointmentID
        END
	ELSE
		BEGIN
				SET @output= @AppointmentID;
				INSERT INTO PatientVisitHistory(AppointmentID,Temperature,BloodPressure,HeartRate,RespiratoryRate,Height,Weight)
				VALUES (@AppointmentID,@Temperature,@BloodPressure,@HeartRate,@RespiratoryRate,@Height,@Weight);
				select @output as AppointmentID
		END
END
