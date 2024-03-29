use HMS_Team4;

DECLARE @outputa int
EXECUTE [dbo].[RegisterPatient]
	25212, 'Alexi', 'Gemson', '1987-11-16', 'fP0UbM', 'Erie', 'Georgia', 'Atlanta', '30323', 6784497970, 'agemson0@bravesites.com', 'Alexi Gemson', 2105784182, 3, 8, 'Bode-Schuster';
EXECUTE [dbo].[RegisterPatient]
	35851, 'Sadella', 'Cubberley', '1996-11-20', 'cX2ZCJHCosM', 'Warrior', 'Texas', 'Amarillo', '79116', 8063366118, 'scubberley1@yale.edu', 'Sadella Cubberley', 5022582792, 4, 1, 'Prohaska Group';
EXECUTE [dbo].[RegisterPatient]
	65587, 'Bibby', 'Ferreiro', '1993-11-03', 'ujX1W8', 'Sutherland', 'Florida', 'Naples', '34102', 9419596207, 'bferreiro2@blogger.com', 'Bibby Ferreiro', 5638956520, 2, 5, 'Daugherty, Roob and Dicki';
EXECUTE [dbo].[RegisterPatient]
	65847, 'Lissi', 'Haglinton', '1964-09-11', '9Erf0QE4Zs2U', 'Lighthouse Bay', 'Illinois', 'Schaumburg', '60193', 8474180638, 'lhaglinton3@illinois.edu', 'Lissi Haglinton', 5208114461, 10, 2, 'Lubowitz-Cummings';
EXECUTE [dbo].[RegisterPatient]
	17220, 'Maryanna', 'De Zamudio', '2000-05-25', 'RSZbj6hAI', 'Jenna', 'Florida', 'Miami', '33129', 7865969303, 'mde4@msn.com', 'Maryanna De Zamudio', 9102294396, 3, 7, 'Hermiston and Sons';
EXECUTE [dbo].[RegisterPatient]
	26168, 'Shani', 'Linebarger', '1974-11-30', 'PA5E1O', 'Chinook', 'Indiana', 'Fort Wayne', '46852', 2607686951, 'slinebarger5@samsung.com', 'Shani Linebarger', 2021665175, 6, 4, 'Romaguera-Bechtelar';
EXECUTE [dbo].[RegisterPatient]
	74569, 'Ava', 'Bennike', '1976-07-16', 'v6YClOzl', 'Kipling', 'Florida', 'Bonita Springs', '34135', 9419348313, 'abennike6@marriott.com', 'Ava Bennike', 4341494277, 9, 9, 'Rohan-Koelpin';
EXECUTE [dbo].[RegisterPatient]
	96607, 'Nessy', 'Martinets', '1993-08-04', 'FEFgYHh', 'Fisk', 'Utah', 'Salt Lake City', '84115', 8011916388, 'nmartinets7@smugmug.com', 'Nessy Martinets', 2534154725, 10, 2, 'Veum, Crona and Ullrich';
EXECUTE [dbo].[RegisterPatient]
	82821, 'Bambi', 'Hasluck', '1978-02-02', '2FA8T5T', 'Erie', 'Idaho', 'Boise', '83757', 2083332704, 'bhasluck8@homestead.com', 'Bambi Hasluck', 9018493826, 1, 4, 'Rohan, Marquardt and Lockman';
EXECUTE [dbo].[RegisterPatient]
	58850, 'Vida', 'Yegorshin', '1998-03-31', 'DxfxyT', 'Dryden', 'District of Columbia', 'Washington', '20036', 2021193169, 'vyegorshin9@icio.us', 'Vida Yegorshin', 8623251130, 10, 5, 'Ebert, Homenick and Braun';
EXECUTE [dbo].[RegisterPatient]
	17589, 'Adriena', 'Imrie', '1970-10-06', 'YjYPUMjEcZq', 'Packers', 'South Carolina', 'Spartanburg', '29319', 8646209029, 'aimriea@storify.com', 'Adriena Imrie', 2081172656, 9, 5, 'Aufderhar and Sons';
