-- Concatenation
SELECT
CONCAT(FirstName, " ", LastName, ": ", HomePhone) AS "Employee Name and Contact Number"
FROM
Employees;

-- NULL
SELECT DISTINCT
Country
FROM Customers
WHERE Region IS NOT NULL;

-- Arithmetic Operators
SELECT
ROUND(UnitPrice, 2) AS "Unit Price",
Quantity,
ROUND(Discount, 2) AS "Discount",
ROUND(UnitPrice * Quantity, 2) AS "Gross Total",
ROUND((UnitPrice * Quantity) * (1 - Discount), 2) AS "Net Total"
FROM `Order Details`
ORDER BY Discount DESC; -- could use "Gross Total" or 4 to order by the gross total