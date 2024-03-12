CREATE DATABASE Sales;
GO
use Sales;
go

CREATE TABLE Employees (
	EmployeeID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	LastName nvarchar (20) NOT NULL ,
	FirstName nvarchar (10) NOT NULL ,
	BirthDate datetime NULL CHECK (BirthDate < getdate())
)

CREATE TABLE Customers (
    CustomerID int IDENTITY(1, 1) PRIMARY KEY,
    CustomerName VARCHAR(255),
    ContactName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(10),
    Country VARCHAR(50)
)

CREATE TABLE "Orders" (
	OrderID int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	CustomerID int NULL FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
	EmployeeID int NULL FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID),
	OrderDate datetime default getdate() 
)

go
INSERT INTO Employees (LastName, FirstName, BirthDate) VALUES('Davolio','Nancy','1968-12-08');
INSERT INTO Employees (LastName, FirstName, BirthDate) VALUES('Fuller','Andrew','1952-02-19');
INSERT INTO Employees (LastName, FirstName, BirthDate) VALUES('Leverling','Janet','1963-08-30');

go
INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country) VALUES
('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway'),
('Greasy Burger', 'Per Olsen', 'Gateveien 15', 'Sandnes', '4306', 'Norway'),
('Tasty Tee', 'Finn Egan', 'Streetroad 19B', 'Liverpool', 'L1 0AA', 'UK');

go
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES(1,1,'1996-07-04');
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES(1,1,'1996-07-05');
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES(1,1,'1996-07-08');
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES(2,1,'1996-07-08');
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES(2,2,'1996-07-09');

SELECT 
EmployeeID,LastName,FirstName,BirthDate
FROM Employees
Where EmployeeID > 1
ORDER BY BirthDate ASC, FirstName ASC, LastName ASC, EmployeeID desc;

SELECT DISTINCT
Country, COUNT(CustomerID) Number
FROM Customers
GROUP BY Country
Having Country in ('Norway', 'UK');

select 
OrderID, CustomerID as Customer, OrderDate as Date
from Orders;