ALTER TABLE PatientPersonalInformation
ADD CONSTRAINT Unique_VerificatioID UNIQUE (VerificationID);


ALTER TABLE [dbo].[LoginInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_Login_Doctor] FOREIGN KEY(UserID)
REFERENCES [dbo].[DoctorInformation] (DoctorID)
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[LoginInformation] NOCHECK CONSTRAINT [FK_Login_Doctor]
GO
ALTER TABLE [dbo].[LoginInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_Login_Admin] FOREIGN KEY(UserID)
REFERENCES [dbo].[AdminInformation] (AdminID)
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[LoginInformation] NOCHECK CONSTRAINT [FK_600_WorkComments_employees_sn]
GO

ALTER TABLE [dbo].[LoginInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_Login_Patient] FOREIGN KEY(UserID)
REFERENCES [dbo].[PatientPersonalInformation] (PatientID)
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[LoginInformation] NOCHECK CONSTRAINT [FK_600_WorkComments_employees_sn]
GO