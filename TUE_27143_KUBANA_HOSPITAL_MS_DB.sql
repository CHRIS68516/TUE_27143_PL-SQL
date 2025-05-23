-- Create Insurance Table (Must come before Patients)
CREATE TABLE Insurance (
    insurance_id NUMBER PRIMARY KEY,
    company_name VARCHAR2(100),
    policy_number VARCHAR2(50),
    coverage_details VARCHAR2(255)
);

-- Create Doctors Table (Must come before Appointments and Prescriptions)
CREATE TABLE Doctors (
    doctor_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    specialty VARCHAR2(100),
    phone VARCHAR2(20),
    email VARCHAR2(100)
);

-- Create Departments Table (Must come before Staff)
CREATE TABLE Departments (
    department_id NUMBER PRIMARY KEY,
    name VARCHAR2(100)
);

-- Create Medications Table (Must come before Prescriptions)
CREATE TABLE Medications (
    medication_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    stock_quantity NUMBER
);

-- Create Patients Table (Depends on Insurance)
CREATE TABLE Patients (
    patient_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    dob DATE,
    gender VARCHAR2(10),
    phone VARCHAR2(20),
    address VARCHAR2(255),
    insurance_id NUMBER,
    CONSTRAINT fk_insurance FOREIGN KEY (insurance_id) REFERENCES Insurance(insurance_id)
);

