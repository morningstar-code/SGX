DROP TABLE IF EXISTS `selldrugs_phone`;
CREATE TABLE IF NOT EXISTS `selldrugs_phone` (
  `player` varchar(255) NOT NULL,
  `settings` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `selldrugs_players`;
CREATE TABLE IF NOT EXISTS `selldrugs_players` (
  `player` varchar(255) DEFAULT NULL,
  `respect` int(11) NOT NULL DEFAULT 0,
  `sale_skill` int(11) NOT NULL DEFAULT 0,
  `mole` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;