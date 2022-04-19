DROP PROCEDURE IF EXISTS deleteMatch;
USE 'lcs2021'
DELIMITER //
CREATE PROCEDURE `deleteMatch` (
	IN d DATETIME, 
    OUT response int(11)
)
BEGIN
    IF (SELECT COUNT(*) FROM `match` WHERE `match_date` = d) = 1 THEN
		DELETE FROM `match` WHERE match_date = d;
	ELSE
		SET response = -1;
    END IF;
END //
DELIMITER ;