EXECUTE [dbo].[RegisterPatient]
	60385, 'Elfrieda', 'Enion', '1967-08-31', 'Un3xdaYqt3vs', 'Alpine', 'Hawaii', 'Honolulu', '96840', 8083400155, 'eenionb@apache.org', 'Elfrieda Enion', 2178144280, 4, 10, 'Heathcote-Armstrong';
EXECUTE [dbo].[RegisterPatient]
	77719, 'Bryana', 'Ruppel', '1993-04-14', 'UbrW5WoMXG', 'Monument', 'Pennsylvania', 'Pittsburgh', '15274', 4127702570, 'bruppelc@purevolume.com', 'Bryana Ruppel', 2028608642, 8, 8, 'Wunsch, Raynor and Miller';
EXECUTE [dbo].[RegisterPatient]
	76991, 'Nora', 'Garioch', '2002-03-10', 'LJEhIBknPq', 'Brown', 'District of Columbia', 'Washington', '20067', 2023814574, 'ngariochd@unc.edu', 'Nora Garioch', 2061944410, 1, 7, 'Dach Inc';
EXECUTE [dbo].[RegisterPatient]
	63586, 'Stephine', 'Snoddon', '1972-02-03', 'QGBIYw9gxHl', 'Talisman', 'New York', 'Mount Vernon', '10557', 8145378037, 'ssnoddone@intel.com', 'Stephine Snoddon', 5038457317, 3, 3, 'McCullough-Brekke';

--delete from PatientAddress;
--select * from PatientAddress;
--select * from PatientPersonalInformation;
--select * from PatientInsurance;
--select * from PatientPrimaryContact;
--select * from PatientWishlistPharmacy;
--select * from PatientAllergies;


EXECUTE [dbo].[RegisterDoctor]
	'Catherin', 'Chastang', '1991-08-09', 'imWHtkwS', 'Sachtjen', 'Kentucky', 'Lexington', 40591, 8594119684, 'General', 'cchastang0@goodreads.com', '6 David Drive', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Armando', 'Dumbare', '1979-01-24', 'e2FVRATG1', 'Northland', 'Minnesota', 'Saint Paul', 55188, 6511896199, 'Surgery', 'adumbare1@dailymotion.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Hubey', 'Dight', '1981-07-18', 'lVNxgvXt', 'Algoma', 'California', 'Sacramento', 95818, 5302984047, 'Internal medicine', 'hdight2@bandcamp.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Gayelord', 'Petera', '1977-08-26', 'GGVn4dbUnQ', 'Wayridge', 'New York', 'New York City', 10280, 3473184742, 'Psychiatry', 'gpetera3@wired.com', '11 Pine View Alley', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Greg', 'Crush', '1990-08-27', 'm6KjVqr', 'Killdeer', 'California', 'Santa Ana', 92725, 7147071850, 'General', 'gcrush4@sohu.com', '305 Fordem Terrace', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Laure', 'Ortet', '1954-12-03', 'myWiJTUIa', 'Garrison', 'Texas', 'Dallas', 75210, 9724834853, 'Dermatology', 'lortet5@sfgate.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Malia', 'Pummery', '1959-08-13', 'kpeQ0yn1I', 'Moose', 'Wisconsin', 'Milwaukee', 53220, 4145125203, 'Internal medicine', 'mpummery6@vistaprint.com', '2 Anzinger Lane', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Dixie', 'Siccombe', '1972-08-07', 'ScPTS3oN', 'Bonner', 'Mississippi', 'Gulfport', 39505, 2287762703, 'Neruology', 'dsiccombe7@howstuffworks.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Dukey', 'Rex', '1995-02-09', 'L2nBchi8L', 'Grim', 'Colorado', 'Denver', 80279, 3039535076, 'Surgery', 'drex8@reverbnation.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Mohandas', 'Hub', '1979-03-03', 'QsgXrkYNuZ90', 'Eagan', 'Texas', 'Austin', 78744, 3614299557, 'Dentist', 'mhub9@dot.gov', '838 Stuart Drive', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Viviyan', 'Manvelle', '1977-12-07', 'DclCee4G5r', 'Nova', 'Idaho', 'Pocatello', 83206, 2082187792, 'Anesthesiology', 'vmanvellea@opera.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Janifer', 'McGhie', '1969-01-27', 'h6eHOsYUz', 'La Follette', 'Minnesota', 'Saint Cloud', 56372, 3206193651, 'Pediatrics', 'jmcghieb@chronoengine.com', '92 Pankratz Junction', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Danna', 'Hartshorne', '1978-12-26', '5nVFExYKrQES', 'Northridge', 'New York', 'New York City', 10275, 2128050075, 'Internal medicine', 'dhartshornec@chron.com', '853 Burning Wood Place', 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Pasquale', 'Burrow', '1985-01-29', 'lIsy5LSA8', 'Manley', 'Georgia', 'Atlanta', 30328, 6787733405, 'Radiology', 'pburrowd@wikia.com', null, 'United States';
