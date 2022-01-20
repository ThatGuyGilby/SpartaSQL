-- Q1 - Use LOCATE to list only product names that contain a single quote
SELECT
*
FROM Products
WHERE LOCATE('''', ProductName) != 0; -- != 0 is not needed but is nice to visualise

-- Q2
SELECT
CONCAT(FirstName, " ", LastName) AS "Name",
FLOOR(DATEDIFF(NOW(), BirthDate) / 365.2425) AS "Age"
FROM Employees;