CREATE DATABASE academic_system;
USE academic_system;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    program VARCHAR(100) NOT NULL
);


INSERT INTO Students VALUES
(1,'Edwin Davis','edwin.davis@gmail.com','BSc Data Science'),
(2,'Anjali Nair','anjali.nair@gmail.com','BSc Data Science'),
(3,'Rahul Menon','rahul.menon@gmail.com','BSc Data Science'),
(4,'Sneha Thomas','sneha.thomas@gmail.com','BSc Data Science'),
(5,'Arjun Pillai','arjun.pillai@gmail.com','BSc Data Science');
 



CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL
);

INSERT INTO Instructors VALUES
(1,'Dr. Mathew Varghese','Computer Science'),
(2,'Prof. Lakshmi Iyer','Statistics'),
(3,'Dr. Arun Krishnan','Artificial Intelligence');




CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

INSERT INTO Courses VALUES
(101,'Database Management Systems',4,1),
(102,'Machine Learning',3,3),
(103,'Statistics for Data Science',3,2),
(104,'Python Programming',4,1);




CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester ENUM('Spring','Summer','Fall') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Enrollments VALUES
(1,1,101,'Spring'),
(2,1,102,'Spring'),
(3,2,101,'Spring'),
(4,3,103,'Summer'),
(5,4,104,'Fall'),
(6,5,101,'Spring'),
(7,2,102,'Spring'),
(8,3,104,'Fall');




CREATE TABLE Assessments (
    assessment_id INT PRIMARY KEY,
    course_id INT,
    type VARCHAR(50),
    max_marks INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Assessments VALUES
(1,101,'Assignment',50),
(2,101,'Exam',100),
(3,102,'Assignment',40),
(4,102,'Exam',100),
(5,103,'Exam',100),
(6,104,'Assignment',50);





CREATE TABLE Grades (
    grade_id INT PRIMARY KEY,
    enrollment_id INT,
    assessment_id INT,
    marks_obtained INT NOT NULL CHECK (marks_obtained >= 0 AND marks_obtained <= 100),
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id),
    FOREIGN KEY (assessment_id) REFERENCES Assessments(assessment_id)
);

INSERT INTO Grades VALUES
(1,1,1,45),
(2,1,2,80),
(3,3,1,40),
(4,6,2,75),
(5,2,3,35),
(6,7,4,85),
(7,4,5,70),
(8,5,6,48),
(9,8,6,42),
(10,2,4,90);