EXECUTE [dbo].[RegisterDoctor]
	'Ines', 'Yurocjhin', '1994-09-21', 'zhZGc6y5Au', 'Moulton', 'Virginia', 'Norfolk', 23520, 7576858206, 'Allergy and immunology', 'iyurocjhine@thetimes.co.uk', '0 Kensington Lane', 'United States';


--select * from Address;
--select * from DoctorInformation;
--Select * from LoginInformation;
--select * from DoctorSpecialization;

DECLARE @outputa int;
EXECUTE [dbo].[Insert_Update_Appointment]
	1032, 1001, 'Out Patient Visit', 'Fever', '7/3/2021', '18:55',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1034, 1007, 'General', 'Bodyache', '3/25/2022', '17:58',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1018, 1006, 'General', 'Chestpain', '7/22/2021', '10:12',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1008, 1003, 'General', 'Fever', '4/4/2022', '4:37',null,@outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1004, 1005, 'Out Patient Visit', 'Fever', '9/14/2021', '21:18',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1002, 1001, 'Out Patient Visit', 'ENT', '2/2/2022', '10:15',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1002, 1009, 'General', 'Fever', '3/14/2022', '21:08',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1000, 1013, 'General', 'ENT', '8/9/2021', '18:42',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1010, 1015, 'Out Patient Visit', 'Pain in the Eye', '9/15/2021', '14:41',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1012, 1019, 'Out Patient Visit', 'Fever', '11/18/2021', '7:37',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1016, 1015, 'Out Patient Visit', 'Headache', '9/4/2021', '11:55',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1020, 1021, 'General', 'Headache', '5/26/2021', '22:46',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1002, 1007, 'Out Patient Visit', 'Fever', '2/15/2022', '9:44',null, @outputa OUTPUT;
EXECUTE [dbo].[Insert_Update_Appointment]
	1004, 1003, 'General', 'ThroatPain', '1/6/2022', '18:22',null;
EXECUTE [dbo].[Insert_Update_Appointment]
	1006, 1009, 'Out Patient Visit', 'Fever', '10/8/2021', '20:07',null;

--select * from Appointments


EXECUTE [dbo].[INSERT_Patient_Visit_History]
	4, 102, 126, 117, 93, 7.2, 120;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	11, 98, 139, 163, 93, 6.0, 134;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	4, 104, 108, 133, 97, 3.0, 66;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	14, 101, 134, 67, 95, 7.1, 99;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	15, 100, 112, 118, 93, 8.5, 136;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	9, 96, 139, 73, 94, 6.0, 96;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	9, 98, 88, 83, 91, 4.8, 84;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	9, 99, 112, 58, 92, 7.4, 12;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	4, 97, 87, 116, 97, 6.8, 113;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	14, 100, 122, 67, 94, 7.7, 13;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	15, 102, 84, 103, 96, 3.9, 82;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	1, 101, 129, 71, 98, 2.9, 144;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	12, 101, 103, 66, 91, 4.3, 104;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	8, 103, 91, 82, 92, 4.1, 135;
EXECUTE [dbo].[INSERT_Patient_Visit_History]
	5, 98, 139, 158, 100, 4.8, 98;

--select * from PatientVisitHistory;


