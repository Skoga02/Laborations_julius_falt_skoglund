DROP TABLE IF EXISTS
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
CASCADE;

-- Core tables
CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE sensitive_person_data (
    sensitive_person_data_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL UNIQUE REFERENCES person(person_id),
    personal_number VARCHAR(20) NOT NULL UNIQUE
);

-- Roles
CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL UNIQUE REFERENCES person(person_id)
);

CREATE TABLE instructor (
    instructor_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL UNIQUE REFERENCES person(person_id),
    employment_type VARCHAR(50) NOT NULL
);

CREATE TABLE program_manager (
    program_manager_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL UNIQUE REFERENCES person(person_id)
);

-- Organization and education
CREATE TABLE campus (
    campus_id SERIAL PRIMARY KEY,
    campus_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE program (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(150) NOT NULL,
    description TEXT
);

CREATE TABLE school_class (
    class_id SERIAL PRIMARY KEY,
    start_year INTEGER NOT NULL CHECK (start_year >= 2000),
    program_id INTEGER NOT NULL REFERENCES program(program_id),
    program_manager_id INTEGER NOT NULL REFERENCES program_manager(program_manager_id),
    campus_id INTEGER NOT NULL REFERENCES campus(campus_id)
);

-- Course and M:N tables
CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    course_code VARCHAR(50) NOT NULL UNIQUE,
    credits INTEGER NOT NULL CHECK (credits > 0),
    description TEXT,
    is_standalone BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE program_course (
    program_course_id SERIAL PRIMARY KEY,
    program_id INTEGER NOT NULL REFERENCES program(program_id),
    course_id INTEGER NOT NULL REFERENCES course(course_id),
    UNIQUE (program_id, course_id)
);

CREATE TABLE class_course (
    class_id INTEGER REFERENCES school_class(class_id),
    course_id INTEGER REFERENCES course(course_id),
    PRIMARY KEY (class_id, course_id)
);

-- Enrollment and instructor-course
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES student(student_id),
    class_id INTEGER NOT NULL REFERENCES school_class(class_id),
    UNIQUE (student_id, class_id)
);

CREATE TABLE instructor_course (
    instructor_course_id SERIAL PRIMARY KEY,
    instructor_id INTEGER NOT NULL REFERENCES instructor(instructor_id),
    course_id INTEGER NOT NULL REFERENCES course(course_id),
    UNIQUE (instructor_id, course_id)
);

-- Consultants and companies
CREATE TABLE company (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    organization_number VARCHAR(50) NOT NULL UNIQUE,
    has_f_tax BOOLEAN NOT NULL,
    address VARCHAR(150)
);

CREATE TABLE consultant (
    consultant_id SERIAL PRIMARY KEY,
    instructor_id INTEGER NOT NULL REFERENCES instructor(instructor_id),
    company_id INTEGER NOT NULL REFERENCES company(company_id),
    hourly_rate NUMERIC(8,2) NOT NULL CHECK (hourly_rate > 0)
);
