import sqlite3

# assumes there is no valuable data in pre-existing tables
connection = sqlite3.connect("lcs2021.db")
c = connection.cursor()

# remove existing tables
c.execute("DROP TABLE IF EXISTS team;")
connection.commit()
c.execute("DROP TABLE IF EXISTS player;")
connection.commit()
c.execute("DROP TABLE IF EXISTS match;")
connection.commit()
c.execute("DROP TABLE IF EXISTS pick_ban;")
connection.commit()
c.execute("DROP TABLE IF EXISTS champion;")
connection.commit()

# table setup
c.execute("CREATE TABLE team ("
          "team_name NVARCHAR(1024) NOT NULL PRIMARY KEY,"
          "num_win INTEGER,"
          "num_loss INTEGER,"
          "lcs_rank INTEGER"
          ");")
connection.commit()

c.execute("CREATE TABLE player ("
          "ign TEXT NOT NULL PRIMARY KEY,"
          "name NVARCHAR(1024),"
          "country NVARCHAR(1024),"
          "role TEXT,"
          "kda_avg FLOAT(24),"
          "cs_avg FLOAT(24),"
          "salary FLOAT(24),"
          "team TEXT,"
          "mvp_count INTEGER"
          ");")
connection.commit()

c.execute("CREATE TABLE match ("
          "match_id INTEGER PRIMARY KEY,"
          "match_date DATETIME,"
          "team1_name NVARCHAR(1024),"
          "team2_name NVARCHAR(1024),"
          "outcome NVARCHAR(1024),"
          "team1_kills INTEGER,"
          "team2_kills INTEGER,"
          "team1_gold INTEGER,"
          "team2_gold INTEGER,"
          "match_length TIME,"
          "mvp NVARCHAR(1024), "
          "patch NVARCHAR(1024)"
          ");")
connection.commit()

c.execute("CREATE TABLE pick_ban ("
          "match_id INTEGER,"
          "team_name NVARCHAR(1024),"
          "pick_or_ban NVARCHAR(1024),"
          "champion1 NVARCHAR(1024),"
          "champion2 NVARCHAR(1024),"
          "champion3 NVARCHAR(1024),"
          "champion4 NVARCHAR(1024),"
          "champion5 NVARCHAR(1024),"
          "PRIMARY KEY (match_id, team_name, pick_or_ban),"
          "FOREIGN KEY (match_id) REFERENCES match (match_id)"
          "ON DELETE CASCADE ON UPDATE NO ACTION"
          ");")
connection.commit()

c.execute("CREATE TABLE champion ("
          "name NVARCHAR(1024) NOT NULL PRIMARY KEY,"
          "pick_rate FLOAT(24),"
          "ban_rate FLOAT(24),"
          "win_rate FLOAT(24)"
          ");")
connection.commit()

# create triggers
c.execute("DROP TRIGGER IF EXISTS champ_add_trigger;")
connection.commit()
c.execute("DROP TRIGGER IF EXISTS champ_recalc_pick_trigger;")
connection.commit()
c.execute("DROP TRIGGER IF EXISTS champ_recalc_ban_trigger;")
connection.commit()
c.execute("DROP TRIGGER IF EXISTS champ_recalc_win_trigger;")
connection.commit()
c.execute("DROP TRIGGER IF EXISTS player_recalc_mvp_trigger;")
connection.commit()
c.execute("DROP TRIGGER IF EXISTS team_recalc_winloss_trigger;")
connection.commit()
c.execute("CREATE TRIGGER champ_add_trigger BEFORE INSERT ON pick_ban BEGIN "
          "INSERT INTO champion SELECT NEW.champion1, 0, 0, 0 "
          "WHERE NOT EXISTS (SELECT 1 FROM champion WHERE name = NEW.champion1);"
          "INSERT INTO champion SELECT NEW.champion2, 0, 0, 0 "
          "WHERE NOT EXISTS (SELECT 1 FROM champion WHERE name = NEW.champion2);"
          "INSERT INTO champion SELECT NEW.champion3, 0, 0, 0 "
          "WHERE NOT EXISTS (SELECT 1 FROM champion WHERE name = NEW.champion3);"
          "INSERT INTO champion SELECT NEW.champion4, 0, 0, 0 "
          "WHERE NOT EXISTS (SELECT 1 FROM champion WHERE name = NEW.champion4);"
          "INSERT INTO champion SELECT NEW.champion5, 0, 0, 0 "
          "WHERE NOT EXISTS (SELECT 1 FROM champion WHERE name = NEW.champion5);"
          "END")
