DROP VIEW IF EXISTS top5Matches;
CREATE VIEW top5Matches AS
	SELECT match_date, team1_name, team2_name, outcome, team1_kills, team2_kills, mvp
    FROM `match`
    WHERE outcome IS NOT NULL
    ORDER BY match_date DESC
    LIMIT 5;