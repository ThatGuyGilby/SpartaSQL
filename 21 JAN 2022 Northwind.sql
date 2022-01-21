-- Exercise 1 – Northwind Queries (40 marks: 5 for each question)

-- 1.1	Write a query that lists all Customers in either Paris or London. Include Customer ID, Company Name, and all address fields.
SELECT
CustomerID,
CompanyName,
Address,
City,
Region,
PostalCode,
Country
FROM Customers
WHERE City IN('London', 'Paris');

-- 1.2	List all products stored in bottles.
SELECT
p.ProductName,
c.CategoryName AS "Category Name",
c.Description
FROM Products p
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN('Beverages', 'Condiments');

-- 1.3	Repeat question above, but add in the Supplier Name and Country.
SELECT
p.ProductName,
c.CategoryName AS "Category Name",
c.Description,
s.CompanyName AS "Supplier Name",
s.Country
FROM Products p
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE c.CategoryName IN('Beverages', 'Condiments');

-- 1.4	Write an SQL Statement that shows how many products there are in each category. Include Category Name in result set and list the highest number first.
SELECT
c.CategoryName AS "Category Name",
COUNT(p.ProductID) AS "No. of Products"
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY `No. of Products` DESC;

-- 1.5	List all UK employees using concatenation to join their title of courtesy, first name and last name together. Also include their city of residence.
SELECT
CONCAT(TitleOfCourtesy, " ", FirstName, " ", LastName) AS "Name",
City AS "City of Residence"
FROM Employees
WHERE Country = 'UK';

-- 1.6	List Sales Totals for all Sales Regions (via the Territories table using 4 joins) with a Sales Total greater than 1,000,000. Use rounding or FORMAT to present the numbers `sales by category`
SELECT
r.RegionDescription AS "Region",
ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)),2) AS "Sales Total"
FROM `Order Details` od
INNER JOIN Orders o ON o.OrderID = od.OrderID
INNER JOIN EmployeeTerritories et ON et.EmployeeID = o.EmployeeID
INNER JOIN Territories t ON t.TerritoryID = et.TerritoryID
INNER JOIN Region r ON r.RegionID = t.RegionID
GROUP BY r.RegionDescription
HAVING ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)),2) > 1000000;

-- 1.7	Count how many Orders have a Freight amount greater than 100.00 and either USA or UK as Ship Country.
SELECT
COUNT(*) AS "No. of Orders"
FROM Orders
WHERE Freight > 100 AND ShipCountry IN("UK", "USA")
ORDER BY Freight DESC;

-- 1.8	Write an SQL Statement to identify the Order Number of the Order with the highest amount of discount applied to that order
SELECT
OrderID AS "Order Number",
Discount
FROM `Order Details`
ORDER BY Discount DESC
LIMIT 1;

SELECT
OrderID
,UnitPrice * Quantity * Discount AS "Max Discount"
FROM `Order Details`
WHERE UnitPrice * Quantity * Discount = (SELECT MAX(UnitPrice * Quantity * Discount) FROM `Order Details`);

-- Exercise 2 – Create Spartans Table (20 marks – 10 each)

-- 2.1 Write the correct SQL statement to create the following table:
-- Spartans Table – include details about all the Spartans on this course. Separate Title, First Name and Last Name into separate columns,
-- and include University attended, course w and mark achieved. Add any other columns you feel would be appropriate.
--
-- IMPORTANT NOTE: For data protection reasons do NOT include date of birth in this exercise.

DROP TABLE IF EXISTS Spartans;

CREATE TABLE Spartans
(
    SpartanID INTEGER NOT NULL AUTO_INCREMENT,
    Title VARCHAR(10),
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    UniversityID INT, -- this assumes that there is a university table to draw from
    CourseID INT, -- this assumes that there is a course table to draw from
    MarkAchieved FLOAT(3),
    CONSTRAINT PK_Element PRIMARY KEY (SpartanID)
);

