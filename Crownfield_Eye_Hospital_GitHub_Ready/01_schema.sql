-- SAFE CONTINUATION: preserves the patient table you created in Workbench.
-- Run only once on your existing crownfield_eye_hospital schema.
-- Never drops a database or the existing patient table.
USE crownfield_eye_hospital;

-- Appendix 1 includes postcode, not present in the original GUI patient table.
ALTER TABLE patient ADD COLUMN postcode VARCHAR(12) NOT NULL DEFAULT 'UNKNOWN';

CREATE TABLE specialty (
 specialty_id INT PRIMARY KEY, specialty_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;
CREATE TABLE clinic (
 clinic_id INT PRIMARY KEY, clinic_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;
CREATE TABLE clinician (
 clinician_id INT PRIMARY KEY, clinician_name VARCHAR(120) NOT NULL,
 specialty_id INT NULL,
 CONSTRAINT fk_clinician_specialty FOREIGN KEY (specialty_id) REFERENCES specialty(specialty_id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE appointment (
 appointment_id INT PRIMARY KEY,
 patient_id VARCHAR(12) NOT NULL, clinician_id INT NOT NULL, clinic_id INT NOT NULL,
 appointment_date DATE NOT NULL, appointment_time TIME NOT NULL,
 notes VARCHAR(255),
 CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id) ON DELETE RESTRICT,
 CONSTRAINT fk_appointment_clinician FOREIGN KEY (clinician_id) REFERENCES clinician(clinician_id) ON DELETE RESTRICT,
 CONSTRAINT fk_appointment_clinic FOREIGN KEY (clinic_id) REFERENCES clinic(clinic_id) ON DELETE RESTRICT,
 CONSTRAINT ck_appointment_date CHECK (appointment_date >= '2020-01-01')
) ENGINE=InnoDB;
CREATE TABLE diagnosis (
 diagnosis_id INT PRIMARY KEY,
 appointment_id INT NOT NULL, diagnosis_description VARCHAR(200) NOT NULL,
 CONSTRAINT fk_diagnosis_appointment FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE medicine (
 medicine_id INT PRIMARY KEY, medicine_name VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB;
CREATE TABLE prescription (
 prescription_id INT PRIMARY KEY, appointment_id INT NOT NULL, prescription_date DATE NOT NULL,
 CONSTRAINT fk_prescription_appointment FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE prescription_item (
 prescription_item_id INT PRIMARY KEY, prescription_id INT NOT NULL, medicine_id INT NOT NULL,
 dose VARCHAR(80) NOT NULL, route VARCHAR(80) NOT NULL,
 frequency VARCHAR(80) NOT NULL, duration VARCHAR(80) NOT NULL,
 CONSTRAINT uq_prescription_medicine UNIQUE (prescription_id, medicine_id),
 CONSTRAINT fk_item_prescription FOREIGN KEY (prescription_id) REFERENCES prescription(prescription_id) ON DELETE RESTRICT,
 CONSTRAINT fk_item_medicine FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE follow_up (
 follow_up_id INT PRIMARY KEY, appointment_id INT NOT NULL UNIQUE,
 follow_up_due_date DATE NOT NULL,
 priority VARCHAR(12) NOT NULL, status VARCHAR(20) NOT NULL DEFAULT 'Planned',
 CONSTRAINT fk_followup_appointment FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id) ON DELETE RESTRICT,
 CONSTRAINT ck_followup_priority CHECK (priority IN ('High','Urgent','Routine')),
 CONSTRAINT ck_followup_status CHECK (status IN ('Planned','Booked','Completed','Cancelled'))
) ENGINE=InnoDB;
-- Optional pseudonymisation support: generated digest is NOT a password hash.
CREATE TABLE patient_token (
 patient_id VARCHAR(12) PRIMARY KEY,
 source_token VARCHAR(120) NOT NULL,
 token_sha256 CHAR(64) GENERATED ALWAYS AS (SHA2(source_token,256)) STORED,
 CONSTRAINT fk_token_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id) ON DELETE RESTRICT
) ENGINE=InnoDB;
