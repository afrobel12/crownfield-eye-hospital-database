-- Queries 1–4 of the six distinct Part C SQL features; features 5–6 in 04_procedure_and_trigger.sql
USE crownfield_eye_hospital;
-- Q1: Which clinicians have conducted more than one appointment?
SELECT c.clinician_id,c.clinician_name,COUNT(*) AS appointment_count
FROM clinician c JOIN appointment a ON a.clinician_id=c.clinician_id
GROUP BY c.clinician_id,c.clinician_name HAVING COUNT(*)>1 ORDER BY appointment_count DESC;
-- Q2: Which patient attended which clinician, and at which clinic? (4-table INNER JOIN)
SELECT a.appointment_id,CONCAT_WS(' ',p.first_name,p.last_name) AS patient_name,c.clinician_name,k.clinic_name,a.appointment_date
FROM appointment a JOIN patient p ON p.patient_id=a.patient_id
JOIN clinician c ON c.clinician_id=a.clinician_id JOIN clinic k ON k.clinic_id=a.clinic_id
ORDER BY a.appointment_id;
-- Q3: Which appointments have no diagnosis recorded? LEFT JOIN retains missing children.
SELECT a.appointment_id,CONCAT_WS(' ',p.first_name,p.last_name) AS patient_name,a.appointment_date,d.diagnosis_description
FROM appointment a JOIN patient p ON p.patient_id=a.patient_id
LEFT JOIN diagnosis d ON d.appointment_id=a.appointment_id
WHERE d.diagnosis_id IS NULL ORDER BY a.appointment_id;
-- Q4: Which patients have attended more than one appointment? Correlated subquery.
SELECT p.patient_id,CONCAT_WS(' ',p.first_name,p.last_name) AS patient_name FROM patient p
WHERE (SELECT COUNT(*) FROM appointment a WHERE a.patient_id=p.patient_id)>1 ORDER BY p.patient_id;
