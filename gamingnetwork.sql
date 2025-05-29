USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'GamingNetwork')
BEGIN
    ALTER DATABASE [GamingNetwork] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [GamingNetwork];
END

CREATE DATABASE GamingNetwork;

USE GamingNetwork;

CREATE TABLE Games (
    id INT NOT NULL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT
) AS NODE;

INSERT INTO Games (id, title, release_year) VALUES
(1, 'The Witcher 3', 2015),  -- RPG
(2, 'Dark Souls', 2011),      -- Action RPG
(3, 'Stardew Valley', 2016),  -- Simulation
(4, 'Doom Eternal', 2020),    -- Shooter
(5, 'Overwatch', 2016),       -- Shooter / Battle Royale
(6, 'Minecraft', 2011),       -- Sandbox
(7, 'Fortnite', 2017),        -- Battle Royale
(8, 'Cyberpunk 2077', 2020),  -- RPG
(9, 'Hollow Knight', 2017),   -- Metroidvania
(10, 'Animal Crossing: New Horizons', 2020),  -- Simulation
(11, 'Celeste', 2018),        -- Adventure
(12, 'Civilization VI', 2016), -- Strategy
(13, 'Portal 2', 2011);       -- Puzzle

CREATE TABLE Players (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
) AS NODE;

INSERT INTO Players (id, name) VALUES
(1, 'Саша'),
(2, 'Мария'),
(3, 'Иван'),
(4, 'Света'),
(5, 'Дима'),
(6, 'Елена'),
(7, 'Сергей'),
(8, 'Анна'),
(9, 'Олег'),
(10, 'Таня');

CREATE TABLE Genres (
    id INT NOT NULL PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
) AS NODE;

INSERT INTO Genres (id, genre_name) VALUES
(1, 'RPG'),                     -- The Witcher 3, Cyberpunk 2077
(2, 'Action RPG'),              -- Dark Souls
(3, 'Simulation'),              -- Stardew Valley, Animal Crossing: New Horizons
(4, 'Shooter'),                 -- Doom Eternal, Overwatch
(5, 'Battle Royale'),           -- Fortnite
(6, 'Sandbox'),                 -- Minecraft
(7, 'Metroidvania'),            -- Hollow Knight
(8, 'Adventure'),               -- Celeste
(9, 'Strategy'),                -- Civilization VI
(10, 'Puzzle');                 -- Portal 2

CREATE TABLE PlaysIn AS EDGE;
CREATE TABLE GameGenres AS EDGE;
CREATE TABLE AdvisesGenre AS EDGE;
CREATE TABLE FriendOf AS EDGE;

ALTER TABLE PlaysIn ADD CONSTRAINT EC_PlaysIn CONNECTION (Players TO Games);
ALTER TABLE GameGenres ADD CONSTRAINT EC_GameGenres CONNECTION (Games TO Genres);
ALTER TABLE AdvisesGenre ADD CONSTRAINT EC_AdvisesGenre CONNECTION (Players TO Genres);
ALTER TABLE FriendOf ADD CONSTRAINT EC_FriendOf CONNECTION (Players TO Players);

INSERT INTO PlaysIn ($from_id, $to_id) VALUES
((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Games WHERE id = 3)),
((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Games WHERE id = 6)),
((SELECT $node_id FROM Players WHERE id = 2), (SELECT $node_id FROM Games WHERE id = 2)),
((SELECT $node_id FROM Players WHERE id = 3), (SELECT $node_id FROM Games WHERE id = 1)),
((SELECT $node_id FROM Players WHERE id = 3), (SELECT $node_id FROM Games WHERE id = 2)),
((SELECT $node_id FROM Players WHERE id = 3), (SELECT $node_id FROM Games WHERE id = 5)),
((SELECT $node_id FROM Players WHERE id = 4), (SELECT $node_id FROM Games WHERE id = 2)),
((SELECT $node_id FROM Players WHERE id = 4), (SELECT $node_id FROM Games WHERE id = 4)),
((SELECT $node_id FROM Players WHERE id = 5), (SELECT $node_id FROM Games WHERE id = 7)),
((SELECT $node_id FROM Players WHERE id = 6), (SELECT $node_id FROM Games WHERE id = 9)),
((SELECT $node_id FROM Players WHERE id = 7), (SELECT $node_id FROM Games WHERE id = 8)),
((SELECT $node_id FROM Players WHERE id = 7), (SELECT $node_id FROM Games WHERE id = 13)),
((SELECT $node_id FROM Players WHERE id = 8), (SELECT $node_id FROM Games WHERE id = 10)),
((SELECT $node_id FROM Players WHERE id = 8), (SELECT $node_id FROM Games WHERE id = 12)),
((SELECT $node_id FROM Players WHERE id = 9), (SELECT $node_id FROM Games WHERE id = 6)),
((SELECT $node_id FROM Players WHERE id = 9), (SELECT $node_id FROM Games WHERE id = 5)),
((SELECT $node_id FROM Players WHERE id = 10), (SELECT $node_id FROM Games WHERE id = 11));

