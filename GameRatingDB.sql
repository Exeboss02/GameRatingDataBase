
#-----------SETUP------------------------------
CREATE DATABASE GameRatings;
USE GameRatings;

#-----------TABLES-----------------------------
CREATE TABLE Meta(
	CurrentGameIndex INT,
    CurrentStudioIndex INT
);

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
    Genre1 VARCHAR(32),
    Genre2 VARCHAR(32)
);

CREATE TABLE Studios(
	StudioID INT,
    Name VARCHAR(255),
    NrOfEmployees INT,
    Country VARCHAR(255)
);

CREATE TABLE UserRanks(
	UserName VARCHAR(255),
    GameID VARCHAR(32),
    StoryRating INT,
    GamePlayRating INT,
    VisualsRating INT,
    SoundRating INT
);

#-----------DATA-INSERTIONS-----------------------

#-----------TRIGGERS------------------------------
DELIMITER //
CREATE TRIGGER AfterAddingGame
AFTER INSERT ON Games
FOR EACH ROW
BEGIN
    UPDATE Customers
    SET booking_count = booking_count + 1
    WHERE customer_id = NEW.customer_id;
END //
DELIMITER ;

#-----------PROCEDURES----------------------------
DELIMITER //
CREATE PROCEDURE InsertGame(
  IN studioID VARCHAR(32),
  IN title VARCHAR(255),
  IN platform VARCHAR(255),
  IN releaseYear INT,
  IN soldCopies INT,
  IN genre1 VARCHAR(32),
  IN genre2 VARCHAR(32)
)
BEGIN
	DECLARE currentGameIndex INT;
	SELECT Meta.CurrentGameIndex INTO currentGameIndex FROM Meta;
    
	INSERT INTO Games(GameID, StudioID, Title, Platform, ReleaseYear, SoldCopies, Genre1, Genre2)
		VALUES (CONCAT('G', currentGameIndex), studioID, title, platform, releaseYear, soldCopies, genre1, genre2);

    UPDATE Meta SET Meta.CurrentGameIndex = Meta.CurrentGameIndex + 1;
END //
DELIMITER ;

#-----------QUIERIES------------------------------