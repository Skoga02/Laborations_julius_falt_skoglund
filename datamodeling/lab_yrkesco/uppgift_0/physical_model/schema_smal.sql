-- Stores basic, non sensitive information about a person 
CREATE TABLE person (
    person_id SERIAL PRIMARY KEY, -- Unique identifier for each person
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(250) NOT NULL UNIQUE -- must be unique 
);

-- Stores sensitive information taht should be separated for privacy
CREATE TABLE sensitive_person_data (
    sensitive_person_data_id SERIAL PRIMARY KEY,
    -- one to one relationship with person, also deletes sensitive data if person is deleted
    person_id INTEGER NOT NULL UNIQUE REFERENCES person(person_id) ON DELETE CASCADE
    personal_number VARCHAR(20) NOT NULL UNIQUE -- National ID number
);

-- Represents a perosn who is a student
CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    -- One to one relationship with person, also deletes student if person is deleted
    person_id INTEGER NOT NULL UNIQUE REFERENCES person(person_id) ON DELETE CASCADE
);

-- Represents an educational program (e.g. Data Engineer)
CREATE TABLE program (
    program_id SERIAL PRIMARY KEY, -- unique identifier 
    program_name VARCHAR(150) NOT NULL, -- Name of program 
    description TEXT -- Possible description of program
);

--- Represents a class within a program
CREATE TABLE class (
    class_id SERIAL PRIMARY KEY, 
    start_year INTEGER NOT NULL CHECK (start_year >= 2000), -- the year the class started
    program_id INTEGER NOT NULL REFERENCES program(program_id) -- each belongs to one program
);

-- Stores inforamtion about individual courses 
CREATE TABLE course (
    course_id SERIAL PRIMARY KEY, -- unique idientifier 
    course_name VARCHAR(150) NOT NULL, -- course name 
    course_code VARCHAR(50) NOT NULL UNIQUE, -- Course code
    credits INTEGER NOT NULL CHECK (credits > 0), -- Number of credits 
    description TEXT, -- Possible course descrption 
    is_standalone BOOLEAN NOT NULL DEFAULT FALSE -- indicates if course is independet from a program
);

-- Connects students to classes (many to many with a junction table)
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY, -- Unique enrollment identifier 
    student_id INTEGER NOT NULL REFERENCES student(student_id) ON DELETE CASCADE, -- Student being enrolled 
    class_id INTEGER NOT NULL REFERENCES class(class_id) ON DELETE CASCADE, -- Class the student is enrolled in
    UNIQUE (student_id, class_id) -- prevents duplicate enrollments 
);

-- Connects programs and courses (many to many relatinship)
CREATE TABLE program_course (
    program_course_id SERIAL PRIMARY KEY, -- unique identifier 
    program_id INTEGER NOT NULL REFERENCES program(program_id) ON DELETE CASCADE, -- program
    course_id INTEGER NOT NULL REFERENCES course(course_id) ON DELETE CASCADE, -- course
    UNIQUE (program_id, course_id) -- prevents duplciates 
);