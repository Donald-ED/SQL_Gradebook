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
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);


-- Creating the Score table
CREATE TABLE Score(
    Score_ID INT PRIMARY KEY,
    Assignment_ID INT,
    Student_ID INT,
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
(5, 'Quizzes', 10.00, 1),
(6, 'Participation', 15.00, 4),
(7, 'Homework', 25.00, 4),
(8, 'Projects', 30.00, 5),
(9, 'Tests', 25.00, 5);

-- Inserting values into the 'Assignment' table
INSERT INTO Assignment (Assignment_ID, Points, Course_ID, Category_ID) VALUES
(1, 100.00, 1, 2),  -- Homework 1 for CS101
(2, 100.00, 1, 3),  -- Test 1 for CS101
(3, 100.00, 1, 4),  -- Project 1 for CS101
(4, 50.00, 1, 5),  -- Quiz 1 for CS101
(5, 100.00, 4, 6), -- Participation for Engineering 101
(6, 100.00, 4, 7), -- Homework 1 for Engineering 101
(7, 200.00, 5, 8), -- Project 1 for Biology 101
(8, 100.00, 5, 9); -- Test 1 for Biology 101

-- Inserting values into the 'Student' table
INSERT INTO Student (Student_ID, First_Name, Last_Name) VALUES
(1, 'Alice', 'Johnson'),
(2, 'Bob', 'Smith'),
(3, 'Charlie', 'Brown'),
(4, 'Diana', 'Prince'),
(5, 'Clark', 'Kent'),
(6, 'Bruce', 'Wayne');

-- Inserting values into the 'Enrollment' table
INSERT INTO Enrollment (Enrollment_ID, Student_ID, Course_ID) VALUES
(1, 1, 1),  -- Alice is enrolled in CS101
(2, 2, 1),  -- Bob is enrolled in CS101
(3, 3, 2),  -- Charlie is enrolled in Calculus II
(4, 4, 1),  -- Diana in CS101
(5, 5, 4),  -- Clark in Engineering 101
(6, 6, 5),  -- Bruce in Biology 101
(7, 1, 4),  -- Alice in Engineering 101
(8, 2, 5);  -- Bob in Biology 101

-- Inserting values into the 'Score' table
INSERT INTO Score (Score_ID, Assignment_ID, Student_ID, Points_Earned) VALUES
(1, 1, 1, 85.00),  -- Alice's score on Homework 1 for CS101
(2, 1, 2, 90.00),  -- Bob's score on Homework 1 for CS101
(3, 2, 1, 95.00),  -- Alice's score on Test 1 for CS101
(4, 4, 1, 45.00),  -- Alice's score on Quiz 1 for CS101
(5, 5, 5, 100.00), -- Clark's Participation in Engineering 101
(6, 6, 5, 95.00),  -- Clark's Homework 1 in Engineering 101
(7, 7, 6, 190.00), -- Bruce's Project 1 in Biology 101
(8, 8, 6, 85.00);  -- Bruce's Test 1 in Biology 101

-- For the 'Course' table
SELECT * FROM Course;

-- For the 'Category' table
SELECT * FROM Category;

-- For the 'Assignment' table
SELECT * FROM Assignment;

-- For the 'Student' table
SELECT * FROM Student;

-- For the 'Enrollment' table
SELECT * FROM Enrollment;

-- For the 'Score' table
SELECT * FROM Score;

-- Average score for assignment with ID 1
SELECT AVG(Points_Earned) FROM Score WHERE Assignment_ID = 1;

-- Highest score for assignment with ID 1
SELECT MAX(Points_Earned) FROM Score WHERE Assignment_ID = 1;

-- Lowest score for assignment with ID 1
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
(9, 100.00, 5, 1);

-- Update category 'Homework' percentage to 25 for course with ID 1
UPDATE Category SET Weight_Percentage = 25.00 WHERE Category_Name = 'Homework' AND Course_ID = 1;

-- For assignment with ID 1
UPDATE Score SET Points_Earned = Points_Earned + 2 WHERE Assignment_ID = 1;

-- Assuming case-insensitive search
UPDATE Score
SET Points_Earned = Points_Earned + 2
WHERE Student_ID IN (
  SELECT Student_ID
  FROM Student
  WHERE Last_Name LIKE '%Q%'
);

-- Compute grade for student with ID 1 in course with ID 1
SELECT s.Student_ID, s.First_Name, s.Last_Name,
       SUM((sc.Points_Earned / a.Points) * cat.Weight_Percentage) AS Weighted_Score
FROM Score sc
JOIN Assignment a ON sc.Assignment_ID = a.Assignment_ID
JOIN Category cat ON a.Category_ID = cat.Category_ID  -- Ensure this line is correct
JOIN Enrollment e ON sc.Student_ID = e.Student_ID
JOIN Student s ON e.Student_ID = s.Student_ID
JOIN Course co ON e.Course_ID = co.Course_ID
WHERE co.Course_ID = 1 AND s.Student_ID = 1
GROUP BY s.Student_ID, s.First_Name, s.Last_Name;



-- First, we rank the scores within each category for each student
WITH ScoreRanks AS (
  SELECT sc.Score_ID, sc.Assignment_ID, sc.Student_ID, sc.Points_Earned,
         a.Category_ID,
         RANK() OVER (PARTITION BY sc.Student_ID, a.Category_ID ORDER BY sc.Points_Earned ASC) AS ScoreRank
  FROM Score sc
  JOIN Assignment a ON sc.Assignment_ID = a.Assignment_ID
),
-- Then, we calculate the weighted score, excluding the lowest score (rank 1)
WeightedScores AS (
  SELECT sr.Student_ID, c.Category_Name, c.Weight_Percentage,
         CASE WHEN ScoreRank > 1 THEN sr.Points_Earned ELSE 0 END AS Points_Earned
  FROM ScoreRanks sr
  JOIN Category c ON sr.Category_ID = c.Category_ID
)
-- Finally, we sum the weighted scores for the student in a particular course
SELECT s.Student_ID, s.First_Name, s.Last_Name,
       SUM(Points_Earned * Weight_Percentage / 100) AS Final_Grade
FROM WeightedScores ws
JOIN Student s ON ws.Student_ID = s.Student_ID
JOIN Enrollment e ON ws.Student_ID = e.Student_ID
WHERE e.Course_ID = 1 AND ws.Student_ID = 1 -- specify course and student IDs
GROUP BY s.Student_ID, s.First_Name, s.Last_Name;

