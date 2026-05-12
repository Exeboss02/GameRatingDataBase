#-----------RESET---------------------------------------------------------
DROP DATABASE GameRatings;

#-----------SETUP---------------------------------------------------------
CREATE DATABASE GameRatings;
USE GameRatings;

CREATE TABLE Meta(
	CurrentGameIndex INT,
    CurrentStudioIndex INT
);

INSERT INTO Meta(CurrentGameIndex, CurrentStudioIndex) VALUES(0, 0);

#-----------TABLES---------------------------------------------------------

CREATE TABLE Users(
	UserName VARCHAR(255),
    Gender VARCHAR(16),
    Age INT,
    Country VARCHAR(255)
);

CREATE TABLE Games(
	GameID VARCHAR(32),
    StudioID VARCHAR(32),
    Title VARCHAR(255),
    Platform VARCHAR(255),
    ReleaseYear INT,
    SoldCopies INT,
    Genre VARCHAR(32)
);

CREATE TABLE Studios(
	StudioID VARCHAR(32),
    Name VARCHAR(255),
    NrOfEmployees INT,
    Country VARCHAR(255)
);

CREATE TABLE UserRatings(
	UserName VARCHAR(255),
    GameID VARCHAR(32),
    StoryRating INT,
    GamePlayRating INT,
    VisualsRating INT,
    SoundRating INT
);

#-----------DATA-INSERTIONS-----------------------------------------------------------------

#-----------TRIGGERS------------------------------------------------------------------------
DELIMITER //
CREATE TRIGGER AfterAddingGame
AFTER INSERT ON Games
FOR EACH ROW
BEGIN
	UPDATE Meta SET Meta.CurrentGameIndex = Meta.CurrentGameIndex + 1;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER AfterAddingStudio
AFTER INSERT ON Studios
FOR EACH ROW
BEGIN
	UPDATE Meta SET Meta.CurrentStudioIndex = Meta.CurrentStudioIndex + 1;
END //
DELIMITER ;

#-----------PROCEDURES---------------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE InsertUser(
	IN userName VARCHAR(255),
    IN gender VARCHAR(16),
    IN age INT,
    IN country VARCHAR(255)
)
BEGIN
	IF CheckUser(userName) = 1
		THEN SELECT "Error! This user already exists";
	ELSE
		INSERT INTO Users(UserName, Gender, Age, Country)
			VALUES (userName, gender, age, country);
	END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE InsertUserRating(
	IN userName VARCHAR(255),
    IN gameID VARCHAR(32),
    IN storyRating INT,
    IN gamePlayRating INT,
    IN visualsRating INT,
    IN soundRating INT
)
BEGIN
	IF CheckUser(userName) = 0 OR CheckGame(gameID) = 0
		Then SELECT "The user or gameID doesn't exist!";
    ELSE
    	INSERT INTO UserRatings(UserName, GameID, StoryRating, GamePlayRating, VisualsRating, SoundRating)
			VALUES (userName, gameID, storyRating, gamePlayRating, visualsRating, soundRating);
	END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE InsertGame(
  IN studioID VARCHAR(32),
  IN title VARCHAR(255),
  IN platform VARCHAR(255),
  IN releaseYear INT,
  IN soldCopies INT,
  IN genre VARCHAR(32)
)
BEGIN
	DECLARE currentGameIndex INT;
	SELECT Meta.CurrentGameIndex INTO currentGameIndex FROM Meta;
    
	IF CheckStudio(studioID) = 0
		THEN SELECT "Error! studioID doesn't exist";
	ELSE		
		INSERT INTO Games(GameID, StudioID, Title, Platform, ReleaseYear, SoldCopies, Genre)
			VALUES (CONCAT('G', currentGameIndex), studioID, title, platform, releaseYear, soldCopies, genre);
	END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE InsertStudio(
	name VARCHAR(255),
    nrOfEmployees INT,
    country VARCHAR(255)
)
BEGIN
	DECLARE currentStudioIndex INT;
	SELECT Meta.CurrentStudioIndex INTO currentStudioIndex FROM Meta;
    
	INSERT INTO Studios(StudioID, Name, NrOfEmployees, Country)
		VALUES (CONCAT('S', currentStudioIndex), name, nrOfEmployees, country);
END //
DELIMITER ;


DELIMITER $$
CREATE FUNCTION CheckUser(userName VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
	IF EXISTS (
	SELECT UserName
	FROM Users
	WHERE
		Users.UserName = userName
    ) THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END $$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION CheckGame(gameID VARCHAR(32))
RETURNS INT
DETERMINISTIC
BEGIN
	IF EXISTS (
	SELECT GameID
	FROM Games
	WHERE
		Games.GameID = gameID
    ) THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END $$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION CheckStudio(studioID VARCHAR(32))
RETURNS INT
DETERMINISTIC
BEGIN
	IF EXISTS (
	SELECT StudioID
	FROM Studios
	WHERE
		Studios.StudioID = studioID
    ) THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END $$
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetStudioIDs(IN studioName VARCHAR(255))
BEGIN
	SELECT Name, StudioID FROM Studios WHERE Name = studioName;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetGameIDs(IN title VARCHAR(255))
BEGIN
	SELECT Title, GameID FROM Games WHERE Title = title;
END //
DELIMITER ;