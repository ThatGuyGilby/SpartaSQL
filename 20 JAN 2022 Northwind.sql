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