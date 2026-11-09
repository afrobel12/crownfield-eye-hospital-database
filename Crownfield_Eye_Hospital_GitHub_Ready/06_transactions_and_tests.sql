USE crownfield_eye_hospital;
-- Test T1: display records and verify foreign-key relationships.
SELECT appointment_id,patient_id,clinician_id,clinic_id FROM appointment WHERE appointment_id=1;
-- Test T2: control an UPDATE, then ROLLBACK. This does NOT permanently alter evidence.
SELECT notes AS before_notes FROM appointment WHERE appointment_id=1;
START TRANSACTION;
UPDATE appointment SET notes='Temporary testing note' WHERE appointment_id=1;
SELECT notes AS inside_transaction FROM appointment WHERE appointment_id=1;
ROLLBACK;
SELECT notes AS after_rollback FROM appointment WHERE appointment_id=1;
-- Test T3: demonstrate controlled INSERT and DELETE as one committed transaction
-- using a disposable visit for existing patient OP015 and clinician 10.
START TRANSACTION;
INSERT INTO appointment(appointment_id,patient_id,clinician_id,clinic_id,appointment_date,appointment_time,notes)
VALUES(999,'OP015',10,10,'2026-11-09','16:00:00','Disposable teaching record');
DELETE FROM appointment WHERE appointment_id=999;
COMMIT;
SELECT COUNT(*) AS disposable_rows_remaining FROM appointment WHERE appointment_id=999;
-- Optional NEGATIVE tests - run each individually and capture error; do not execute with entire script.
-- Invalid FK expected 1452:
-- INSERT INTO appointment VALUES(998,'OP999',1,1,'2026-11-09','12:00:00','Invalid patient');
-- Invalid CHECK expected 3819:
-- INSERT INTO follow_up VALUES(998,15,'2026-11-15','Unknown','Planned');
-- Duplicate PK expected 1062:
-- INSERT INTO patient VALUES('OP001','Duplicate','NE1 4AB');
-- Retention: do not delete actual appointment rows with clinical children.
