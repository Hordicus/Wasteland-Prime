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
  `animation` varchar(45) DEFAULT NULL,
  `direction` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
