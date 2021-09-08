/* change if needed */
USE exile;

DROP TABLE IF EXISTS `mine_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mine_data` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `spawned_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `account_owner_uid` varchar(32) COLLATE utf8_bin NOT NULL,
  `position_x` double NOT NULL DEFAULT '0',
  `position_y` double NOT NULL DEFAULT '0',
  `position_z` double NOT NULL DEFAULT '0',
  `direction` double NOT NULL DEFAULT '0',
  `territory_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_owner_uid` (`account_owner_uid`) /*!80000 INVISIBLE */,
  KEY `territory_uid` (`territory_id`) /*!80000 INVISIBLE */,
  CONSTRAINT `mine_data_ibfk_1` FOREIGN KEY (`territory_id`) REFERENCES `territory` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;