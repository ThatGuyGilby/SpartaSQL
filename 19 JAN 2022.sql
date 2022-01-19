DROP DATABASE IF EXISTS monsters;

CREATE DATABASE IF NOT EXISTS monsters;

USE monsters;

DROP TABLE IF EXISTS elements;
DROP TABLE IF EXISTS species;

CREATE TABLE Elements (
    ElementID INTEGER NOT NULL AUTO_INCREMENT,
    ElementName VARCHAR(15) NOT NULL,
    ElementDescription MEDIUMTEXT,
    CONSTRAINT PK_Element PRIMARY KEY (ElementID)
);

CREATE TABLE Species (
    SpeciesID INTEGER NOT NULL AUTO_INCREMENT,
    SpeciesName VARCHAR(15) NOT NULL,
    ElementID INT, -- foreign key defined
    FOREIGN KEY (ElementID) REFERENCES Elements (ElementID), -- foreign key value assigned
    SpeciesDescription MEDIUMTEXT,
    CONSTRAINT PK_Species PRIMARY KEY (SpeciesID)
);

ALTER TABLE Species
ADD Country VARCHAR(20); -- Add column

SET SQL_SAFE_UPDATES = 0;
UPDATE Species
SET Country = 'Spain';
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE Species
drop column Country;

INSERT INTO Elements (ElementName, ElementDescription)
VALUES
('Grass','The grass type.'),
('Fire','The fire type.'),
('Water','The water type.');

INSERT INTO Species (SpeciesName, ElementID, SpeciesDescription)
VALUES
('Charmander',  (SELECT ElementID FROM Elements WHERE ElementName ='Fire'), 'Obviously prefers hot places. When it rains, steam is said to spout from the tip of its tail.');

-- Join
SELECT
s.SpeciesName,
e.ElementName
FROM Species s
INNER JOIN Elements e
ON s.ElementID = e.ElementID;

SELECT * FROM Species;