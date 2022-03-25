DROP TRIGGER IF EXISTS champ_add_trigger;
USE 'lcs2021'
DELIMITER //
CREATE TRIGGER champ_add_trigger BEFORE INSERT ON `pick_ban` FOR EACH ROW BEGIN
	IF (SELECT COUNT(*) FROM champion WHERE name = NEW.champion1) = 0 THEN
		INSERT INTO `champion` VALUES (NEW.champion1, 0, 0, 0);
	END IF;
    IF (SELECT COUNT(*) FROM champion WHERE name = NEW.champion2) = 0 THEN
		INSERT INTO `champion` VALUES (NEW.champion1, 0, 0, 0);
	END IF;
    IF (SELECT COUNT(*) FROM champion WHERE name = NEW.champion3) = 0 THEN
		INSERT INTO `champion` VALUES (NEW.champion1, 0, 0, 0);
	END IF;
    IF (SELECT COUNT(*) FROM champion WHERE name = NEW.champion4) = 0 THEN
		INSERT INTO `champion` VALUES (NEW.champion1, 0, 0, 0);
	END IF;
    IF (SELECT COUNT(*) FROM champion WHERE name = NEW.champion5) = 0 THEN
		INSERT INTO `champion` VALUES (NEW.champion1, 0, 0, 0);
	END IF;
END //
DELIMITER ;