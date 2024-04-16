USE demo_db;
-- Creating the 'Course' table
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Department VARCHAR(50),
    Course_Number VARCHAR(10),
    Course_name VARCHAR(100),
    Semester VARCHAR(25),
    Year INT
);

-- Creating the 'Category' table

CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(50),
    Weight_Percentage DECIMAL(5, 2),
    Course_ID INT,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

-- Creating the 'Assignment' table
CREATE TABLE Assignment (
    Assignment_ID INT PRIMARY KEY,
    Points Decimal(5, 2),
    Course_ID INT,
    Course_Name VARCHAR(50),
    Category_ID INT,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

-- Cresting the 'Student' table
CREATE TABLE Student (
  Student_ID INT PRIMARY KEY,
  First_Name VARCHAR(50),
  Last_Name VARCHAR(50)
);

-- Creating the 'Enrollment' table
CREATE TABLE Enrollment (
  Enrollment_ID INT PRIMARY KEY,
  Student_ID INT,
  Course_ID INT,
  Student_Name varchar(50),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);


-- Creating the Score table
CREATE TABLE Score(
    Score_ID INT PRIMARY KEY,
    Assignment_ID INT,
    Student_ID INT,
    Assignment_Name varchar(50),
    Points_Earned DECIMAL(5, 2),
    FOREIGN KEY (Assignment_ID) REFERENCES Assignment(Assignment_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

-- Inserting values into the 'Course' table
INSERT INTO Course (Course_ID, Department, Course_Number, Course_Name, Semester, Year) VALUES
(1, 'Computer Science', 'CS101', 'Introduction to Programming', 'Fall', 2024),
(2, 'Mathematics', 'MATH201', 'Calculus II', 'Spring', 2024),
(3, 'Physics', 'PHYS101', 'General Physics', 'Fall', 2024),
(4, 'Engineering', 'ENG101', 'Introduction to Engineering', 'Winter', 2024),
(5, 'Biology', 'BIO101', 'General Biology', 'Fall', 2024);

-- Inserting values into the 'Category' table
INSERT INTO Category (Category_ID, Category_Name, Weight_Percentage, Course_ID) VALUES
(1, 'Participation', 10.00, 1),
(2, 'Homework', 20.00, 1),
(3, 'Tests', 50.00, 1),
(4, 'Projects', 20.00, 1),
(5, 'Quizzes', 10.00, 1);


-- Inserting values into the 'Assignment' table
INSERT INTO Assignment (Assignment_ID, Points, Course_ID, Category_ID,Course_Name) VALUES
(1, 15.00, 1, 2,'Intro To CS'),  -- Homework 1 for CS101
(2, 50.00, 1, 3,'Intro To CS'),  -- Test 1 for CS101
(3, 100.00, 1, 4,'Intro To CS'),  -- Project 1 for CS101
(4, 15.00, 1, 5,'Intro To CS'),  -- Quiz 1 for CS101
(5, 15.00, 1, 2,'Intro To CS'),  -- Homework 2 for CS101
(6, 100.00, 1, 4,'Intro To CS');  -- Project 2 for CS101

-- Inserting values into the 'Student' table
INSERT INTO Student (Student_ID, First_Name, Last_Name) VALUES
(1, 'Alice', 'Johnson'),
(2, 'Bob', 'Quagmire'),
(3, 'Charlie', 'Brown'),
(4, 'Diana', 'Prince'),
(5, 'Clark', 'Kent'),
(6, 'Bruce', 'Wayne');

-- Inserting values into the 'Enrollment' table
INSERT INTO Enrollment (Enrollment_ID, Student_ID, Course_ID,Student_Name) VALUES
(1, 1, 1,'Alice'),  -- Alice is enrolled in CS101
(2, 2, 1,'Bob'),  -- Bob is enrolled in CS101
(3, 3, 2,'Charlie'),  -- Charlie is enrolled in Calculus II
(4, 4, 1,'Diana'),  -- Diana in CS101
(5, 5, 4,'Clark'),  -- Clark in Engineering 101
(6, 6, 5,'Bruce'),  -- Bruce in Biology 101
(7, 1, 4,'Alice'),  -- Alice in Engineering 101
(8, 2, 5,'Bob');  -- Bob in Biology 101

-- Inserting values into the 'Score' table
INSERT INTO Score (Score_ID, Assignment_ID, Student_ID, Points_Earned, Assignment_Name) VALUES
(1, 1, 1, 12.00,'Homework 1'),  -- Alice's score on Homework 1 for CS101
(2, 6, 1, 97.00,'Project 2'),  -- Alice's score on Project 2 for CS101
(3, 5, 1, 10.00,'Homework 2'),  -- Alice's score on Homework 2 for CS101
(4, 2, 1, 47.00,'Test 1'),  -- Alice's score on Test 1 for CS101
(5, 4, 1, 13.00,'Quiz 1'),  -- Alice's score on Quiz 1 for CS101
(6, 3, 1, 97.00,'Project 1'),  -- Alice's score on Project 1 for CS101
(7, 1, 2, 13.00,'Homework 1'),  -- Bob's score on Homework 1 for CS101
(8, 5, 2, 13.00,'Homework 2'),  -- Bob's score on Homework 2 for CS101
(9, 6, 2, 92.00,'Project 2'),  -- Bob's score on Project 2 for CS101
(10, 2, 2, 45.00,'Test 1'),  -- Bob's score on Test 1 for CS101
(11, 4, 2, 10.00,'Quiz 1'),  -- Bob's score on Quiz 1 for CS101
(12, 3, 2, 95.00,'Project 1');  -- Bob's score on Project 1 for CS101


-- -- For the 'Course' table
-- SELECT * FROM Course;

-- -- For the 'Category' table
-- SELECT * FROM Category;

-- -- For the 'Assignment' table
-- SELECT * FROM Assignment;

-- -- For the 'Student' table
-- SELECT * FROM Student;

-- -- For the 'Enrollment' table
-- SELECT * FROM Enrollment;

-- -- For the 'Score' table
-- SELECT * FROM Score;

-- Average score for assignment with ID 1
SELECT AVG(Points_Earned) FROM Score WHERE Assignment_ID = 1;

 -- Highest score for assignment with ID 1
SELECT MAX(Points_Earned) FROM Score WHERE Assignment_ID = 1;

-- -- Lowest score for assignment with ID 1
 SELECT MIN(Points_Earned) FROM Score WHERE Assignment_ID = 1;

-- For course with ID 1
SELECT s.Student_ID, s.First_Name, s.Last_Name
FROM Student s
JOIN Enrollment e ON s.Student_ID = e.Student_ID
WHERE e.Course_ID = 1;

-- For course with ID 1
SELECT s.Student_ID, s.First_Name, s.Last_Name, a.Assignment_ID, sc.Points_Earned
FROM Student s
JOIN Enrollment e ON s.Student_ID = e.Student_ID
JOIN Score sc ON s.Student_ID = sc.Student_ID
JOIN Assignment a ON sc.Assignment_ID = a.Assignment_ID
WHERE e.Course_ID = 1;

-- Add a new homework assignment to course with ID 1
INSERT INTO Assignment (Assignment_ID, Points, Course_ID, Category_ID) VALUES
(7, 100.00, 1, 5); -- Adding a new Quiz
SELECT * FROM Assignment;

-- Update category 'Homework' percentage to 25 for course with ID 1
UPDATE Category SET Weight_Percentage = 25.00 WHERE Category_Name = 'Homework' AND Course_ID = 1;
SELECT * FROM Category;

-- For assignment with ID 6
UPDATE Score SET Points_Earned = Points_Earned + 2 WHERE Assignment_ID = 1;

-- Assuming case-insensitive search
UPDATE Score
SET Points_Earned = Points_Earned + 2
WHERE Student_ID IN (
  SELECT Student_ID
  FROM Student
  WHERE Last_Name LIKE '%Q%'
);
SELECT * FROM Score;


-- Calculate the normalized weighted score properly by ensuring the total weights sum to 100.
SELECT s.Student_ID, s.First_Name, s.Last_Name,
       (SUM((sc.Points_Earned / a.Points) * cat.Weight_Percentage) / SUM(cat.Weight_Percentage)) * 100 AS Normalized_Weighted_Score
FROM Score sc
JOIN Assignment a ON sc.Assignment_ID = a.Assignment_ID
JOIN Category cat ON a.Category_ID = cat.Category_ID
JOIN Enrollment e ON sc.Student_ID = e.Student_ID
JOIN Student s ON e.Student_ID = s.Student_ID
JOIN Course co ON e.Course_ID = co.Course_ID
WHERE co.Course_ID = 1 AND s.Student_ID = 1
GROUP BY s.Student_ID, s.First_Name, s.Last_Name;

-- First, rank scores within the specified category (Homework) for each student
WITH ScoreRanks AS (
    SELECT 
        sc.Score_ID, 
        sc.Assignment_ID, 
        sc.Student_ID, 
        sc.Points_Earned, 
        a.Category_ID,
        -- Rank scores within the Homework category for each student. Lowest score gets rank 1.
        RANK() OVER (PARTITION BY sc.Student_ID, a.Category_ID ORDER BY sc.Points_Earned ASC) AS ScoreRank
    FROM Score sc
    JOIN Assignment a ON sc.Assignment_ID = a.Assignment_ID
    JOIN Category c ON a.Category_ID = c.Category_ID
    WHERE c.Category_Name = 'Homework'  -- Focus on the Homework category
),

-- Compute weighted scores, excluding the lowest score in the Homework category
FilteredScores AS (
    SELECT
        sc.Student_ID,
        sc.Assignment_ID,
        sc.Points_Earned,
        c.Weight_Percentage
    FROM Score sc
    JOIN Assignment a ON sc.Assignment_ID = a.Assignment_ID
    JOIN Category c ON a.Category_ID = c.Category_ID
    LEFT JOIN ScoreRanks sr ON sc.Score_ID = sr.Score_ID
    WHERE sr.ScoreRank > 1 OR sr.ScoreRank IS NULL  -- Exclude the lowest Homework score; include all other scores normally
)

-- Finally, calculate the normalized weighted score
SELECT 
    s.Student_ID, 
    s.First_Name, 
    s.Last_Name,
    (SUM((fs.Points_Earned / a.Points) * fs.Weight_Percentage) / SUM(fs.Weight_Percentage)) * 100 AS Normalized_Weighted_Score
FROM FilteredScores fs
JOIN Assignment a ON fs.Assignment_ID = a.Assignment_ID
JOIN Student s ON fs.Student_ID = s.Student_ID
JOIN Enrollment e ON s.Student_ID = e.Student_ID
JOIN Course co ON e.Course_ID = co.Course_ID
WHERE co.Course_ID = 1 AND s.Student_ID = 1  -- Specify the course and student
GROUP BY s.Student_ID, s.First_Name, s.Last_Name;