INSERT INTO FriendOf ($from_id, $to_id) VALUES
((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Players WHERE id = 3)),
((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Players WHERE id = 5)),
((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Players WHERE id = 8)),
((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Players WHERE id = 7)),
((SELECT $node_id FROM Players WHERE id = 2), (SELECT $node_id FROM Players WHERE id = 9)),
((SELECT $node_id FROM Players WHERE id = 3), (SELECT $node_id FROM Players WHERE id = 6)),
((SELECT $node_id FROM Players WHERE id = 4), (SELECT $node_id FROM Players WHERE id = 9)),
((SELECT $node_id FROM Players WHERE id = 5), (SELECT $node_id FROM Players WHERE id = 4)),
((SELECT $node_id FROM Players WHERE id = 6), (SELECT $node_id FROM Players WHERE id = 8)),
((SELECT $node_id FROM Players WHERE id = 6), (SELECT $node_id FROM Players WHERE id = 5)),
((SELECT $node_id FROM Players WHERE id = 7), (SELECT $node_id FROM Players WHERE id = 4)),
((SELECT $node_id FROM Players WHERE id = 9), (SELECT $node_id FROM Players WHERE id = 8)),
((SELECT $node_id FROM Players WHERE id = 10), (SELECT $node_id FROM Players WHERE id = 5));

 
INSERT INTO GameGenres ($from_id, $to_id) VALUES
((SELECT $node_id FROM Games WHERE id = 1), (SELECT $node_id FROM Genres WHERE id = 1)),
((SELECT $node_id FROM Games WHERE id = 2), (SELECT $node_id FROM Genres WHERE id = 2)),
((SELECT $node_id FROM Games WHERE id = 3), (SELECT $node_id FROM Genres WHERE id = 3)),
((SELECT $node_id FROM Games WHERE id = 4), (SELECT $node_id FROM Genres WHERE id = 4)),
((SELECT $node_id FROM Games WHERE id = 5), (SELECT $node_id FROM Genres WHERE id = 4)),
((SELECT $node_id FROM Games WHERE id = 5), (SELECT $node_id FROM Genres WHERE id = 5)),
((SELECT $node_id FROM Games WHERE id = 6), (SELECT $node_id FROM Genres WHERE id = 6)),
((SELECT $node_id FROM Games WHERE id = 7), (SELECT $node_id FROM Genres WHERE id = 5)),
((SELECT $node_id FROM Games WHERE id = 8), (SELECT $node_id FROM Genres WHERE id = 1)),
((SELECT $node_id FROM Games WHERE id = 9), (SELECT $node_id FROM Genres WHERE id = 7)),
((SELECT $node_id FROM Games WHERE id = 10), (SELECT $node_id FROM Genres WHERE id = 3)),
((SELECT $node_id FROM Games WHERE id = 11), (SELECT $node_id FROM Genres WHERE id = 8)),
((SELECT $node_id FROM Games WHERE id = 12), (SELECT $node_id FROM Genres WHERE id = 9)),
((SELECT $node_id FROM Games WHERE id = 13), (SELECT $node_id FROM Genres WHERE id = 10));


INSERT INTO AdvisesGenre ($from_id, $to_id) VALUES
((SELECT $node_id FROM Players WHERE id = 1), (SELECT $node_id FROM Genres WHERE id = 3)),
((SELECT $node_id FROM Players WHERE id = 2), (SELECT $node_id FROM Genres WHERE id = 2)),
((SELECT $node_id FROM Players WHERE id = 3), (SELECT $node_id FROM Genres WHERE id = 1)),
((SELECT $node_id FROM Players WHERE id = 4), (SELECT $node_id FROM Genres WHERE id = 4)),
((SELECT $node_id FROM Players WHERE id = 5), (SELECT $node_id FROM Genres WHERE id = 5)),
((SELECT $node_id FROM Players WHERE id = 6), (SELECT $node_id FROM Genres WHERE id = 7)),
((SELECT $node_id FROM Players WHERE id = 7), (SELECT $node_id FROM Genres WHERE id = 10)),
((SELECT $node_id FROM Players WHERE id = 8), (SELECT $node_id FROM Genres WHERE id = 9)),
((SELECT $node_id FROM Players WHERE id = 9), (SELECT $node_id FROM Genres WHERE id = 6)),
((SELECT $node_id FROM Players WHERE id = 10), (SELECT $node_id FROM Genres WHERE id = 8));


SELECT TOP (1000) $node_id
      ,[id]
      ,[title]
      ,[release_year]
	  --,[graph_id_59D0239507C8452D99220B7F58D3DCAF]
FROM [GamingNetwork].[dbo].[Games]

--Во что играет данный человек
SELECT Player1.name,
	Game1.title AS [played game]
FROM Players AS Player1,
	PlaysIn,
	Games AS Game1
	WHERE MATCH(Player1-(PlaysIn)->Game1)
	AND Player1.name = N'Иван';
