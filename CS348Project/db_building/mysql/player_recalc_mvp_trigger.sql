DELIMITER //
DROP TRIGGER IF EXISTS `player_recalc_mvp_trigger`//
CREATE TRIGGER player_recalc_mvp_trigger AFTER INSERT ON `match` FOR EACH ROW
	BEGIN 
	UPDATE player SET mvp_count = mvp_count + 1 WHERE ign = NEW.mvp;
	END;//
DELIMITER ;
