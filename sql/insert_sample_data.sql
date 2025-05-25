-- Sample data inserts

-- USERS
INSERT INTO users (
    user_id, full_name, email, password, role, gender, date_of_birth, education,
    skills, experience_years, resume_path, company_name, contact_person, phone_number,
    company_website, location
) VALUES
(
    users_seq.NEXTVAL, 'Admin One', 'admin1@mail.com', 'admin123', 'admin', 'Male', TO_DATE('1980-01-01', 'YYYY-MM-DD'),
    'NA', 'NA', 0, NULL, 'NA', 'NA', NULL, 'NA', 'NA'
),
(
    users_seq.NEXTVAL, 'Recruiter One', 'recruiter1@mail.com', 'recruiter123', 'recruiter', 'Female', TO_DATE('1985-10-15', 'YYYY-MM-DD'),
    'NA', 'NA', 0, NULL, 'Tech Corp', 'John Doe', '9999999999', 'https://techcorp.com', 'Mumbai'
),
(
    users_seq.NEXTVAL, 'Jobseeker One', 'jobseeker1@mail.com', 'job123', 'jobseeker', 'Male', TO_DATE('2000-05-20', 'YYYY-MM-DD'),
    'B.Tech', 'Java,SQL,HTML,CSS', 1, 'https://drive.google.com/file/d/unique_file_id_1/view?usp=sharing', 'NA', 'NA', '7777777777', 'NA', 'Delhi'
),
(
    users_seq.NEXTVAL, 'Jobseeker Two', 'jobseeker2@mail.com', 'job234', 'jobseeker', 'Female', TO_DATE('1998-08-12', 'YYYY-MM-DD'),
    'MCA', 'Python,JavaScript', 2, 'https://drive.google.com/file/d/unique_file_id_2/view?usp=sharing', 'NA', 'NA', '8888888888', 'NA', 'Bangalore'
);

-- JOBS
INSERT INTO jobs (
    job_id, company, last_date_to_apply, recruiter_id, job_role,
    job_description, job_title, industry, job_location, salary, job_type, experience_required
) VALUES
(
    job_seq.NEXTVAL, 'Tech Corp', TO_DATE('2025-06-15', 'YYYY-MM-DD'), 2, 'Software Developer',
    'Develop and maintain software applications.', 'Software Developer', 'IT', 'Mumbai', 1200000, 'Full-Time', 1
),
(
    job_seq.NEXTVAL, 'Tech Corp', TO_DATE('2025-07-01', 'YYYY-MM-DD'), 2, 'Data Analyst',
    'Analyze data and generate reports.', 'Data Analyst', 'IT', 'Mumbai', 900000, 'Full-Time', 2
);

-- APPLICATIONS
INSERT INTO applications (
    application_id, jobseeker_id, recruiter_id, job_id, jobseeker_status,
    jobseeker_resume, interview_date
) VALUES
(
    application_seq.NEXTVAL, 3, 2, 1, 'Applied',
    'https://drive.google.com/file/d/unique_file_id_1/view?usp=sharing', TO_DATE('2025-06-01', 'YYYY-MM-DD')
),
(
    application_seq.NEXTVAL, 4, 2, 2, 'Interview Scheduled',
    'https://drive.google.com/file/d/unique_file_id_2/view?usp=sharing', TO_DATE('2025-06-05', 'YYYY-MM-DD')
);

-- CONTACT_MESSAGES
INSERT INTO contact_messages (
    message_id, role, name, email, message
) VALUES
(
    contact_msg_seq.NEXTVAL, 'jobseeker', 'Jobseeker One', 'jobseeker1@mail.com', 'I would like to know more about the Software Developer role.'
),
(
    contact_msg_seq.NEXTVAL, 'recruiter', 'Recruiter One', 'recruiter1@mail.com', 'Please update the job posting for Data Analyst.'
);