--Предпочтения в жанрах игр данного человека
	SELECT Player1.name,
	Genre1.genre_name AS [favorite genre]
FROM Players AS Player1,
	AdvisesGenre,
	Genres AS Genre1
	WHERE MATCH(Player1-(AdvisesGenre)->Genre1)
	AND Player1.name = N'Таня';

--К какому жанру относится данная игра
	SELECT Game1.title,
	Genre1.genre_name AS [genre of game]
FROM Games AS Game1,
	GameGenres,
	Genres AS Genre1
	WHERE MATCH(Game1-(GameGenres)->Genre1)
	AND Genre1.genre_name = N'Strategy';

--Потенциальные друзья, которые бы могли играть в одну игру
	SELECT Player1.name + N' играет в ' + Game1.title AS Level1,
		Player2.name + N' играет в ' + Game1.title AS Level2
FROM Players AS Player1,
	PlaysIn AS Plays1,
	Games AS Game1,
	PlaysIn AS Plays2,
	Players AS Player2 
	WHERE MATCH(Player1-(Plays1)->Game1<-(Plays2)-Player2)
	AND Game1.title = N'Dark Souls'
	AND Player1.id <> Player2.id;
	
--Во что еще играют люди помимо данной игры
	SELECT Player1.name + N' играет в ' + Game1.title AS Level1,
		Player2.name + N', который играл в это, также играет в' + Game2.title AS Level2
FROM Players AS Player1,
	PlaysIn AS Plays1,
	Games AS Game1,
	PlaysIn AS Plays2,
	Players AS Player2,
	PlaysIn AS Plays3,
	Games AS Game2
	WHERE MATCH(Player1-(Plays1)->Game1<-(Plays2)-Player2-(Plays3)->Game2)
	AND Game1.title = N'Minecraft'
	AND Player1.id <> Player2.id
	AND Game1.id <> Game2.id;

--Друзья и друзья друзей
	SELECT
    Player1.name AS Player1,
    STRING_AGG(Player2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
FROM
    Players AS Player1,
    friendOf FOR PATH AS fo,
    Players FOR PATH  AS Player2
WHERE MATCH(SHORTEST_PATH(Player1(-(fo)->Player2)+))
AND Player1.name = N'Саша'

--Друзья друзей(в 2 прыжка)
SELECT PlayerName, Friends
FROM (
    SELECT
        Player1.name AS PlayerName,
        STRING_AGG(Player2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends,
        COUNT(Player2.name) WITHIN GROUP (GRAPH PATH) AS levels
    FROM
        Players AS Player1,
        friendOf FOR PATH AS fo,
        Players FOR PATH  AS Player2
    WHERE MATCH(SHORTEST_PATH(Player1(-(fo)->Player2){1,3}))
    AND Player1.name = N'Сергей'
) Q
WHERE Q.levels = 2



-- PowerBI визуализация

SELECT @@SERVERNAME
-- Сервер: 12KUROKAA\SQLEXPRESS
-- База данных: GamingNetwork
--https://raw.githubusercontent.com/gorgunkirill/gamingnetworkbd/refs/heads/main/pics/404.png


--PlaysIn
SELECT PL.id AS IdFirst
	  , PL.name AS First
	  , CONCAT(N'Players',PL.id) AS [First image name]
	  , G.id AS IdSecond
	  , G.title AS Second
	  , CONCAT(N'Games',G.id) AS [Second image name]
FROM dbo.Players AS PL
	, dbo.PlaysIn AS P
	, dbo.Games AS G
WHERE MATCH(PL-(P)->G)


--GameGenres
SELECT G.id AS IdFirst
	  , G.title AS First
	  , CONCAT(N'Games',G.id) AS [First image name]
	  , GE.id AS IdSecond
	  , GE.genre_name AS Second
	  , CONCAT(N'Genres',GE.id) AS [Second image name]
FROM dbo.Games AS G
	, dbo.GameGenres AS GG
	, dbo.Genres AS GE
WHERE MATCH(G-(GG)->GE)


--AdvisesGenre
SELECT PL.id AS IdFirst
	  , PL.name AS First
	  , CONCAT(N'Players',PL.id) AS [First image name]
	  , GE.id AS IdSecond
	  , GE.genre_name AS Second
	  , CONCAT(N'Genres',GE.id) AS [Second image name]
FROM dbo.Players AS PL
	, dbo.AdvisesGenre AS AG
	, dbo.Genres AS GE
WHERE MATCH(PL-(AG)->GE)


--FriendsOf
SELECT PL1.id AS IdFirst
	  , PL1.name AS First
	  , CONCAT(N'Players',PL1.id) AS [First image name]
	  , PL2.id AS IdSecond
	  , PL2.name AS Second
	  , CONCAT(N'Players',PL2.id) AS [Second image name]
FROM dbo.Players AS PL1
	, dbo.FriendOf AS F
	, dbo.Players AS PL2
WHERE MATCH(PL1-(f)->PL2)




	