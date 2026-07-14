CREATE TABLE students (
    student_id SREAL PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    branch     VARCHAR(50) NOT NULL
);

CREATE TABLE exam_scores (
    score_id   SREAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    subject    VARCHAR(50) NOT NULL,
    score      INT NOT NULL CHECK (score BETWEEN 0 AND 100),
    exam_month varchar(7) NOT NULL
);

CREATE TABLE projects (
    project_id SREAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    title     VARCHAR(100) NOT NULL,
    marks     INT NOT NULL CHECK (marks BETWEEN 0 AND 100)
);