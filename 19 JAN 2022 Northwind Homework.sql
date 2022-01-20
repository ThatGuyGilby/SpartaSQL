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
UnitPrice,
Quantity,
Discount,
(UnitPrice * Quantity) AS "Price Before Reductions",
(UnitPrice * Quantity) * (1 - Discount) AS "Discounted Total"
FROM `Order Details`
ORDER BY Discount DESC;