-- Create Staff Table (Depends on Departments)
CREATE TABLE Staff (
    staff_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    role VARCHAR2(50),
    department_id NUMBER,
    CONSTRAINT fk_staff_department FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Create Appointments Table (Depends on Patients and Doctors)
CREATE TABLE Appointments (
    appointment_id NUMBER PRIMARY KEY,
    patient_id NUMBER,
    doctor_id NUMBER,
    appointment_date DATE,
    status VARCHAR2(50),
    CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Create Medical Records Table (Depends on Patients)
CREATE TABLE Medical_Records (
    record_id NUMBER PRIMARY KEY,
    patient_id NUMBER,
    diagnosis VARCHAR2(255),
    treatment VARCHAR2(255),
    record_date DATE,
    CONSTRAINT fk_medical_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Create Billing Table (Depends on Patients)
CREATE TABLE Billing (
    billing_id NUMBER PRIMARY KEY,
    patient_id NUMBER,
    amount NUMBER(10,2),
    billing_date DATE,
    status VARCHAR2(50),
    CONSTRAINT fk_billing_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Create Prescriptions Table (Depends on Patients, Doctors, and Medications)
CREATE TABLE Prescriptions (
    prescription_id NUMBER PRIMARY KEY,
    patient_id NUMBER,
    doctor_id NUMBER,
    medication_id NUMBER,
    quantity NUMBER,
    prescription_date DATE,
    CONSTRAINT fk_prescription_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    CONSTRAINT fk_prescription_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    CONSTRAINT fk_prescription_medication FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);
-- Insert into Insurance
INSERT INTO Insurance VALUES (1, 'HealthSecure Inc.', 'HS123456', 'Full Coverage');
INSERT INTO Insurance VALUES (2, 'MediCare Plus', 'MC654321', 'Partial Coverage');

-- Insert into Departments
INSERT INTO Departments VALUES (1, 'Cardiology');
INSERT INTO Departments VALUES (2, 'Pediatrics');

-- Insert into Doctors
INSERT INTO Doctors VALUES (1, 'Dr. Alice Smith', 'Cardiologist', '123-456-7890', 'alice@hospital.org');
INSERT INTO Doctors VALUES (2, 'Dr. Bob Jones', 'Pediatrician', '987-654-3210', 'bob@hospital.org');

-- Insert into Medications
INSERT INTO Medications VALUES (1, 'Paracetamol', 200);
INSERT INTO Medications VALUES (2, 'Amoxicillin', 100);

-- Insert into Patients (Must match insurance_id from Insurance)
INSERT INTO Patients VALUES (1, 'John Doe', TO_DATE('1985-06-15', 'YYYY-MM-DD'), 'Male', '555-1234', '123 Main St', 1);
INSERT INTO Patients VALUES (2, 'Jane Roe', TO_DATE('1990-09-21', 'YYYY-MM-DD'), 'Female', '555-5678', '456 Oak St', 2);

-- Insert into Staff (Must match department_id from Departments)
INSERT INTO Staff VALUES (1, 'Nancy White', 'Nurse', 1);
INSERT INTO Staff VALUES (2, 'Mark Brown', 'Technician', 2);

-- Insert into Appointments (Must match patient_id and doctor_id)
INSERT INTO Appointments VALUES (1, 1, 1, TO_DATE('2025-05-10', 'YYYY-MM-DD'), 'Scheduled');
INSERT INTO Appointments VALUES (2, 2, 2, TO_DATE('2025-05-11', 'YYYY-MM-DD'), 'Completed');

-- Insert into Medical Records (Must match patient_id)
INSERT INTO Medical_Records VALUES (1, 1, 'Hypertension', 'Prescribed medication', TO_DATE('2025-05-10', 'YYYY-MM-DD'));
INSERT INTO Medical_Records VALUES (2, 2, 'Fever', 'Rest and fluids', TO_DATE('2025-05-11', 'YYYY-MM-DD'));

-- Insert into Billing (Must match patient_id)
INSERT INTO Billing VALUES (1, 1, 250.00, TO_DATE('2025-05-10', 'YYYY-MM-DD'), 'Paid');
INSERT INTO Billing VALUES (2, 2, 150.00, TO_DATE('2025-05-11', 'YYYY-MM-DD'), 'Pending');

-- Insert into Prescriptions (Must match patient_id, doctor_id, medication_id)
INSERT INTO Prescriptions VALUES (1, 1, 1, 1, 30, TO_DATE('2025-05-10', 'YYYY-MM-DD'));
INSERT INTO Prescriptions VALUES (2, 2, 2, 2, 20, TO_DATE('2025-05-11', 'YYYY-MM-DD'));
-- Insurance
INSERT INTO Insurance VALUES (3, 'LifeCare Assurance', 'LC112233', 'Dental + Vision');
INSERT INTO Insurance VALUES (4, 'SafeHealth', 'SH778899', 'Full Coverage with Co-pay');

-- Departments
INSERT INTO Departments VALUES (3, 'Neurology');
INSERT INTO Departments VALUES (4, 'Orthopedics');

-- Doctors
INSERT INTO Doctors VALUES (3, 'Dr. Clara Osei', 'Neurologist', '111-222-3333', 'clara@hospital.org');
INSERT INTO Doctors VALUES (4, 'Dr. David Kim', 'Orthopedic Surgeon', '444-555-6666', 'david@hospital.org');

-- Medications
INSERT INTO Medications VALUES (3, 'Ibuprofen', 150);
INSERT INTO Medications VALUES (4, 'Metformin', 80);

-- Patients
INSERT INTO Patients VALUES (3, 'Michael Lee', TO_DATE('1978-12-03', 'YYYY-MM-DD'), 'Male', '555-9012', '789 Pine St', 3);
INSERT INTO Patients VALUES (4, 'Sarah Green', TO_DATE('2002-07-19', 'YYYY-MM-DD'), 'Female', '555-3456', '321 Elm St', 4);
INSERT INTO Patients VALUES (5, 'Peter Grant', TO_DATE('1965-11-25', 'YYYY-MM-DD'), 'Male', '555-6789', '654 Birch St', 1);

-- Staff
INSERT INTO Staff VALUES (3, 'Linda Hope', 'Receptionist', 3);
INSERT INTO Staff VALUES (4, 'George Stone', 'Radiologist', 4);

-- Appointments
INSERT INTO Appointments VALUES (3, 3, 3, TO_DATE('2025-05-12', 'YYYY-MM-DD'), 'Scheduled');
INSERT INTO Appointments VALUES (4, 4, 4, TO_DATE('2025-05-12', 'YYYY-MM-DD'), 'Cancelled');
INSERT INTO Appointments VALUES (5, 5, 1, TO_DATE('2025-05-13', 'YYYY-MM-DD'), 'Completed');

-- Medical Records
INSERT INTO Medical_Records VALUES (3, 3, 'Migraine', 'Neurology assessment', TO_DATE('2025-05-12', 'YYYY-MM-DD'));
INSERT INTO Medical_Records VALUES (4, 4, 'Fractured arm', 'Cast applied', TO_DATE('2025-05-12', 'YYYY-MM-DD'));
INSERT INTO Medical_Records VALUES (5, 5, 'High blood pressure', 'Medication prescribed', TO_DATE('2025-05-13', 'YYYY-MM-DD'));

-- Billing
INSERT INTO Billing VALUES (3, 3, 300.00, TO_DATE('2025-05-12', 'YYYY-MM-DD'), 'Paid');
INSERT INTO Billing VALUES (4, 4, 500.00, TO_DATE('2025-05-12', 'YYYY-MM-DD'), 'Pending');
INSERT INTO Billing VALUES (5, 5, 220.00, TO_DATE('2025-05-13', 'YYYY-MM-DD'), 'Paid');

-- Prescriptions
INSERT INTO Prescriptions VALUES (3, 3, 3, 3, 15, TO_DATE('2025-05-12', 'YYYY-MM-DD'));
INSERT INTO Prescriptions VALUES (4, 4, 4, 1, 10, TO_DATE('2025-05-12', 'YYYY-MM-DD'));
INSERT INTO Prescriptions VALUES (5, 5, 1, 4, 25, TO_DATE('2025-05-13', 'YYYY-MM-DD'));
SELECT p.patient_id, p.name AS patient_name, i.company_name, i.coverage_details
FROM Patients p
JOIN Insurance i ON p.insurance_id = i.insurance_id;
SELECT a.appointment_id, p.name AS patient_name, d.name AS doctor_name, a.appointment_date, a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.appointment_date = TO_DATE('2025-05-12', 'YYYY-MM-DD');
SELECT pr.prescription_id, p.name AS patient, m.name AS medication, pr.quantity, d.name AS doctor
FROM Prescriptions pr
JOIN Patients p ON pr.patient_id = p.patient_id
JOIN Medications m ON pr.medication_id = m.medication_id
JOIN Doctors d ON pr.doctor_id = d.doctor_id;
UPDATE Appointments
SET status = 'Completed'
WHERE appointment_id = 3;
UPDATE Medications
SET stock_quantity = stock_quantity - 10
WHERE medication_id = 1;  -- Make sure 10 or more are in stock
UPDATE Patients
SET phone = '555-9999'
WHERE patient_id = 2;
UPDATE Billing
SET status = 'Paid'
WHERE billing_id = 4;

