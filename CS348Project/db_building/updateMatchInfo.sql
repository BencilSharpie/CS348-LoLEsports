DROP PROCEDURE IF EXISTS updateMatchInfo;
USE 'lcs2021'
DELIMITER //
CREATE PROCEDURE `updateMatchInfo` (
	IN d DATETIME, 
    IN winner varchar(64),
    IN t1_kills tinyint,
    IN t2_kills tinyint,
    IN t1_gold mediumint,
    IN t2_gold mediumint,
    IN match_time TIME,
    IN match_mvp varchar(64),
    IN match_patch DECIMAL(3,1),
    IN t1_ban1 varchar(64),
    IN t1_ban2 varchar(64),
    IN t1_ban3 varchar(64),
    IN t1_ban4 varchar(64),
    IN t1_ban5 varchar(64),
    IN t2_ban1 varchar(64),
    IN t2_ban2 varchar(64),
    IN t2_ban3 varchar(64),
    IN t2_ban4 varchar(64),
    IN t2_ban5 varchar(64),
    IN t1_pick1 varchar(64),
    IN t1_pick2 varchar(64),
    IN t1_pick3 varchar(64),
    IN t1_pick4 varchar(64),
    IN t1_pick5 varchar(64),
    IN t2_pick1 varchar(64),
    IN t2_pick2 varchar(64),
    IN t2_pick3 varchar(64),
    IN t2_pick4 varchar(64),
    IN t2_pick5 varchar(64),
    OUT response int(11)
)
BEGIN
	DECLARE m_id int;
    DECLARE team1 varchar(64);
    DECLARE team2 varchar(64);
    IF (SELECT COUNT(*) FROM `match` WHERE match_date = d) = 0 THEN
		SET response = -1;
    ELSEIF (SELECT COUNT(*) FROM `player` WHERE name = mvp) = 0 THEN
		SET response = -2;
	ELSE
		SET m_id = (SELECT match_id FROM `match` WHERE match_date = d);
        SET team1 = (SELECT team1_name FROM `match` WHERE match_date = d);
        SET team2 = (SELECT team2_name FROM `match` WHERE match_date = d);
		UPDATE `match`
        SET outcome = winner, team1_kills = t1_kills, team2_kills = t2_kills,
			team1_gold = t1_gold, team2_gold = t2_gold, match_length = match_time, 
            mvp = match_mvp, patch = match_patch
		WHERE match_date = d;
        INSERT INTO `pick_ban` VALUES (m_id, team1, 'ban', t1_ban1, t1_ban2, t1_ban3, t1_ban4, t1_ban5);
        INSERT INTO `pick_ban` VALUES (m_id, team2, 'ban', t2_ban1, t2_ban2, t2_ban3, t2_ban4, t2_ban5);
		INSERT INTO `pick_ban` VALUES (m_id, team1, 'pick', t1_pick1, t1_pick2, t1_pick3, t1_pick4, t1_pick5);
		INSERT INTO `pick_ban` VALUES (m_id, team2, 'pick', t2_pick1, t2_pick2, t2_pick3, t2_pick4, t2_pick5);
        CALL updateChampWinrates();
        SET response = 0;
    END IF;
END //
DELIMITER ;