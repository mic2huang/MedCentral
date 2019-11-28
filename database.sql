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

INSERT INTO user VALUES (1, 'claymana', 123), (2, 'schlickr', 123), (3, 'cousinsr', 123), (4, 'tungh', 123), (5, 'huynhthu', 123);
INSERT INTO patient VALUES (2, TRUE, TRUE, TRUE, NULL, NULL), (3, TRUE, TRUE, TRUE, NULL, NULL), (1, TRUE, TRUE, TRUE, 2, 3);
INSERT INTO hcp VALUES (4, 1, 'Nephrology', 'Hillside Hospital');
INSERT INTO patient_hcp VALUES (1, 4);
INSERT INTO researcher VALUES (5, 'Healthcare Economics', 'Oregon State University');
INSERT INTO genetic_result VALUES (1, 'Genetic B-12 Processing Deficiency', TRUE, TRUE, TRUE, 'B-12 Processing Deficiency is a fairly self-explanatory genetic disorder.', '2019-11-27');
INSERT INTO lab_result VALUES (1, 'Lab Vitamin D Deficiency', TRUE, TRUE, TRUE, 'Vitamin D Deficiency is a common lab result in the Northern hemisphere.', '2019-11-28');
INSERT INTO medical_result VALUES (1, 'Left femur hairline fracture', TRUE, TRUE, TRUE, 'Patient has broken her left femur in a hairline fracture.', '2019-11-29');
INSERT INTO genetic_report VALUES (1, TRUE, TRUE, TRUE, 'Here is my report on Genetic B-12 Processing Deficiency', '2019-11-27', 1, 4, 1);
INSERT INTO lab_report VALUES (1, TRUE, TRUE, TRUE, 'Here is my report on the lab result of a Vitamin D deficiency.', '2019-11-28', 1, 4, 1);
INSERT INTO medical_report VALUES (1, TRUE, TRUE, TRUE, 'The patient suffered a hairline fracture of her left femur.', '2019-11-29', 2, 4, 1);