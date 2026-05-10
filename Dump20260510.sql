CREATE DATABASE  IF NOT EXISTS `GameRatings` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `GameRatings`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: GameRatings
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Games`
--

DROP TABLE IF EXISTS `Games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Games` (
  `GameID` varchar(32) DEFAULT NULL,
  `StudioID` varchar(32) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Platform` varchar(255) DEFAULT NULL,
  `ReleaseYear` int DEFAULT NULL,
  `SoldCopies` int DEFAULT NULL,
  `Genre1` varchar(32) DEFAULT NULL,
  `Genre2` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Games`
--

LOCK TABLES `Games` WRITE;
/*!40000 ALTER TABLE `Games` DISABLE KEYS */;
INSERT INTO `Games` VALUES ('G0','S0','Dark Souls','PC, PlayStation 3, Xbox 360',2011,5000000,'Action','RPG'),('G1','S0','Dark Souls II','PC, PlayStation 3, Xbox 360',2014,2500000,'Action','RPG'),('G2','S0','Dark Souls III','PC, PlayStation 4, Xbox One',2016,10000000,'Action','RPG'),('G3','S1','Halo 3','Xbox 360',2007,14500000,'Shooter','Action'),('G4','S1','Halo Infinite','Xbox Series X/S, PC',2021,20000000,'Shooter','Action'),('G5','S0','Elden Ring','PC, PlayStation 4/5, Xbox One/Series X/S',2022,25000000,'Action','RPG'),('G6','S2','Night in the Woods','PC, PlayStation 4, Xbox One, Nintendo Switch',2017,500000,'Adventure','Indie'),('G7','S3','Deltarune','PC, Nintendo Switch, PlayStation 4',2018,1000000,'RPG','Adventure'),('G8','S3','Undertale','PC, PlayStation 4, Xbox One, Nintendo Switch',2015,5000000,'RPG','Indie'),('G9','S4','Hunt: Showdown','PC, PlayStation 4, Xbox One',2019,2000000,'Shooter','Survival'),('G10','S5','Counter-Strike 2','PC',2023,15000000,'Shooter','Competitive'),('G11','S6','Rocket League','PC, PlayStation 4, Xbox One, Nintendo Switch',2015,100000000,'Sports','Racing'),('G12','S7','Super Mario Galaxy','Wii',2007,12800000,'Platformer','Adventure'),('G13','S7','Super Mario Galaxy 2','Wii',2010,7500000,'Platformer','Adventure'),('G14','S8','Hollow Knight','PC, PlayStation 4, Xbox One, Nintendo Switch',2017,3000000,'Metroidvania','Action'),('G15','S9','Tunic','PC, Xbox One/Series X/S, PlayStation 4/5, Nintendo Switch',2022,1000000,'Adventure','Puzzle');
/*!40000 ALTER TABLE `Games` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`exeboss`@`localhost`*/ /*!50003 TRIGGER `AfterAddingGame` AFTER INSERT ON `Games` FOR EACH ROW BEGIN
	UPDATE Meta SET Meta.CurrentGameIndex = Meta.CurrentGameIndex + 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Meta`
--

