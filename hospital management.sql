-- 1. TABLE CREATION

CREATE TABLE Patients (
    patient_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    dob DATE,
    gender VARCHAR2(10),
    phone VARCHAR2(20),
    address VARCHAR2(255),
    insurance_id NUMBER
);

CREATE TABLE Doctors (
    doctor_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    specialty VARCHAR2(100),
    phone VARCHAR2(20),
    email VARCHAR2(100)
);

CREATE TABLE Appointments (
    appointment_id NUMBER PRIMARY KEY,
    patient_id NUMBER REFERENCES Patients(patient_id),
    doctor_id NUMBER REFERENCES Doctors(doctor_id),
    appointment_date DATE,
    status VARCHAR2(50)
);

CREATE TABLE Medical_Records (
    record_id NUMBER PRIMARY KEY,
    patient_id NUMBER REFERENCES Patients(patient_id),
    diagnosis VARCHAR2(255),
    treatment VARCHAR2(255),
    record_date DATE
);

CREATE TABLE Billing (
    billing_id NUMBER PRIMARY KEY,
    patient_id NUMBER REFERENCES Patients(patient_id),
    amount NUMBER(10,2),
    billing_date DATE,
    status VARCHAR2(50)
);

CREATE TABLE Departments (
    department_id NUMBER PRIMARY KEY,
    name VARCHAR2(100)
);

CREATE TABLE Insurance (
    insurance_id NUMBER PRIMARY KEY,
    company_name VARCHAR2(100),
    policy_number VARCHAR2(50),
    coverage_details VARCHAR2(255)
);

CREATE TABLE Staff (
    staff_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    role VARCHAR2(50),
    department_id NUMBER REFERENCES Departments(department_id)
);

CREATE TABLE Medications (
    medication_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    stock_quantity NUMBER
);

CREATE TABLE Prescriptions (
    prescription_id NUMBER PRIMARY KEY,
    patient_id NUMBER REFERENCES Patients(patient_id),
    doctor_id NUMBER REFERENCES Doctors(doctor_id),
    medication_id NUMBER REFERENCES Medications(medication_id),
    quantity NUMBER,
    prescription_date DATE
);
-- Insert Insurance
INSERT INTO Insurance VALUES (1, 'HealthPlus', 'HP12345', 'Full coverage');
INSERT INTO Insurance VALUES (2, 'MediCare', 'MC67890', 'Partial coverage');

-- Insert Patients
INSERT INTO Patients VALUES (1, 'John Doe', TO_DATE('1990-05-15','YYYY-MM-DD'), 'Male', '0712345678', '123 Main St', 1);
INSERT INTO Patients VALUES (2, 'Jane Smith', TO_DATE('1985-08-20','YYYY-MM-DD'), 'Female', '0787654321', '456 Elm St', 2);

-- Insert Doctors
INSERT INTO Doctors VALUES (1, 'Dr. Adams', 'Cardiologist', '0700111222', 'adams@hospital.com');
INSERT INTO Doctors VALUES (2, 'Dr. Brown', 'Dermatologist', '0711222333', 'brown@hospital.com');

-- Insert Departments
INSERT INTO Departments VALUES (1, 'Cardiology');
INSERT INTO Departments VALUES (2, 'Dermatology');

-- Insert Staff
INSERT INTO Staff VALUES (1, 'Alice Johnson', 'Nurse', 1);
INSERT INTO Staff VALUES (2, 'Bob Williams', 'Receptionist', 2);

-- Insert Appointments
INSERT INTO Appointments VALUES (1, 1, 1, TO_DATE('2025-04-20','YYYY-MM-DD'), 'Scheduled');
INSERT INTO Appointments VALUES (2, 2, 2, TO_DATE('2025-04-22','YYYY-MM-DD'), 'Scheduled');

-- Insert Medical Records
INSERT INTO Medical_Records VALUES (1, 1, 'Hypertension', 'Medication prescribed', TO_DATE('2025-04-20','YYYY-MM-DD'));
INSERT INTO Medical_Records VALUES (2, 2, 'Acne', 'Topical cream prescribed', TO_DATE('2025-04-22','YYYY-MM-DD'));

-- Insert Billing
INSERT INTO Billing VALUES (1, 1, 500.00, TO_DATE('2025-04-20','YYYY-MM-DD'), 'Unpaid');
INSERT INTO Billing VALUES (2, 2, 300.00, TO_DATE('2025-04-22','YYYY-MM-DD'), 'Paid');

-- Insert Medications
INSERT INTO Medications VALUES (1, 'Atenolol', 50);
INSERT INTO Medications VALUES (2, 'Benzoyl Peroxide Cream', 30);

-- Insert Prescriptions
INSERT INTO Prescriptions VALUES (1, 1, 1, 1, 1, TO_DATE('2025-04-20','YYYY-MM-DD'));
INSERT INTO Prescriptions VALUES (2, 2, 2, 2, 2, TO_DATE('2025-04-22','YYYY-MM-DD'));
-- UPDATE: Update phone number for a patient
UPDATE Patients
SET phone = '0723456789'
WHERE patient_id = 1;

-- DELETE: Remove a patient (maybe they deleted their records)
DELETE FROM Patients
WHERE patient_id = 2;
-- UPDATE: Change a doctor's specialty
UPDATE Doctors
SET specialty = 'General Practitioner'
WHERE doctor_id = 1;

-- DELETE: Remove a doctor who retired
DELETE FROM Doctors
WHERE doctor_id = 2;
-- UPDATE: Change appointment status to 'Completed'
UPDATE Appointments
SET status = 'Completed'
WHERE appointment_id = 1;

-- DELETE: Cancel an appointment (and remove it)
DELETE FROM Appointments
WHERE appointment_id = 2;
-- UPDATE: Update the treatment details for a record
UPDATE Medical_Records
SET treatment = 'Lifestyle changes and medication'
WHERE record_id = 1;

-- DELETE: Remove a wrong medical record
DELETE FROM Medical_Records
WHERE record_id = 2;
-- UPDATE: Update billing status to 'Paid'
UPDATE Billing
SET status = 'Paid'
WHERE billing_id = 1;

-- DELETE: Delete a billing record (maybe duplicated)
DELETE FROM Billing
WHERE billing_id = 2;
-- UPDATE: Rename a department
UPDATE Departments
SET name = 'Internal Medicine'
WHERE department_id = 1;

-- DELETE: Remove a department (if it closed)
DELETE FROM Departments
WHERE department_id = 2;
-- UPDATE: Update insurance coverage details
UPDATE Insurance
SET coverage_details = 'Full coverage including dental'
WHERE insurance_id = 1;

-- DELETE: Remove an insurance company (contract ended)
DELETE FROM Insurance
WHERE insurance_id = 2;
-- UPDATE: Update staff role
UPDATE Staff
SET role = 'Senior Nurse'
WHERE staff_id = 1;

-- DELETE: Delete a staff member record
DELETE FROM Staff
WHERE staff_id = 2;
-- UPDATE: Add new stock to a medication
UPDATE Medications
SET stock_quantity = stock_quantity + 20
WHERE medication_id = 1;

-- DELETE: Remove a medication (outdated product)
DELETE FROM Medications
WHERE medication_id = 2;
-- UPDATE: Change quantity in a prescription
UPDATE Prescriptions
SET quantity = 3
WHERE prescription_id = 1;

-- DELETE: Delete a wrong prescription
DELETE FROM Prescriptions
WHERE prescription_id = 2;

