DROP TABLE IF EXISTS patient;

CREATE TABLE patient (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    pword VARCHAR(30) NOT NULL,
    research_opt_in BOOLEAN NOT NULL DEFAULT FALSE,
    family_data_share BOOLEAN NOT NULL DEFAULT FALSE,
    deceased BOOLEAN NOT NULL DEFAULT FALSE,
    genetic_mother INT DEFAULT NULL,
    genetic_father INT DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (genetic_mother) REFERENCES patient (id) ON DELETE SET NULL,
    FOREIGN KEY (genetic_father) REFERENCES patient (id) ON DELETE SET NULL
);

DROP TABLE IF EXISTS hcp;

CREATE TABLE hcp (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    pword VARCHAR(30) NOT NULL,
    heirarchy_level INT NOT NULL DEFAULT 1,
    specialization VARCHAR(50) DEFAULT NULL,
    organization VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS patient_hcp;

CREATE TABLE patient_hcp (
    patient_id INT NOT NULL,
    hcp_id INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patient (id) ON DELETE SET NULL,
    FOREIGN KEY (hcp_id) REFERENCES hcp (id) ON DELETE SET NULL,
    PRIMARY KEY (patient_id, hcp_id)
);

DROP TABLE IF EXISTS researcher;

CREATE TABLE researcher (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    pword VARCHAR(30) NOT NULL,
    specialization VARCHAR(50) DEFAULT NULL,
    organization VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS genetic_report;

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
    FOREIGN KEY (genetic_result_id) REFERENCES genetic_result (id) ON DELETE SET NULL,
    FOREIGN KEY (patient_id) REFERENCES patient (id) ON DELETE SET NULL,
    FOREIGN KEY (hcp_id) REFERENCES hcp (id) ON DELETE SET NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS lab_report;

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
    FOREIGN KEY (lab_result_id) REFERENCES lab_result (id) ON DELETE SET NULL,
    FOREIGN KEY (patient_id) REFERENCES patient (id) ON DELETE SET NULL,
    FOREIGN KEY (hcp_id) REFERENCES hcp (id) ON DELETE SET NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS medical_report;

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
    FOREIGN KEY (medical_result_id) REFERENCES medical_result (id) ON DELETE SET NULL,
    FOREIGN KEY (patient_id) REFERENCES patient (id) ON DELETE SET NULL,
    FOREIGN KEY (hcp_id) REFERENCES hcp (id) ON DELETE SET NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS genetic_result;

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

DROP TABLE IF EXISTS lab_result;

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

DROP TABLE IF EXISTS medical_result;

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