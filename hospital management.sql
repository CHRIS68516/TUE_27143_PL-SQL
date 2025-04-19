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
