USE Northwind; -- use the 'Northwind' database

-- 1. Intro to Querying
SELECT
*
FROM Customers
WHERE City = 'London'; -- filter by the city 'London'

SELECT
*
FROM Employees
WHERE TitleOfCourtesy = 'Dr.'; -- filter by the title 'Dr.'

SELECT
*
FROM Products
WHERE Discontinued = 1; -- filter by discontinued

-- Dealing with apostrophes
SELECT
*
FROM Suppliers
WHERE Address = '29 King\'s Way'; 

-- Specifying column name
SELECT
CompanyName,
City,
Country
FROM Customers;

-- Limit
SELECT
*
FROM `Order Details`
ORDER BY Quantity DESC -- order by orders in ascending value by default
LIMIT 2;

-- Logic

SELECT -- select all entries where 'CategoryId' and 'Discontinued' is false
CategoryId,
ProductName,
UnitPrice,
Discontinued
FROM Products
WHERE CategoryId = 1 AND Discontinued = 0;

SELECT
ProductName,
UnitPrice
FROM Products
WHERE UnitsInStock > 0 AND UnitPrice >= 30;

SELECT DISTINCT
Country
FROM CUSTOMERS
WHERE  ContactTitle = 'Owner';

-- Views
SELECT
*
FROM Invoices;

DROP VIEW IF EXISTS French_customers;

CREATE VIEW French_customers AS
SELECT
CompanyName,
Contactname,
Phone
FROM Customers
WHERE Country = 'France';

SELECT
*
FROM French_customers;

-- Wildcards (Can match multiple things based on condition) e.g. * or %

SELECT
ProductName
FROM Products
WHERE ProductName
LIKE 'Ch%'; -- starts with 'Ch'

SELECT
ProductName
FROM Products
WHERE ProductName
LIKE '%e'; -- ends in 'e'

SELECT
ProductName
FROM Products
WHERE ProductName
LIKE '%tea%'; -- contains 'tea'

SELECT
*
FROM Customers
WHERE City
LIKE 'B____N'; -- '_' represents a black character

SELECT
*
FROM Customers
WHERE Region
LIKE '_A'; -- two characters long and ends in 'A'

SELECT
ProductName
FROM Products
WHERE ProductName
LIKE 'A%' -- begins with 'A'
OR ProductName -- or
LIKE 'E%'; -- begins with 'E'

-- MSSQL
-- WHERE PRODUCT NAME LIKE '[AE']%

SELECT
ProductName
FROM Products
WHERE ProductName REGEXP '^[AEIOU]'; -- anything that begins with AEIOU

SELECT
ProductName
FROM Products
WHERE ProductName REGEXP '[AEIOU]$'; -- anything that ends with 

-- IN Keyword
SELECT
*
FROM Customers
WHERE Region = 'WA' OR Region = 'SP';

SELECT
*
FROM Customers
WHERE Region IN('WA', 'SP', 'Isle of Wight'); -- acts as a way to reduce OR statements

-- BETWEEN Keyword
SELECT
*
FROM EmployeeTerritories
WHERE TerritoryID BETWEEN 06800 AND 09999;

-- String concatenation

SELECT
Region,
CompanyName,
CONCAT(City, ', ' , Country) AS "City"
FROM Customers
WHERE Region IS NOT NULL;

-- arithmetic operators
SELECT
UnitPrice,
Quantity,
Discount,
UnitPrice * Quantity AS "Gross Total"
FROM `Order Details`