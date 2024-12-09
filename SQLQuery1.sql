CREATE DATABASE ITIWorkshop;

USE ITIWorkshop;

CREATE TABLE Students 
(
    Id INT PRIMARY KEY IDENTITY (1,1),
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    Age INT,
    Address VARCHAR(50),
    Dep_Id INT
);

CREATE TABLE Departments
(
    Id INT PRIMARY KEY IDENTITY (10,10),
    Name VARCHAR(50) NOT NULL,
    Hiring_Date DATE,
    Ins_Id INT
);

CREATE TABLE Instructors 
(
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(50),
    Bouns DECIMAL,
    Salaey DECIMAL,
    Hour_Rate INT,
    Dep_Id INT REFERENCES Departments(Id) 
);

CREATE TABLE Courses 
(
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(50) NOT NULL,
    Duration INT NOT NULL,
    Description VARCHAR(50),
    Top_Id INT
);

CREATE TABLE Topics 
(
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Student_Course 
(
    Stud_Id INT REFERENCES Students(Id),
    Course_Id INT REFERENCES Courses(Id),
    Grade DECIMAL,
    PRIMARY KEY (Stud_Id, Course_Id)
);

CREATE TABLE Course_Instructor
(
    Course_Id INT REFERENCES Courses(Id),
    Ins_Id INT REFERENCES Instructors(Id),
    Evaluation VARCHAR(30),
    PRIMARY KEY (Course_Id, Ins_Id)
);

ALTER TABLE Students 
ADD FOREIGN KEY (Dep_Id) REFERENCES Departments (Id);

ALTER TABLE Departments 
ADD FOREIGN KEY (Ins_Id) REFERENCES Instructors(Id);

ALTER TABLE Courses 
ADD FOREIGN KEY (Top_Id) REFERENCES Topics (Id);