connection.commit()
c.execute("CREATE TRIGGER champ_recalc_pick_trigger AFTER INSERT ON pick_ban WHEN NEW.pick_or_ban = 'pick' BEGIN "
          "UPDATE champion "
          "SET pick_rate = pick_rate + 1 "
          "WHERE name = NEW.champion1;"
          "UPDATE champion "
          "SET pick_rate = pick_rate + 1 "
          "WHERE name = NEW.champion2;"
          "UPDATE champion "
          "SET pick_rate = pick_rate + 1 "
          "WHERE name = NEW.champion3;"
          "UPDATE champion "
          "SET pick_rate = pick_rate + 1 "
          "WHERE name = NEW.champion4;"
          "UPDATE champion "
          "SET pick_rate = pick_rate + 1 "
          "WHERE name = NEW.champion5;"
          "END")
connection.commit()
c.execute("CREATE TRIGGER champ_recalc_ban_trigger AFTER INSERT ON pick_ban WHEN NEW.pick_or_ban = 'ban' BEGIN "
          "UPDATE champion "
          "SET ban_rate = ban_rate + 1 "
          "WHERE name = NEW.champion1;"
          "UPDATE champion "
          "SET ban_rate = ban_rate + 1 "
          "WHERE name = NEW.champion2;"
          "UPDATE champion "
          "SET ban_rate = ban_rate + 1 "
          "WHERE name = NEW.champion3;"
          "UPDATE champion "
          "SET ban_rate = ban_rate + 1 "
          "WHERE name = NEW.champion4;"
          "UPDATE champion "
          "SET ban_rate = ban_rate + 1 "
          "WHERE name = NEW.champion5;"
          "END")
connection.commit()
c.execute("CREATE TRIGGER champ_recalc_win_trigger AFTER INSERT ON pick_ban WHEN NEW.pick_or_ban = 'pick' "
          "AND NEW.team_name = (SELECT outcome FROM match WHERE match_id = NEW.match_id) BEGIN "
          "UPDATE champion "
          "SET win_rate = win_rate + 1 "
          "WHERE name = NEW.champion1;"
          "UPDATE champion "
          "SET win_rate = win_rate + 1 "
          "WHERE name = NEW.champion2;"
          "UPDATE champion "
          "SET win_rate = win_rate + 1 "
          "WHERE name = NEW.champion3;"
          "UPDATE champion "
          "SET win_rate = win_rate + 1 "
          "WHERE name = NEW.champion4;"
          "UPDATE champion "
          "SET win_rate = win_rate + 1 "
          "WHERE name = NEW.champion5;"
          "END")
c.execute("CREATE TRIGGER player_recalc_mvp_trigger AFTER INSERT ON match BEGIN "
          "UPDATE player "
          "SET mvp_count = mvp_count + 1 "
          "WHERE ign = NEW.mvp;"
          "END")
c.execute("CREATE TRIGGER team_recalc_winloss_trigger AFTER INSERT ON match BEGIN "
          "UPDATE team "
          "SET num_loss = num_loss + 1 "
          "WHERE team_name = NEW.team1_name OR team_name = NEW.team2_name;"
          "UPDATE team "
          "SET num_win = num_win + 1, "
          "num_loss = num_loss - 1 "
          "WHERE team_name = NEW.outcome;"
          "END")

