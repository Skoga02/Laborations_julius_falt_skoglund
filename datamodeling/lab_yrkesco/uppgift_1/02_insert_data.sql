-- to avoid breaking any constraints unintenonally 
TRUNCATE
    enrollment,
    instructor_course,
    program_course,
    school_class,
    course,
    program,
    campus,
    program_manager,
    instructor,
    consultant,
    company,
    student,
    sensitive_person_data,
    person
RESTART IDENTITY CASCADE;

-- Insert persons first
INSERT INTO person (first_name, last_name, email)
VALUES
('Johan', 'Svensson', 'johan@yrkesco.se'),
('Erika', 'Andersson', 'Erika@yrkesco.se'),
('Lars', 'Bengtsson', 'Lars@yrkesco.se');

-- Assign roles
INSERT INTO student (person_id) VALUES (1);

INSERT INTO instructor (person_id, employment_type) VALUES (2, 'Consultant');

INSERT INTO program_manager (person_id) VALUES (3);

-- Programs, campus and class
INSERT INTO campus (campus_name) VALUES ('Stockholm'), ('Göteborg');

INSERT INTO program (program_name, description) VALUES ('Data Engineering', 'Backend and data systems');

INSERT INTO school_class (start_year, program_id, program_manager_id, campus_id)
VALUES (2025, 1, 1, 1);

-- Courses and links
INSERT INTO course (course_name, course_code, credits, description, is_standalone)
VALUES ('Programming', 'Programming101', 40, 'Intro to Programming', false);

INSERT INTO program_course (program_id, course_id) VALUES (1, 1);

INSERT INTO instructor_course (instructor_id, course_id) VALUES (1, 1);

-- Enrollment 
INSERT INTO enrollment (student_id, class_id) VALUES (1, 1);
