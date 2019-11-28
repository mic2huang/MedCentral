DROP TABLE IF EXISTS patient_hcp;
DROP TABLE IF EXISTS genetic_report;
DROP TABLE IF EXISTS lab_report;
DROP TABLE IF EXISTS medical_report;
DROP TABLE IF EXISTS genetic_result;
DROP TABLE IF EXISTS lab_result;
DROP TABLE IF EXISTS medical_result;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS hcp;
DROP TABLE IF EXISTS researcher;
DROP TABLE IF EXISTS user;

CREATE TABLE user (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    pword VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE patient (
    user_id INT NOT NULL,
    research_opt_in BOOLEAN NOT NULL DEFAULT FALSE,
    family_data_share BOOLEAN NOT NULL DEFAULT FALSE,
    deceased BOOLEAN NOT NULL DEFAULT FALSE,
    genetic_mother INT DEFAULT NULL,
    genetic_father INT DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES user (id),
    FOREIGN KEY (genetic_mother) REFERENCES patient (user_id),
    FOREIGN KEY (genetic_father) REFERENCES patient (user_id),
    PRIMARY KEY (user_id)
);

CREATE TABLE hcp (
    user_id INT NOT NULL,
    username VARCHAR(30) NOT NULL,
    pword VARCHAR(30) NOT NULL,
    heirarchy_level INT NOT NULL DEFAULT 1,
    specialization VARCHAR(50) DEFAULT NULL,
    organization VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user (id),
    PRIMARY KEY (user_id)
);

CREATE TABLE patient_hcp (
    patient_id INT NOT NULL,
    hcp_id INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patient (user_id),
    FOREIGN KEY (hcp_id) REFERENCES hcp (user_id),
    PRIMARY KEY (patient_id, hcp_id)
);

CREATE TABLE researcher (
    user_id INT NOT NULL,
    username VARCHAR(30) NOT NULL,
    pword VARCHAR(30) NOT NULL,
    specialization VARCHAR(50) DEFAULT NULL,
    organization VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user (id),
    PRIMARY KEY (user_id)
);

CREATE TABLE genetic_result (
    id INT NOT NULL AUTO_INCREMENT,
    result VARCHAR(255) NOT NULL,
    researcher_access BOOLEAN NOT NULL DEFAULT FALSE,
    family_access BOOLEAN NOT NULL DEFAULT FALSE,
    ancestor_access BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    creation_date DATE,
    PRIMARY KEY (id)
);

CREATE TABLE lab_result (
    id INT NOT NULL AUTO_INCREMENT,
    result VARCHAR(255) NOT NULL,
    researcher_access BOOLEAN NOT NULL DEFAULT FALSE,
    family_access BOOLEAN NOT NULL DEFAULT FALSE,
    ancestor_access BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    creation_date DATE,
    PRIMARY KEY (id)
);

CREATE TABLE medical_result (
    id INT NOT NULL AUTO_INCREMENT,
    result VARCHAR(255) NOT NULL,
    researcher_access BOOLEAN NOT NULL DEFAULT FALSE,
    family_access BOOLEAN NOT NULL DEFAULT FALSE,
    ancestor_access BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    creation_date DATE,
    PRIMARY KEY (id)
);

CREATE TABLE genetic_report (
    id INT NOT NULL AUTO_INCREMENT,
    researcher_access BOOLEAN NOT NULL DEFAULT FALSE,
    family_access BOOLEAN NOT NULL DEFAULT FALSE,
    ancestor_access BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    creation_date DATE,
    patient_id INT NOT NULL,
    hcp_id INT NOT NULL,
    genetic_result_id INT DEFAULT NULL,
    FOREIGN KEY (genetic_result_id) REFERENCES genetic_result (id),
    FOREIGN KEY (patient_id) REFERENCES patient (user_id),
    FOREIGN KEY (hcp_id) REFERENCES hcp (user_id),
    PRIMARY KEY (id)
);

CREATE TABLE lab_report (
    id INT NOT NULL AUTO_INCREMENT,
    researcher_access BOOLEAN NOT NULL DEFAULT FALSE,
    family_access BOOLEAN NOT NULL DEFAULT FALSE,
    ancestor_access BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    creation_date DATE,
    patient_id INT NOT NULL,
    hcp_id INT NOT NULL,
    lab_result_id INT DEFAULT NULL,
    FOREIGN KEY (lab_result_id) REFERENCES lab_result (id),
    FOREIGN KEY (patient_id) REFERENCES patient (user_id),
    FOREIGN KEY (hcp_id) REFERENCES hcp (user_id),
    PRIMARY KEY (id)
);

CREATE TABLE medical_report (
    id INT NOT NULL AUTO_INCREMENT,
    researcher_access BOOLEAN NOT NULL DEFAULT FALSE,
    family_access BOOLEAN NOT NULL DEFAULT FALSE,
    ancestor_access BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    creation_date DATE,
    patient_id INT NOT NULL,
    hcp_id INT NOT NULL,
    medical_result_id INT DEFAULT NULL,
    FOREIGN KEY (medical_result_id) REFERENCES medical_result (id),
    FOREIGN KEY (patient_id) REFERENCES patient (user_id),
    FOREIGN KEY (hcp_id) REFERENCES hcp (user_id),
    PRIMARY KEY (id)
);