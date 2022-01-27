CREATE DATABASE IF NOT EXISTS proyecto;

USE proyecto;

CREATE TABLE stroke_data (
	id_caso INT PRIMARY KEY,
    gender varchar(7),
    age INT,
    hypertension INT,
    heart_disease INT,
    ever_married varchar(4),
    work_type varchar(20),
    residence varchar(7),
    avg_glucose_level float,
    bmi float,
    smoking_status varchar(30),
    stroke tinyint
);

CREATE TABLE heart_attack (
	id_caso INT PRIMARY KEY,
    age tinyint,
    anaemia tinyint,
    creatinine int,
    diabetes tinyint,
    ejection_fraction tinyint,
    high_blood_pressure tinyint,
    platelets int,
    serum_creatinine float,
    serum_sodium int,
    sex tinyint,
    smoking tinyint,
    death_event tinyint
);

DROP TABLE heart_attack;

CREATE TABLE patient_conditon (
	id_patient INT PRIMARY KEY,
    male tinyint,
    age tinyint,
    currentSmoker tinyint,
    cigsPerDay tinyint,
    BPMeds tinyint,
    prevalentStroke tinyint,
    prevalentHyp tinyint,
    diabetes tinyint,
    totChol int,
    bmi float,
    heartRate tinyint,
    glucose varchar(4)
    );
    
SELECT * from patient_conditon;
    
 




    



