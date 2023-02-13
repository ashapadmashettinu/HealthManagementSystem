Database Project - Health Management System

Maintain patients’ medical records to analyze their past conditions for determining the line of treatment. 
Help facilitate booking an appointment with a doctor based on their availability. 


StoredProcedures
————————————

1. RegisterPatient - VerificationID, FirstName, LastName, DOB, password, roleid, Adresss(all except email, isprimary and adressline2)
-- Generate Address
-- We will insert patient info along with the above genre


2. RegisterDoctor ->  FirstName, LastName, DOB, password, roleid, Addresss(all except email, isprimary and adressline2)(At the end - Complication - Only admin/doctor can do this)

(Consider Specialization and Address)

3. LoginVerification - userid, password (can be a function/sp) (this should create session)

4. AddSpecilizations - use the loginverification

-- Patient/Admin
5. EditPatientInfo - address and information and login

6. AddAllergies
7. AddWishlist
8. AddPrimaryContact
9. AddPatientInsurance
10. Schedule appointments - date, Time, doctor, patientid, appointmenttype, DESCRIPTION
11. Appointment summary(Patient Visit)

Functions are stopred procedures

12. Doctors appointments
13. Patient appointments

Trigger/Table-Level Constriant
————————————
Appointment --All the mentioned can be combined into one trigger/ table level constraint
    14. Patient (Similarly for Doctor) Cant make 2 or more apointments for the same datetime/There should be some gap between the next appointment and the first. Also considering duration
    One Patient can’t schedule appointment with a doctor who has already been scheduled with another.
     Doctor can see 25 per day
    
15. Patient Doctor Admin
    Add age as computational column 

Reports
————————————
16. Patient appointments

17. Doctor Appointments

18. Number of patients with Fever/Obese/Allergies etc.,

19. Number of patients with vs without insurance

20. Busiest Doctor/Number of patients per doctor based on month or year. (This covers the Pivot and horizontal reporting)

21. Top Pharma
