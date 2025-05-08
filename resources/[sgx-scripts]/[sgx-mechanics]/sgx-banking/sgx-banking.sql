CREATE TABLE IF NOT EXISTS `transactions` (
  `id` INT AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;