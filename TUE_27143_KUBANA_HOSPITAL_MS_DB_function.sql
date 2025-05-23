CREATE OR REPLACE FUNCTION FUNC_GetBillingSummary(p_patient_id NUMBER)
RETURN VARCHAR2 IS
    v_total_amount NUMBER(10,2);
    v_status_list  VARCHAR2(1000);
BEGIN
    -- Calculate total billing for the patient
    SELECT SUM(amount) INTO v_total_amount
    FROM Billing
    WHERE patient_id = p_patient_id;

    -- Collect statuses
    SELECT LISTAGG(status, ', ') WITHIN GROUP (ORDER BY billing_date)
    INTO v_status_list
    FROM Billing
    WHERE patient_id = p_patient_id;

    -- Return formatted summary
    RETURN 'Total: $' || v_total_amount || ' | Statuses: ' || v_status_list;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'No billing records found.';
    WHEN OTHERS THEN
        RETURN 'Error retrieving billing summary.';
END;
/
SELECT FUNC_GetBillingSummary(1) AS billing_info FROM dual;

CREATE OR REPLACE FUNCTION FUNC_GetPatientProfile(p_patient_id NUMBER)
RETURN VARCHAR2 IS
    v_name      VARCHAR2(100);
    v_phone     VARCHAR2(20);
    v_insurance VARCHAR2(100);
BEGIN
    SELECT p.name, p.phone, i.company_name
    INTO v_name, v_phone, v_insurance
    FROM Patients p
    JOIN Insurance i ON p.insurance_id = i.insurance_id
    WHERE p.patient_id = p_patient_id;

    RETURN '👤 Name: ' || v_name || 
           ' | 📞 Phone: ' || v_phone || 
           ' | 🏥 Insurance: ' || v_insurance;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '⚠️ Patient not found.';
    WHEN OTHERS THEN
        RETURN '❌ Error retrieving patient profile.';
END;
/

SELECT FUNC_GetPatientProfile(1) AS patient_profile FROM dual;

CREATE OR REPLACE FUNCTION FUNC_DoctorAppointmentCount(
    p_doctor_id NUMBER,
    p_status VARCHAR2 DEFAULT NULL
) RETURN NUMBER IS
    v_count NUMBER;
BEGIN
    IF p_status IS NULL THEN
        SELECT COUNT(*) INTO v_count
        FROM Appointments
        WHERE doctor_id = p_doctor_id;
    ELSE
        SELECT COUNT(*) INTO v_count
        FROM Appointments
        WHERE doctor_id = p_doctor_id AND status = p_status;
    END IF;

    RETURN v_count;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1;
END;
/
SELECT FUNC_DoctorAppointmentCount(1) FROM dual;
SELECT FUNC_DoctorAppointmentCount(1, 'Completed') FROM dual;

CREATE OR REPLACE FUNCTION FUNC_CalculateTotalBill(p_patient_id NUMBER)
RETURN NUMBER IS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(amount), 0)
    INTO v_total
    FROM Billing
    WHERE patient_id = p_patient_id;

    RETURN v_total;
EXCEPTION
    WHEN OTHERS THEN
        RETURN -1;
END;
/
SELECT FUNC_CalculateTotalBill(1) AS total_bill FROM dual;

CREATE OR REPLACE FUNCTION FUNC_CheckMedicationStock(p_medication_id NUMBER)
RETURN VARCHAR2 IS
    v_qty NUMBER;
BEGIN
    SELECT stock_quantity INTO v_qty
    FROM Medications
    WHERE medication_id = p_medication_id;

    IF v_qty > 0 THEN
        RETURN 'In Stock: ' || v_qty;
    ELSE
        RETURN 'Out of Stock';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Medication not found';
    WHEN OTHERS THEN
        RETURN 'Error checking stock';
END;
/

SELECT FUNC_CheckMedicationStock(1) AS stock_status FROM dual;


CREATE OR REPLACE FUNCTION FUNC_GetPatientInfo(p_patient_id NUMBER)
RETURN VARCHAR2 IS
    v_info VARCHAR2(500);
BEGIN
    SELECT 'Name: ' || p.name || ', Phone: ' || p.phone || ', Insurance: ' || i.company_name
    INTO v_info
    FROM Patients p
    JOIN Insurance i ON p.insurance_id = i.insurance_id
    WHERE p.patient_id = p_patient_id;

    RETURN v_info;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Patient not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving patient info';
END;
/
SELECT FUNC_GetPatientInfo(2) AS patient_info FROM dual;

CREATE OR REPLACE PROCEDURE PROC_UpdatePatientPhone(p_patient_id NUMBER, p_new_phone VARCHAR2) IS
BEGIN
    UPDATE Patients
    SET phone = p_new_phone
    WHERE patient_id = p_patient_id;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/

EXEC PROC_UpdatePatientPhone(2, '555-7777');


CREATE OR REPLACE PROCEDURE PROC_AddAppointment(
    p_patient_id NUMBER,
    p_doctor_id NUMBER,
    p_date DATE,
    p_status VARCHAR2
) IS
BEGIN
    INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status)
    VALUES (Appointments_seq.NEXTVAL, p_patient_id, p_doctor_id, p_date, p_status);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/
CREATE SEQUENCE Appointments_seq
START WITH 6  -- Assuming the last used ID is 5
INCREMENT BY 1
NOCACHE
NOCYCLE;


