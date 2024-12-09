Use ITI;

--Scalar Function to Get Month Name from a Date

CREATE FUNCTION GetMonthName (@InputDate DATE)
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN DATENAME(MONTH, @InputDate)
END

SELECT dbo.GetMonthName(GETDATE())


--Multi-Statement Table-Valued Function (Returns Values Between Two Integers)

CREATE FUNCTION GetValuesBetween (@StartInt INT, @EndInt INT)
RETURNS @ValuesTable TABLE (Value INT)
AS
BEGIN
    WHILE @StartInt <= @EndInt
    BEGIN
        INSERT INTO @ValuesTable (Value)
        VALUES (@StartInt)
        SET @StartInt = @StartInt + 1
    END
    RETURN
END

SELECT * FROM dbo.GetValuesBetween(5, 10)

--Table-Valued Function to Get Department Name and Student Full Name

CREATE FUNCTION GetStudentDetails (@StudentId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        D.Dept_Name AS DepartmentName,
        CONCAT(S.St_Fname, ' ', S.St_Lname) AS FullName
    FROM Student S
    INNER JOIN Department D ON S.Dept_Id = D.Dept_Id
    WHERE S.St_Id = @StudentId
)

SELECT * FROM dbo.GetStudentDetails(1)

--Scalar Function to Return Message Based on Student First and Last Names

CREATE FUNCTION CheckStudentName (@StudentId INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @FirstName NVARCHAR(50)
    DECLARE @LastName NVARCHAR(50)
    DECLARE @Message NVARCHAR(100)

    SELECT @FirstName = St_Fname, @LastName = St_Lname
    FROM Student
    WHERE St_Id = @StudentId

    IF @FirstName IS NULL AND @LastName IS NULL
        SET @Message = 'First name & last name are null.'
    ELSE IF @FirstName IS NULL
        SET @Message = 'First name is null.'
    ELSE IF @LastName IS NULL
        SET @Message = 'Last name is null.'
    ELSE
        SET @Message = 'First name & last name are not null.'

    RETURN @Message
END

SELECT dbo.CheckStudentName(1)

--Function to Display Manager Name, Department Name, and Hiring Date with Format


CREATE FUNCTION GetManagerDetails (@Format INT)
RETURNS @ManagerDetails TABLE
(
    DepartmentName NVARCHAR(100),
    ManagerName NVARCHAR(100),
    HiringDate NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO @ManagerDetails
    SELECT 
        D.Dept_Name AS DepartmentName,
        D.Dept_Manager AS ManagerName,
        CASE 
            WHEN @Format = 1 THEN FORMAT(D.Manager_hiredate, 'dd/MM/yyyy')
            WHEN @Format = 2 THEN FORMAT(D.Manager_hiredate, 'MMMM dd, yyyy')
            WHEN @Format = 3 THEN FORMAT(D.Manager_hiredate, 'yyyy-MM-dd')
            ELSE FORMAT(D.Manager_hiredate, 'dd-MM-yyyy')
        END AS HiringDate
    FROM Department D

    RETURN
END

SELECT * FROM dbo.GetManagerDetails(1) 

--Multi-Statement Table-Valued Function to Get Student Info Based on Input String

CREATE FUNCTION GetStudentNameByType (@NameType NVARCHAR(50))
RETURNS @StudentTable TABLE (Name NVARCHAR(100))
AS
BEGIN
    IF @NameType = 'first name'
        INSERT INTO @StudentTable
        SELECT ISNULL(St_Fname, 'Unknown') AS Name
        FROM Student
    ELSE IF @NameType = 'last name'
        INSERT INTO @StudentTable
        SELECT ISNULL(St_Lname, 'Unknown') AS Name
        FROM Student
    ELSE IF @NameType = 'full name'
        INSERT INTO @StudentTable
        SELECT ISNULL(CONCAT(St_Fname, ' ', St_Lname), 'Unknown') AS Name
        FROM Student
    RETURN
END

SELECT * FROM dbo.GetStudentNameByType('full name')


--Function to Display Employees in a Project (Using MyCompany Database)
USE MyCompany;
GO

IF OBJECT_ID('dbo.GetEmployeesByProject', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetEmployeesByProject
GO

CREATE FUNCTION dbo.GetEmployeesByProject_v2 (@ProjectNo INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        E.SSN AS Emp_SSN,
        E.Fname + ' ' + E.Lname AS Emp_FullName, 
        P.Pname AS Project_Name,
        W.Hours AS Work_Hours  
    FROM Employee E
    INNER JOIN Works_for W ON E.SSN = W.ESSN
    INNER JOIN Project P ON W.Pno = P.Pnumber
    WHERE P.Pnumber = @ProjectNo
)
GO


SELECT * FROM sys.objects WHERE name = 'GetEmployeesByProject'



----------------------------------------------------------------------------------------------------------------------------
Use IKEA_Company;

--Create view “v_clerk”

CREATE VIEW v_clerk AS
SELECT EmpNo, ProjectNo, Enter_Date
FROM Works_on
WHERE Job = 'Clerk'

-- 2. Create a view named “v_without_budget” to display all project data without a budget

CREATE VIEW v_without_budget AS
SELECT ProjectNo, ProjectName
FROM Project
WHERE Budget IS NULL


-- 3. Create a view named “v_count” to display the project name and the number of jobs in it.


CREATE VIEW v_count AS
SELECT ProjectName, COUNT(*) AS JobCount
FROM Works_On
GROUP BY ProjectName

-- 4. Create a view named “v_project_p2” to display employee numbers for project ‘p2’ using “v_clerk”.


CREATE VIEW v_project_p2 AS
SELECT EmpNo
FROM v_clerk
WHERE ProjectNo = 'p2';

-- 5. Modify the view “v_without_budget” to display all data in project ‘p1’ and ‘p2’.


CREATE OR REPLACE VIEW v_without_budget AS
SELECT ProjectNo, ProjectName, Budget
FROM Project
WHERE ProjectNo IN ('p1', 'p2');

-- 6. Delete the views “v_clerk” and “v_count”.


DROP VIEW v_clerk;
DROP VIEW v_count;

-- 7. Create a view to display employee number and last name for those in department ‘d2’.


CREATE VIEW v_dept_d2 AS
SELECT e.EmpNo, e.EmpLname
FROM Employee e
JOIN Department d ON e.DeptNo = d.DeptNo
WHERE d.DeptNo = 'd2';

-- 8. Display employee last names containing the letter “J” using the view created in step 7.


SELECT EmpLname
FROM v_dept_d2
WHERE EmpLname LIKE '%J%';

-- 9. Create a view named “v_dept” to display department number and name.


CREATE VIEW v_dept AS
SELECT DeptNo, DeptName
FROM Department;