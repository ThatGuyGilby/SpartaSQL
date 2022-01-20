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

-- Q3
SELECT
CONCAT(FirstName, " ", LastName) AS "Name",
FLOOR(DATEDIFF(NOW(), BirthDate) / 365.2425) AS "Age",
CASE
	WHEN FLOOR(DATEDIFF(NOW(), BirthDate) / 365.2425) >= 65
	THEN 'Retired'
	When FLOOR(DATEDIFF(NOW(), BirthDate) / 365.2425) >= 60
	THEN 'Retirement due'
	ELSE 'More than 5 years to go'
    END AS "Retirement Status"
FROM Employees;

-- Q3 EXT
DROP VIEW IF EXISTS Retirement_details;

CREATE VIEW Retirement_details AS
SELECT
CONCAT(FirstName, " ", LastName) AS "Name",
FLOOR(DATEDIFF(NOW(), BirthDate) / 365.2425) AS "Age",
CASE
	WHEN FLOOR(DATEDIFF(NOW(), BirthDate) / 365.2425) >= 65
	THEN 'Retired'
	When FLOOR(DATEDIFF(NOW(), BirthDate) / 365.2425) >= 60
	THEN 'Retirement due'
	ELSE 'More than 5 years to go'
    END AS "Retirement Status"
FROM Employees;

SELECT
*
FROM Retirement_details;