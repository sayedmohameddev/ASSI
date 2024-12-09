USE ITI; 
--Create a Clustered Index on the Hiredate Column in the Department Table

CREATE CLUSTERED INDEX idx_Hiredate ON Department (Manager_hiredate)

--Create a Unique Index on St_Age in the Student Table

CREATE UNIQUE INDEX idx_StudentAge ON Student (St_Age)

--Create a Login Named RouteStudent with Access to Only Student and Course Tables

CREATE LOGIN RouteStudent WITH PASSWORD = '123'

--Map the Login to a User in the Database

USE ITI;

CREATE user RouteStudent FOR LOGIN RouteStudent

-- Grant Access to Student and Course Tables

GRANT SELECT, INSERT ON Student TO RouteStudent

GRANT SELECT, INSERT ON Course TO RouteStudent

--Deny Access to DELETE and UPDATE

DENY DELETE, UPDATE ON Student TO RouteStudent

DENY DELETE, UPDATE ON Course TO RouteStudent

--Create the ReturnedBooks Table


CREATE TABLE ReturnedBooks (
    UserSSN INT NOT NULL,
    BookId INT NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE NOT NULL,
    Fees DECIMAL(10, 2)
)

go
--Create a Trigger for Checking Due Date

CREATE TRIGGER trg_CheckReturnDate
ON ReturnedBooks
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @DueDate DATE, @ReturnDate DATE, @PreviousFees DECIMAL(10, 2)
    
    -- Get data from the inserted row
    SELECT 
        @DueDate = DueDate,
        @ReturnDate = ReturnDate,
        @PreviousFees = Fees
    FROM inserted;
    
    -- Check if the return date is after the due date
    IF @ReturnDate > @DueDate
    BEGIN
        -- Calculate the fee as 20% of the previous amount
        SET @PreviousFees = ISNULL(@PreviousFees, 0) * 0.2
    END
    ELSE
    BEGIN
        SET @PreviousFees = 0; -- No fees if returned on time
    END

    -- Insert the row with calculated fees
    INSERT INTO ReturnedBooks (UserSSN, BookId, DueDate, ReturnDate, Fees)
    SELECT UserSSN, BookId, DueDate, ReturnDate, @PreviousFees
    FROM inserted
END

--Create a Trigger to Prevent Modifications on Employee Table

go

CREATE TRIGGER trg_PreventChangesOnEmployee
ON Employee
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    RAISERROR ('You cannot modify, insert, or delete data in the Employee table.', 16, 1);
    ROLLBACK TRANSACTION;
END

--Test Referential Integrity

ALTER TABLE ReturnedBooks
ADD CONSTRAINT FK_UserSSN FOREIGN KEY (UserSSN) REFERENCES Employee(UserSSN)


--Create a Clustered Index on the Salary Column

CREATE CLUSTERED INDEX idx_Salary ON Employee (Salary)

--Create a Login and Assign Permissions

CREATE LOGIN YourName WITH PASSWORD = '123'

--Create a User in the Database

CREATE USER YourName FOR LOGIN YourName

--Grant Permissions to Access Specific Tables

GRANT SELECT, INSERT ON Employee TO YourName

GRANT SELECT, INSERT ON Floor TO YourName

--Deny Permissions to Update and Delete

DENY UPDATE, DELETE ON Employee TO YourName

DENY UPDATE, DELETE ON Floor TO YourName

