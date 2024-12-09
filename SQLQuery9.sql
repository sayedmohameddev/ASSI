use RouteCompany_1;
CREATE TABLE Department (
    DeptNo VARCHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
)

INSERT INTO Department (DeptNo, DeptName, Location)
VALUES
    ('d1', 'Research', 'NY'),
    ('d2', 'Accounting', 'DS'),
    ('d3', 'Marketing', 'KW')



	CREATE TABLE Employees (
    EmpNo INT PRIMARY KEY,
    EmpFname VARCHAR(50) NOT NULL,
    EmpLname VARCHAR(50) NOT NULL,
    DeptNo VARCHAR(5),
    Salary DECIMAL(10, 2) UNIQUE,
    FOREIGN KEY (DeptNo) REFERENCES Department(DeptNo)
)

INSERT INTO Employees(EmpNo, EmpFname, EmpLname, DeptNo, Salary)
VALUES
    (25348, 'Mathew', 'Smith', 'd3', 2500),
    (10102, 'Ann', 'Jones', 'd3', 3000),
    (18316, 'John', 'Barrymore', 'd1', 2400),
    (29346, 'James', 'James', 'd2', 2800),
    (9031, 'Lisa', 'Bertoni', 'd2', 4000),
    (2581, 'Elisa', 'Hansel', 'd2', 3600),
    (28559, 'Sybl', 'Moser', 'd1', 2900)


	CREATE TABLE Projects (
    ProjectNo VARCHAR(5) PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    Budget DECIMAL(10, 2) NULL
)

INSERT INTO Projects (ProjectNo, ProjectName, Budget)
VALUES
    ('p1', 'Apollo', 120000),
    ('p2', 'Gemini', 95000),
    ('p3', 'Mercury', 185600)



CREATE TABLE Works_on (
    EmpNo INT NOT NULL,
    ProjectNo VARCHAR(5) NOT NULL,
    Job VARCHAR(50),
    Enter_Date DATE DEFAULT GETDATE(),
    PRIMARY KEY (EmpNo, ProjectNo),
    FOREIGN KEY (EmpNo) REFERENCES Employees(EmpNo),
    FOREIGN KEY (ProjectNo) REFERENCES Projects(ProjectNo)
)

INSERT INTO Works_on (EmpNo, ProjectNo, Job, Enter_Date)
VALUES
    (10102, 'p1', 'Analyst', '2006-10-01'),
    (10102, 'p3', 'Manager', '2012-01-01'),
    (25348, 'p2', 'Clerk', '2007-02-15'),
    (18316, 'p2', NULL, '2007-06-01'),
    (29346, 'p2', NULL, '2006-12-15'),
    (2581, 'p3', 'Analyst', '2007-10-15'),
    (9031, 'p1', 'Manager', '2007-04-15'),
    (28559, 'p1', NULL, '2007-08-01'),
    (28559, 'p2', 'Clerk', '2012-02-01'),
    (9031, 'p3', 'Clerk', '2006-11-15'),
    (29346, 'p1', 'Clerk', '2007-01-04')






-- This will fail because EmpNo 11111 doesn't exist in the Employee table
INSERT INTO Works_on (EmpNo, ProjectNo, Job, Enter_Date)
VALUES
    (10102, 'p1', 'Analyst', '2006-10-01'),
    (10102, 'p3', 'Manager', '2012-01-01'),
    (25348, 'p2', 'Clerk', '2007-02-15')


-- This will fail because EmpNo 11111 doesn't exist in the Employee table
UPDATE Works_on
SET EmpNo = 11111
WHERE EmpNo = 10102

-- This will update Works_on due to cascading update
UPDATE Employees
SET EmpNo = 22222
WHERE EmpNo = 10102

DELETE FROM Employees
WHERE EmpNo = 10102

ALTER TABLE Employees
ADD TelephoneNumber VARCHAR(15)

ALTER TABLE Employees
DROP COLUMN TelephoneNumber

go

CREATE SCHEMA RouteCompany_1 

CREATE SCHEMA HumanResource

-- Move Department and Project tables to Company schema
ALTER SCHEMA  RouteCompany_1 TRANSFER dbo.Department
ALTER SCHEMA  RouteCompany_1 TRANSFER dbo.Projects

-- Move Employee table to HumanResource schema
ALTER SCHEMA HumanResource TRANSFER dbo.Employees

