CREATE DATABASE ITI_1;

--Get all instructor names without repetition

SELECT DISTINCT Ins_Name
FROM Instructor;

--Display Instructor Name and Department Name

SELECT i.Ins_Name, d.Dept_Name
FROM Instructor i
LEFT JOIN Department d ON i.Dept_Id = d.Dept_Id;

--Display student full name and the name of the course they are taking for only courses that have a grade

SELECT s.St_Fname + ' ' + s.St_Lname AS Full_Name, c.Crs_Name
FROM Student s
JOIN Stud_Course sc ON s.St_Id = sc.St_Id
JOIN Course c ON sc.Crs_Id = c.Crs_Id
WHERE sc.Grade IS NOT NULL;

--Select student first name and the data of his supervisor

SELECT s.St_Fname, i.Ins_Name, i.Ins_Degree, i.Salary
FROM Student s
JOIN Instructor i ON s.St_super = i.Ins_Id;

--Display student information in the following format

SELECT 
    s.St_Id AS 'Student ID',
    s.St_Fname + ' ' + s.St_Lname AS 'Student Full Name',
    d.Dept_Name AS 'Department Name'
FROM Student s
JOIN Department d ON s.Dept_Id = d.Dept_Id;
-------------------------------------------------------------------------------------------------

--Bonus: Display results of the following two statements



SELECT @@VERSION;
--This statement returns the version information of the SQL Server, including the version number, build, and edition of the SQL Server instance.

		----------------------------------------------------------------------------------------------

SELECT @@SERVERNAME;
--This statement returns the name of the SQL Server instance you are connected to. It's typically the network name of the machine hosting the SQL Server instance.

