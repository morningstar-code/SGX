CREATE TABLE IF NOT EXISTS `wais_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` mediumtext DEFAULT NULL,
  `meta` longtext DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;