CREATE OR REPLACE PACKAGE Hospital_Pkg AS
  -- Functions
  FUNCTION FUNC_CalculateTotalBill(p_patient_id NUMBER) RETURN NUMBER;
  FUNCTION FUNC_DoctorAppointmentCount(p_doctor_id NUMBER) RETURN NUMBER;
  FUNCTION FUNC_CheckMedicationStock(p_medication_id NUMBER) RETURN VARCHAR2;
  FUNCTION FUNC_GetPatientInfo(p_patient_id NUMBER) RETURN VARCHAR2;

  -- Procedures
  PROCEDURE PROC_AddAppointment(p_patient_id NUMBER, p_doctor_id NUMBER, p_date DATE, p_status VARCHAR2);
  PROCEDURE PROC_UpdateBillingStatus(p_billing_id NUMBER, p_new_status VARCHAR2);
END Hospital_Pkg;
/


CREATE OR REPLACE PACKAGE BODY Hospital_Pkg AS

  FUNCTION FUNC_CalculateTotalBill(p_patient_id NUMBER) RETURN NUMBER IS
    v_total NUMBER := 0;
  BEGIN
    SELECT NVL(SUM(amount), 0) INTO v_total
    FROM Billing
    WHERE patient_id = p_patient_id;
    RETURN v_total;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN -1;
  END FUNC_CalculateTotalBill;

  FUNCTION FUNC_DoctorAppointmentCount(p_doctor_id NUMBER) RETURN NUMBER IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Appointments
    WHERE doctor_id = p_doctor_id;
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN -1;
  END FUNC_DoctorAppointmentCount;

  FUNCTION FUNC_CheckMedicationStock(p_medication_id NUMBER) RETURN VARCHAR2 IS
    v_qty NUMBER;
  BEGIN
    SELECT stock_quantity INTO v_qty
    FROM Medications
    WHERE medication_id = p_medication_id;

    IF v_qty > 0 THEN
      RETURN 'In Stock: ' || v_qty;
    ELSE
      RETURN 'Out of Stock';
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 'Medication not found';
    WHEN OTHERS THEN
      RETURN 'Error checking stock';
  END FUNC_CheckMedicationStock;

  FUNCTION FUNC_GetPatientInfo(p_patient_id NUMBER) RETURN VARCHAR2 IS
    v_info VARCHAR2(500);
  BEGIN
    SELECT 'Name: ' || p.name || ', Phone: ' || p.phone || ', Insurance: ' || i.company_name
    INTO v_info
    FROM Patients p
    JOIN Insurance i ON p.insurance_id = i.insurance_id
    WHERE p.patient_id = p_patient_id;

    RETURN v_info;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 'Patient not found';
    WHEN OTHERS THEN
      RETURN 'Error retrieving patient info';
  END FUNC_GetPatientInfo;

  PROCEDURE PROC_AddAppointment(
    p_patient_id NUMBER,
    p_doctor_id NUMBER,
    p_date DATE,
    p_status VARCHAR2
  ) IS
  BEGIN
    INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status)
    VALUES (Appointments_seq.NEXTVAL, p_patient_id, p_doctor_id, p_date, p_status);
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END PROC_AddAppointment;

  PROCEDURE PROC_UpdateBillingStatus(
    p_billing_id NUMBER,
    p_new_status VARCHAR2
  ) IS
  BEGIN
    UPDATE Billing
    SET status = p_new_status
    WHERE billing_id = p_billing_id;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END PROC_UpdateBillingStatus;

END Hospital_Pkg;
/

-- Function call
SELECT Hospital_Pkg.FUNC_GetPatientInfo(1) FROM dual;

-- Procedure call
BEGIN
  Hospital_Pkg.PROC_AddAppointment(1, 2, TO_DATE('2025-05-14', 'YYYY-MM-DD'), 'Scheduled');
END;

CREATE TABLE Appointment_Log (
    log_id NUMBER PRIMARY KEY,
    appointment_id NUMBER,
    patient_id NUMBER,
    doctor_id NUMBER,
    log_date DATE
);
CREATE SEQUENCE Appointment_Log_Seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_log_appointment
AFTER INSERT ON Appointments
FOR EACH ROW
BEGIN
  INSERT INTO Appointment_Log (
    log_id, appointment_id, patient_id, doctor_id, log_date
  ) VALUES (
    Appointment_Log_Seq.NEXTVAL, :NEW.appointment_id, :NEW.patient_id, :NEW.doctor_id, SYSDATE
  );
END;
/
CREATE TABLE Appointment_Bulk_Log (
    log_id NUMBER PRIMARY KEY,
    appointment_id NUMBER,
    patient_id NUMBER,
    doctor_id NUMBER,
    log_date DATE
);

CREATE SEQUENCE Appointment_Bulk_Log_Seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER trg_bulk_appointment_log
FOR INSERT ON Appointments
COMPOUND TRIGGER

  TYPE t_appointment_info IS RECORD (
    appointment_id Appointments.appointment_id%TYPE,
    patient_id     Appointments.patient_id%TYPE,
    doctor_id      Appointments.doctor_id%TYPE
  );

  TYPE t_appointment_table IS TABLE OF t_appointment_info;
  g_appointment_data t_appointment_table := t_appointment_table();

  AFTER EACH ROW IS
  BEGIN
    g_appointment_data.EXTEND;
    g_appointment_data(g_appointment_data.COUNT) := t_appointment_info(
      :NEW.appointment_id,
      :NEW.patient_id,
      :NEW.doctor_id
    );
  END AFTER EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    FOR i IN 1 .. g_appointment_data.COUNT LOOP
      INSERT INTO Appointment_Bulk_Log (
        log_id,
        appointment_id,
        patient_id,
        doctor_id,
        log_date
      ) VALUES (
        Appointment_Bulk_Log_Seq.NEXTVAL,
        g_appointment_data(i).appointment_id,
        g_appointment_data(i).patient_id,
        g_appointment_data(i).doctor_id,
        SYSDATE
      );
    END LOOP;
  END AFTER STATEMENT;

END trg_bulk_appointment_log;
/
