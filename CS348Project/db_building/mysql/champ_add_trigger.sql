DELIMITER //
DROP TRIGGER IF EXISTS `champ_add_trigger`//
CREATE TRIGGER champ_add_trigger BEFORE INSERT ON pick_ban FOR EACH ROW
	BEGIN
	INSERT INTO champion SELECT NEW.champion1, 0, 0, 0 WHERE NOT EXISTS 
		(SELECT 1 FROM champion WHERE name = NEW.champion1);
	INSERT INTO champion SELECT NEW.champion2, 0, 0, 0 WHERE NOT EXISTS 
		(SELECT 1 FROM champion WHERE name = NEW.champion2);
	INSERT INTO champion SELECT NEW.champion3, 0, 0, 0 WHERE NOT EXISTS 
		(SELECT 1 FROM champion WHERE name = NEW.champion3);
	INSERT INTO champion SELECT NEW.champion4, 0, 0, 0 WHERE NOT EXISTS 
		(SELECT 1 FROM champion WHERE name = NEW.champion4);
	INSERT INTO champion SELECT NEW.champion5, 0, 0, 0 WHERE NOT EXISTS 
		(SELECT 1 FROM champion WHERE name = NEW.champion5);
	END;//
DELIMITER ;
