DROP PROCEDURE IF EXISTS rescheduleMatch;
USE 'lcs2021'
DELIMITER //
CREATE PROCEDURE `rescheduleMatch` (
	IN m_id tinyint, 
    IN d datetime,
    IN team1 varchar(64),
    IN team2 varchar(64),
    OUT response int(11)
)
BEGIN
    IF (SELECT COUNT(*) FROM `match` WHERE `match_id` = m_id) = 0 THEN
		SET response = -1;
	ELSEIF (SELECT COUNT(*) FROM `match` WHERE `match_id` = m_id AND `outcome` <> NULL) <> 0 THEN
		SET response = -2;
	ELSEIF (SELECT COUNT(*) FROM `team` WHERE `team_name` = team1) = 0 THEN
		SET response = -3;
    ELSEIF (SELECT COUNT(*) FROM `team` WHERE `team_name` = team2) = 0 THEN
		SET response = -4;
    ELSEIF (SELECT COUNT(*) FROM `match` WHERE `match_date` = d AND `match_id` <> m_id) = 0 THEN
		UPDATE `match`
			SET match_date = d, team1_name = team1, team2_name = team2
			WHERE `match_id` = m_id;
        SET response = 0;
	ELSE
		SET response = -5;
	END IF;
END //
DELIMITER ;