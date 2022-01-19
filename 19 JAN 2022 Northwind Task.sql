SELECT
ProductName,
ProductId
FROM Products
WHERE UnitPrice < 5;

SELECT
*
FROM Products
ORDER BY UnitPrice;

SELECT
*
FROM Categories
WHERE CategoryName REGEXP '^[BS]'; -- anything that begins with B or S