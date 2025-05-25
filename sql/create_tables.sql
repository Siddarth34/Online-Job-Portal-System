-- USERS Table
CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(30) NOT NULL,
    email VARCHAR2(30) NOT NULL UNIQUE,
    password VARCHAR2(15) NOT NULL,
    role VARCHAR2(30) DEFAULT 'NA',
    gender VARCHAR2(6)  CHECK (gender IN ('Male', 'Female','Other'))  NOT NULL,
    date_of_birth DATE NOT NULL,
    education VARCHAR2(30) DEFAULT 'NA',
    skills VARCHAR2(100) DEFAULT 'NA',
    experience_years VARCHAR2(5) DEFAULT '0',
    resume_path VARCHAR2(100) UNIQUE,
    company_name VARCHAR2(30) DEFAULT 'NA',
    contact_person VARCHAR2(30) DEFAULT 'NA',
    phone_number VARCHAR2(10) UNIQUE,
    company_website VARCHAR2(255) DEFAULT 'NA',
    location VARCHAR2(30) DEFAULT 'NA',
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP
);

-- JOBS Table
CREATE TABLE jobs (
    job_id NUMBER PRIMARY KEY,
    company VARCHAR2(100) NOT NULL,
    posted_on TIMESTAMP DEFAULT SYSTIMESTAMP,
    last_date_to_apply DATE,
    recruiter_id NUMBER REFERENCES users(user_id),
    job_role VARCHAR2(100) DEFAULT 'NA',
    job_description CLOB DEFAULT 'NA',
    job_title VARCHAR2(100) DEFAULT 'NA',
    industry VARCHAR2(100) DEFAULT 'NA',
    job_location VARCHAR2(100) DEFAULT 'NA',
    salary FLOAT DEFAULT 0.0 ,
    job_type VARCHAR2(50) DEFAULT 'NA',
    experience_required NUMBER DEFAULT 0
);

-- APPLICATIONS Table
CREATE TABLE applications (
    application_id NUMBER PRIMARY KEY,
    jobseeker_id NUMBER REFERENCES users(user_id),
    recruiter_id NUMBER REFERENCES users(user_id),
    job_id NUMBER REFERENCES jobs(job_id),
    jobseeker_status VARCHAR2(30) NOT NULL,
    application_date DATE DEFAULT SYSDATE,
    jobseeker_resume VARCHAR2(100),
    interview_date DATE,
    CONSTRAINT fk_resume_path FOREIGN KEY (jobseeker_resume) REFERENCES users(resume_path)
);

-- CONTACT_MESSAGES
CREATE TABLE contact_messages (
    message_id NUMBER PRIMARY KEY, 
    role VARCHAR2(30),
    name VARCHAR2(50),
    email VARCHAR2(100),
    message CLOB,
    submitted_at DATE DEFAULT SYSDATE
);


-- SEQUENCES
CREATE SEQUENCE users_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE job_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE application_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE contact_msg_seq START WITH 1 INCREMENT BY 1;

-- TRIGGERS
CREATE OR REPLACE TRIGGER update_resume_path_trigger
BEFORE UPDATE OF resume_path on users
FOR EACH ROW
BEGIN 
    UPDATE applications
    SET jobseeker_resume = :NEW.resume_path
    WHERE jobseeker_resume = :OLD.resume_path;
END;
/
