 ## 🏥 HOSPITAL APPOINTMENT AND MANAGEMENT SYSTEM ##


 ****📌 Project Overview****

The ****Hospital Appointment and Management System**** is a comprehensive Oracle PL/SQL-based application designed to automate and streamline hospital operations. It addresses key challenges in appointment scheduling, medical records, billing, and staff/medication tracking to enhance operational efficiency and improve patient care.


***🚩 Problem Definition***

***odern hospitals face several inefficiencies, including:***

✅Poorly managed appointment scheduling systems

✅Unstructured and fragmented medical records

✅Complexities in insurance processing and billing

✅Limited automation in staff and medication inventory management



***🎯 Project Objectives***

This system aims to:

✅ Automate patient, staff, and appointment management

✅ Improve access to and tracking of medical records

✅ Streamline billing and insurance integration

✅ Manage medication prescriptions and inventory automatically

✅ Provide real-time views for better hospital decision-making


## PhaseII: Business Process Modeling (Related to Management Information Systems - MIS) ##

This BPMN diagram shows a healthcare workflow where a patient requests an appointment. If the doctor is unavailable, it's scheduled for later. If available, the patient is seen and a medical record is updated. The MIS system handles scheduling, consultations, and checks medication stock. If stock is available, the billing department generates a bill and processes payment. If not, the process ends. It involves patients, reception/nurses, the MIS system, and billing.

