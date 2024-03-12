CREATE database Training
Use Training
CREATE TABLE Student (
	StudentId int IDENTITY(1,1) PRIMARY KEY,
	LastName varchar(255) not null,
	FirstName varchar(255) not null
);

ALTER TABLE Student
ADD DateOfBirth date

ALTER TABLE Student
ALTER COLUMN LastName nvarchar(255)

ALTER TABLE Student
ALTER COLUMN FirstName nvarchar(255)

ALTER TABLE Student
ADD CONSTRAINT c_DateOfBirth
CHECK (getdate() > DateOfBirth)

