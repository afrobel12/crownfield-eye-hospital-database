-- Features 5 and 6. Run this in MySQL Workbench as a complete SQL script.
USE crownfield_eye_hospital;
DROP PROCEDURE IF EXISTS get_patient_appointments;
DROP TRIGGER IF EXISTS trg_followup_due_after_appointment;
DELIMITER $$
CREATE PROCEDURE get_patient_appointments(IN p_patient_id VARCHAR(12))
BEGIN
 SELECT a.appointment_id,CONCAT_WS(' ',p.first_name,p.last_name) AS patient_name,a.appointment_date,a.appointment_time,
        c.clinician_name,k.clinic_name
 FROM appointment a JOIN patient p ON p.patient_id=a.patient_id
 JOIN clinician c ON c.clinician_id=a.clinician_id
 JOIN clinic k ON k.clinic_id=a.clinic_id
 WHERE a.patient_id=p_patient_id ORDER BY a.appointment_date,a.appointment_time;
END$$
CREATE TRIGGER trg_followup_due_after_appointment
BEFORE INSERT ON follow_up FOR EACH ROW
BEGIN
 DECLARE v_appointment_date DATE;
 SELECT appointment_date INTO v_appointment_date FROM appointment
 WHERE appointment_id=NEW.appointment_id;
 IF NEW.follow_up_due_date < v_appointment_date THEN
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Follow-up date cannot precede appointment date';
 END IF;
END$$
DELIMITER ;
-- Feature 5: expected OP001's two visits (actual screenshot to be captured).
CALL get_patient_appointments('OP001');
-- Feature 6: demonstrate successful trigger using an isolated test appointment.
INSERT INTO follow_up(follow_up_id,appointment_id,follow_up_due_date,priority,status)
VALUES(99,15,'2026-11-13','Routine','Planned');
SELECT follow_up_id,appointment_id,follow_up_due_date FROM follow_up WHERE follow_up_id=99;
DELETE FROM follow_up WHERE follow_up_id=99;
-- Separate MANUAL NEGATIVE TEST: run the following statement alone after commenting it in.
-- INSERT INTO follow_up(follow_up_id,appointment_id,follow_up_due_date,priority,status)
-- VALUES (99,15,'2026-01-01','Routine','Planned');
-- Expected SQLSTATE 45000. The failure is intentional and should be captured separately.
