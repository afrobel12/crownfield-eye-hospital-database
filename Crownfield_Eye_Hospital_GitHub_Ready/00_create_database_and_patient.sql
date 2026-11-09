-- Fresh-install bootstrap: execute ONLY when the hospital database is absent.
-- On the already-built coursework database, skip this file.
-- Safe creation; does not drop or overwrite existing tables.
CREATE DATABASE IF NOT EXISTS crownfield_eye_hospital;
USE crownfield_eye_hospital;
CREATE TABLE IF NOT EXISTS patient (
 patient_id VARCHAR(10) NOT NULL PRIMARY KEY,
 first_name VARCHAR(45) NOT NULL,
 last_name VARCHAR(45) NOT NULL,
 date_of_birth DATE NOT NULL,
 gender VARCHAR(20),
 phone VARCHAR(20),
 email VARCHAR(100)
) ENGINE=InnoDB;
