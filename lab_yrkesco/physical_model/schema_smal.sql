CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(250) NOT NULL UNIQUE
);

CREATE TABLE sensitive_person_data (
    sensitive_person_data_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL UNIQUE REFERENCES person(person_id) ON DELETE CASCADE,
    personal_number VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL UNIQUE REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE program (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(150) NOT NULL,
    description TEXT
);

CREATE TABLE class (
    class_id SERIAL PRIMARY KEY,
    start_year INTEGER NOT NULL CHECK (start_year >= 2000),
    program_id INTEGER NOT NULL REFERENCES program(program_id)
);

CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    course_code VARCHAR(50) NOT NULL UNIQUE,
    credits INTEGER NOT NULL CHECK (credits > 0), 
    description TEXT,
    is_standalone BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES student(student_id) ON DELETE CASCADE,
    class_id INTEGER NOT NULL REFERENCES class(class_id) ON DELETE CASCADE,
    UNIQUE (student_id, class_id)
);

CREATE TABLE program_course (
    program_course_id SERIAL PRIMARY KEY,
    program_id INTEGER NOT NULL REFERENCES program(program_id) ON DELETE CASCADE,
    course_id INTEGER NOT NULL REFERENCES course(course_id) ON DELETE CASCADE,
    UNIQUE (program_id, course_id)
);