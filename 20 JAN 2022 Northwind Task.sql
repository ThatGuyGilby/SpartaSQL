-- Q1 - Use LOCATE to list only product names that contain a single quote
SELECT
*
FROM Products
WHERE LOCATE('''', ProductName) != 0;