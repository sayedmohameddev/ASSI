CREATE DATABASE MyCompany1;

--part_1

--Display all the employees' data
SELECT * FROM Employee;

--Display the employee's first name, last name, salary, and department number


SELECT FName, LName, Salary, Dno

FROM Employee;

--Display all project names, locations, and the responsible department:

SELECT Pname, Plocation, Dnum 

FROM Project;

--Display each employee’s full name and annual commission (10% of annual salary)

SELECT 
    CONCAT(FName, ' ', LName) AS FullName, 
    Salary * 12 * 0.1 AS ANNUAL_COMM 

	FROM Employee;

 
--Display the employees' ID, name for those earning more than 1000 LE monthly

SELECT SSN, CONCAT(FName, ' ', LName) AS FullName 
FROM Employee 
WHERE Salary > 1000;

--Display the employees' ID, name for those earning more than 10,000 LE annually

SELECT SSN, CONCAT(FName, ' ', LName) AS FullName 
FROM Employee 
WHERE Salary * 12 > 10000;


--Display the names and salaries of female employees

SELECT FName, LName, Salary 
FROM Employee
WHERE Sex = 'Female';

--Display each department ID and name managed by a manager with ID 968574

SELECT Dnum, Dname 
FROM Departments 
WHERE MGRSSN = 968574;

--Display the IDs, names, and locations of projects controlled by department 10

SELECT Pnumber, Pname, Plocation 
FROM Project
WHERE Dnum = 10;
-----------------------------------------------------------------------------------------------------------------------------------
--part_3

--Display the Department ID, name, and the ID and name of its manager

SELECT 
    d.Dnum, 
    d.Dname, 
    m.SSN,

    CONCAT(m.FName, ' ', m.LName) AS ManagerName
FROM Departments d
LEFT JOIN Employee m ON d.MGRSSN = m.SSN;


--Display the name of the departments and the name of the projects under their control

SELECT 
    d.Dname, 
    p.Pname
FROM Departments d
LEFT JOIN Project p ON d.Dname = p.Dnum;

--Display the full data about all the dependents associated with the name of the employee they depend on

SELECT 
    dp.*,
    CONCAT(e.Fname, ' ', e.Lname) AS EmployeeName
FROM Dependent dp
JOIN Employee e ON dp.ESSN = e.SSN;

--Display the ID, name, and location of projects in Cairo or Alex city

SELECT 
    Pnumber, 
    Pname, 
    Plocation
FROM Project
WHERE Plocation IN ('Cairo', 'Alex');

--Display the projects' full data where the project name starts with the letter "A"

SELECT *
FROM Project
WHERE Pname LIKE 'A%';

--Display all employees in department 30 whose salary is between 1000 and 2000 LE monthly
SELECT 
    e.SSN AS EmployeeID, 
    CONCAT(e.Fname, ' ', e.Lname) AS EmployeeName, 
    e.Salary
FROM Employee e
WHERE e.Dno = 30 
  AND e.Salary BETWEEN 1000 AND 2000;


--Retrieve the names of all employees in department 10 who work 10 hours or more per week on the "AL Rabwah" project

SELECT 
    CONCAT(e.Fname, ' ', e.Lname) AS EmployeeName
FROM Employee e
JOIN Works_for w ON e.SSN = w.ESSN
JOIN Project p ON w.Pno = p.Pnumber
WHERE e.Dno = 10 
  AND w.Hours >= 10 
  AND p.Pname = 'AL Rabwah';
 
 --Find the names of the employees who were directly supervised by Kamel Mohamed

 SELECT 
    CONCAT(e.Fname, ' ', e.Lname) AS EmployeeName
FROM Employee e
JOIN Employee m ON e.Superssn = m.SSN
WHERE m.Fname = 'Kamel' AND m.Lname = 'Mohamed';

--Display all data of the managers

SELECT 
    e.SSN, 
    CONCAT(e.Fname, ' ', e.Lname) AS ManagerName, 
    e.Address, 
    e.Salary, 
    e.Bdate
FROM Employee e
WHERE e.SSN IN (SELECT MGRSSN FROM Departments);

--Retrieve the names of all employees and the names of the projects they are working on, sorted by project name

SELECT 
    CONCAT(e.Fname, ' ', e.Lname) AS EmployeeName, 
    p.Pname AS ProjectName
FROM Employee e
JOIN Works_for w ON e.SSN = w.ESSN
JOIN Project p ON w.Pno = p.Pnumber
ORDER BY p.Pname;

--For each project located in Cairo, find the project number, the controlling department name, and the department manager’s last name, address, and birthdate

SELECT 
    p.Pnumber AS ProjectID, 
    d.Dname AS DepartmentName, 
    e.Lname AS ManagerLastName, 
    e.Address AS ManagerAddress, 
    e.Bdate AS ManagerBirthdate
FROM Project p
JOIN Departments d ON p.Dnum = d.Dnum
JOIN Employee e ON d.MGRSSN = e.SSN
WHERE p.City = 'Cairo';


--Display all employees' data and the data of their dependents, even if they have no dependents:

SELECT 
    e.SSN AS EmployeeID, 
    CONCAT(e.Fname, ' ', e.Lname) AS EmployeeName, 
    e.Address, 
    e.Salary, 
    e.Bdate, 
    d.Dependent_name AS DependentName, 
    d.Sex AS DependentSex, 
    d.Bdate AS DependentBdate
FROM Employee e
LEFT JOIN Dependent d ON e.SSN = d.ESSN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--part_4

-- Inserting the new department

INSERT INTO Departments (Dnum, Dname, MGRSSN, [MGRStart Date])
VALUES (100, 'DEPT IT', 112233, '2006-11-01');


-- Update the manager to be Mrs. Oha Mohamed

UPDATE Departments
SET MGRSSN = 968574
WHERE Dnum = 100;

-- Update your record as manager for department 20

UPDATE Departments
SET MGRSSN = 102672
WHERE Dnum = 20;

-- Update employee 102660 to be supervised by you

UPDATE Employee
SET Superssn = 102672
WHERE SSN = 102660;

----------------------------------------------------------------------------------------------------------------------------------

--DML


--Check if Mr. Kamel has dependents

SELECT * FROM Dependent WHERE ESSN = 223344;

--Check if Mr. Kamel is a department manager

SELECT * FROM Departments WHERE MGRSSN = 223344;

--Check if Mr. Kamel supervises any employees

SELECT * FROM Employee WHERE Superssn = 223344;

--Check if Mr. Kamel works in any projects

SELECT * FROM Works_for WHERE ESSN = 223344;

