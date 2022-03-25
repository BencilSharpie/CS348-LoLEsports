DROP PROCEDURE IF EXISTS insertBlankMatch;
USE 'lcs2021'
DELIMITER //
CREATE PROCEDURE `insertBlankMatch` (
	IN d DATETIME, 
    IN team1 varchar(64), 
    IN team2 varchar(64), 
    OUT response int(11)
)
BEGIN
	DECLARE new_id int default 0;
    SET new_id = (SELECT MAX(match_id) FROM `match`) + 1;
    IF (SELECT COUNT(*) FROM `match` WHERE `match_date` = d) = 0 THEN
		INSERT INTO `match` (match_id, match_date, team1_name, team2_name) VALUES (new_id, d, team1, team2);
        SET response = 0;
	ELSE
		SET response = -1;
    END IF;
END //
DELIMITER ;