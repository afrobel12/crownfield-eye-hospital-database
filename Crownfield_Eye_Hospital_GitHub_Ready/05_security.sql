-- Run using an account authorised to CREATE ROLE and GRANT; MySQL 8.x.
-- Roles define privileges but do not create real login accounts.
USE crownfield_eye_hospital;
CREATE ROLE IF NOT EXISTS 'ceh_admin','ceh_doctor','ceh_receptionist','ceh_patient';
-- Administrator access to this teaching database only.
GRANT ALL PRIVILEGES ON crownfield_eye_hospital.* TO 'ceh_admin';
-- Clinicians: read records and insert/update clinical findings; no DROP or unrestricted DELETE.
GRANT SELECT ON crownfield_eye_hospital.patient TO 'ceh_doctor';
GRANT SELECT ON crownfield_eye_hospital.appointment TO 'ceh_doctor';
GRANT SELECT ON crownfield_eye_hospital.clinician TO 'ceh_doctor';
GRANT SELECT ON crownfield_eye_hospital.medicine TO 'ceh_doctor';
GRANT SELECT,INSERT,UPDATE ON crownfield_eye_hospital.diagnosis TO 'ceh_doctor';
GRANT SELECT,INSERT,UPDATE ON crownfield_eye_hospital.prescription TO 'ceh_doctor';
GRANT SELECT,INSERT,UPDATE ON crownfield_eye_hospital.prescription_item TO 'ceh_doctor';
GRANT SELECT,INSERT,UPDATE ON crownfield_eye_hospital.follow_up TO 'ceh_doctor';
-- Reception: patient registration/scheduling, not access to diagnosis/prescriptions.
GRANT SELECT,INSERT,UPDATE ON crownfield_eye_hospital.patient TO 'ceh_receptionist';
GRANT SELECT,INSERT,UPDATE ON crownfield_eye_hospital.appointment TO 'ceh_receptionist';
GRANT SELECT ON crownfield_eye_hospital.clinic TO 'ceh_receptionist';
GRANT SELECT ON crownfield_eye_hospital.clinician TO 'ceh_receptionist';
-- IMPORTANT LIMITATION: SQL table-level SELECT is NOT patient-specific access control.
-- Patient role intentionally gets no direct clinical-table grants; patient portal would
-- require a separately authenticated application/service with per-patient checks.
SELECT 'Security roles provisioned; capture SHOW GRANTS results separately' AS message;
SHOW GRANTS FOR 'ceh_admin';
SHOW GRANTS FOR 'ceh_doctor';
SHOW GRANTS FOR 'ceh_receptionist';
SHOW GRANTS FOR 'ceh_patient';
-- The generated SHA-256 digest in patient_token is an illustrative data-minimisation
-- pseudonym. SHA2 is NOT suitable for password storage; use app-side Argon2id/bcrypt.
SELECT patient_id, LEFT(token_sha256,12) AS digest_prefix FROM patient_token;
