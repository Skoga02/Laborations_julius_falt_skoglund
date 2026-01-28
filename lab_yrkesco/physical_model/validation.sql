-- Validation inserts that should pass (should return 0 1)
INSERT INTO person (first_name, last_name, email)
VALUES ('Anna', 'Svensson', 'anna.svensson@example.com');

INSERT INTO sensitive_person_data (person_id, personal_number)
VALUES (1, '19900101-1234');

INSERT INTO student (person_id)
VALUES (1);

INSERT INTO program (program_name, description)
VALUES ('Data Engineering', 'Learn data pipelines');

INSERT INTO class (start_year, program_id)
VALUES (2025, 1);

INSERT INTO course (course_name, course_code, credits)
VALUES ('SQL Basics', 'SQL101', 10);

INSERT INTO enrollment (student_id, class_id)
VALUES (1, 1);

INSERT INTO program_course (program_id, course_id)
VALUES (1, 1);

-- Validation inserts that should not pass 
-- expect violation of unique constratint 
INSERT INTO person (first_name, last_name, email)
VALUES ('Erik', 'Karlsson', 'anna.svensson@example.com');

-- negative credits
INSERT INTO course (course_name, course_code, credits)
VALUES ('Bad Course', 'BAD101', -5);

-- invalid foregin keys
INSERT INTO enrollment (student_id, class_id)
VALUES (999, 1);