![BPMN IO](https://github.com/user-attachments/assets/245cb667-13df-4fb2-8a6b-f8b3efcf15f3)



## PhaseIII: Logical Model Design ##

This diagram shows a hospital database structure with tables for Patients, Doctors, Appointments, Medical Records, Billing, Insurance, Medications, Prescriptions, Departments, and Staff. Each patient can have insurance, appointments with doctors, medical records, bills, and prescriptions. Prescriptions link doctors, patients, and medications. Staff members belong to departments. The system is designed to track all hospital operations efficiently through these connected entities.

![ERD D](https://github.com/user-attachments/assets/41866b70-ce51-407b-93b3-708418dea4fb)



## PhaseIV: Database (Pluggable Database) Creation and Naming ##
***🗃️ Database Design and  💻 PL/SQL Implementation*** 

***DCL(Data Control Language)***

***Pluggabl database***

<img width="752" alt="pluggable database " src="https://github.com/user-attachments/assets/1e536fa3-e4c1-4a0e-873c-ff782e11e49f" />

<img width="483" alt="pluggable database 2" src="https://github.com/user-attachments/assets/ca1a8ef8-9a37-4559-ad25-27f4635192aa" />


***Conceptual Diagram***

<img width="761" alt="model of appointments" src="https://github.com/user-attachments/assets/3b78d9df-a42e-436c-a23d-1de4bc583773" />

<img width="960" alt="model of staff" src="https://github.com/user-attachments/assets/151c7a1e-ca4c-47b5-a05b-a282e43a90bf" />

<img width="939" alt="model of doctors" src="https://github.com/user-attachments/assets/1914c675-0571-4b73-98a7-14daf63e916e" />

<img width="670" alt="model of insurance" src="https://github.com/user-attachments/assets/a1b7ff4f-442d-4dab-8dad-d649971bf3d5" />

<img width="841" alt="model of medical_records" src="https://github.com/user-attachments/assets/b40975f7-c236-4b5a-b08f-5f1109f6c9aa" />

<img width="960" alt="model of patients" src="https://github.com/user-attachments/assets/6f797b01-f9fb-4ba9-a0aa-1a92c4f27112" />

<img width="960" alt="model of prescripitions" src="https://github.com/user-attachments/assets/2cb4d25f-dee2-460a-bf50-bdddb6a92162" />

<img width="960" alt="model of staff" src="https://github.com/user-attachments/assets/93ea3fe5-f297-43ca-b802-3959a1f24767" />

*****Creating Tables*****

<img width="960" alt="create table" src="https://github.com/user-attachments/assets/d3ef0ca0-b28c-4ad1-a061-09db74dbc48a" />

<img width="958" alt="create" src="https://github.com/user-attachments/assets/82b97311-ecad-4c14-8b5f-c918de150e87" />


## PhaseV: Table Implementation and Data Insertion ##

***DML(Data Manipulation Language)***

***INSERT INTO TABLES***

<img width="960" alt="insert " src="https://github.com/user-attachments/assets/44f8d25d-2927-46e9-a119-7ed4112eedab" />

***SELECT INTO TABLES***

<img width="958" alt="select" src="https://github.com/user-attachments/assets/0b466256-2a76-4535-a4ea-3f163b71cc47" />

***DELETE INTO TABLES***

<img width="959" alt="delete" src="https://github.com/user-attachments/assets/964a0bd0-7fd1-4a9a-bedb-070fe91b9ff6" />

***UPDATE INTO TABLES***

<img width="960" alt="update" src="https://github.com/user-attachments/assets/e9b41a5e-f14e-4b52-b347-c114c3320573" />


 ## PhaseVI: Database Interaction and Transactions ##

 ***Triggers***                            
Prevents double bookings for doctors and rooms

Automatically reduces medication stock upon prescription

<img width="950" alt="triggers" src="https://github.com/user-attachments/assets/393323cf-c1c7-42e7-9814-80d4542b7457" />

<img width="960" alt="compound trigger" src="https://github.com/user-attachments/assets/61553555-8b0a-48e8-90d7-69b4b25b0fc8" />


***Functions***

<img width="960" alt="function call" src="https://github.com/user-attachments/assets/abab0a58-eeee-4b26-b916-3fc4e6335397" />

***Function getbillingsummary***

<img width="958" alt="function getbillingsummary" src="https://github.com/user-attachments/assets/677969a6-f57f-444d-8574-9e0ae97d09aa" />

***Calculate Total Bill for a Patient***

<img width="959" alt="Calculate Total Bill for a Patient" src="https://github.com/user-attachments/assets/57a4bad2-30fa-42a9-b9d2-d11a18e664c4" />

***Calculate Total Bill for a Patient1***

<img width="960" alt="Calculate Total Bill for a Patient1" src="https://github.com/user-attachments/assets/1cc79333-72d0-496d-8bea-efa48a970749" />

***Check Medication Stock***

<img width="960" alt="Check Medication Stock" src="https://github.com/user-attachments/assets/34afec41-5ddd-4690-8dad-529aae09b150" />

***RESULT OF FUNCTIONS***

<img width="960" alt="result Check Medication Stock" src="https://github.com/user-attachments/assets/668fa6ec-71b4-4d81-962b-067ece764436" />

<img width="960" alt="result doctor function " src="https://github.com/user-attachments/assets/bd1082fe-1428-43db-94f9-c34adab1b787" />

<img width="960" alt="result function" src="https://github.com/user-attachments/assets/311de5a8-b8bf-462d-95fd-b1f33b0baf19" />

<img width="954" alt="result Get Patient Info" src="https://github.com/user-attachments/assets/b7294704-a7d5-46b7-ba34-9c5ca22d7d95" />

<img width="960" alt="result patient" src="https://github.com/user-attachments/assets/a835cac6-de80-4d13-897b-2b4306d83556" />


***Procedures***

<img width="946" alt="PROC_AddAppointment" src="https://github.com/user-attachments/assets/77e44cd6-b3a8-4848-aab2-643dea9617b6" />

<img width="953" alt="procedures of PROC_UpdatePatientPhone" src="https://github.com/user-attachments/assets/dc56cb9b-3e8d-412b-b37e-ccd8fb1cb5fc" />

***Packages***

<img width="959" alt="package" src="https://github.com/user-attachments/assets/9a1d03b5-97e8-43e7-b0da-a4e3315cd985" />

<img width="960" alt="package body hospital" src="https://github.com/user-attachments/assets/28f84360-4bbe-4387-9c7b-093711b29896" />





***🧪 Technologies Used***

✅ ***Oracle Database 18c***

✅ PL/SQL

✅ ***SQL Developer***


***🚀 How to Run the Project****

✅Clone the repository or download the SQL scripts.

✅Connect to your Oracle database using SQL Developer.

✅Execute the SQL scripts to create tables, views, procedures, functions, and triggers.

✅Populate the tables with sample data (if available).

✅Use the procedures and views to interact with the system.



🙋‍♂️ Contributors

NAME:IRADUKUNDA KUBANA CHRISTIAN

Student at Adventist University of Central Africa

ID: 27143

GROUP:B



