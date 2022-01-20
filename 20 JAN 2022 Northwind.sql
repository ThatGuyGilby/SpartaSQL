-- string functions
SELECT
LOCATE('i',  'Nish'),
SUBSTRING('Autumn', 1, 1),
LEFT('Mihai', 3),
LEFT('Right', 3),
LENGTH('Paula'),
TRIM('           Franklin           '),
UPPER('dale'),
LOWER('DALE');

SELECT
PostalCode AS "Postal Code",
LEFT(PostalCode, TRIM(LOCATE(' ', PostalCode)) - 1) AS 'Postcode Region',
LOCATE(' ', PostalCode) AS "Space Found",
Country
FROM Customers
WHERE Country = "UK";

-- date functions
SELECT
NOW(),
CURDATE();

SELECT
ShippedDate,
DATE_ADD(ShippedDate, INTERVAL 10 DAY)
FROM Orders
WHERE DATE_ADD(ShippedDate, INTERVAL 10 DAY) IS NOT NULL;

SELECT
DATE_ADD(NOW(), INTERVAL 5 YEAR);

SELECT
FLOOR(DATEDIFF(NOW(), '2000-07-04') / 365.2425);

SELECT
YEAR(NOW());

SELECT
OrderDate,
DATE_ADD(ShippedDate, INTERVAL 5 DAY) AS "Due Date",
DATEDIFF(ShippedDate, OrderDate) AS "Ship Days"
FROM Orders
ORDER BY DATEDIFF(ShippedDate, OrderDate) DESC;

SELECT
DATE_FORMAT(OrderDate, "%d %m %Y")
FROM Orders;

-- case
SELECT
OrderId,
OrderDate,
ShippedDate,
CASE
WHEN DATEDIFF(ShippedDate, OrderDate) < 5
THEN 'Early'
WHEN DATEDIFF(ShippedDate, OrderDate) < 10
THEN 'On Time'
ELSE 'Overdue'
END AS "Status"
FROM orders
WHERE ShippedDate IS NOT NULL;

-- aggregate functions (HAVING acts as a WHERE clause for aggrefgates)
SELECT
SUM(UnitsOnOrder) AS "Total On Order",
AVG(UnitsOnOrder) AS "AVG On Order",
MIN(UnitsOnOrder) AS "Min On order",
MAX(UnitsOnOrder) AS "Max On order"
FROM Products;

SELECT
SupplierId,
SUM(UnitsOnOrder) AS "Total On Order"
FROM Products
GROUP BY SupplierId;

SELECT
SupplierId,
SUM(UnitsOnOrder) AS "Total On Order"
FROM Products
GROUP BY SupplierId
HAVING SUM(UnitsOnOrder) > 50;

-- join
SELECT
et.EmployeeId,
e.FirstName,
e.Lastname,
COUNT(et.TerritoryId) AS "No. of territories covered"
FROM EmployeeTerritories et
INNER JOIN Employees e ON et.EmployeeId = e.EmployeeId
GROUP BY et.EmployeeId, e.FirstName, e.Lastname
HAVING COUNT(TerritoryId) > 5;

-- multiple joins
SELECT
p.ProductName,
p.UnitPrice,
s.CompanyName AS "Supplier",
c.CategoryName AS "Category"
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;

-- Subqueries
SELECT DISTINCT
CompanyName AS 'Customer'
FROM Customers
WHERE CustomerID NOT IN
(
	SELECT CustomerID
	FROM Orders
);

SELECT DISTINCT
c.CompanyName AS 'Customer'
FROM Customers c
LEFT JOIN Orders  o ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL;

SELECT
MAX(UnitPrice)
FROM `Order Details`;

SELECT
OrderID,
ProductID,
UnitPrice,
Quantity,
Discount,
(
	SELECT
	MAX(UnitPrice)
	FROM `Order Details`
) AS `Max Price`
FROM `Order Details`;

-- Unions
-- UNION removes dupes
-- UNION ALL does not

SELECT City
FROM Customers
WHERE City IS NOT NULL
UNION
SELECT City
FROM Employees
ORDER BY City;

SELECT
City,
CompanyName,
'Customer' AS "Relationship"
FROM Customers
WHERE City IS NOT NULL
UNION
SELECT
City,
CompanyName,
'Supplier' AS "Relationship"
FROM Suppliers
WHERE City IS NOT NULL
ORDER BY City, CompanyName;