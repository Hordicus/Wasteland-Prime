/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  `message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_kills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `player_uid` varchar(100) NOT NULL,
  `killer_uid` varchar(100) DEFAULT NULL,
  `player_weapon` varchar(45) DEFAULT NULL,
  `killer_weapon` varchar(45) DEFAULT NULL,
  `player_veh` varchar(45) DEFAULT NULL,
  `killer_veh` varchar(45) DEFAULT NULL,
  `player_pos` varchar(45) DEFAULT NULL,
  `killer_pos` varchar(45) DEFAULT NULL,
  `friendly` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `player_uid` varchar(100) NOT NULL,
  `points` int(11) NOT NULL,
  `code` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `uid` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `damage` float NOT NULL DEFAULT '1',
  `pos_x` double NOT NULL DEFAULT '0',
  `pos_y` double NOT NULL DEFAULT '0',
  `pos_z` double NOT NULL DEFAULT '0',
  `gear` text,
  `last_login` datetime DEFAULT NULL,
  `animation` varchar(200) DEFAULT NULL,
  `direction` smallint(6) DEFAULT '0',
  `money` int(11) DEFAULT '0',
  `playerInv` text,
  `side` varchar(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `key` varchar(45) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(100) NOT NULL,
  `object_type` varchar(45) NOT NULL DEFAULT 'veh',
  `pos_x` float NOT NULL DEFAULT '0',
  `pos_y` float NOT NULL DEFAULT '0',
  `pos_z` float NOT NULL DEFAULT '0',
  `damage` float NOT NULL DEFAULT '0',
  `fuel` float DEFAULT '1',
  `weaponCargo` text,
  `magazineCargo` text,
  `itemCargo` text,
  `dir` smallint(6) DEFAULT NULL,
  `vectorUp` varchar(45) DEFAULT NULL,
  `fuelCargo` varchar(45) DEFAULT NULL,
  `ammoCargo` varchar(45) DEFAULT NULL,
  `magazines` text,
  `variables` text,
  `log_contents` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;