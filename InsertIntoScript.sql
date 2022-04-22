INSERT INTO PharmacyLookup (PharmacyName ,PharmacyStreetName ,PharmacyState ,PharmacyCity ,PharmacyZip ,ContactNumber)
VALUES
    ('CVS', '91 Seaport Blvd', 'MA', 'Boston', '02210', '8573504646'),
    ('CVS', '423 W Broadway', 'MA', 'South Boston', '02127', '6172697656'),
    ('Star Market Pharmacy', '45 Morrissey Blvd', 'MA', 'Dorchester', '02125', '6172657911'),
    ('CVS', '333 Washington St', 'MA', 'Boston', '02108', '6177420783'),
    ('CVS', '7000 Atlantic Ave', 'MA', 'Boston', '02111', '6177377232'),
    ('CVS', '631 Washington St', 'MA', 'Boston', '02118', '6173380128'),
    ('Walgreens', '710 E Broadway', 'MA', 'South Boston', '02127', '6172695788'),
    ('Walgreens', '24 School St', 'MA', 'Boston', '02108', '6173728156'),
    ('Walgreens', '841 Boylston St', 'MA', 'Boston', '02116', '6172361692'),
    ('Default Pharmacy', '587 Boylston St', 'MA', 'Boston', '02116', '6174378414');
	
INSERT INTO PatientInsurance (InsuranceId,PatientId,InsuranceProvider)
VALUES
    ('1', '1000', 'UMR'),
    ('2', '1002', 'United HealthCare'),
    ('3', '1004', 'Blue Cross Blue Shield'),
    ('4', '1006', 'Aetna'),
    ('5', '1008', 'Cigna'),
    ('6', '1010', 'Blue Cross Blue Shield'),
    ('7', '1012', 'Aetna'),
    ('8', '1014', 'Cigna'),
    ('9', '1016', 'NeyYork Life'),
    ('10', '1018', 'United HealthCare'),
    ('11', '1010', 'NeyYork Life'),
    ('12', '1000', 'United HealthCare');
	
INSERT INTO PatientPrimaryContact (PatientId,FullName,PhoneNumber)
VALUES
    ('1000', 'Kasey Roman', '15824003109'),
    ('1002', 'Lana Stevens', '12095196285'),
    ('1004', 'Adrien Ingram', '15824429752'),
    ('1006', 'Angelica Carr', '12077269540'),
    ('1008', 'Bailee Calhoun', '14082561159'),
    ('1010', 'Luciano Mckenzie', '15824005039'),
    ('1012', 'Alma Alexander', '15822622408'),
    ('1014', 'Solomon Wilcox', '13092519490'),
    ('1016', 'Trevin Olson', '13095474029'),
    ('1018', 'Jacey Newman', '12288619737');
	
INSERT INTO PatientWishlistPharmacy (PatientId,PharmacyId)
VALUES
    ('1000', '10'),
    ('1002', '9'),
    ('1004', '8'),
    ('1006', '7'),
    ('1008', '6'),
    ('1010', '5'),
    ('1012', '4'),
    ('1014', '3'),
    ('1016', '2'),
    ('1018', '1');
	
INSERT INTO AllergyTypes(AllergyTypeId,AllergyName,Description)
VALUES
    ('1', 'No Allergy', 'Default Allergy'),
    ('2', 'Peanuts', 'Peanuts'),
    ('3', 'Mold', 'Mold'),
    ('4', 'Penicillin ', 'Penicillin '),
    ('5', 'Pollen', 'Pollen'),
    ('6', 'Eggs', 'Eggs'),
    ('7', 'Dairy', 'Dairy'),
    ('8', 'Tree Nuts', 'Tree Nuts'),
    ('9', 'Dust', 'Dust'),
    ('10', 'Grass', 'Grass');


INSERT
	
INSERT INTO PatientAllergies (Patientid,AllergyTypeId)
VALUES
    ('1000', '1'),
    ('1002', '2'),
    ('1004', '3'),
    ('1006', '4'),
    ('1008', '5'),
    ('1010', '6'),
    ('1012', '7'),
    ('1014', '8'),
    ('1016', '9'),
    ('1018', '10');
	
INSERT INTO RolesLookup (RoleId,RoleType)
VALUES
    ('1', 'Admin'),
    ('2', 'Doctor'),
    ('3', 'Patient');
	
INSERT INTO Specialization (SpecializationID,SpecializationName)
VALUES
    ('0', 'General'),
    ('1', 'Allergy and immunology'),
    ('2', 'Anesthesiology'),
    ('3', 'Dermatology'),
    ('4', 'Radiology'),
    ('5', 'Dentist'),
    ('6', 'Internal medicine'),
    ('7', 'Surgery'),
    ('8', 'Psychiatry'),
    ('9', 'Pediatrics'),
    ('10', 'Neruology');
	
INSERT INTO DoctorSpecialization (DoctorID,SpecializationID)
VALUES
    ('1001', '10'),
    ('1003', '9'),
    ('1005', '8'),
    ('1007', '7'),
    ('1009', '6'),
    ('1011', '5'),
    ('1013', '4'),
    ('1015', '3'),
    ('1017', '2'),
    ('1019', '1'),
    ('1021', '0');
	
INSERT INTO LoginInformation (UserID,Password,RoleID)
VALUES
    ('11', 'En\?BnNm((2G$_H3', '1'),
    ('13', '@~@ve}b/G*u<E2yt', '1'),
    ('15', 'v{9:8=/UBR=XFfpJ', '1'),
    ('17', 'W`{/qzrv_HKVdu8Z', '1'),
    ('19', '~7PW`d>,;T!%Yk,#', '1'),
    ('21', '#?68?"AH+fP_9,S#', '1'),
    ('23', '(dzrHs,~V6VL%LK^', '1'),
    ('25', ':[R7jPV;tz^s]w?!', '1'),
    ('27', 'W*?%r}c^M7gjRX#w', '1'),
    ('29', '^A@N<s5J\>Np?aM_', '1'),
    ('1001', '=Enhk6SM"k/4*wy', '2'),
    ('1003', '!j+-!#vBqd$>*9W-', '2'),
    ('1005', '2hEt]WUJ%rHeUXtU', '2'),
    ('1007', 'v4QVB-P)4+Y9V8[t', '2'),
    ('1009', 'CF5b^Y$k*J=4P3', '2'),
    ('1011', 'Qdjg"a~X{D>M7!N-', '2'),
    ('1013', 'M4B!3cwp`Y$W$yWD', '2'),
    ('1015', '<)hT:6A_;SLD2UaY', '2'),
    ('1017', 'zY#gd(U_7$.u@>Kq', '2'),
    ('1019', '@ChLT>.+xSWy964h', '2'),
    ('1000', 'w~&>5(n[@*=8ePD<', '3'),
    ('1002', 'W-DNm~(@9apGkj+&', '3'),
    ('1004', 'j)v8M"*w;@pF3}c<', '3'),
    ('1006', 'b.u5P&yer3,Zt4[V', '3'),
    ('1008', 'q*Ny[eV}!rB8<;>^', '3'),
    ('1010', 'z}=9JDk4Hqby;LWS', '3'),
    ('1012', 'c.9W<PCq%X64}53', '3'),
    ('1014', 'c^)JE+a:6?-wX5zx', '3'),
    ('1016', 'BsMWJwr:u]t5e2+^', '3'),
    ('1018', 'XP5%T4SdvRw:8bg', '3');
