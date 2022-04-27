DROP PROCEDURE IF EXISTS deleteMatch;
USE 'lcs2021'
DELIMITER //
CREATE PROCEDURE `deleteMatch` (
	IN m_id tinyint, 
    OUT response int(11)
)
BEGIN
    IF (SELECT COUNT(*) FROM `match` WHERE `match_id` = m_id) = 1 THEN
		DELETE FROM `match` WHERE match_id = m_id;
        CALL refreshTables();
		SET response = 0;
	ELSE
		SET response = -1;
    END IF;
END //
DELIMITER ;