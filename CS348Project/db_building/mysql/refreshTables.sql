DROP PROCEDURE IF EXISTS refreshTables;
USE 'lcs2021'
DELIMITER //
CREATE PROCEDURE `refreshTables` ()
BEGIN
	CALL updateChampWinrates();
    CALL updateMVPCount();
    CALL updateTeamWL();
END //
DELIMITER ;