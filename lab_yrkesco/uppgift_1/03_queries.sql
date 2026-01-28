SELECT 
    sc.class_id,
    p.first_name,
    p.last_name
FROM school_class sc
JOIN program_manager pm ON sc.program_manager_id = pm.program_manager_id
JOIN person p ON pm.person_id = p.person_id;

SELECT 
    pr.program_name,
    co.course_name
FROM school_class sc
JOIN program pr ON sc.program_id = pr.program_id
JOIN program_course pc ON pr.program_id = pc.program_id
JOIN course co ON pc.course_id = co.course_id;

SELECT 
    p.first_name,
    p.last_name,
    c.course_name
FROM instructor_course ic
JOIN instructor i ON ic.instructor_id = i.instructor_id
JOIN person p ON i.person_id = p.person_id
JOIN course c ON ic.course_id = c.course_id;

SELECT 
    sc.class_id,
    pr.program_name,
    co.course_name,
    p.first_name AS instructor_first_name,
    p.last_name AS instructor_last_name
FROM school_class sc
JOIN program pr ON sc.program_id = pr.program_id
JOIN program_course pc ON pr.program_id = pc.program_id
JOIN course co ON pc.course_id = co.course_id
JOIN instructor_course ic ON co.course_id = ic.course_id
JOIN instructor i ON ic.instructor_id = i.instructor_id
JOIN person p ON i.person_id = p.person_id;