# insert teams into table, delimited in the source file by "::"
with open ("teams.txt") as file:
    for line in file:
        line = line.rstrip()
        args = line.split("::")
        if len(args) != 2:
            print(f"invalid number of args for team, ignoring entry {line}\n")
            continue
        c.execute("INSERT INTO team " 
                  f"VALUES ('{args[0]}', 0, 0, {args[1]});")
        connection.commit()


# insert players into table, delimited in the source file by "::"
with open ("players.txt") as file:
    for line in file:
        line = line.rstrip()
        args = line.split("::")
        if len(args) != 8:
            print(f"invalid number of args for player, ignoring entry {line}\n")
            continue
        c.execute("INSERT INTO player "
                  f"VALUES ('{args[0]}', '{args[1]}', '{args[2]}', '{args[3]}', "
                  f"{args[4]}, {args[5]}, {args[6]}, '{args[7]}', 0);")
        connection.commit()
# format -> match date::team1::team2::winner::team1 kills::team2 kills::team1 gold::team2 gold::match length::mvp::team1 bans (5 entries)::team2 bans (5 entries)::team1 picks (5 entries)::team2 picks (5 entries)
# insert matches into table, alongside associated picks/bans, delimited in the source file by "::"
match_id = 1
with open ("matches.txt") as file:
    for line in file:
        line = line.rstrip()
        args = line.split("::")
        if len(args) != 31:
            print(f"invalid number of args for match, ignoring entry {line}\n")
            continue
        c.execute("INSERT INTO match "
                  f"VALUES ({match_id}, '{args[0]}', '{args[1]}', '{args[2]}', '{args[3]}', "
                  f"{args[4]}, {args[5]}, {args[6]}, {args[7]}, '{args[8]}', '{args[9]}', '{args[30]}');")
        connection.commit()
        c.execute("INSERT INTO pick_ban "
                  f"VALUES ({match_id}, '{args[1]}', 'ban', '{args[10]}', '{args[11]}', "
                  f"'{args[12]}', '{args[13]}', '{args[14]}');")
        connection.commit()
        c.execute("INSERT INTO pick_ban "
                  f"VALUES ({match_id}, '{args[2]}', 'ban', '{args[15]}', '{args[16]}', "
                  f"'{args[17]}', '{args[18]}', '{args[19]}');")
        connection.commit()
        c.execute("INSERT INTO pick_ban "
                  f"VALUES ({match_id}, '{args[1]}', 'pick', '{args[20]}', '{args[21]}', "
                  f"'{args[22]}', '{args[23]}', '{args[24]}');")
        connection.commit()
        c.execute("INSERT INTO pick_ban "
                  f"VALUES ({match_id}, '{args[2]}', 'pick', '{args[25]}', '{args[26]}', "
                  f"'{args[27]}', '{args[28]}', '{args[29]}');")
        connection.commit()
        match_id += 1

# properly calculate pr, br, and wr of champs (should be done in sp in the future)
c.execute("UPDATE champion "
          "SET win_rate = ((win_rate / pick_rate) * 100) "
          "WHERE pick_rate <> 0;")
c.execute("UPDATE champion "
          "SET pick_rate = ((pick_rate / (SELECT COUNT(*) FROM match)) * 100), "
          "ban_rate = ((ban_rate / (SELECT COUNT(*) FROM match)) * 100);")

connection.commit()

# drop hanging triggers (leave the one that makes new champs, it's useful)
c.execute("DROP TRIGGER IF EXISTS champ_recalc_pick_trigger;")
connection.commit()
c.execute("DROP TRIGGER IF EXISTS champ_recalc_ban_trigger;")
connection.commit()
c.execute("DROP TRIGGER IF EXISTS champ_recalc_win_trigger;")
connection.commit()
c.close()
