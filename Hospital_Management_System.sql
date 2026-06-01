CREATE DATABASE IF NOT EXISTS HospitalAnalytics;
USE HospitalAnalytics;

-- Departments Table
CREATE TABLE Departments (
    Department_ID INT PRIMARY KEY AUTO_INCREMENT,
    Department_Name VARCHAR(100),
    Floor_Number INT
);

-- Doctors Table
CREATE TABLE Doctors (
    Doctor_ID INT PRIMARY KEY AUTO_INCREMENT,
    Doctor_Name VARCHAR(100),
    Specialty VARCHAR(100),
    Salary DECIMAL(10,2),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID)
);

-- Patients Table
CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    Phone VARCHAR(20),
    City VARCHAR(50)
);

-- Insurance Table
CREATE TABLE Insurance (
    Insurance_ID INT PRIMARY KEY AUTO_INCREMENT,
    Provider_Name VARCHAR(100),
    Coverage_Percentage INT
);

-- Appointments Table
CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID INT,
    Doctor_ID INT,
    Appointment_Date DATE,
    Status VARCHAR(20),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

-- Billing Table
CREATE TABLE Billing (
    Bill_ID INT PRIMARY KEY AUTO_INCREMENT,
    Appointment_ID INT,
    Amount DECIMAL(10,2),
    Payment_Status VARCHAR(20),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointments(Appointment_ID)
);

-- Hospital Financial Report View
CREATE VIEW Hospital_Financial_Report AS
SELECT
    D.Department_Name,
    Doc.Doctor_Name,
    COUNT(A.Appointment_ID) AS Total_Appointments,
    SUM(B.Amount) AS Total_Revenue,
    AVG(B.Amount) AS Average_Bill
FROM Appointments A
JOIN Doctors Doc ON A.Doctor_ID = Doc.Doctor_ID
JOIN Departments D ON Doc.Department_ID = D.Department_ID
JOIN Billing B ON A.Appointment_ID = B.Appointment_ID
GROUP BY D.Department_Name, Doc.Doctor_Name;
