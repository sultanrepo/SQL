CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    branch VARCHAR(50) NOT NULL
);
CREATE TABLE exam_scores (
    score_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    subject VARCHAR(50) NOT NULL,
    score INT NOT NULL CHECK (
        score BETWEEN 0 AND 100
    ),
    exam_month varchar(7) NOT NULL
);
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    title VARCHAR(100) NOT NULL,
    marks INT NOT NULL CHECK (
        marks BETWEEN 0 AND 100
    )
);
-- ==========================
-- STUDENTS
-- ==========================
INSERT INTO students (name, branch)
VALUES ('Amit Sharma', 'Computer Science'),
    ('Priya Verma', 'Information Technology'),
    ('Rahul Singh', 'Electronics'),
    ('Sneha Gupta', 'Mechanical'),
    ('Vikram Patel', 'Civil'),
    ('Neha Joshi', 'Computer Science'),
    ('Arjun Mehta', 'Electrical'),
    ('Pooja Nair', 'Information Technology'),
    ('Karan Malhotra', 'Mechanical'),
    ('Anjali Rao', 'Computer Science');
-- ==========================
-- EXAM SCORES
-- ==========================
INSERT INTO exam_scores (student_id, subject, score, exam_month)
VALUES -- Student 1
    (1, 'Mathematics', 88, '2026-01'),
    (1, 'Database', 91, '2026-01'),
    (1, 'Programming', 94, '2026-01'),
    (1, 'Operating Systems', 86, '2026-01'),
    (1, 'Networking', 89, '2026-01'),
    -- Student 2
    (2, 'Mathematics', 78, '2026-01'),
    (2, 'Database', 85, '2026-01'),
    (2, 'Programming', 90, '2026-01'),
    (2, 'Operating Systems', 82, '2026-01'),
    (2, 'Networking', 87, '2026-01'),
    -- Student 3
    (3, 'Mathematics', 65, '2026-01'),
    (3, 'Physics', 76, '2026-01'),
    (3, 'Programming', 72, '2026-01'),
    (3, 'Operating Systems', 80, '2026-01'),
    (3, 'Database', 74, '2026-01'),
    -- Student 4
    (4, 'Mathematics', 83, '2026-01'),
    (4, 'Mechanics', 82, '2026-01'),
    (4, 'Programming', 78, '2026-01'),
    (4, 'Database', 75, '2026-01'),
    (4, 'Operating Systems', 81, '2026-01'),
    -- Student 5
    (5, 'Mathematics', 69, '2026-01'),
    (5, 'Surveying', 71, '2026-01'),
    (5, 'Programming', 73, '2026-01'),
    (5, 'Database', 68, '2026-01'),
    (5, 'Operating Systems', 75, '2026-01'),
    -- Student 6
    (6, 'Mathematics', 92, '2026-01'),
    (6, 'Database', 95, '2026-01'),
    (6, 'Programming', 98, '2026-01'),
    (6, 'Operating Systems', 94, '2026-01'),
    (6, 'Networking', 96, '2026-01'),
    -- Student 7
    (7, 'Mathematics', 80, '2026-01'),
    (7, 'Circuits', 84, '2026-01'),
    (7, 'Programming', 82, '2026-01'),
    (7, 'Database', 79, '2026-01'),
    (7, 'Operating Systems', 81, '2026-01'),
    -- Student 8
    (8, 'Mathematics', 77, '2026-01'),
    (8, 'Networking', 79, '2026-01'),
    (8, 'Database', 81, '2026-01'),
    (8, 'Programming', 85, '2026-01'),
    (8, 'Operating Systems', 83, '2026-01'),
    -- Student 9
    (9, 'Mathematics', 70, '2026-01'),
    (9, 'Thermodynamics', 73, '2026-01'),
    (9, 'Programming', 75, '2026-01'),
    (9, 'Database', 72, '2026-01'),
    (9, 'Operating Systems', 76, '2026-01'),
    -- Student 10
    (10, 'Mathematics', 89, '2026-01'),
    (10, 'Operating Systems', 91, '2026-01'),
    (10, 'Database', 87, '2026-01'),
    (10, 'Programming', 93, '2026-01'),
    (10, 'Networking', 90, '2026-01');
-- ==========================
-- PROJECTS
-- ==========================
INSERT INTO projects (student_id, title, marks)
VALUES (1, 'Library Management System', 90),
    (2, 'Online Food Ordering', 87),
    (3, 'Smart Home Automation', 81),
    (4, 'Robotic Arm Design', 85),
    (5, 'Bridge Construction Analysis', 78),
    (6, 'Student Attendance System', 94),
    (7, 'Power Grid Monitoring', 88),
    (8, 'Hospital Management System', 86),
    (9, 'Engine Performance Analysis', 80),
    (10, 'E-Commerce Website', 92);
SELECT *
FROM students;
SELECT *
FROM exam_scores;
SELECT *
FROM projects;
-- select s.name, s.branch, e.subject, e.score
-- from students as s
-- INNER JOIN exam_scores as e
-- ON s.student_id=e.student_id
-- WHERE e.score < (select avg(score) from exam_scores);
-- SELECT * 
--     FROM
--     students
--     where student_id IN (
--         SELECT student_id
--             from exam_scores 
--             where score < (select avg(score) from exam_scores)
--     );
-- ! Criteria for Placement
-- ? 1. At least 1 exam attempt have score >= 90
-- * AND
-- ? 2. Any one of thier project should have marks >= 85
SELECT *
FROM exam_scores
WHERE score >= 90;
SELECT *
FROM projects
where marks >= 85;
SELECT *
FROM students
WHERE student_id IN (
        SELECT e.student_id
        FROM exam_scores as e
            INNER JOIN projects as p ON e.student_id = p.student_id
        WHERE e.score >= 90
            AND p.marks >= 85
    );
SELECT *
FROM students as s
WHERE s.student_id IN (
        select student_id
        from exam_scores
        where score >= 90
    )
    AND s.student_id IN (
        select student_id
        from projects
        where marks >= 85
    );
-- ? Requriement:
-- ! We need to have total score student has earned 
-- ! and number of exam each student has attempted
SELECT 
    s.name,
    s.branch,
    total_stats.attemps,
    total_stats.score
FROM (
        SELECT student_id,
            COUNT(*) as attemps,
            SUM(score) as score
        FROM exam_scores
        GROUP BY student_id
        ORDER BY student_id
) as total_stats
JOIN students as s
ON s.student_id = total_stats.student_id




SELECT e.student_id,
    s.name,
    COUNT(*) as exams,
    SUM(e.score) as score
FROM exam_scores as e
    JOIN students as s ON e.student_id = s.student_id
GROUP BY e.student_id,
    s.name
ORDER BY e.student_id;