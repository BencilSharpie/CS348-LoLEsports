DROP PROCEDURE IF EXISTS updateChampWinrates;
USE 'lcs2021'
DELIMITER //
CREATE PROCEDURE `updateChampWinrates` ()
BEGIN
	DECLARE noMoreRow int default 1;
    DECLARE champ_name varchar(64);
	DECLARE champcur CURSOR FOR SELECT name FROM `champion`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET noMoreRow = 0;

    OPEN champcur;
    SET @games = (SELECT COUNT(*) FROM `match`);
    ITR:LOOP
		FETCH champcur INTO champ_name;
        IF nomoreRow = 0 THEN
			LEAVE ITR;
		END IF;
        SET @picks = (SELECT COUNT(*) FROM `pick_ban` WHERE pick_or_ban = 'pick' AND 
			(champion1 = champ_name OR champion2 = champ_name OR champion3 = champ_name OR
            champion4 = champ_name OR champion5 = champ_name));
		SET @bans = (SELECT COUNT(*) FROM `pick_ban` WHERE pick_or_ban = 'ban' AND 
			(champion1 = champ_name OR champion2 = champ_name OR champion3 = champ_name OR
            champion4 = champ_name OR champion5 = champ_name));
		SET @wins = (SELECT COUNT(*) FROM `pick_ban` p JOIN `match` m ON m.match_id = p.match_id WHERE p.team_name = m.outcome AND
			p.pick_or_ban = 'pick' AND 
			(p.champion1 = champ_name OR p.champion2 = champ_name OR p.champion3 = champ_name OR
            p.champion4 = champ_name OR p.champion5 = champ_name));
		IF @picks <> 0 THEN
			UPDATE champion
				SET pick_rate = @picks / @games, ban_rate = @bans / @games, win_rate = @wins / @picks
				WHERE name = champ_name;
		ELSE
			UPDATE champion
				SET pick_rate = 0, ban_rate = @bans / @games, win_rate = 0
				WHERE name = champ_name;
		END IF;
    END LOOP ITR;
	DELETE FROM `champion` WHERE pick_rate = 0 AND ban_rate = 0 AND win_rate = 0;
END //
DELIMITER ;