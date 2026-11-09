-- Appendix 1's five visits are A001-A005; all other records are fictional additions.
-- Asterisks in comments distinguish exercise-generated dosages (NOT medical advice).
USE crownfield_eye_hospital;
INSERT INTO specialty VALUES (1,'Glaucoma'),(2,'Retina'),(3,'Cornea'),(4,'Paediatric Ophthalmology'),(5,'Cataract'),(6,'Oculoplastics'),(7,'Neuro-ophthalmology'),(8,'Uveitis'),(9,'Low Vision'),(10,'General Ophthalmology');
INSERT INTO clinic VALUES (1,'City Road'),(2,'Bedford'),(3,'Croydon'),(4,'North Clinic'),(5,'South Clinic'),(6,'East Clinic'),(7,'West Clinic'),(8,'Outpatient A'),(9,'Outpatient B'),(10,'Community Eye Unit');
-- Dates of birth are synthetic placeholders, NOT taken from Appendix 1.
INSERT INTO patient (patient_id,first_name,last_name,postcode,date_of_birth) VALUES
('OP001','Amina','Yusuf','NE1 4AB','1990-01-01'),
('OP002','Daniel','Reed','N16 7QP','1990-01-02'),
('OP003','Sofia','Bennett','E8 2LD','1990-01-03'),
('OP004','Michael','Okoro','SE6 3RT','1990-01-04'),
('OP005','Sarah','Johnson','SW1 2AB','1990-01-05'),
('OP006','Noah','Patel','N1 6XY','1990-01-06'),
('OP007','Emma','Clarke','E2 7AA','1990-01-07'),
('OP008','Luca','Green','SE1 8EF','1990-01-08'),
('OP009','Ruby','Khan','NW3 4YY','1990-01-09'),
('OP010','George','Hill','W4 5PL','1990-01-10'),
('OP011','Ella','Price','EC1 7LP','1990-01-11'),
('OP012','Adam','Scott','BR1 2HF','1990-01-12'),
('OP013','Mia','Brown','SW2 6AD','1990-01-13'),
('OP014','Oliver','White','N4 5JR','1990-01-14'),
('OP015','Zara','Ali','SE8 4LL','1990-01-15');
INSERT INTO clinician VALUES (1,'Dr Maya Shah',1),(2,'Dr Leo Grant',2),(3,'Dr Priya Nair',3),(4,'Dr Iris Wong',4),(5,'Dr Noah Evans',5),(6,'Dr Leah Moss',6),(7,'Dr Amir Khan',7),(8,'Dr Sophie Lane',8),(9,'Dr David Cole',9),(10,'Dr Grace Hall',10);
INSERT INTO appointment VALUES
(1,'OP001',1,1,'2026-10-05','09:00:00','Review IOP'),
(2,'OP002',2,1,'2026-10-05','09:30:00','OCT before review'),
(3,'OP001',1,2,'2026-11-16','10:15:00','Visual field test'),
(4,'OP003',1,1,'2026-10-06','11:00:00','Monitor'),
(5,'OP004',3,3,'2026-10-07','14:00:00','Corneal topography'),
(6,'OP005',4,4,'2026-10-08','09:00:00','Synthetic teaching visit'),
(7,'OP006',5,5,'2026-10-08','10:00:00','Synthetic teaching visit'),
(8,'OP007',6,6,'2026-10-09','11:00:00','Synthetic teaching visit'),
(9,'OP008',7,7,'2026-10-09','14:00:00','Synthetic teaching visit'),
(10,'OP009',8,8,'2026-10-10','09:00:00','Synthetic teaching visit'),
(11,'OP010',9,9,'2026-10-10','10:00:00','Synthetic teaching visit'),
(12,'OP011',10,10,'2026-10-11','11:00:00','Synthetic teaching visit'),
(13,'OP012',1,1,'2026-10-12','12:00:00','Synthetic teaching visit'),
(14,'OP013',2,2,'2026-10-12','13:00:00','Synthetic teaching visit'),
(15,'OP014',3,3,'2026-10-13','14:00:00','Intentionally has no diagnosis/prescription'),
(16,'OP015',4,4,'2026-10-14','15:00:00','Intentionally has no diagnosis/prescription');
INSERT INTO diagnosis VALUES
(1,1,'Ocular hypertension'),(2,2,'Diabetic macular oedema'),(3,3,'Ocular hypertension'),(4,4,'Glaucoma suspect'),(5,5,'Keratoconus'),
(6,6,'Routine screening'),(7,7,'Cataract assessment'),(8,8,'Eyelid assessment'),(9,9,'Visual symptoms'),(10,10,'Anterior inflammation'),(11,11,'Reduced visual acuity'),(12,12,'Routine review'),(13,13,'Ocular pressure monitoring'),(14,14,'Retinal follow-up');
INSERT INTO medicine VALUES
(1,'Latanoprost'),(2,'Timolol'),(3,'Aflibercept'),(4,'Sodium chloride drops'),(5,'Artificial tears'),(6,'Cyclopentolate'),(7,'Prednisolone acetate'),(8,'Brimonidine'),(9,'Dorzolamide'),(10,'Tropicamide'),(11,'Lubricating gel');
INSERT INTO prescription VALUES
(1,1,'2026-10-05'),(2,2,'2026-10-05'),(3,3,'2026-11-16'),(4,5,'2026-10-07'),(5,6,'2026-10-08'),(6,7,'2026-10-08'),(7,8,'2026-10-09'),(8,9,'2026-10-09'),(9,10,'2026-10-10'),(10,11,'2026-10-10'),(11,12,'2026-10-11'),(12,13,'2026-10-12');
-- Appendix 1 does not give dosages/routes/frequencies/durations; examples below are synthetic placeholders.
INSERT INTO prescription_item VALUES
(1,1,1,'Demo dose','Demo route','Demo frequency','Demo duration'),(2,1,2,'Demo dose','Demo route','Demo frequency','Demo duration'),
(3,2,3,'Demo dose','Demo route','Demo frequency','Demo duration'),(4,3,1,'Demo dose','Demo route','Demo frequency','Demo duration'),
(5,4,4,'Demo dose','Demo route','Demo frequency','Demo duration'),(6,5,5,'Demo dose','Demo route','Demo frequency','Demo duration'),
(7,6,6,'Demo dose','Demo route','Demo frequency','Demo duration'),(8,7,7,'Demo dose','Demo route','Demo frequency','Demo duration'),
(9,8,8,'Demo dose','Demo route','Demo frequency','Demo duration'),(10,9,9,'Demo dose','Demo route','Demo frequency','Demo duration'),
(11,10,10,'Demo dose','Demo route','Demo frequency','Demo duration'),(12,11,11,'Demo dose','Demo route','Demo frequency','Demo duration'),(13,12,5,'Demo dose','Demo route','Demo frequency','Demo duration');
-- Due dates computed as visit date plus the original Appendix 1 week interval for A001-A005.
INSERT INTO follow_up VALUES
(1,1,'2026-11-16','High','Planned'),(2,2,'2026-11-02','Urgent','Planned'),(3,3,'2027-02-08','Routine','Planned'),
(4,4,'2027-04-06','Routine','Planned'),(5,5,'2026-12-02','Routine','Planned'),
(6,6,'2026-11-05','Routine','Planned'),(7,7,'2026-11-05','Routine','Planned'),(8,8,'2026-11-06','High','Booked'),
(9,9,'2026-11-06','Routine','Planned'),(10,10,'2026-11-07','Routine','Planned'),(11,11,'2026-11-07','Urgent','Planned'),(12,12,'2026-11-08','Routine','Planned');
INSERT INTO patient_token(patient_id,source_token) VALUES ('OP001','synthetic-op001-only'),('OP002','synthetic-op002-only');
-- Evidence: row counts (16 appointments, 15 patients, 10 clinicians, etc.)
SELECT 'patient' AS table_name,COUNT(*) AS rows_present FROM patient
UNION ALL SELECT 'specialty',COUNT(*) FROM specialty
UNION ALL SELECT 'clinic',COUNT(*) FROM clinic
UNION ALL SELECT 'clinician',COUNT(*) FROM clinician
UNION ALL SELECT 'appointment',COUNT(*) FROM appointment
UNION ALL SELECT 'diagnosis',COUNT(*) FROM diagnosis
UNION ALL SELECT 'medicine',COUNT(*) FROM medicine
UNION ALL SELECT 'prescription',COUNT(*) FROM prescription
UNION ALL SELECT 'prescription_item',COUNT(*) FROM prescription_item
UNION ALL SELECT 'follow_up',COUNT(*) FROM follow_up;
