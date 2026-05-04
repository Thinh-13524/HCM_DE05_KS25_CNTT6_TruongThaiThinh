CREATE DATABASE ESportsManagement;
USE ESportsManagement;

CREATE TABLE teams (
	team_id VARCHAR(10) PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    owner VARCHAR(100),
    founded_year INT
);

CREATE TABLE players (
	player_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100),
    nick_name VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(12, 2),
    team_id VARCHAR(10),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE matchs (
	match_id VARCHAR(10) PRIMARY KEY,
    start_time DATETIME,
    result VARCHAR(50)
);

CREATE TABLE match_statistics (
	match_id VARCHAR(10),
    player_id VARCHAR(10),
    kills INT,
    deaths INT,
    assists INT,
    PRIMARY KEY (match_id, player_id),
    FOREIGN KEY (match_id) REFERENCES matchs(match_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id)
);

ALTER TABLE matchs
ADD prize DECIMAL(15, 2);

ALTER TABLE teams
CHANGE country region VARCHAR(50);

INSERT INTO teams VALUES 
('T01','SGP','Vietnam','GAM',2023),
('T02','Esports','China','skeleton',2022),
('T03','T1','Korea','SK',2021),
('T04','Cloud','USA','EDG group',2022),
('T05','Edra','Vietnam',NULL,2024);


INSERT INTO players VALUES
('P01','Nguyen Van A', 'Levi', 'Jungler',100000000,'T01'),
('P02','Nguyen Van B', 'Caps', 'Mid',200000000,'T02'),
('P03','Nguyen Van C', 'Faker', 'Mid',150000000,'T03'),
('P04','Nguyen Van D', 'Viper', 'ADC',100000000,'T04'),
('P05','Nguyen Van E', 'Blaber', 'Jungler',90000000,'T05');

INSERT INTO matchs VALUES
('MS_001','2024-01-01 10:00:00','2-1',50000000),
('MS_002','2024-01-02 12:00:00','2-0',60000000),
('MS_003','2024-01-03 14:00:00','1-2',40000000),
('MS_004','2024-01-04 16:00:00','2-1',55000000),
('MS_005','2024-01-05 18:00:00','0-2',30000000);

INSERT INTO match_statistics VALUES 
('MS_001','P01',10, 2, 8),
('MS_002','P02',8, 3, 6),
('MS_003','P03',7, 1, 10),
('MS_004','P04',12, 4, 5),
('MS_005','P05',9, 2, 7);

SET SQL_SAFE_UPDATES = 0;

UPDATE players
SET salary = salary * 1.2
WHERE position = 'Jungler';

DELETE FROM teams
WHERE owner = NULL;

SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM players
WHERE salary BETWEEN 50000000 AND 1500000000;

SELECT *
FROM matchs
WHERE match_id = 'MS_007';

SELECT players.nick_name, players.position 
FROM players, teams
WHERE players.team_id = teams.team_id
AND teams.region = 'Vietnam';

DROP TABLE match_statistics;
DROP TABLE matchs;