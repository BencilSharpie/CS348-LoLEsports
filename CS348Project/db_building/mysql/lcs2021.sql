CREATE DATABASE  IF NOT EXISTS `lcs2021` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lcs2021`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: lcs2021
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `champion`
--

DROP TABLE IF EXISTS `champion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `champion` (
  `name` varchar(64) NOT NULL,
  `pick_rate` decimal(8,5) DEFAULT NULL,
  `ban_rate` decimal(8,5) DEFAULT NULL,
  `win_rate` decimal(8,5) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `champion`
--

LOCK TABLES `champion` WRITE;
/*!40000 ALTER TABLE `champion` DISABLE KEYS */;
INSERT INTO `champion` VALUES ('Aatrox',0.13483,0.04494,0.41667),('Ahri',0.01124,0.00000,1.00000),('Alistar',0.43820,0.22472,0.46154),('Aphelios',0.11236,0.05618,0.60000),('Ashe',0.02247,0.00000,0.50000),('Aurelion Sol',0.00000,0.01124,0.00000),('Azir',0.42697,0.31461,0.52632),('Bard',0.02247,0.01124,0.50000),('Blitzcrank',0.05618,0.01124,0.40000),('Caitlyn',0.03371,0.00000,0.33333),('Camille',0.20225,0.31461,0.44444),('Cassiopeia',0.00000,0.01124,0.00000),('Chogath',0.03371,0.00000,1.00000),('Corki',0.03371,0.00000,0.00000),('Dr. Mundo',0.04494,0.00000,0.50000),('Draven',0.02247,0.01124,0.00000),('Ekko',0.02247,0.00000,1.00000),('Ezreal',0.05618,0.05618,0.40000),('Galio',0.11236,0.10112,0.60000),('Gangplank',0.20225,0.29213,0.38889),('Garen',0.00000,0.01124,0.00000),('Gnar',0.34831,0.34831,0.51613),('Gragas',0.32584,0.21348,0.41379),('Graves',0.16854,0.11236,0.26667),('Hecarim',0.40449,0.28090,0.52778),('Irelia',0.04494,0.17978,0.75000),('Ivern',0.01124,0.00000,0.00000),('Janna',0.02247,0.00000,0.50000),('Jarvan IV',0.03371,0.02247,0.66667),('Jax',0.02247,0.00000,1.00000),('Jayce',0.04494,0.07865,0.50000),('Jhin',0.03371,0.01124,0.33333),('Jinx',0.04494,0.03371,0.25000),('Kaisa',0.62921,0.23596,0.55357),('Kalista',0.08989,0.13483,0.62500),('Karma',0.03371,0.03371,0.66667),('Kayn',0.04494,0.01124,0.25000),('Kennen',0.02247,0.00000,0.00000),('Kindred',0.01124,0.02247,1.00000),('Kled',0.03371,0.02247,0.66667),('Leblanc',0.03371,0.01124,0.66667),('Leona',0.13483,0.05618,0.41667),('Lillia',0.34831,0.26966,0.58065),('Lucian',0.10112,0.12360,0.44444),('Lulu',0.04494,0.02247,0.50000),('Malphite',0.01124,0.01124,1.00000),('Malzahar',0.00000,0.01124,0.00000),('Maokai',0.01124,0.00000,0.00000),('Miss Fortune',0.05618,0.02247,0.80000),('Morgana',0.02247,0.02247,0.00000),('Nautilus',0.16854,0.04494,0.53333),('Neeko',0.02247,0.00000,0.50000),('Nidalee',0.10112,0.10112,0.55556),('Nocturne',0.02247,0.03371,0.00000),('Olaf',0.24719,0.67416,0.63636),('Orianna',0.35955,0.24719,0.56250),('Ornn',0.02247,0.00000,0.00000),('Pantheon',0.07865,0.25843,0.85714),('Quinn',0.01124,0.00000,1.00000),('Rakan',0.08989,0.05618,0.62500),('Reksai',0.02247,0.02247,1.00000),('Rell',0.48315,0.43820,0.55814),('Renekton',0.30337,0.52809,0.62963),('Rengar',0.01124,0.00000,0.00000),('Rumble',0.01124,0.00000,1.00000),('Ryze',0.05618,0.07865,0.80000),('Samira',0.11236,0.04494,0.20000),('Senna',0.17978,0.46067,0.37500),('Seraphine',0.13483,0.64045,0.50000),('Sett',0.02247,0.02247,0.50000),('Shen',0.08989,0.08989,0.62500),('Sion',0.12360,0.04494,0.18182),('Sivir',0.02247,0.00000,1.00000),('Skarner',0.13483,0.03371,0.33333),('Sylas',0.05618,0.02247,0.60000),('Syndra',0.29213,0.25843,0.38462),('Tahmkench',0.16854,0.02247,0.40000),('Taiyah',0.01124,0.00000,0.00000),('Taliyah',0.11236,0.07865,0.40000),('Thresh',0.17978,0.39326,0.43750),('Tristana',0.32584,0.23596,0.62069),('Twisted Fate',0.10112,0.32584,0.33333),('Udyr',0.20225,0.77528,0.50000),('Varus',0.01124,0.01124,1.00000),('Vayne',0.03371,0.01124,0.33333),('Veigar',0.01124,0.00000,1.00000),('Viktor',0.14607,0.04494,0.38462),('Xayah',0.20225,0.11236,0.44444),('Yasuo',0.01124,0.00000,1.00000),('Yone',0.06742,0.06742,0.66667),('Ziggs',0.01124,0.00000,0.00000),('Zoe',0.10112,0.05618,0.44444);
/*!40000 ALTER TABLE `champion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-04-27 22:04:02.202702'),(2,'auth','0001_initial','2022-04-27 22:04:03.291062'),(3,'admin','0001_initial','2022-04-27 22:04:03.546904'),(4,'admin','0002_logentry_remove_auto_add','2022-04-27 22:04:03.558900'),(5,'admin','0003_logentry_add_action_flag_choices','2022-04-27 22:04:03.570853'),(6,'contenttypes','0002_remove_content_type_name','2022-04-27 22:04:03.880625'),(7,'auth','0002_alter_permission_name_max_length','2022-04-27 22:04:04.107659'),(8,'auth','0003_alter_user_email_max_length','2022-04-27 22:04:04.140646'),(9,'auth','0004_alter_user_username_opts','2022-04-27 22:04:04.153612'),(10,'auth','0005_alter_user_last_login_null','2022-04-27 22:04:04.244502'),(11,'auth','0006_require_contenttypes_0002','2022-04-27 22:04:04.252530'),(12,'auth','0007_alter_validators_add_error_messages','2022-04-27 22:04:04.264773'),(13,'auth','0008_alter_user_username_max_length','2022-04-27 22:04:04.368655'),(14,'auth','0009_alter_user_last_name_max_length','2022-04-27 22:04:04.481147'),(15,'auth','0010_alter_group_name_max_length','2022-04-27 22:04:04.514578'),(16,'auth','0011_update_proxy_permissions','2022-04-27 22:04:04.526538'),(17,'auth','0012_alter_user_first_name_max_length','2022-04-27 22:04:04.635371');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match`
--

DROP TABLE IF EXISTS `match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match` (
  `match_id` tinyint NOT NULL,
  `match_date` datetime DEFAULT NULL,
  `team1_name` varchar(64) DEFAULT NULL,
  `team2_name` varchar(64) DEFAULT NULL,
  `outcome` varchar(64) DEFAULT NULL,
  `team1_kills` tinyint DEFAULT NULL,
  `team2_kills` tinyint DEFAULT NULL,
  `team1_gold` mediumint DEFAULT NULL,
  `team2_gold` mediumint DEFAULT NULL,
  `match_length` varchar(64) DEFAULT NULL,
  `mvp` varchar(64) DEFAULT NULL,
  `patch` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`match_id`),
  KEY `OUTCOME_NULL` (`outcome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match`
--

LOCK TABLES `match` WRITE;
/*!40000 ALTER TABLE `match` DISABLE KEYS */;
INSERT INTO `match` VALUES (1,'2021-02-05 18:00:00','TSM','FlyQuest','FlyQuest',9,20,68200,73500,'00:40:00','Josedeodo',11.2),(2,'2021-02-05 19:00:00','Team Liquid','Immortals','Immortals',6,14,59400,64600,'00:35:00','Destiny',11.2),(3,'2021-02-05 20:00:00','Evil Geniuses','100 Thieves','100 Thieves',15,15,75400,81200,'00:46:00','huhi',11.2),(4,'2021-02-05 21:00:00','Golden Guardians','Cloud9','Cloud9',5,15,50000,59200,'00:31:00','Blaber',11.2),(5,'2021-02-05 22:00:00','Counter Logic Gaming','Dignitas','Dignitas',16,21,61900,67700,'00:34:00','Neo',11.2),(6,'2021-02-06 16:00:00','FlyQuest','Evil Geniuses','Evil Geniuses',14,22,57000,64000,'00:33:00','Impact',11.2),(7,'2021-02-06 17:00:00','Dignitas','Team Liquid','Team Liquid',6,9,42200,52800,'00:27:00','Alphari',11.2),(8,'2021-02-06 18:00:00','100 Thieves','Counter Logic Gaming','100 Thieves',21,23,93400,84700,'00:49:00','Damonte',11.2),(9,'2021-02-06 19:00:00','Cloud9','TSM','Cloud9',26,10,62300,44700,'00:28:00','Blaber',11.2),(10,'2021-02-06 20:00:00','Immortals','Golden Guardians','Golden Guardians',15,9,82700,89200,'00:48:00','Niles',11.2),(11,'2021-02-07 16:00:00','FlyQuest','Team Liquid','Team Liquid',11,16,49700,60800,'00:31:00','Santorin',11.2),(12,'2021-02-07 17:00:00','Evil Geniuses','Golden Guardians','Evil Geniuses',22,6,58500,44100,'00:28:00','Deftly',11.2),(13,'2021-02-07 19:00:00','Counter Logic Gaming','TSM','TSM',10,14,75900,82800,'00:45:00','PowerOfEvil',11.2),(14,'2021-02-07 20:00:00','100 Thieves','Dignitas','100 Thieves',14,4,60900,44300,'00:30:00','Closer',11.2),(15,'2021-02-12 18:00:00','100 Thieves','FlyQuest','100 Thieves',15,18,59500,52400,'00:31:00','FBI',11.3),(16,'2021-02-12 19:00:00','Counter Logic Gaming','Team Liquid','Team Liquid',3,18,38100,49800,'00:24:00','Jensen',11.3),(17,'2021-02-12 20:00:00','Evil Geniuses','Cloud9','Evil Geniuses',26,10,62900,51000,'00:31:00','Svenskeren',11.3),(18,'2021-02-12 21:00:00','TSM','Golden Guardians','TSM',15,10,62800,56300,'00:33:00','PowerOfEvil',11.3),(19,'2021-02-12 22:00:00','Dignitas','Immortals','Dignitas',16,5,60000,49500,'00:30:00','aphromoo',11.3),(20,'2021-02-13 16:00:00','FlyQuest','Counter Logic Gaming','FlyQuest',20,6,57800,46500,'00:28:00','Palafox',11.3),(21,'2021-02-13 17:00:00','Cloud9','100 Thieves','Cloud9',30,18,69700,58100,'00:33:00','Perkz',11.3),(22,'2021-02-13 18:00:00','Golden Guardians','Dignitas','Dignitas',4,16,48300,57300,'00:29:00','Dardoch',11.3),(23,'2021-02-13 19:00:00','TSM','Team Liquid','TSM',12,3,64100,51400,'00:32:00','PowerOfEvil',11.3),(24,'2021-02-13 20:00:00','Immortals','Evil Geniuses','Immortals',19,4,60200,46900,'00:30:00','Xerxe',11.3),(25,'2021-02-14 16:00:00','Team Liquid','100 Thieves','100 Thieves',13,11,57000,50500,'00:30:00','Closer',11.3),(26,'2021-02-14 17:00:00','Immortals','TSM','TSM',5,14,46500,57500,'00:29:00','Huni',11.3),(27,'2021-02-14 18:00:00','Evil Geniuses','Dignitas','Dignitas',9,21,49100,60900,'00:32:00','Soligo',11.3),(28,'2021-02-14 19:00:00','Cloud9','FlyQuest','Cloud9',16,6,58200,46000,'00:29:00','Blaber',11.3),(29,'2021-02-14 20:00:00','Golden Guardians','Counter Logic Gaming','Counter Logic Gaming',17,5,62500,51000,'00:32:00','Finn',11.3),(30,'2021-02-19 18:00:00','Counter Logic Gaming','Cloud9','Cloud9',17,21,70400,77300,'00:39:00','Perkz',11.3),(31,'2021-02-19 19:00:00','Dignitas','FlyQuest','Dignitas',22,7,60900,49600,'00:30:00','FakeGod',11.3),(32,'2021-02-19 20:00:00','Golden Guardians','Team Liquid','Team Liquid',2,16,33200,47900,'00:23:00','Jensen',11.3),(33,'2021-02-19 21:00:00','TSM','Evil Geniuses','TSM',17,8,54200,44600,'00:27:00','PowerOfEvil',11.3),(34,'2021-02-19 22:00:00','Immortals','100 Thieves','100 Thieves',8,13,46600,56800,'00:29:00','huhi',11.3),(35,'2021-02-20 16:00:00','Cloud9','Dignitas','Cloud9',21,7,54600,45600,'00:23:00','Perkz',11.3),(36,'2021-02-20 17:00:00','Counter Logic Gaming','Immortals','Immortals',4,18,54600,65100,'00:34:00','Raes',11.3),(37,'2021-02-20 18:00:00','TSM','100 Thieves','TSM',15,2,66100,52100,'00:32:00','SwordArt',11.3),(38,'2021-02-20 19:00:00','Team Liquid','Evil Geniuses','Evil Geniuses',11,18,55300,60500,'00:33:00','Impact',11.3),(39,'2021-02-20 20:00:00','FlyQuest','Golden Guardians','FlyQuest',16,2,53900,42700,'00:28:00','Licorice',11.3),(40,'2021-02-21 16:00:00','Dignitas','TSM','Dignitas',20,7,56200,45900,'00:28:00','Dardoch',11.3),(41,'2021-02-21 17:00:00','Immortals','FlyQuest','Immortals',22,9,75700,63600,'00:39:00','Xerxe',11.3),(42,'2021-02-21 18:00:00','100 Thieves','Golden Guardians','Golden Guardians',16,16,93900,102400,'00:56:00','Stixxay',11.3),(43,'2021-02-21 19:00:00','Team Liquid','Cloud9','Team Liquid',24,11,62400,50200,'00:30:00','Santorin',11.3),(44,'2021-02-21 20:00:00','Evil Geniuses','Counter Logic Gaming','Evil Geniuses',13,8,80500,68300,'00:42:00','Svenskeren',11.3),(45,'2021-02-26 18:00:00','Cloud9','Golden Guardians','Cloud9',12,4,54700,42300,'00:28:00','Vulcan',11.4),(46,'2021-02-26 19:00:00','Team Liquid','TSM','TSM',18,14,70100,73500,'00:40:00','Spica',11.4),(47,'2021-02-26 20:00:00','Evil Geniuses','FlyQuest','Evil Geniuses',16,15,75500,70600,'00:44:00','Jiizuke',11.4),(48,'2021-02-26 21:00:00','Counter Logic Gaming','100 Thieves','100 Thieves',17,15,68400,72700,'00:40:00','Closer',11.4),(49,'2021-02-26 22:00:00','Immortals','Dignitas','Dignitas',4,10,44700,54200,'00:29:00','FakeGod',11.4),(50,'2021-02-27 16:00:00','Team Liquid','FlyQuest','Team Liquid',11,5,59100,47400,'00:30:00','Tactical',11.4),(51,'2021-02-27 17:00:00','Cloud9','Evil Geniuses','Cloud9',19,9,59000,51100,'00:31:00','Blaber',11.4),(52,'2021-02-27 18:00:00','Dignitas','100 Thieves','100 Thieves',17,18,73800,80100,'00:42:00','Ssumday',11.4),(53,'2021-02-27 19:00:00','TSM','Counter Logic Gaming','TSM',15,5,69600,56600,'00:35:00','Huni',11.4),(54,'2021-02-27 20:00:00','Golden Guardians','Immortals','Immortals',4,10,54300,65300,'00:35:00','Insanity',11.4),(55,'2021-02-28 16:00:00','FlyQuest','TSM','FlyQuest',12,4,68700,64700,'00:37:00','Palafox',11.4),(56,'2021-02-28 17:00:00','100 Thieves','Cloud9','Cloud9',2,14,39400,46500,'00:24:00','Blaber',11.4),(57,'2021-02-28 18:00:00','Immortals','Team Liquid','Team Liquid',7,16,51000,65100,'00:32:00','Alphari',11.4),(58,'2021-02-28 19:00:00','Golden Guardians','Evil Geniuses','Evil Geniuses',21,15,77800,68300,'00:40:00','IgNar',11.4),(59,'2021-02-28 20:00:00','Dignitas','Counter Logic Gaming','Counter Logic Gaming',10,15,54400,60400,'00:34:00','Smoothie',11.4),(60,'2021-03-05 18:00:00','TSM','Dignitas','Dignitas',14,12,65000,64000,'00:36:00','FakeGod',11.4),(61,'2021-03-05 19:00:00','100 Thieves','Evil Geniuses','Evil Geniuses',7,11,53000,63100,'00:33:00','Deftly',11.4),(62,'2021-03-05 20:00:00','FlyQuest','Cloud9','Cloud9',4,14,35700,51600,'00:23:00','Perkz',11.4),(63,'2021-03-05 21:00:00','Team Liquid','Golden Guardians','Team Liquid',16,2,61000,46800,'00:31:00','Santorin',11.4),(64,'2021-03-05 22:00:00','Immortals','Counter Logic Gaming','Counter Logic Gaming',3,12,39500,51100,'00:26:00','WildTurtle',11.4),(65,'2021-03-06 16:00:00','Dignitas','Golden Guardians','Dignitas',24,11,75300,66200,'00:39:00','Neo',11.4),(66,'2021-03-06 17:00:00','100 Thieves','TSM','TSM',6,16,46200,55500,'00:30:00','Lost',11.4),(67,'2021-03-06 18:00:00','Cloud9','Team Liquid','Team Liquid',7,13,67900,76400,'00:40:00','Alphari',11.4),(68,'2021-03-06 19:00:00','Evil Geniuses','Immortals','Immortals',7,19,54500,62600,'00:32:00','Destiny',11.4),(69,'2021-03-06 20:00:00','Counter Logic Gaming','FlyQuest','FlyQuest',12,24,61900,72400,'00:36:00','Josedeodo',11.4),(70,'2021-03-07 16:00:00','Golden Guardians','100 Thieves','100 Thieves',25,7,62100,47600,'00:30:00','Closer',11.4),(71,'2021-03-07 17:00:00','Dignitas','Evil Geniuses','Dignitas',21,29,75700,83900,'00:43:00','FakeGod',11.4),(72,'2021-03-07 18:00:00','TSM','Cloud9','TSM',23,11,67300,59000,'00:34:00','SwordArt',11.4),(73,'2021-03-07 19:00:00','Team Liquid','Counter Logic Gaming','Counter Logic Gaming',6,18,63200,74100,'00:38:00','Pobelter',11.4),(74,'2021-03-07 20:00:00','FlyQuest','Immortals','Immortals',4,14,40800,51200,'00:26:00','Raes',11.4),(75,'2021-03-12 18:00:00','Cloud9','Counter Logic Gaming','Counter Logic Gaming',9,19,54700,62300,'00:32:00','Finn',11.5),(76,'2021-03-12 19:00:00','Evil Geniuses','TSM','Evil Geniuses',16,4,70900,55400,'00:37:00','Impact',11.5),(77,'2021-03-12 20:00:00','100 Thieves','Immortals','100 Thieves',12,8,62400,56400,'00:34:00','FBI',11.5),(78,'2021-03-12 21:00:00','Team Liquid','Dignitas','Team Liquid',14,4,56900,46600,'00:29:00','Alphari',11.5),(79,'2021-03-12 22:00:00','Golden Guardians','FlyQuest','FlyQuest',10,13,73100,77800,'00:43:00','Johnsun',11.5),(80,'2021-03-13 16:00:00','TSM','Immortals','TSM',14,6,59300,48100,'00:31:00','PowerOfEvil',11.5),(81,'2021-03-13 17:00:00','Dignitas','Cloud9','Cloud9',5,16,50700,64100,'00:32:00','Vulcan',11.5),(82,'2021-03-13 18:00:00','FlyQuest','100 Thieves','100 Thieves',11,20,57500,67300,'00:34:00','FBI',11.5),(83,'2021-03-13 19:00:00','Evil Geniuses','Team Liquid','Team Liquid',7,21,54600,67500,'00:34:00','Santorin',11.5),(84,'2021-03-13 20:00:00','Counter Logic Gaming','Golden Guardians','Golden Guardians',4,19,66000,81000,'00:41:00','Ablazeolive',11.5),(85,'2021-03-14 16:00:00','FlyQuest','Dignitas','Dignitas',21,17,74500,70600,'00:38:00','FakeGod',11.5),(86,'2021-03-14 17:00:00','Golden Guardians','TSM','TSM',4,21,44200,59700,'00:28:00','Spica',11.5),(87,'2021-03-14 18:00:00','100 Thieves','Team Liquid','Team Liquid',6,17,49800,63600,'00:31:00','Santorin',11.5),(88,'2021-03-14 19:00:00','Evil Geniuses','Counter Logic Gaming','Evil Geniuses',24,18,75500,74300,'00:39:00','Jiizuke',11.5),(89,'2021-03-14 20:00:00','Immortals','Cloud9','Cloud9',4,11,61600,64900,'00:36:00','Blaber',11.5);
/*!40000 ALTER TABLE `match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pick_ban`
--

DROP TABLE IF EXISTS `pick_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pick_ban` (
  `match_id` tinyint NOT NULL,
  `team_name` varchar(64) NOT NULL,
  `pick_or_ban` varchar(64) NOT NULL,
  `champion1` varchar(64) DEFAULT NULL,
  `champion2` varchar(64) DEFAULT NULL,
  `champion3` varchar(64) DEFAULT NULL,
  `champion4` varchar(64) DEFAULT NULL,
  `champion5` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`match_id`,`team_name`,`pick_or_ban`),
  CONSTRAINT `pick_ban_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `match` (`match_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pick_ban`
--

LOCK TABLES `pick_ban` WRITE;
/*!40000 ALTER TABLE `pick_ban` DISABLE KEYS */;
INSERT INTO `pick_ban` VALUES (1,'FlyQuest','ban','Pantheon','Olaf','Udyr','Xayah','Samira'),(1,'FlyQuest','pick','Camille','Hecarim','Orianna','Seraphine','Rell'),(1,'TSM','ban','Twisted Fate','Renekton','Kaisa','Galio','Shen'),(1,'TSM','pick','Gangplank','Taliyah','Syndra','Miss Fortune','Alistar'),(2,'Immortals','ban','Gangplank','Camille','Thresh','Azir','Renekton'),(2,'Immortals','pick','Irelia','Pantheon','Orianna','Kaisa','Blitzcrank'),(2,'Team Liquid','ban','Olaf','Nidalee','Seraphine','Rell','Jayce'),(2,'Team Liquid','pick','Kennen','Udyr','Yone','Senna','Tahmkench'),(3,'100 Thieves','ban','Pantheon','Taliyah','Renekton','Seraphine','Blitzcrank'),(3,'100 Thieves','pick','Camille','Olaf','Orianna','Aphelios','Alistar'),(3,'Evil Geniuses','ban','Twisted Fate','Galio','Kaisa','Rell','Senna'),(3,'Evil Geniuses','pick','Gnar','Udyr','Azir','Xayah','Rakan'),(4,'Cloud9','ban','Pantheon','Olaf','Jayce','Rell','Alistar'),(4,'Cloud9','pick','Jax','Taliyah','Azir','Miss Fortune','Galio'),(4,'Golden Guardians','ban','Twisted Fate','Seraphine','Renekton','Senna','Thresh'),(4,'Golden Guardians','pick','Camille','Udyr','Syndra','Kaisa','Leona'),(5,'Counter Logic Gaming','ban','Azir','Olaf','Thresh','Leona','Gangplank'),(5,'Counter Logic Gaming','pick','Aatrox','Lillia','Twisted Fate','Xayah','Rell'),(5,'Dignitas','ban','Seraphine','Pantheon','Renekton','Irelia','Camille'),(5,'Dignitas','pick','Gnar','Udyr','Orianna','Kaisa','Alistar'),(6,'Evil Geniuses','ban','Olaf','Seraphine','Pantheon','Miss Fortune','Orianna'),(6,'Evil Geniuses','pick','Shen','Hecarim','Leblanc','Kaisa','Rell'),(6,'FlyQuest','ban','Renekton','Xayah','Udyr','Gragas','Ryze'),(6,'FlyQuest','pick','Camille','Taliyah','Twisted Fate','Senna','Alistar'),(7,'Dignitas','ban','Gangplank','Pantheon','Seraphine','Senna','Aphelios'),(7,'Dignitas','pick','Gragas','Dr. Mundo','Azir','Xayah','Blitzcrank'),(7,'Team Liquid','ban','Olaf','Gnar','Kaisa','Kindred','Jarvan IV'),(7,'Team Liquid','pick','Renekton','Udyr','Orianna','Miss Fortune','Thresh'),(8,'100 Thieves','ban','Irelia','Udyr','Pantheon','Gnar','Gangplank'),(8,'100 Thieves','pick','Renekton','Taliyah','Syndra','Kaisa','Leona'),(8,'Counter Logic Gaming','ban','Galio','Twisted Fate','Olaf','Alistar','Sett'),(8,'Counter Logic Gaming','pick','Gragas','Nocturne','Orianna','Samira','Rell'),(9,'Cloud9','ban','Rell','Renekton','Nidalee','Galio','Orianna'),(9,'Cloud9','pick','Jax','Udyr','Azir','Miss Fortune','Alistar'),(9,'TSM','ban','Pantheon','Olaf','Twisted Fate','Senna','Thresh'),(9,'TSM','pick','Camille','Taiyah','Corki','Kaisa','Leona'),(10,'Golden Guardians','ban','Seraphine','Pantheon','Irelia','Gragas','Alistar'),(10,'Golden Guardians','pick','Gangplank','Olaf','Twisted Fate','Xayah','Rakan'),(10,'Immortals','ban','Udyr','Camille','Senna','Jayce','Gnar'),(10,'Immortals','pick','Ivern','Hecarim','Orianna','Kaisa','Rell'),(11,'FlyQuest','ban','Renekton','Camille','Azir','Xayah','Senna'),(11,'FlyQuest','pick','Aatrox','Udyr','Orianna','Kaisa','Nautilus'),(11,'Team Liquid','ban','Seraphine','Olaf','Lulu','Rell','Alistar'),(11,'Team Liquid','pick','Gangplank','Pantheon','Syndra','Aphelios','Thresh'),(12,'Evil Geniuses','ban','Gangplank','Camille','Twisted Fate','Azir','Jayce'),(12,'Evil Geniuses','pick','Sylas','Udyr','Orianna','Kaisa','Nautilus'),(12,'Golden Guardians','ban','Pantheon','Olaf','Renekton','Rell','Rakan'),(12,'Golden Guardians','pick','Gnar','Taliyah','Viktor','Xayah','Alistar'),(13,'Counter Logic Gaming','ban','Kaisa','Camille','Nidalee','Rakan','Gangplank'),(13,'Counter Logic Gaming','pick','Camille','Udyr','Zoe','Aphelios','Thresh'),(13,'TSM','ban','Twisted Fate','Seraphine','Pantheon','Jhin','Orianna'),(13,'TSM','pick','Lulu','Olaf','Azir','Xayah','Leona'),(14,'100 Thieves','ban','Azir','Udyr','Pantheon','Hecarim','Nocturne'),(14,'100 Thieves','pick','Renekton','Taliyah','Sett','Senna','Tahmkench'),(14,'Dignitas','ban','Twisted Fate','Galio','Olaf','Aphelios','Xayah'),(14,'Dignitas','pick','Gragas','Rengar','Syndra','Kaisa','Blitzcrank'),(15,'100 Thieves','ban','Gragas','Hecarim','Graves','Gnar','Miss Fortune'),(15,'100 Thieves','pick','Renekton','Udyr','Orianna','Senna','Tahmkench'),(15,'FlyQuest','ban','Twisted Fate','Pantheon','Rell','Kaisa','Leona'),(15,'FlyQuest','pick','Gangplank','Olaf','Azir','Seraphine','Maokai'),(16,'Counter Logic Gaming','ban','Olaf','Skarner','Thresh','Camille','Nidalee'),(16,'Counter Logic Gaming','pick','Renekton','Graves','Orianna','Xayah','Rell'),(16,'Team Liquid','ban','Udyr','Zoe','Taliyah','Gangplank','Thresh'),(16,'Team Liquid','pick','Gnar','Lillia','Azir','Kaisa','Alistar'),(17,'Cloud9','ban','Olaf','Udyr','Renekton','Shen','Orianna'),(17,'Cloud9','pick','Camille','Taliyah','Galio','Kaisa','Blitzcrank'),(17,'Evil Geniuses','ban','Twisted Fate','Rell','Lillia','Pantheon','Syndra'),(17,'Evil Geniuses','pick','Gragas','Graves','Ryze','Senna','Tahmkench'),(18,'Golden Guardians','ban','Udyr','Renekton','Kaisa','Seraphine','Rell'),(18,'Golden Guardians','pick','Gnar','Graves','Azir','Senna','Thresh'),(18,'TSM','ban','Twisted Fate','Taliyah','Camille','Kalista','Aphelios'),(18,'TSM','pick','Gragas','Olaf','Syndra','Ezreal','Bard'),(19,'Dignitas','ban','Seraphine','Irelia','Camille','Senna','Leona'),(19,'Dignitas','pick','Renekton','Hecarim','Orianna','Kalista','Thresh'),(19,'Immortals','ban','Olaf','Udyr','Taliyah','Kaisa','Ezreal'),(19,'Immortals','pick','Gnar','Lillia','Azir','Aphelios','Nautilus'),(20,'Counter Logic Gaming','ban','Olaf','Udyr','Camille','Gragas','Gnar'),(20,'Counter Logic Gaming','pick','Gangplank','Taliyah','Sylas','Kaisa','Alistar'),(20,'FlyQuest','ban','Renekton','Senna','Rell','Twisted Fate','Zoe'),(20,'FlyQuest','pick','Chogath','Graves','Yone','Miss Fortune','Seraphine'),(21,'100 Thieves','ban','Udyr','Olaf','Hecarim','Nocturne','Graves'),(21,'100 Thieves','pick','Aatrox','Taliyah','Galio','Kaisa','Sett'),(21,'Cloud9','ban','Senna','Camille','Renekton','Alistar','Pantheon'),(21,'Cloud9','pick','Gragas','Reksai','Zoe','Samira','Rell'),(22,'Dignitas','ban','Udyr','Olaf','Senna','Galio','Zoe'),(22,'Dignitas','pick','Rumble','Kindred','Twisted Fate','Aphelios','Thresh'),(22,'Golden Guardians','ban','Renekton','Seraphine','Gragas','Taliyah','Nidalee'),(22,'Golden Guardians','pick','Gangplank','Graves','Azir','Kaisa','Alistar'),(23,'Team Liquid','ban','Udyr','Olaf','Syndra','Gangplank','Alistar'),(23,'Team Liquid','pick','Kennen','Graves','Zoe','Jhin','Nautilus'),(23,'TSM','ban','Camille','Taliyah','Seraphine','Rell','Jayce'),(23,'TSM','pick','Gnar','Lillia','Azir','Kaisa','Pantheon'),(24,'Evil Geniuses','ban','Udyr','Olaf','Hecarim','Lucian','Samira'),(24,'Evil Geniuses','pick','Gragas','Graves','Leblanc','Kaisa','Alistar'),(24,'Immortals','ban','Renekton','Pantheon','Senna','Syndra','Orianna'),(24,'Immortals','pick','Camille','Lillia','Tristana','Seraphine','Rell'),(25,'100 Thieves','ban','Udyr','Senna','Orianna','Alistar','Thresh'),(25,'100 Thieves','pick','Quinn','Lillia','Ryze','Kaisa','Rell'),(25,'Team Liquid','ban','Azir','Camille','Graves','Gnar','Gangplank'),(25,'Team Liquid','pick','Renekton','Olaf','Twisted Fate','Ezreal','Nautilus'),(26,'Immortals','ban','Renekton','Azir','Syndra','Gangplank','Rell'),(26,'Immortals','pick','Camille','Lillia','Orianna','Xayah','Alistar'),(26,'TSM','ban','Seraphine','Udyr','Olaf','Thresh','Senna'),(26,'TSM','pick','Shen','Hecarim','Viktor','Kaisa','Pantheon'),(27,'Dignitas','ban','Udyr','Olaf','Garen','Bard','Karma'),(27,'Dignitas','pick','Gangplank','Kayn','Zoe','Senna','Tahmkench'),(27,'Evil Geniuses','ban','Twisted Fate','Aurelion Sol','Thresh','Hecarim','Syndra'),(27,'Evil Geniuses','pick','Gnar','Lillia','Lucian','Ezreal','Seraphine'),(28,'Cloud9','ban','Seraphine','Senna','Camille','Azir','Gangplank'),(28,'Cloud9','pick','Gragas','Taliyah','Tristana','Samira','Alistar'),(28,'FlyQuest','ban','Udyr','Olaf','Rell','Hecarim','Yone'),(28,'FlyQuest','pick','Aatrox','Graves','Syndra','Kaisa','Leona'),(29,'Counter Logic Gaming','ban','Udyr','Renekton','Rell','Nocturne','Alistar'),(29,'Counter Logic Gaming','pick','Gangplank','Graves','Syndra','Kaisa','Galio'),(29,'Golden Guardians','ban','Twisted Fate','Olaf','Camille','Malzahar','Nautilus'),(29,'Golden Guardians','pick','Aatrox','Gragas','Zoe','Samira','Leona'),(30,'Cloud9','ban','Graves','Udyr','Samira','Orianna','Camille'),(30,'Cloud9','pick','Gragas','Reksai','Ryze','Kaisa','Alistar'),(30,'Counter Logic Gaming','ban','Senna','Olaf','Seraphine','Hecarim','Tristana'),(30,'Counter Logic Gaming','pick','Aatrox','Lillia','Zoe','Xayah','Rell'),(31,'Dignitas','ban','Senna','Yone','Thresh','Sylas','Syndra'),(31,'Dignitas','pick','Gnar','Jarvan IV','Azir','Seraphine','Alistar'),(31,'FlyQuest','ban','Renekton','Udyr','Olaf','Graves','Kindred'),(31,'FlyQuest','pick','Gangplank','Hecarim','Orianna','Kaisa','Rell'),(32,'Golden Guardians','ban','Seraphine','Syndra','Thresh','Samira','Renekton'),(32,'Golden Guardians','pick','Pantheon','Lillia','Yone','Kaisa','Gragas'),(32,'Team Liquid','ban','Udyr','Olaf','Senna','Orianna','Gangplank'),(32,'Team Liquid','pick','Camille','Hecarim','Azir','Tristana','Rell'),(33,'Evil Geniuses','ban','Udyr','Olaf','Pantheon','Lillia','Alistar'),(33,'Evil Geniuses','pick','Gangplank','Hecarim','Ryze','Samira','Rell'),(33,'TSM','ban','Twisted Fate','Renekton','Senna','Leblanc','Shen'),(33,'TSM','pick','Gnar','Nidalee','Azir','Kaisa','Galio'),(34,'100 Thieves','ban','Udyr','Camille','Seraphine','Orianna','Tristana'),(34,'100 Thieves','pick','Aatrox','Olaf','Twisted Fate','Kaisa','Nautilus'),(34,'Immortals','ban','Senna','Renekton','Thresh','Sett','Alistar'),(34,'Immortals','pick','Gragas','Hecarim','Azir','Draven','Rell'),(35,'Cloud9','ban','Gnar','Azir','Seraphine','Nidalee','Syndra'),(35,'Cloud9','pick','Gragas','Lillia','Tristana','Ashe','Lulu'),(35,'Dignitas','ban','Udyr','Olaf','Rell','Thresh','Ryze'),(35,'Dignitas','pick','Renekton','Kayn','Twisted Fate','Senna','Tahmkench'),(36,'Counter Logic Gaming','ban','Camille','Seraphine','Senna','Leona','Gragas'),(36,'Counter Logic Gaming','pick','Ornn','Graves','Azir','Samira','Alistar'),(36,'Immortals','ban','Udyr','Gangplank','Rell','Aatrox','Gnar'),(36,'Immortals','pick','Renekton','Lillia','Viktor','Kaisa','Galio'),(37,'100 Thieves','ban','Udyr','Azir','Olaf','Orianna','Gragas'),(37,'100 Thieves','pick','Jayce','Nidalee','Syndra','Senna','Tahmkench'),(37,'TSM','ban','Twisted Fate','Renekton','Taliyah','Graves','Aatrox'),(37,'TSM','pick','Gnar','Hecarim','Viktor','Kaisa','Rell'),(38,'Evil Geniuses','ban','Udyr','Olaf','Rell','Thresh','Kalista'),(38,'Evil Geniuses','pick','Gnar','Lillia','Yone','Kaisa','Alistar'),(38,'Team Liquid','ban','Renekton','Senna','Hecarim','Lucian','Ryze'),(38,'Team Liquid','pick','Camille','Nidalee','Galio','Samira','Leona'),(39,'FlyQuest','ban','Pantheon','Camille','Olaf','Karma','Gangplank'),(39,'FlyQuest','pick','Shen','Lillia','Yone','Senna','Tahmkench'),(39,'Golden Guardians','ban','Udyr','Seraphine','Thresh','Gnar','Tristana'),(39,'Golden Guardians','pick','Gragas','Graves','Azir','Ezreal','Bard'),(40,'Dignitas','ban','Senna','Kaisa','Hecarim','Syndra','Orianna'),(40,'Dignitas','pick','Gnar','Skarner','Azir','Kalista','Alistar'),(40,'TSM','ban','Udyr','Seraphine','Thresh','Lillia','Nidalee'),(40,'TSM','pick','Lulu','Olaf','Corki','Samira','Rell'),(41,'FlyQuest','ban','Udyr','Seraphine','Lillia','Kaisa','Kalista'),(41,'FlyQuest','pick','Gnar','Skarner','Viktor','Aphelios','Thresh'),(41,'Immortals','ban','Senna','Tristana','Yone','Orianna','Azir'),(41,'Immortals','pick','Gangplank','Hecarim','Syndra','Ezreal','Rell'),(42,'100 Thieves','ban','Pantheon','Camille','Graves','Alistar','Yone'),(42,'100 Thieves','pick','Aatrox','Olaf','Orianna','Kaisa','Rell'),(42,'Golden Guardians','ban','Udyr','Renekton','Thresh','Gnar','Syndra'),(42,'Golden Guardians','pick','Gragas','Lillia','Tristana','Sivir','Janna'),(43,'Cloud9','ban','Rell','Udyr','Azir','Kaisa','Nautilus'),(43,'Cloud9','pick','Gragas','Skarner','Lucian','Ashe','Thresh'),(43,'Team Liquid','ban','Senna','Alistar','Olaf','Reksai','Tristana'),(43,'Team Liquid','pick','Renekton','Hecarim','Orianna','Aphelios','Tahmkench'),(44,'Counter Logic Gaming','ban','Udyr','Seraphine','Olaf','Gragas','Rakan'),(44,'Counter Logic Gaming','pick','Ornn','Graves','Corki','Samira','Alistar'),(44,'Evil Geniuses','ban','Rell','Senna','Irelia','Gangplank','Malphite'),(44,'Evil Geniuses','pick','Gnar','Lillia','Azir','Kaisa','Galio'),(45,'Cloud9','ban','Camille','Lillia','Gangplank','Lulu','Irelia'),(45,'Cloud9','pick','Karma','Hecarim','Azir','Kaisa','Rell'),(45,'Golden Guardians','ban','Udyr','Thresh','Olaf','Orianna','Twisted Fate'),(45,'Golden Guardians','pick','Gragas','Skarner','Syndra','Jinx','Janna'),(46,'Team Liquid','ban','Gnar','Azir','Lillia','Rell','Pantheon'),(46,'Team Liquid','pick','Gragas','Olaf','Seraphine','Tristana','Alistar'),(46,'TSM','ban','Udyr','Senna','Camille','Renekton','Gangplank'),(46,'TSM','pick','Shen','Hecarim','Syndra','Kaisa','Galio'),(47,'Evil Geniuses','ban','Seraphine','Tristana','Lillia','Azir','Gnar'),(47,'Evil Geniuses','pick','Renekton','Olaf','Orianna','Varus','Neeko'),(47,'FlyQuest','ban','Udyr','Gragas','Rell','Jinx','Ezreal'),(47,'FlyQuest','pick','Sion','Graves','Syndra','Senna','Tahmkench'),(48,'100 Thieves','ban','Udyr','Rell','Graves','Sion','Hecarim'),(48,'100 Thieves','pick','Gragas','Olaf','Zoe','Aphelios','Thresh'),(48,'Counter Logic Gaming','ban','Twisted Fate','Renekton','Senna','Jinx','Irelia'),(48,'Counter Logic Gaming','pick','Gnar','Jarvan IV','Azir','Kaisa','Seraphine'),(49,'Dignitas','ban','Udyr','Seraphine','Senna','Draven','Gangplank'),(49,'Dignitas','pick','Renekton','Hecarim','Zoe','Kaisa','Alistar'),(49,'Immortals','ban','Azir','Thresh','Kalista','Syndra','Twisted Fate'),(49,'Immortals','pick','Camille','Lillia','Orianna','Tristana','Rell'),(50,'FlyQuest','ban','Udyr','Rell','Seraphine','Kalista','Varus'),(50,'FlyQuest','pick','Gragas','Hecarim','Syndra','Jinx','Tahmkench'),(50,'Team Liquid','ban','Gnar','Lillia','Graves','Kaisa','Senna'),(50,'Team Liquid','pick','Renekton','Olaf','Azir','Aphelios','Thresh'),(51,'Cloud9','ban','Renekton','Lillia','Hecarim','Xayah','Jinx'),(51,'Cloud9','pick','Malphite','Gragas','Yasuo','Kaisa','Rell'),(51,'Evil Geniuses','ban','Udyr','Olaf','Tristana','Azir','Reksai'),(51,'Evil Geniuses','pick','Sion','Graves','Orianna','Jhin','Alistar'),(52,'100 Thieves','ban','Udyr','Azir','Graves','Gnar','Syndra'),(52,'100 Thieves','pick','Renekton','Olaf','Orianna','Tristana','Rell'),(52,'Dignitas','ban','Senna','Twisted Fate','Thresh','Kaisa','Ezreal'),(52,'Dignitas','pick','Gangplank','Hecarim','Zoe','Seraphine','Alistar'),(53,'Counter Logic Gaming','ban','Udyr','Hecarim','Olaf','Galio','Alistar'),(53,'Counter Logic Gaming','pick','Gnar','Lillia','Azir','Aphelios','Rell'),(53,'TSM','ban','Twisted Fate','Seraphine','Irelia','Tristana','Syndra'),(53,'TSM','pick','Jayce','Skarner','Syndra','Kaisa','Rakan'),(54,'Golden Guardians','ban','Tristana','Lillia','Rell','Camille','Tahmkench'),(54,'Golden Guardians','pick','Sion','Skarner','Seraphine','Jinx','Lulu'),(54,'Immortals','ban','Udyr','Olaf','Ezreal','Thresh','Irelia'),(54,'Immortals','pick','Aatrox','Hecarim','Azir','Senna','Karma'),(55,'FlyQuest','ban','Azir','Olaf','Hecarim','Alistar','Pantheon'),(55,'FlyQuest','pick','Gnar','Dr. Mundo','Sylas','Tristana','Rell'),(55,'TSM','ban','Udyr','Senna','Seraphine','Twisted Fate','Jarvan IV'),(55,'TSM','pick','Jayce','Skarner','Syndra','Kaisa','Rakan'),(56,'100 Thieves','ban','Tristana','Kaisa','Gragas','Twisted Fate','Galio'),(56,'100 Thieves','pick','Gnar','Udyr','Azir','Senna','Tahmkench'),(56,'Cloud9','ban','Renekton','Rell','Thresh','Pantheon','Kalista'),(56,'Cloud9','pick','Camille','Olaf','Leblanc','Seraphine','Rakan'),(57,'Immortals','ban','Renekton','Olaf','Thresh','Gangplank','Camille'),(57,'Immortals','pick','Gragas','Hecarim','Ziggs','Senna','Tahmkench'),(57,'Team Liquid','ban','Udyr','Seraphine','Rell','Syndra','Viktor'),(57,'Team Liquid','pick','Gnar','Jarvan IV','Azir','Kaisa','Blitzcrank'),(58,'Evil Geniuses','ban','Udyr','Hecarim','Syndra','Orianna','Cassiopeia'),(58,'Evil Geniuses','pick','Gnar','Lillia','Tristana','Sivir','Alistar'),(58,'Golden Guardians','ban','Seraphine','Skarner','Twisted Fate','Lucian','Gangplank'),(58,'Golden Guardians','pick','Renekton','Olaf','Azir','Kaisa','Rell'),(59,'Counter Logic Gaming','ban','Udyr','Hecarim','Seraphine','Gnar','Lillia'),(59,'Counter Logic Gaming','pick','Kled','Olaf','Viktor','Tristana','Rell'),(59,'Dignitas','ban','Senna','Irelia','Twisted Fate','Zoe','Syndra'),(59,'Dignitas','pick','Renekton','Nidalee','Azir','Kaisa','Alistar'),(60,'Dignitas','ban','Udyr','Azir','Olaf','Syndra','Gnar'),(60,'Dignitas','pick','Gangplank','Gragas','Orianna','Kalista','Rell'),(60,'TSM','ban','Renekton','Seraphine','Senna','Skarner','Lillia'),(60,'TSM','pick','Shen','Hecarim','Viktor','Kaisa','Alistar'),(61,'100 Thieves','ban','Hecarim','Sion','Lillia','Syndra','Ryze'),(61,'100 Thieves','pick','Renekton','Skarner','Orianna','Xayah','Alistar'),(61,'Evil Geniuses','ban','Udyr','Olaf','Azir','Thresh','Tristana'),(61,'Evil Geniuses','pick','Gnar','Dr. Mundo','Ekko','Kaisa','Rell'),(62,'Cloud9','ban','Seraphine','Udyr','Tristana','Renekton','Shen'),(62,'Cloud9','pick','Camille','Lillia','Irelia','Kaisa','Alistar'),(62,'FlyQuest','ban','Olaf','Thresh','Gragas','Yone','Gnar'),(62,'FlyQuest','pick','Sion','Hecarim','Azir','Vayne','Rell'),(63,'Golden Guardians','ban','Udyr','Hecarim','Olaf','Morgana','Senna'),(63,'Golden Guardians','pick','Kled','Kayn','Viktor','Tristana','Rell'),(63,'Team Liquid','ban','Gangplank','Syndra','Seraphine','Gnar','Gragas'),(63,'Team Liquid','pick','Renekton','Lillia','Lucian','Xayah','Rakan'),(64,'Counter Logic Gaming','ban','Udyr','Seraphine','Rell','Azir','Viktor'),(64,'Counter Logic Gaming','pick','Sion','Lillia','Lucian','Kalista','Nautilus'),(64,'Immortals','ban','Thresh','Irelia','Olaf','Kled','Gnar'),(64,'Immortals','pick','Renekton','Hecarim','Syndra','Tristana','Alistar'),(65,'Dignitas','ban','Tristana','Twisted Fate','Olaf','Kalista','Xayah'),(65,'Dignitas','pick','Aatrox','Udyr','Syndra','Kaisa','Nautilus'),(65,'Golden Guardians','ban','Seraphine','Renekton','Azir','Gnar','Rell'),(65,'Golden Guardians','pick','Gragas','Lillia','Lucian','Senna','Tahmkench'),(66,'100 Thieves','ban','Kaisa','Syndra','Rell','Viktor','Twisted Fate'),(66,'100 Thieves','pick','Gnar','Lillia','Azir','Kalista','Thresh'),(66,'TSM','ban','Udyr','Renekton','Senna','Aphelios','Gragas'),(66,'TSM','pick','Jayce','Olaf','Seraphine','Tristana','Alistar'),(67,'Cloud9','ban','Renekton','Hecarim','Lillia','Camille','Seraphine'),(67,'Cloud9','pick','Gangplank','Gragas','Azir','Caitlyn','Thresh'),(67,'Team Liquid','ban','Alistar','Udyr','Olaf','Irelia','Karma'),(67,'Team Liquid','pick','Gnar','Skarner','Orianna','Tristana','Rell'),(68,'Evil Geniuses','ban','Seraphine','Tristana','Lillia','Xayah','Irelia'),(68,'Evil Geniuses','pick','Gnar','Dr. Mundo','Orianna','Kaisa','Alistar'),(68,'Immortals','ban','Udyr','Olaf','Renekton','Ryze','Syndra'),(68,'Immortals','pick','Camille','Hecarim','Azir','Vayne','Rell'),(69,'Counter Logic Gaming','ban','Thresh','Senna','Hecarim','Viktor','Aatrox'),(69,'Counter Logic Gaming','pick','Sion','Morgana','Lucian','Tristana','Rell'),(69,'FlyQuest','ban','Udyr','Seraphine','Olaf','Nidalee','Gragas'),(69,'FlyQuest','pick','Shen','Lillia','Yone','Kaisa','Alistar'),(70,'100 Thieves','ban','Renekton','Gnar','Olaf','Gragas','Azir'),(70,'100 Thieves','pick','Pantheon','Skarner','Orianna','Kaisa','Rakan'),(70,'Golden Guardians','ban','Seraphine','Lillia','Udyr','Irelia','Gangplank'),(70,'Golden Guardians','pick','Shen','Hecarim','Sylas','Tristana','Rell'),(71,'Dignitas','ban','Azir','Tristana','Seraphine','Thresh','Zoe'),(71,'Dignitas','pick','Renekton','Hecarim','Orianna','Jinx','Rell'),(71,'Evil Geniuses','ban','Udyr','Olaf','Senna','Kaisa','Xayah'),(71,'Evil Geniuses','pick','Gnar','Skarner','Viktor','Kalista','Alistar'),(72,'Cloud9','ban','Rell','Udyr','Pantheon','Syndra','Orianna'),(72,'Cloud9','pick','Gnar','Lillia','Viktor','Caitlyn','Morgana'),(72,'TSM','ban','Olaf','Senna','Seraphine','Tristana','Gragas'),(72,'TSM','pick','Renekton','Hecarim','Azir','Kaisa','Nautilus'),(73,'Counter Logic Gaming','ban','Udyr','Rell','Renekton','Azir','Orianna'),(73,'Counter Logic Gaming','pick','Chogath','Lillia','Lucian','Xayah','Leona'),(73,'Team Liquid','ban','Irelia','Kalista','Seraphine','Ezreal','Sion'),(73,'Team Liquid','pick','Gangplank','Hecarim','Syndra','Tristana','Nautilus'),(74,'FlyQuest','ban','Rell','Seraphine','Lillia','Renekton','Camille'),(74,'FlyQuest','pick','Gragas','Olaf','Syndra','Senna','Tahmkench'),(74,'Immortals','ban','Udyr','Lucian','Hecarim','Thresh','Shen'),(74,'Immortals','pick','Aatrox','Nidalee','Azir','Tristana','Nautilus'),(75,'Cloud9','ban','Kalista','Lillia','Kled','Leona','Alistar'),(75,'Cloud9','pick','Camille','Hecarim','Syndra','Kaisa','Rell'),(75,'Counter Logic Gaming','ban','Olaf','Udyr','Seraphine','Shen','Renekton'),(75,'Counter Logic Gaming','pick','Irelia','Nidalee','Lucian','Tristana','Nautilus'),(76,'Evil Geniuses','ban','Azir','Olaf','Gnar','Orianna','Jayce'),(76,'Evil Geniuses','pick','Aatrox','Hecarim','Ekko','Xayah','Rell'),(76,'TSM','ban','Renekton','Udyr','Kaisa','Shen','Ryze'),(76,'TSM','pick','Sion','Lillia','Viktor','Tristana','Alistar'),(77,'100 Thieves','ban','Seraphine','Tristana','Lillia','Camille','Irelia'),(77,'100 Thieves','pick','Gragas','Hecarim','Orianna','Kaisa','Rell'),(77,'Immortals','ban','Renekton','Olaf','Thresh','Shen','Gnar'),(77,'Immortals','pick','Karma','Udyr','Lucian','Vayne','Alistar'),(78,'Dignitas','ban','Udyr','Seraphine','Olaf','Lillia','Orianna'),(78,'Dignitas','pick','Gangplank','Skarner','Azir','Kalista','Thresh'),(78,'Team Liquid','ban','Kaisa','Alistar','Gnar','Hecarim','Sion'),(78,'Team Liquid','pick','Renekton','Nidalee','Veigar','Tristana','Rell'),(79,'FlyQuest','ban','Seraphine','Lucian','Renekton','Morgana','Senna'),(79,'FlyQuest','pick','Chogath','Udyr','Viktor','Caitlyn','Thresh'),(79,'Golden Guardians','ban','Rell','Gnar','Tristana','Aphelios','Yone'),(79,'Golden Guardians','pick','Gangplank','Hecarim','Orianna','Kaisa','Alistar'),(80,'Immortals','ban','Hecarim','Olaf','Udyr','Thresh','Xayah'),(80,'Immortals','pick','Sion','Kayn','Orianna','Kaisa','Nautilus'),(80,'TSM','ban','Seraphine','Tristana','Lucian','Gnar','Rell'),(80,'TSM','pick','Renekton','Lillia','Azir','Kalista','Alistar'),(81,'Cloud9','ban','Kalista','Seraphine','Hecarim','Alistar','Nautilus'),(81,'Cloud9','pick','Renekton','Nidalee','Orianna','Tristana','Rell'),(81,'Dignitas','ban','Lillia','Olaf','Gnar','Lucian','Senna'),(81,'Dignitas','pick','Sion','Udyr','Syndra','Kaisa','Gragas'),(82,'100 Thieves','ban','Seraphine','Thresh','Rell','Tahmkench','Vayne'),(82,'100 Thieves','pick','Camille','Udyr','Sylas','Kaisa','Leona'),(82,'FlyQuest','ban','Olaf','Renekton','Tristana','Jayce','Gangplank'),(82,'FlyQuest','pick','Gnar','Hecarim','Twisted Fate','Xayah','Rakan'),(83,'Evil Geniuses','ban','Thresh','Rell','Udyr','Orianna','Azir'),(83,'Evil Geniuses','pick','Renekton','Hecarim','Neeko','Kaisa','Galio'),(83,'Team Liquid','ban','Kaisa','Alistar','Lillia','Ryze','Rakan'),(83,'Team Liquid','pick','Gnar','Olaf','Ahri','Tristana','Leona'),(84,'Counter Logic Gaming','ban','Thresh','Gangplank','Seraphine','Galio','Aatrox'),(84,'Counter Logic Gaming','pick','Sion','Lillia','Viktor','Tristana','Leona'),(84,'Golden Guardians','ban','Rell','Lucian','Renekton','Gnar','Gragas'),(84,'Golden Guardians','pick','Kled','Hecarim','Syndra','Xayah','Alistar'),(85,'Dignitas','ban','Seraphine','Udyr','Lillia','Orianna','Sylas'),(85,'Dignitas','pick','Pantheon','Graves','Syndra','Xayah','Alistar'),(85,'FlyQuest','ban','Kalista','Gnar','Renekton','Kaisa','Gangplank'),(85,'FlyQuest','pick','Shen','Hecarim','Twisted Fate','Tristana','Rell'),(86,'Golden Guardians','ban','Rell','Renekton','Hecarim','Gnar','Alistar'),(86,'Golden Guardians','pick','Camille','Udyr','Orianna','Xayah','Thresh'),(86,'TSM','ban','Seraphine','Lucian','Twisted Fate','Gangplank','Rakan'),(86,'TSM','pick','Gragas','Olaf','Azir','Tristana','Nautilus'),(87,'100 Thieves','ban','Seraphine','Rell','Thresh','Camille','Orianna'),(87,'100 Thieves','pick','Gnar','Olaf','Syndra','Tristana','Leona'),(87,'Team Liquid','ban','Kaisa','Renekton','Senna','Gragas','Twisted Fate'),(87,'Team Liquid','pick','Gangplank','Udyr','Azir','Xayah','Alistar'),(88,'Counter Logic Gaming','ban','Kaisa','Orianna','Lillia','Xayah','Azir'),(88,'Counter Logic Gaming','pick','Irelia','Nidalee','Renekton','Samira','Nautilus'),(88,'Evil Geniuses','ban','Tristana','Lucian','Olaf','Kalista','Syndra'),(88,'Evil Geniuses','pick','Gnar','Hecarim','Ryze','Jhin','Rell'),(89,'Cloud9','ban','Seraphine','Hecarim','Udyr','Nidalee','Kayn'),(89,'Cloud9','pick','Sion','Lillia','Orianna','Tristana','Rell'),(89,'Immortals','ban','Olaf','Lucian','Nautilus','Gnar','Gragas'),(89,'Immortals','pick','Renekton','Nocturne','Syndra','Draven','Thresh');
/*!40000 ALTER TABLE `pick_ban` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `champ_add_trigger` BEFORE INSERT ON `pick_ban` FOR EACH ROW BEGIN
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
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `ign` varchar(64) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `role` varchar(7) DEFAULT NULL,
  `kda_avg` decimal(2,1) DEFAULT NULL,
  `cs_avg` decimal(2,1) DEFAULT NULL,
  `salary` decimal(7,2) DEFAULT NULL,
  `team` varchar(64) DEFAULT NULL,
  `mvp_count` tinyint DEFAULT NULL,
  PRIMARY KEY (`ign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES ('Ablazeolive','Nicholas Antonio Abbott','Canada','Mid',2.2,8.5,25000.00,'Golden Guardians',1),('Alphari','Barney Morris','United Kingdom','Top',3.0,8.7,52235.41,'Team Liquid',4),('aphromoo','Zaqueri Black','United States','Support',4.1,1.3,31000.00,'Dignitas',1),('Blaber','Robert Huang','United States','Jungle',5.1,7.2,49525.00,'Cloud9',6),('Broxah','Mads Brock-Pedersen','Denmark','Jungle',3.7,5.9,30000.00,'Counter Logic Gaming',0),('Closer','Can Celik','Turkey','Jungle',3.9,6.2,35125.00,'100 Thieves',4),('CoreJJ','Jo Yong-in','South Korea','Support',4.8,1.4,52235.41,'Team Liquid',0),('Damonte','Tanner Damonte','United States','Mid',3.3,8.1,35125.00,'100 Thieves',1),('Dardoch','Joshua Hartnett','United States','Jungle',3.3,6.3,31000.00,'Dignitas',2),('Deftly','Matthew Chen','United States','ADC',5.7,8.9,33500.00,'Evil Geniuses',2),('Destiny','Mitchell Shaw','Australia','Support',3.3,1.8,26000.00,'Immortals',2),('Diamond','David Berube','Canada','Support',2.0,2.1,27500.00,'FlyQuest',0),('Dreams','Han Min-kook','South Korea','Support',2.8,0.7,27500.00,'FlyQuest',0),('FakeGod','Aaron Lee','United States','Top',3.4,7.4,31000.00,'Dignitas',5),('FBI','Victor Huang','Australia','ADC',4.7,7.7,35125.00,'100 Thieves',3),('Finn','Finn Wiestal','Sweden','Top',2.8,7.6,30000.00,'Counter Logic Gaming',2),('Fudge','Ibrahim Allami','Australia','Top',6.0,7.8,49525.00,'Cloud9',0),('Griffin','Raymond Griffin','United States','Jungle',2.7,6.0,30000.00,'Counter Logic Gaming',0),('huhi','Choi Jae-hyun','South Korea','Support',3.2,2.4,35125.00,'100 Thieves',2),('Huni','Heo Seung-hoon','South Korea','Top',4.2,7.9,29000.00,'TSM',2),('Iconic','Ethan Wilkinson','United States','Jungle',1.9,6.8,25000.00,'Golden Guardians',0),('IgNar','Lee Dong-geun','South Korea','Support',3.2,1.3,33500.00,'Evil Geniuses',1),('Impact','Jeong Eon-young','South Korea','Top',3.0,7.1,33500.00,'Evil Geniuses',3),('Insanity','David Challe','United States','Mid',4.2,9.2,26000.00,'Immortals',1),('Jensen','Nicolaj Jensen','Denmark','Mid',6.0,9.0,52235.41,'Team Liquid',2),('Jiizuke','Daniele di Mauro','Italy','Mid',3.5,9.1,33500.00,'Evil Geniuses',2),('Johnsun','Johnson Nguyen','Canada','ADC',3.9,8.1,27500.00,'FlyQuest',1),('Josedeodo','Brandon Joel Villegas','Argentina','Jungle',3.2,6.7,27500.00,'FlyQuest',2),('Licorice','Eric Ritchie','Canada','Top',2.3,7.7,27500.00,'FlyQuest',1),('Lost','Lawrence Hui','New Zealand','ADC',4.4,9.0,29000.00,'TSM',1),('Neo','ToÃ n Tran','Vietnam','ADC',5.6,8.7,31000.00,'Dignitas',2),('Newbie','Leandro Marcos','Argentina','Support',2.0,1.3,25000.00,'Golden Guardians',0),('Niles','Aiden Tidwell','United States','Top',1.1,6.9,25000.00,'Golden Guardians',1),('Palafox','Cristian Palafox','United States','Mid',2.7,8.7,27500.00,'FlyQuest',2),('Perkz','Luka Perkovic','Croatia','Mid',4.5,9.3,49525.00,'Cloud9',4),('Pobelter','Eugene Park','United States','Mid',2.2,8.6,30000.00,'Counter Logic Gaming',1),('PowerOfEvil','Tristan Schrage','Germany','Mid',3.6,9.6,29000.00,'TSM',5),('Raes','Quin Korebrits','New Zealand','ADC',3.0,8.1,26000.00,'Immortals',2),('Revenge','Mohamed Kaddoura','United States','Top',2.5,7.7,26000.00,'Immortals',0),('rjs','Alexy Zatorski','Canada','Mid',2.7,8.2,30000.00,'Counter Logic Gaming',0),('ry0ma','Tommy Le','Australia','Mid',5.3,8.6,35125.00,'100 Thieves',0),('Santorin','Lucas Larsen','Denmark','Jungle',5.5,6.5,52235.41,'Team Liquid',5),('Smoothie','Andy Ta','Canada','Support',2.8,1.0,30000.00,'Counter Logic Gaming',1),('Soligo','Max Soong','United States','Mid',4.4,8.5,31000.00,'Dignitas',1),('Spica','Mingyi Lu','China','Jungle',4.3,6.1,29000.00,'TSM',2),('Ssumday','Kim Chan-ho','South Korea','Top',2.3,7.9,35125.00,'100 Thieves',1),('Stixxay','Trevor Hayes','United States','ADC',1.9,9.1,25000.00,'Golden Guardians',1),('Svenskeren','Dennis Johnsen','Denmark','Jungle',2.7,6.1,33500.00,'Evil Geniuses',2),('SwordArt','Hu Shuo-Chieh','Taiwan','Support',3.7,1.2,29000.00,'TSM',2),('Tactical','Edward Ra','United States','ADC',3.7,9.0,52235.41,'Team Liquid',1),('Vulcan','Philippe Laflamme','Canada','Support',3.3,1.0,49525.00,'Cloud9',2),('WildTurtle','Jason Tran','Canada','ADC',2.5,9.9,30000.00,'Counter Logic Gaming',1),('Xerxe','Andrei Dragomir','Romania','Jungle',4.2,6.3,26000.00,'Immortals',2),('Zven','Jesper Svenningsen','Denmark','ADC',5.3,9.3,49525.00,'Cloud9',0);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `team_name` varchar(64) NOT NULL,
  `num_win` tinyint DEFAULT NULL,
  `num_loss` tinyint DEFAULT NULL,
  `lcs_rank` tinyint DEFAULT NULL,
  PRIMARY KEY (`team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES ('100 Thieves',11,7,4),('Cloud9',12,5,1),('Counter Logic Gaming',5,13,9),('Dignitas',11,7,5),('Evil Geniuses',10,8,6),('FlyQuest',6,12,8),('Golden Guardians',3,15,10),('Immortals',7,10,7),('Team Liquid',12,6,3),('TSM',12,6,2);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `top5matches`
--

DROP TABLE IF EXISTS `top5matches`;
/*!50001 DROP VIEW IF EXISTS `top5matches`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `top5matches` AS SELECT 
 1 AS `match_date`,
 1 AS `team1_name`,
 1 AS `team2_name`,
 1 AS `outcome`,
 1 AS `team1_kills`,
 1 AS `team2_kills`,
 1 AS `mvp`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'lcs2021'
--

--
-- Dumping routines for database 'lcs2021'
--
/*!50003 DROP PROCEDURE IF EXISTS `deleteMatch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteMatch`(
	IN m_id tinyint, 
    OUT response int(11)
)
BEGIN
    IF (SELECT COUNT(*) FROM `match` WHERE `match_id` = m_id) = 1 THEN
		DELETE FROM `match` WHERE match_id = m_id;
        CALL refreshTables();
		SET response = 0;
	ELSE
		SET response = -1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertBlankMatch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertBlankMatch`(
	IN d DATETIME, 
    IN team1 varchar(64), 
    IN team2 varchar(64), 
    OUT response int(11)
)
BEGIN
	DECLARE new_id int default 0;
    SET new_id = (SELECT MAX(match_id) FROM `match`) + 1;
    IF (SELECT COUNT(*) FROM `team` WHERE `team_name` = team1) = 0 THEN
		SET response = -1;
    ELSEIF (SELECT COUNT(*) FROM `team` WHERE `team_name` = team2) = 0 THEN
		SET response = -2;
    ELSEIF (SELECT COUNT(*) FROM `match` WHERE `match_date` = d) = 0 THEN
		INSERT INTO `match` (match_id, match_date, team1_name, team2_name) VALUES (new_id, d, team1, team2);
        SET response = 0;
	ELSE
		SET response = -3;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `refreshTables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `refreshTables`()
BEGIN
	CALL updateChampWinrates();
    CALL updateMVPCount();
    CALL updateTeamWL();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rescheduleMatch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rescheduleMatch`(
	IN m_id tinyint, 
    IN d datetime,
    IN team1 varchar(64),
    IN team2 varchar(64),
    OUT response int(11)
)
BEGIN
    IF (SELECT COUNT(*) FROM `match` WHERE `match_id` = m_id) = 0 THEN
		SET response = -1;
	ELSEIF (SELECT COUNT(*) FROM `match` WHERE `match_id` = m_id AND `outcome` <> NULL) <> 0 THEN
		SET response = -2;
	ELSEIF (SELECT COUNT(*) FROM `team` WHERE `team_name` = team1) = 0 THEN
		SET response = -3;
    ELSEIF (SELECT COUNT(*) FROM `team` WHERE `team_name` = team2) = 0 THEN
		SET response = -4;
    ELSEIF (SELECT COUNT(*) FROM `match` WHERE `match_date` = d AND `match_id` <> m_id) = 0 THEN
		UPDATE `match`
			SET match_date = d, team1_name = team1, team2_name = team2
			WHERE `match_id` = m_id;
        SET response = 0;
	ELSE
		SET response = -5;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateChampWinrates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateChampWinrates`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateMatchInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMatchInfo`(
	IN m_id tinyint, 
    IN winner varchar(64),
    IN t1_kills tinyint,
    IN t2_kills tinyint,
    IN t1_gold mediumint,
    IN t2_gold mediumint,
    IN match_time varchar(64),
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
    DECLARE team1 varchar(64);
    DECLARE team2 varchar(64);
    IF (SELECT COUNT(*) FROM `match` WHERE `match_id` = m_id) = 0 THEN
		SET response = -1;
    ELSEIF (SELECT COUNT(*) FROM `player` WHERE `ign` = match_mvp) = 0 THEN
		SET response = -2;
	ELSEIF (SELECT COUNT(*) FROM `team` WHERE `team_name` = winner) = 0 THEN
		SET response = -3;
	ELSE
		DELETE FROM `pick_ban` WHERE match_id = m_id;
        SET team1 = (SELECT team1_name FROM `match` WHERE match_id = m_id);
        SET team2 = (SELECT team2_name FROM `match` WHERE match_id = m_id);
        IF (team1 <> winner AND team2 <> winner) THEN
			SET response = -4;
        ELSE
			UPDATE `match`
			SET outcome = winner, team1_kills = t1_kills, team2_kills = t2_kills,
				team1_gold = t1_gold, team2_gold = t2_gold, match_length = match_time, 
				mvp = match_mvp, patch = match_patch
			WHERE match_id = m_id;
			INSERT INTO `pick_ban` VALUES (m_id, team1, 'ban', t1_ban1, t1_ban2, t1_ban3, t1_ban4, t1_ban5);
			INSERT INTO `pick_ban` VALUES (m_id, team2, 'ban', t2_ban1, t2_ban2, t2_ban3, t2_ban4, t2_ban5);
			INSERT INTO `pick_ban` VALUES (m_id, team1, 'pick', t1_pick1, t1_pick2, t1_pick3, t1_pick4, t1_pick5);
			INSERT INTO `pick_ban` VALUES (m_id, team2, 'pick', t2_pick1, t2_pick2, t2_pick3, t2_pick4, t2_pick5);
			CALL refreshTables();
			SET response = 0;
		END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateMVPCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMVPCount`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateTeamWL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateTeamWL`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `top5matches`
--

/*!50001 DROP VIEW IF EXISTS `top5matches`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `top5matches` AS select `match`.`match_date` AS `match_date`,`match`.`team1_name` AS `team1_name`,`match`.`team2_name` AS `team2_name`,`match`.`outcome` AS `outcome`,`match`.`team1_kills` AS `team1_kills`,`match`.`team2_kills` AS `team2_kills`,`match`.`mvp` AS `mvp` from `match` where (`match`.`outcome` is not null) order by `match`.`match_date` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-28 18:55:10