DROP TABLE IF EXISTS `Meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Meta` (
  `CurrentGameIndex` int DEFAULT NULL,
  `CurrentStudioIndex` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Meta`
--

LOCK TABLES `Meta` WRITE;
/*!40000 ALTER TABLE `Meta` DISABLE KEYS */;
INSERT INTO `Meta` VALUES (16,10);
/*!40000 ALTER TABLE `Meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Studios`
--

DROP TABLE IF EXISTS `Studios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Studios` (
  `StudioID` varchar(32) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `NrOfEmployees` int DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Studios`
--

LOCK TABLES `Studios` WRITE;
/*!40000 ALTER TABLE `Studios` DISABLE KEYS */;
INSERT INTO `Studios` VALUES ('S0','FromSoftware',1000,'Japan'),('S1','Bungie',1000,'USA'),('S2','Infinite Fall',5,'USA'),('S3','Toby Fox',1,'USA'),('S4','Crytek',500,'Germany'),('S5','Valve',400,'USA'),('S6','Psyonix',200,'USA'),('S7','Nintendo',5000,'Japan'),('S8','Team Cherry',3,'Australia'),('S9','Finji',10,'USA');
/*!40000 ALTER TABLE `Studios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`exeboss`@`localhost`*/ /*!50003 TRIGGER `AfterAddingStudio` AFTER INSERT ON `Studios` FOR EACH ROW BEGIN
	UPDATE Meta SET Meta.CurrentStudioIndex = Meta.CurrentStudioIndex + 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `UserRatings`
--

DROP TABLE IF EXISTS `UserRatings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserRatings` (
  `UserName` varchar(255) DEFAULT NULL,
  `GameID` varchar(32) DEFAULT NULL,
  `StoryRating` int DEFAULT NULL,
  `GamePlayRating` int DEFAULT NULL,
  `VisualsRating` int DEFAULT NULL,
  `SoundRating` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRatings`
--

LOCK TABLES `UserRatings` WRITE;
/*!40000 ALTER TABLE `UserRatings` DISABLE KEYS */;
INSERT INTO `UserRatings` VALUES ('xxxFredxxx','G0',5,6,7,8),('xxxFredxxx','G1',3,6,9,9),('xxxFredxxx','G2',5,8,8,4),('xxxFredxxx','G3',10,10,9,10),('xxxFredxxx','G4',1,4,3,4),('xxxFredxxx','G5',6,5,3,10),('Bjorn','G0',3,7,7,8),('Bjorn','G2',5,10,10,1),('Bjorn','G4',5,3,8,7),('Bjorn','G8',6,5,5,6),('Bjorn','G8',4,8,10,9),('AndrewScandrew','G5',8,8,8,10),('AndrewScandrew','G6',8,8,10,9),('AndrewScandrew','G7',5,2,3,9),('AndrewScandrew','G8',10,7,7,2),('AndrewScandrew','G9',6,10,5,6),('AndrewScandrew','G12',4,4,1,9),('AndrewScandrew','G14',5,5,4,8),('Landso','G11',8,10,10,8),('Landso','G12',8,6,6,4),('Landso','G13',9,10,10,6),('Landso','G14',3,5,5,4),('Landso','G6',7,7,10,9);
/*!40000 ALTER TABLE `UserRatings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `UserName` varchar(255) DEFAULT NULL,
  `Gender` varchar(16) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES ('xxxFredxxx','Female',31,'USA'),('Bjorn','Male',19,'Norway'),('AndrewScandrew','Male',25,'Sweden'),('Landso','Female',21,'Australia');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'GameRatings'
--

--
-- Dumping routines for database 'GameRatings'
--
/*!50003 DROP FUNCTION IF EXISTS `CheckGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`exeboss`@`localhost` FUNCTION `CheckGame`(gameID VARCHAR(32)) RETURNS int
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CheckStudio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`exeboss`@`localhost` FUNCTION `CheckStudio`(studioID VARCHAR(32)) RETURNS int
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CheckUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`exeboss`@`localhost` FUNCTION `CheckUser`(userName VARCHAR(255)) RETURNS int
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetGameIDs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`exeboss`@`localhost` PROCEDURE `GetGameIDs`(IN title VARCHAR(255))
BEGIN
	SELECT Title, GameID FROM Games WHERE Title = title;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetStudioIDs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`exeboss`@`localhost` PROCEDURE `GetStudioIDs`(IN studioName VARCHAR(255))
BEGIN
	SELECT Name, StudioID FROM Studios WHERE Name = studioName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`exeboss`@`localhost` PROCEDURE `InsertGame`(
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
    
	IF CheckStudio(studioID) = 0
		THEN SELECT "Error! studioID doesn't exist";
	ELSE		
		INSERT INTO Games(GameID, StudioID, Title, Platform, ReleaseYear, SoldCopies, Genre1, Genre2)
			VALUES (CONCAT('G', currentGameIndex), studioID, title, platform, releaseYear, soldCopies, genre1, genre2);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertStudio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`exeboss`@`localhost` PROCEDURE `InsertStudio`(
	name VARCHAR(255),
    nrOfEmployees INT,
    country VARCHAR(255)
)
BEGIN
	DECLARE currentStudioIndex INT;
	SELECT Meta.CurrentStudioIndex INTO currentStudioIndex FROM Meta;
    
	INSERT INTO Studios(StudioID, Name, NrOfEmployees, Country)
		VALUES (CONCAT('S', currentStudioIndex), name, nrOfEmployees, country);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`exeboss`@`localhost` PROCEDURE `InsertUser`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertUserRating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`exeboss`@`localhost` PROCEDURE `InsertUserRating`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-10 17:21:31
