--------------------------------part-1-----------------------------------

use ITI;
go
CREATE PROCEDURE ShowStudentsPerDepartment
AS
BEGIN
    SELECT 
        d.Dept_Name AS DepartmentName,
        COUNT(s.St_Id) AS NumberOfStudents
    FROM Department d
    LEFT JOIN Student s ON d.Dept_Id = s.Dept_Id
    GROUP BY d.Dept_Id, d.Dept_Name
    ORDER BY NumberOfStudents DESC
END

EXEC ShowStudentsPerDepartment

go


use MyCompany;


go
CREATE PROCEDURE CheckEmployeesInProject100
AS
BEGIN
    DECLARE @EmployeeCount INT

    SELECT @EmployeeCount = COUNT(*)
    FROM Works_for
    WHERE Pno = 100

    IF @EmployeeCount >= 3
    BEGIN
        PRINT 'The number of employees in the project 100 is 3 or more'
    END
    ELSE
    BEGIN
        PRINT 'The following employees work for the project 100:'
        SELECT e.Fname AS FirstName, e.Lname AS LastName
        FROM Employee e
        INNER JOIN Works_for w ON e.SSN = w.ESSN
        WHERE w.Pno = 100
    END
END

EXEC CheckEmployeesInProject100

go

CREATE PROCEDURE ReplaceEmployeeInProject
    @OldEmpNo CHAR(9),    
    @NewEmpNo CHAR(9),    
    @ProjNo INT           
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM works_for
        WHERE ESSN = @OldEmpNo AND Pno = @ProjNo
    )
    BEGIN
        UPDATE Works_for
        SET ESSN = @NewEmpNo
        WHERE ESSN = @OldEmpNo AND Pno = @ProjNo

        PRINT 'Employee replacement successful.'
    END
    ELSE
    BEGIN
        PRINT 'Error: Old employee is not working on the specified project.'
    END
END
GO

IF EXISTS (SELECT 1 FROM works_for WHERE ESSN = @OldEmpNo AND Pno = @ProjNo)

UPDATE works_for SET ESSN = @NewEmpNo WHERE ESSN = @OldEmpNo AND Pno = @ProjNo;


EXEC ReplaceEmployeeInProject '123456789', '987654321', 100

----------------------------------------------------------------------------------------------------------------------------
--------------------------------------------pat_2-------------------------------

go

CREATE PROCEDURE CalculateSumInRange
    @start INT, 
    @end INT     
AS
BEGIN
    DECLARE @sum INT
    SET @sum = 0     

    WHILE @start <= @end
    BEGIN
        SET @sum = @sum + @start
        SET @start = @start + 1
    END

    SELECT @sum AS TotalSum
END

EXEC CalculateSumInRange @start = 1, @end = 10

EXEC CalculateSumInRange @start = 5, @end = 8
go



CREATE PROCEDURE CalculateCircleArea
    @radius FLOAT  
AS
BEGIN
    DECLARE @area FLOAT 
    DECLARE @pi FLOAT  

    SET @pi = 3.14159;

    SET @area = @pi * (@radius * @radius)

    SELECT @area AS CircleArea
END

EXEC CalculateCircleArea @radius = 5

EXEC CalculateCircleArea @radius = 10


go

CREATE PROCEDURE CalculateAgeCategory
    @age INT 
AS
BEGIN
    DECLARE @category VARCHAR(20)

    IF @age < 18
    BEGIN
        SET @category = 'Child'
    END
    ELSE IF @age >= 18 AND @age < 60
    BEGIN
        SET @category = 'Adult'
    END
    ELSE
    BEGIN
        SET @category = 'Senior'
    END

    SELECT @category AS AgeCategory
END

EXEC CalculateAgeCategory @age = 20
EXEC CalculateAgeCategory @age = 15
EXEC CalculateAgeCategory @age = 40
EXEC CalculateAgeCategory @age = 60


go


CREATE PROCEDURE CalculateMaxMinAvg
    @numbers VARCHAR(MAX)  
AS
BEGIN
    DECLARE @max INT, @min INT, @avg FLOAT

    CREATE TABLE #Numbers (Number INT)

    INSERT INTO #Numbers (Number)
    SELECT value
    FROM STRING_SPLIT(@numbers, ',')

    SELECT 
        @max = MAX(Number), 
        @min = MIN(Number), 
        @avg = AVG(Number)
    FROM #Numbers

    -- Return the results
    SELECT @max AS MaxValue, @min AS MinValue, @avg AS AvgValue

    DROP TABLE #Numbers
END

EXEC CalculateMaxMinAvg @numbers = '5, 10, 15, 20, 25'



----------------------------------------------------------------------------------------------------














