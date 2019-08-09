DROP TABLE IF EXISTS PlayerRegistration;
DROP TABLE IF EXISTS TeamEntry;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Season;
DROP TABLE IF EXISTS Club;

CREATE TABLE Club (
    ClubName NVARCHAR(100) NOT NULL PRIMARY KEY,
    ContactName NVARCHAR(100)
);

CREATE TABLE Season (
    SeasonYear INT NOT NULL,
    SeasonName NVARCHAR(6) NOT NULL,
    PRIMARY KEY (SeasonYear, SeasonName),
    CONSTRAINT CheckSeasonName
        CHECK (SeasonName IN ('Summer', 'Winter'))
);

CREATE TABLE Player (
    PlayerId INT NOT NULL PRIMARY KEY IDENTITY(1000,1),
    Fname NVARCHAR(100) NOT NULL,
    Lname NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(50)
);

CREATE TABLE TeamEntry (
    ClubName NVARCHAR(100) NOT NULL,
    SeasonYear INT NOT NULL,
    SeasonName NVARCHAR(6) NOT NULL,
    AgeGroup NVARCHAR(3) NOT NULL,
    TeamNumber INT NOT NULL,
    PRIMARY KEY (ClubName, Seasonyear, SeasonName, AgeGroup, TeamNumber),
    FOREIGN KEY (ClubName) REFERENCES Club,
    FOREIGN KEY (SeasonYear, SeasonName) REFERENCES Season
);

CREATE TABLE PlayerRegistration (
    PlayerId INT NOT NULL,
    ClubName NVARCHAR(100) NOT NULL,
    SeasonYear INT NOT NULL,
    SeasonName NVARCHAR(6) NOT NULL,
    AgeGroup NVARCHAR(3) NOT NULL,
    TeamNumber INT NOT NULL,
    DateRegistered DATE NOT NULL,
    PRIMARY KEY (PlayerId, ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber),
    FOREIGN KEY (PlayerId) REFERENCES Player,
    FOREIGN KEY (ClubName) REFERENCES Club,
    FOREIGN KEY (SeasonYear, SeasonName) ReFeReNcEs Season
);

INSERT INTO Club (ClubName, ContactName) VALUES
    ('Best Chess Club', 'John Doe'),
    ('Boston Competitive Shin-kicking Club', 'Jane Doe'),    
    ('The Questionable Club', 'Joe Doe'),
    ('The Worst Club', 'Joto')
;

INSERT INTO Season (SeasonYear, SeasonName) VALUES
    (2019, 'Summer'),
    (2019, 'Winter'),
    (2020, 'Summer'),
    (2020, 'Winter')
;

INSERT INTO Player (Fname, Lname, Phone) VALUES
    ('Test', 'Best', NULL),
    ('Kest', 'Mest', '0419191919'),
    ('Dest', 'Pest', NULL),
    ('Lest', 'Yest', '1')
;

INSERT INTO TeamEntry (ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber) VALUES
    ('Best Chess Club', 2020, 'Summer', 'U14', 1),
    ('The Questionable Club', 2019, 'Winter', 'U14', 1),
    ('Boston Competitive Shin-kicking Club', 2019, 'Summer', 'U14', 1),
    ('Best Chess Club', 2020, 'Summer', 'U14', 2)
;

INSERT INTO PlayerRegistration (PlayerId, ClubName, Seasonyear, SeasonName, AgeGroup, TeamNumber, DateRegistered) VALUES
    (1001, 'Best Chess Club', 2020, 'Summer', 'U14', 1, '2019-03-04'),
    (1002, 'The Questionable Club', 2019, 'Winter', 'U14', 1, '2019-05-06'),
    (1003, 'Boston Competitive Shin-kicking Club', 2019, 'Summer', 'U14', 1, '2019-07-08'),
    (1002, 'Best Chess Club', 2020, 'Summer', 'U14', 2, '2019-09-10')
;

SELECT R.PlayerId, P.Fname, P.Lname, P.Phone, R.ClubName, C.ContactName, R.SeasonYear, R.SeasonName, R.AgeGroup, R.TeamNumber
    FROM PlayerRegistration R
    INNER JOIN Player P
    ON P.PlayerId = R.PlayerId
    INNER JOIN TeamEntry T
    ON T.ClubName = R.ClubName AND T.SeasonYear = R.SeasonYear AND T.SeasonName = R.SeasonName AND T.AgeGroup = R.AgeGroup AND T.TeamNumber = R.TeamNumber
    INNER JOIN Season S
    ON S.SeasonYear = R.SeasonYear AND S.SeasonName = R.SeasonName
    INNER JOIN Club C
    ON C.ClubName = R.ClubName
    ORDER BY PlayerId ASC
;

SELECT R.SeasonYear, R.AgeGroup, COUNT(R.PlayerId) as 'Number of Player'
    FROM PlayerRegistration R
    GROUP BY R.SeasonYear, R.AgeGroup
    ORDER BY SeasonYear ASC, AgeGroup ASC
;

SELECT *
    FROM PlayerRegistration R
    WHERE R.PlayerId > (
        SELECT AVG(R.PlayerId)
            FROM PlayerRegistration R
    )
;