-- 2.2 Write SQL statements to add the details of the Spartans in your course to the table you have created.
-- 4. Insert into the tables
INSERT INTO Spartans (Title, FirstName, LastName, UniversityID, CourseID, MarkAchieved)
VALUES
(
	"Mr.", "Jack", "Gilbride", 1, 1, 65.05
);

-- 2.2 Extended (Personal)
DROP TABLE IF EXISTS Universities;

CREATE TABLE Universities
(
    UniversityID INTEGER NOT NULL AUTO_INCREMENT,
    Name VARCHAR(40),
    CONSTRAINT PK_Element PRIMARY KEY (UniversityID)
);

INSERT INTO Universities (Name)
VALUES
(
	"Bournemouth University"
);

DROP TABLE IF EXISTS Courses;

CREATE TABLE Courses
(
    CourseID INTEGER NOT NULL AUTO_INCREMENT,
    UniversityID INT,
    Name VARCHAR(40),
    CONSTRAINT PK_Element PRIMARY KEY (CourseID)
);

INSERT INTO Courses (UniversityID, Name)
VALUES
(
	1, "BSc (Hons) Games Software Engineering"
);

SELECT
s.SpartanID,
s.Title,
s.FirstName AS "First Name",
s.LastName AS "Last Name",
u.Name AS "University",
c.Name AS "Course",
s.MarkAchieved AS "Mark Achieved"
FROM Spartans s
INNER JOIN Universities u ON s.UniversityID = u.UniversityID
INNER JOIN Courses c ON s.CourseID = c.CourseID;

-- Exercise 3 – Northwind Data Analysis linked to Excel (30 marks)

-- Write SQL statements to extract the data required for the following charts (create these in Excel):
-- 3.1 List all Employees from the Employees table and who they report to. No Excel required. (5 Marks)
SELECT
CONCAT(e.TitleOfCourtesy, " ", e.FirstName, " ", e.LastName) AS "Name",
CONCAT(r.TitleOfCourtesy, " ", r.FirstName, " ", r.LastName) AS "Reports To"
FROM Employees e
INNER JOIN Employees r ON e.ReportsTo = r.EmployeeID;

-- 3.2 List all Suppliers with total sales over $10,000 in the Order Details table. Include the Company Name from the Suppliers Table and pre  sent as a bar chart as below: (5 Marks)
SELECT
s.CompanyName AS "Supplier Name",
ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS "Total Sales"
FROM `Order Details` od
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierID
HAVING SUM(od.UnitPrice * od.Quantity) > 10000
ORDER BY SUM(od.UnitPrice * od.Quantity) DESC;

-- 3.3 List the Top 10 Customers YTD for the latest year in the Orders file. Based on total value of orders shipped. No Excel required. (10 Marks)
SELECT c.CustomerID AS "Customer ID", c.CompanyName As "Company",
FORMAT(SUM(UnitPrice * Quantity * (1-Discount)),'C')
AS "YTD Sales"
FROM Customers c
INNER JOIN Orders o ON o.CustomerID=c.CustomerID
INNER JOIN `Order Details` od ON od.OrderID=o.OrderID
WHERE YEAR(OrderDate)=(SELECT MAX(YEAR(OrderDate)) From Orders)
-- WHERE YEAR(OrderDate)=1998 -- WHERE YEAR(OrderDate)='1998'
AND o.ShippedDate IS NOT NULL
GROUP BY c.CustomerID, c.CompanyName
ORDER BY SUM(UnitPrice * Quantity * (1-Discount)) DESC
LIMIT 10;

-- 3.4 Plot the Average Ship Time by month for all data in the Orders Table using a line chart as below. (10 Marks)
SELECT
DATE_FORMAT(OrderDate, "%M-%Y") AS "Order Month"
,AVG(DATEDIFF(ShippedDate, OrderDate)) AS "Ship Time"
FROM Orders
GROUP BY DATE_FORMAT(OrderDate, "%M-%Y");