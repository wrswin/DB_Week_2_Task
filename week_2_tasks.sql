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
    PRIMARY KEY (PlayerId, ClubName, Seasonyear, SeasonName, AgeGroup, TeamNumber),
    FOREIGN KEY (PlayerId) REFERENCES Player,
    FOREIGN KEY (ClubName) REFERENCES Club,
    FOREIGN KEY (SeasonYear, SeasonName) REFERENCES Season
);