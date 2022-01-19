-- Q1
SELECT
ProductName,
ProductId
FROM Products
WHERE UnitPrice < 5;

SELECT
*
FROM Products
ORDER BY UnitPrice;

-- Q2
SELECT
*
FROM Categories
WHERE CategoryName REGEXP '^[BS]'; -- anything that begins with B or S

SELECT
*
FROM Categories;

-- Q3
SELECT -- select the count of applicable records from orders
COUNT(EmployeeID)
FROM Orders
WHERE EmployeeID IN(5, 7); -- select orders from EmployeeID 5 and 7

SELECT
*
FROM Orders
WHERE EmployeeID IN(5, 7) -- select orders from EmployeeID 5 and 7
ORDER BY EmployeeID; -- order by ascending employee id value