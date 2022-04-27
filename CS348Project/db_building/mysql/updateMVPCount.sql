DROP PROCEDURE IF EXISTS updateMVPCount;
USE 'lcs2021'
DELIMITER //
CREATE PROCEDURE `updateMVPCount` ()
BEGIN
	DECLARE noMoreRow int default 1;
    DECLARE player_ign varchar(64);
	DECLARE playercur CURSOR FOR SELECT `ign` FROM `player`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET noMoreRow = 0;
    OPEN playercur;
    ITR:LOOP
		FETCH playercur INTO player_ign;
        IF nomoreRow = 0 THEN
			LEAVE ITR;
		END IF;
		SET @mvp_cnt = (SELECT COUNT(*) FROM `match` WHERE `mvp` = player_ign);
        UPDATE player
			SET mvp_count = @mvp_cnt
			WHERE `ign` = player_ign;
    END LOOP ITR;
END //
DELIMITER ;