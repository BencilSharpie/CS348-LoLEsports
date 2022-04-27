DROP PROCEDURE IF EXISTS updateTeamWL;
USE 'lcs2021'
DELIMITER //
CREATE PROCEDURE `updateTeamWL` ()
BEGIN
	DECLARE noMoreRow int default 1;
    DECLARE t_name varchar(64);
	DECLARE teamcur CURSOR FOR SELECT `team_name` FROM `team`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET noMoreRow = 0;
    OPEN teamcur;
    ITR:LOOP
		FETCH teamcur INTO t_name;
        IF nomoreRow = 0 THEN
			LEAVE ITR;
		END IF;
		SET @games = (SELECT COUNT(*) FROM `match` WHERE (`team1_name` = t_name OR `team2_name` = t_name) AND `outcome` IS NOT NULL);
        SET @wins = (SELECT COUNT(*) FROM `match` WHERE `outcome` = t_name);
		SET @losses = @games - @wins;
        UPDATE team
			SET num_win = @wins, num_loss = @losses
			WHERE `team_name` = t_name;
    END LOOP ITR;
END //
DELIMITER ;