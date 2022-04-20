USE HMS;

DROP FUNCTION IF EXISTS calculateAge;
Create function calculateAge(@DateOfBirth date) 
returns int 
as 
Begin 
	IF MONTH(@DateOfBirth) = MONTH(getdate()) and day(@DateOfBirth)>day(getdate()) 
		return datediff(MONTH,@DateOfBirth, getdate())/12 - 1
	return datediff(MONTH,@DateOfBirth, getdate())/12
End


SELECT PatientID,
	   FirstName,
	   LastName,
	   dbo.calculateAge(DOB) AS Age
FROM PatientPersonalInformation