DROP DATABASE IF EXISTS Monsters; -- drop the 'Monsters' database if it exists

CREATE DATABASE IF NOT EXISTS Monsters; -- create the 'Monsters' database if no database with that name exists

USE Monsters; -- use the 'Monsters' database

DROP TABLE IF EXISTS Elements; -- drop table 'Elements' if it exists
DROP TABLE IF EXISTS Species; -- drop table 'Species' if it exists

CREATE TABLE Elements ( -- create the 'Elements' table
    ElementID INTEGER NOT NULL AUTO_INCREMENT, -- constrain the value to not being NULL and to auto increment
    ElementName VARCHAR(15) NOT NULL, -- constrain the value to not being NULL 
    ElementDescription MEDIUMTEXT, -- constrain the value to a string with a maximum length of 16,777,215 characters
    CONSTRAINT PK_Element PRIMARY KEY (ElementID) -- set the 'ElemendID' value to the primary key
);

CREATE TABLE Species ( -- create the 'Species' table
    SpeciesID INTEGER NOT NULL AUTO_INCREMENT, -- constrain the value to not being NULL and to auto increment
    SpeciesName VARCHAR(15) NOT NULL, -- constrain the value to not being NULL 
    ElementID INT, -- foreign key defined
    FOREIGN KEY (ElementID) REFERENCES Elements (ElementID), -- foreign key value assigned
    SpeciesDescription MEDIUMTEXT, -- constrain the value to a string with a maximum length of 16,777,215 characters
    CONSTRAINT PK_Species PRIMARY KEY (SpeciesID) -- set the 'SpeciesID' value to the primary key
);

ALTER TABLE Species -- alter the 'Species' table
ADD Country VARCHAR(20); -- add column

SET SQL_SAFE_UPDATES = 0; -- set safe updates to false
UPDATE Species -- start updating 'Species'
SET Country = 'Spain'; -- set the 'Country' value to 'Spain'
SET SQL_SAFE_UPDATES = 1; -- set safe updates to true

ALTER TABLE Species -- alter the 'Species' table
drop column Country; -- drop the 'Country' column

INSERT INTO Elements (ElementName, ElementDescription) -- insert values into the 'Elements' table
VALUES
('Grass','The grass type.'),
('Fire','The fire type.'),
('Water','The water type.');

INSERT INTO Species (SpeciesName, ElementID, SpeciesDescription) -- insert values into the 'Species' table
VALUES
('Charmander',  (SELECT ElementID FROM Elements WHERE ElementName ='Fire'), 'Obviously prefers hot places. When it rains, steam is said to spout from the tip of its tail.'),
('Squirtle',  (SELECT ElementID FROM Elements WHERE ElementName ='Water'), 'After birth, its back swells and hardens into a shell. Powerfully sprays foam from its mouth.');

SELECT -- select 'SpeciesName' from 's' and 'ElementName' from 'e' when the ElementID from 's' and 'e' are equal (Join statement)
s.SpeciesName,
e.ElementName
FROM Species s
INNER JOIN Elements e
ON s.ElementID = e.ElementID;