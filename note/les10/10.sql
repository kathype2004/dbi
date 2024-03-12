CREATE DATABASE L10
GO
USE L10
GO
CREATE TABLE Authors (
	Author_Id INT NOT NULL IDENTITY (1,1)
				CONSTRAINT pk_Author PRIMARY KEY,
	Name varchar(100)
);

CREATE TABLE Books (
	Book_Id INT not null IDENTITY (1,1)
				CONSTRAINT pk_Books Primary Key,
	Author_Id INT	CONSTRAINT fk_Books_Author_Id
					FOREIGN KEY REFERENCES Authors(Author_Id),
	Name varchar(100)
);

INSERT INTO Authors(Name)
VALUES
	('Itzik Ben-Gan'),
	('Grant-Fritchey'),
	('Kellyn Pot`VinGorman');

INSERT INTO Books (Author_Id, Name)
VALUES
	(1,'T-SQL Fundamentals'),
	(1,'T-SQL Window Functions'),
	(2, 'SQL Sever 2017 Query Performence Tuning'),
	(2,'SQL Sever Query Performence Tuning'),
	(3,'Crushing the IT Gender Bias');

DELETE FROM Books WHERE Author_Id = 2;
DELETE FROM Authors WHERE Name = 'Grant-Fritchey';

SELECT * FROM Authors;
SELECT * FROM Books;