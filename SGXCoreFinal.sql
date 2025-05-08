-- Dumping database structure for sgxcorev1
CREATE DATABASE IF NOT EXISTS `sgxcorev1` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `sgxcorev1`;

-- Dumping structure for table sgxcorev1.apartments
CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `citizenid` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.apartments: ~7 rows (approximately)
INSERT IGNORE INTO `apartments` (`id`, `name`, `type`, `label`, `citizenid`) VALUES
	(10, 'apartment11794', 'apartment1', 'Apartments 1794', 'KBN48829'),
	(14, 'apartment19123', 'apartment1', 'Apartments 9123', 'JIY91569'),
	(15, 'apartment19470', 'apartment1', 'Apartments 9470', 'TDN82412'),
	(16, 'apartment17851', 'apartment1', 'Apartments 7851', 'QEZ87736'),
	(17, 'apartment18617', 'apartment1', 'Apartments 8617', 'XGI09387'),
	(18, 'apartment14479', 'apartment1', 'Apartments 4479', 'OGB23731');

-- Dumping structure for table sgxcorev1.bank_accounts
CREATE TABLE IF NOT EXISTS `bank_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `account_balance` int(11) NOT NULL DEFAULT 0,
  `account_type` enum('shared','job','gang') NOT NULL,
  `users` longtext DEFAULT '[]',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `account_name` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.bank_accounts: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.bank_statements
CREATE TABLE IF NOT EXISTS `bank_statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT 'checking',
  `amount` int(11) DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `statement_type` enum('deposit','withdraw') DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.bank_statements: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.bans: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.configs
CREATE TABLE IF NOT EXISTS `configs` (
  `name` varchar(20) NOT NULL,
  `config` text DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.configs: ~1 rows (approximately)
INSERT IGNORE INTO `configs` (`name`, `config`) VALUES
	('keylabs', '{"worth1":6535,"methlab":531,"cokelab":535,"washer2":3,"washer1":5,"methlab2":550,"worth4":0,"washer4":0,"worth2":807,"worth3":777,"washer3":3,"weedlab":528}');

-- Dumping structure for table sgxcorev1.crypto
CREATE TABLE IF NOT EXISTS `crypto` (
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`crypto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.crypto: ~1 rows (approximately)
INSERT IGNORE INTO `crypto` (`crypto`, `worth`, `history`) VALUES
	('qbit', 1020, '[{"PreviousWorth":1004,"NewWorth":1010},{"PreviousWorth":1004,"NewWorth":1010},{"PreviousWorth":1004,"NewWorth":1010},{"PreviousWorth":1010,"NewWorth":1020}]');

-- Dumping structure for table sgxcorev1.cryptominers
CREATE TABLE IF NOT EXISTS `cryptominers` (
  `citizenid` varchar(50) NOT NULL,
  `card` varchar(50) NOT NULL,
  `balance` double NOT NULL,
  PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.cryptominers: ~4 rows (approximately)
INSERT IGNORE INTO `cryptominers` (`citizenid`, `card`, `balance`) VALUES
	('CLC04795', '4090gpu', 0),
	('JIY91569', '4090gpu', 23.800000000000015),
	('QEZ87736', '4090gpu', 28.600000000000016),
	('XGI09387', '4090gpu', 0);

-- Dumping structure for table sgxcorev1.crypto_transactions
CREATE TABLE IF NOT EXISTS `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.crypto_transactions: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.dealers
CREATE TABLE IF NOT EXISTS `dealers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.dealers: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.gloveboxitems
CREATE TABLE IF NOT EXISTS `gloveboxitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table sgxcorev1.gloveboxitems: ~4 rows (approximately)
INSERT IGNORE INTO `gloveboxitems` (`id`, `plate`, `items`) VALUES
	(11, '08CZA808', '[]'),
	(2, '1YX283SS', '[]'),
	(7, '42SIK520', '[]'),
	(4, '48ZSA984', '[]'),
	(1, 'LIFE1598', '[]');

-- Dumping structure for table sgxcorev1.houselocations
CREATE TABLE IF NOT EXISTS `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(2) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(4) DEFAULT NULL,
  `garage` text NOT NULL DEFAULT '{"y":0,"x":0,"w":0,"z":0}',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table sgxcorev1.houselocations: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.house_plants
CREATE TABLE IF NOT EXISTS `house_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) DEFAULT NULL,
  `stage` int(11) DEFAULT 1,
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building` (`building`),
  KEY `plantid` (`plantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.house_plants: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.inventories
CREATE TABLE IF NOT EXISTS `inventories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `items` longtext DEFAULT '[]',
  PRIMARY KEY (`identifier`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.inventories: ~1 rows (approximately)
INSERT IGNORE INTO `inventories` (`id`, `identifier`, `items`) VALUES
	(1, 'apartment49582', '[]');

-- Dumping structure for table sgxcorev1.lapraces
CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raceid` (`raceid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.lapraces: ~0 rows (approximately)
INSERT IGNORE INTO `lapraces` (`id`, `name`, `checkpoints`, `records`, `creator`, `distance`, `raceid`) VALUES
	(1, 'SGX', '[{"coords":{"x":142.1277313232422,"y":-1025.84619140625,"z":28.58924674987793},"offset":{"left":{"x":141.12539672851563,"y":-1028.669189453125,"z":28.42806243896484},"right":{"x":143.13006591796876,"y":-1023.023193359375,"z":28.75043106079101}}},{"coords":{"x":80.33745574951172,"y":-1000.5567626953125,"z":28.70314598083496},"offset":{"left":{"x":79.08696746826172,"y":-1003.2828979492188,"z":28.63725471496582},"right":{"x":81.58794403076172,"y":-997.8306274414063,"z":28.7690372467041}}}]', NULL, 'XGI09387', 67, 'LR-5355');

-- Dumping structure for table sgxcorev1.management_outfits
CREATE TABLE IF NOT EXISTS `management_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `minrank` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT 'Cool Outfit',
  `gender` varchar(50) NOT NULL DEFAULT 'male',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.management_outfits: ~8 rows (approximately)
INSERT IGNORE INTO `management_outfits` (`id`, `job_name`, `type`, `minrank`, `name`, `gender`, `model`, `props`, `components`) VALUES
	(26, 'redlinemechanic', 'Job', 0, 'ss', 'male', 'mp_m_freemode_01', '[{"drawable":-1,"prop_id":0,"texture":-1},{"drawable":-1,"prop_id":1,"texture":-1},{"drawable":-1,"prop_id":2,"texture":-1},{"drawable":-1,"prop_id":6,"texture":-1},{"drawable":-1,"prop_id":7,"texture":-1}]', '[{"drawable":0,"component_id":0,"texture":0},{"drawable":3,"component_id":1,"texture":0},{"drawable":0,"component_id":2,"texture":0},{"drawable":0,"component_id":3,"texture":0},{"drawable":3,"component_id":4,"texture":0},{"drawable":0,"component_id":5,"texture":0},{"drawable":3,"component_id":6,"texture":0},{"drawable":0,"component_id":7,"texture":0},{"drawable":0,"component_id":8,"texture":0},{"drawable":0,"component_id":9,"texture":0},{"drawable":0,"component_id":10,"texture":0},{"drawable":6,"component_id":11,"texture":0}]'),
	(27, 'police', 'Job', 11, 'sdasda', 'male', 'mp_m_freemode_01', '[{"texture":-1,"drawable":-1,"prop_id":0},{"texture":-1,"drawable":-1,"prop_id":1},{"texture":-1,"drawable":-1,"prop_id":2},{"texture":-1,"drawable":-1,"prop_id":6},{"texture":-1,"drawable":-1,"prop_id":7}]', '[{"component_id":0,"texture":0,"drawable":0},{"component_id":1,"texture":0,"drawable":0},{"component_id":2,"texture":0,"drawable":79},{"component_id":3,"texture":0,"drawable":0},{"component_id":4,"texture":0,"drawable":0},{"component_id":5,"texture":0,"drawable":0},{"component_id":6,"texture":0,"drawable":0},{"component_id":7,"texture":0,"drawable":0},{"component_id":8,"texture":0,"drawable":0},{"component_id":9,"texture":0,"drawable":0},{"component_id":10,"texture":0,"drawable":0},{"component_id":11,"texture":0,"drawable":0}]'),
	(28, 'police', 'Job', 7, 'sdasdads', 'male', 'mp_m_freemode_01', '[{"texture":-1,"drawable":-1,"prop_id":0},{"texture":-1,"drawable":-1,"prop_id":1},{"texture":-1,"drawable":-1,"prop_id":2},{"texture":-1,"drawable":-1,"prop_id":6},{"texture":-1,"drawable":-1,"prop_id":7}]', '[{"component_id":0,"texture":0,"drawable":0},{"component_id":1,"texture":0,"drawable":0},{"component_id":2,"texture":0,"drawable":0},{"component_id":3,"texture":0,"drawable":0},{"component_id":4,"texture":0,"drawable":0},{"component_id":5,"texture":0,"drawable":0},{"component_id":6,"texture":0,"drawable":0},{"component_id":7,"texture":0,"drawable":0},{"component_id":8,"texture":0,"drawable":0},{"component_id":9,"texture":0,"drawable":0},{"component_id":10,"texture":0,"drawable":0},{"component_id":11,"texture":0,"drawable":0}]'),
	(29, 'ballas', 'Gang', 0, 'Ballas Recurit', 'male', 'mp_m_freemode_01', '[{"drawable":-1,"texture":-1,"prop_id":0},{"drawable":-1,"texture":-1,"prop_id":1},{"drawable":-1,"texture":-1,"prop_id":2},{"drawable":-1,"texture":-1,"prop_id":6},{"drawable":-1,"texture":-1,"prop_id":7}]', '[{"drawable":0,"texture":0,"component_id":0},{"drawable":16,"texture":0,"component_id":1},{"drawable":1,"texture":0,"component_id":2},{"drawable":1,"texture":0,"component_id":3},{"drawable":24,"texture":0,"component_id":4},{"drawable":0,"texture":0,"component_id":5},{"drawable":10,"texture":0,"component_id":6},{"drawable":0,"texture":0,"component_id":7},{"drawable":31,"texture":0,"component_id":8},{"drawable":0,"texture":0,"component_id":9},{"drawable":0,"texture":0,"component_id":10},{"drawable":30,"texture":0,"component_id":11}]'),
	(30, 'burgershot', 'Job', 0, 'Burgershot Dress', 'male', 'mp_m_freemode_01', '[{"drawable":-1,"texture":-1,"prop_id":0},{"drawable":-1,"texture":-1,"prop_id":1},{"drawable":-1,"texture":-1,"prop_id":2},{"drawable":-1,"texture":-1,"prop_id":6},{"drawable":-1,"texture":-1,"prop_id":7}]', '[{"texture":0,"drawable":0,"component_id":0},{"texture":0,"drawable":0,"component_id":1},{"texture":0,"drawable":80,"component_id":2},{"texture":0,"drawable":11,"component_id":3},{"texture":2,"drawable":209,"component_id":4},{"texture":0,"drawable":132,"component_id":5},{"texture":0,"drawable":202,"component_id":6},{"texture":0,"drawable":283,"component_id":7},{"texture":0,"drawable":15,"component_id":8},{"texture":0,"drawable":0,"component_id":9},{"texture":0,"drawable":0,"component_id":10},{"texture":0,"drawable":509,"component_id":11}]'),
	(31, 'coolbeans', 'Job', 0, 'Cool Beans Uniform', 'male', 'mp_m_freemode_01', '[{"drawable":-1,"texture":-1,"prop_id":0},{"drawable":-1,"texture":-1,"prop_id":1},{"drawable":-1,"texture":-1,"prop_id":2},{"drawable":-1,"texture":-1,"prop_id":6},{"drawable":-1,"texture":-1,"prop_id":7}]', '[{"texture":0,"drawable":0,"component_id":0},{"texture":0,"drawable":0,"component_id":1},{"texture":0,"drawable":80,"component_id":2},{"texture":0,"drawable":11,"component_id":3},{"texture":2,"drawable":209,"component_id":4},{"texture":0,"drawable":132,"component_id":5},{"texture":0,"drawable":202,"component_id":6},{"texture":0,"drawable":283,"component_id":7},{"texture":0,"drawable":15,"component_id":8},{"texture":0,"drawable":0,"component_id":9},{"texture":0,"drawable":0,"component_id":10},{"texture":0,"drawable":509,"component_id":11}]'),
	(32, 'pizzathis', 'Job', 1, 'Pizza This Outfit', 'male', 'mp_m_freemode_01', '[{"prop_id":0,"texture":-1,"drawable":-1},{"prop_id":1,"texture":-1,"drawable":-1},{"prop_id":2,"texture":-1,"drawable":-1},{"prop_id":6,"texture":-1,"drawable":-1},{"prop_id":7,"texture":-1,"drawable":-1}]', '[{"component_id":0,"texture":0,"drawable":0},{"component_id":1,"texture":0,"drawable":0},{"component_id":2,"texture":0,"drawable":80},{"component_id":3,"texture":0,"drawable":11},{"component_id":4,"texture":2,"drawable":209},{"component_id":5,"texture":0,"drawable":132},{"component_id":6,"texture":0,"drawable":202},{"component_id":7,"texture":0,"drawable":283},{"component_id":8,"texture":0,"drawable":15},{"component_id":9,"texture":0,"drawable":0},{"component_id":10,"texture":0,"drawable":0},{"component_id":11,"texture":0,"drawable":509}]'),
	(33, 'sahp', 'Job', 6, 'SAHP  Sergant', 'male', 'mp_m_freemode_01', '[{"prop_id":0,"texture":-1,"drawable":-1},{"prop_id":1,"texture":-1,"drawable":-1},{"prop_id":2,"texture":-1,"drawable":-1},{"prop_id":6,"texture":-1,"drawable":-1},{"prop_id":7,"texture":-1,"drawable":-1}]', '[{"component_id":0,"texture":0,"drawable":0},{"component_id":1,"texture":0,"drawable":0},{"component_id":2,"texture":0,"drawable":80},{"component_id":3,"texture":0,"drawable":11},{"component_id":4,"texture":2,"drawable":209},{"component_id":5,"texture":0,"drawable":132},{"component_id":6,"texture":0,"drawable":202},{"component_id":7,"texture":0,"drawable":283},{"component_id":8,"texture":0,"drawable":15},{"component_id":9,"texture":0,"drawable":0},{"component_id":10,"texture":0,"drawable":0},{"component_id":11,"texture":0,"drawable":509}]');

-- Dumping structure for table sgxcorev1.mdt_bolos
CREATE TABLE IF NOT EXISTS `mdt_bolos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `individual` varchar(50) DEFAULT NULL,
  `detail` text DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `gallery` text DEFAULT NULL,
  `officersinvolved` text DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) NOT NULL DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_bolos: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.mdt_bulletin
CREATE TABLE IF NOT EXISTS `mdt_bulletin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `desc` text NOT NULL,
  `author` varchar(50) NOT NULL,
  `time` varchar(20) NOT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_bulletin: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.mdt_clocking
CREATE TABLE IF NOT EXISTS `mdt_clocking` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL DEFAULT '',
  `firstname` varchar(255) NOT NULL DEFAULT '',
  `lastname` varchar(255) NOT NULL DEFAULT '',
  `clock_in_time` varchar(255) NOT NULL DEFAULT '',
  `clock_out_time` varchar(50) DEFAULT NULL,
  `total_time` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_clocking: ~2 rows (approximately)
INSERT IGNORE INTO `mdt_clocking` (`id`, `user_id`, `firstname`, `lastname`, `clock_in_time`, `clock_out_time`, `total_time`) VALUES
	(7, 'BCO92693', 'Sssss', 'Ssssssssss', '2024-06-13 19:10:08', NULL, 0),
	(8, 'CLC04795', 'SGX', 'SGX', '2024-06-19 15:44:33', '2024-07-18 00:12:44', 2449691);

-- Dumping structure for table sgxcorev1.mdt_convictions
CREATE TABLE IF NOT EXISTS `mdt_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(50) DEFAULT NULL,
  `linkedincident` int(11) NOT NULL DEFAULT 0,
  `warrant` varchar(50) DEFAULT NULL,
  `guilty` varchar(50) DEFAULT NULL,
  `processed` varchar(50) DEFAULT NULL,
  `associated` varchar(50) DEFAULT '0',
  `charges` text DEFAULT NULL,
  `fine` int(11) DEFAULT 0,
  `sentence` int(11) DEFAULT 0,
  `recfine` int(11) DEFAULT 0,
  `recsentence` int(11) DEFAULT 0,
  `time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_convictions: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.mdt_data
CREATE TABLE IF NOT EXISTS `mdt_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(20) NOT NULL,
  `information` mediumtext DEFAULT NULL,
  `tags` text NOT NULL,
  `gallery` text NOT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  `pfp` text DEFAULT NULL,
  `fingerprint` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_data: ~2 rows (approximately)
INSERT IGNORE INTO `mdt_data` (`id`, `cid`, `information`, `tags`, `gallery`, `jobtype`, `pfp`, `fingerprint`) VALUES
	(1, 'BCO92693', '', '[]', '[]', 'police', 'https://media.discordapp.net/attachments/1236040444740370563/1250678986011316224/screenshot.jpg?ex=666bd112&is=666a7f92&hm=c72d4397c4fe03d5d268e0c7213f5ac94ad65ca6e9382a6c6d752c1942a8bf41&', NULL),
	(4, 'CLC04795', '', '[]', '[]', 'police', '', NULL);

-- Dumping structure for table sgxcorev1.mdt_impound
CREATE TABLE IF NOT EXISTS `mdt_impound` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicleid` int(11) NOT NULL,
  `linkedreport` int(11) NOT NULL,
  `fee` int(11) DEFAULT NULL,
  `time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_impound: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.mdt_incidents
CREATE TABLE IF NOT EXISTS `mdt_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '0',
  `details` text NOT NULL,
  `tags` text NOT NULL,
  `officersinvolved` text NOT NULL,
  `civsinvolved` text NOT NULL,
  `evidence` text NOT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) NOT NULL DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_incidents: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.mdt_logs
CREATE TABLE IF NOT EXISTS `mdt_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_logs: ~7 rows (approximately)
INSERT IGNORE INTO `mdt_logs` (`id`, `text`, `time`, `jobtype`) VALUES
	(1, 'A vehicle with the plate () has a new image () edited by sssss ssssssssss', '1718286052000', 'police'),
	(2, 'A vehicle with the plate () was added to the vehicle information database by sssss ssssssssss', '1718286052000', 'police'),
	(3, 'A vehicle with the plate () has a new image () edited by sssss ssssssssss', '1718286053000', 'police'),
	(4, 'A vehicle with the plate () has a new image () edited by SGX Fivem', '1719206820000', 'police'),
	(5, 'A vehicle with the plate () was added to the vehicle information database by SGX Fivem', '1719206820000', 'police'),
	(6, 'A vehicle with the plate (6XM780SE) has a new image (images/not-found.webp) edited by SGX FIvem', '1721251222000', 'police'),
	(7, 'A vehicle with the plate (6XM780SE) was added to the vehicle information database by SGX FIvem', '1721251223000', 'police');

-- Dumping structure for table sgxcorev1.mdt_reports
CREATE TABLE IF NOT EXISTS `mdt_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `officersinvolved` text DEFAULT NULL,
  `civsinvolved` text DEFAULT NULL,
  `gallery` text DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_reports: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.mdt_vehicleinfo
CREATE TABLE IF NOT EXISTS `mdt_vehicleinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) DEFAULT NULL,
  `information` text NOT NULL DEFAULT '',
  `stolen` tinyint(1) NOT NULL DEFAULT 0,
  `code5` tinyint(1) NOT NULL DEFAULT 0,
  `image` text NOT NULL DEFAULT '',
  `points` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_vehicleinfo: ~2 rows (approximately)
INSERT IGNORE INTO `mdt_vehicleinfo` (`id`, `plate`, `information`, `stolen`, `code5`, `image`, `points`) VALUES
	(1, '', '', 0, 0, '', 0),
	(2, '', '', 0, 0, '', 0),
	(3, '6XM780SE', '', 0, 0, 'images/not-found.webp', 30);

-- Dumping structure for table sgxcorev1.mdt_weaponinfo
CREATE TABLE IF NOT EXISTS `mdt_weaponinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `information` text NOT NULL DEFAULT '',
  `weapClass` varchar(50) DEFAULT NULL,
  `weapModel` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.mdt_weaponinfo: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.multijobs
CREATE TABLE IF NOT EXISTS `multijobs` (
  `citizenid` varchar(100) NOT NULL,
  `jobdata` text DEFAULT NULL,
  PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.multijobs: ~8 rows (approximately)
INSERT IGNORE INTO `multijobs` (`citizenid`, `jobdata`) VALUES
	('BCO92693', '{"police":0,"ambulance":4,"burgershot":4}'),
	('CLC04795', '{"pizzathis":4,"bennys":4,"mechanic":4,"sahp":4,"mechanic3":4,"ambulance":4,"mechanic2":4,"bennys2":4,"autoexotic":4,"redlinemechanic":4,"coolbeans":4,"beeker":4,"bcso":0,"police":4,"realestate":3}'),
	('JIY91569', '{"police":4,"realestate":4}'),
	('KBN48829', '{"police":4,"ambulance":2,"burgershot":2}'),
	('KWX83656', '{"autoexotic":4,"realestate":2,"police":4}'),
	('QEZ87736', '{"coolbeans":3,"autoexotic":3,"police":4,"burgershot":3,"cardealer":3,"ambulance":1}'),
	('XGI09387', '{"burgershot":0,"tow":0,"police":01,"sahp":05,"reporter":0,"bcso":4,"ammunation":4,"ambulance":4,"taxi":0,"vineyard":0,"autoexotic":2,"bennys2":4,"bus":0,"realestate":4,"redlinemechanic":4,"mechanic":1,"coolbeans":4,"pizzathis":4,"cardealer":4}'),
	('ZQM42339', '{"burgershot":2,"pizzathis":2,"bcso":0,"police":01,"coolbeans":2}');

-- Dumping structure for table sgxcorev1.newspaper
CREATE TABLE IF NOT EXISTS `newspaper` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `story_type` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(5000) NOT NULL DEFAULT '',
  `body` varchar(5000) NOT NULL DEFAULT '',
  `date` varchar(50) DEFAULT '',
  `jailed_player` varchar(50) DEFAULT NULL,
  `jailed_time` varchar(50) DEFAULT NULL,
  `image` varchar(250) DEFAULT NULL,
  `publisher` varchar(250) NOT NULL DEFAULT 'Los Santos Newspaper',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.newspaper: ~4 rows (approximately)
INSERT IGNORE INTO `newspaper` (`id`, `story_type`, `title`, `body`, `date`, `jailed_player`, `jailed_time`, `image`, `publisher`) VALUES
	(1, 'jail', '', '', '2024-07-18 02:49:14', 'SGX Fivem', '21212', NULL, 'Los Santos Newspaper'),
	(2, 'jail', '', '', '2024-07-18 04:30:24', 'SGX Fivem', '12', NULL, 'Los Santos Newspaper'),
	(3, 'jail', '', '', '2024-07-18 04:32:10', 'SGX Fivem', '1', NULL, 'Los Santos Newspaper'),
	(4, 'jail', '', '', '2024-07-18 04:45:01', 'SGX Fivem', '1', NULL, 'Los Santos Newspaper');

-- Dumping structure for table sgxcorev1.occasion_vehicles
CREATE TABLE IF NOT EXISTS `occasion_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `occasionId` (`occasionid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.occasion_vehicles: ~1 rows (approximately)

-- Dumping structure for table sgxcorev1.ox_doorlock
CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.ox_doorlock: ~216 rows (approximately)
INSERT IGNORE INTO `ox_doorlock` (`id`, `name`, `data`) VALUES
	(68, 'SAHP1', '{"coords":{"x":1852.1531982421876,"y":3679.8173828125,"z":34.49084854125976},"groups":{"sahp":0},"doors":false,"unlockSound":"door_bolt","state":1,"heading":210,"lockSound":"door_bolt","maxDistance":3,"model":-1468659663}'),
	(69, 'sahp2', '{"coords":{"x":1853.7440185546876,"y":3680.73583984375,"z":34.49084854125976},"groups":{"sahp":0},"doors":false,"state":1,"heading":30,"maxDistance":3,"model":584285758}'),
	(70, 'sahp3', '{"coords":{"x":1856.1478271484376,"y":3684.438720703125,"z":34.57547760009765},"groups":{"sahp":0},"doors":false,"state":1,"heading":300,"maxDistance":3,"model":983313535}'),
	(71, 'sahp4', '{"coords":{"x":1845.900634765625,"y":3675.267578125,"z":34.51080703735351},"groups":{"sahp":0},"doors":false,"state":1,"heading":30,"maxDistance":2,"model":-444005590}'),
	(72, 'sahp5', '{"coords":{"x":1843.0723876953126,"y":3673.634521484375,"z":34.51080703735351},"groups":{"sahp":0},"doors":false,"state":1,"heading":30,"maxDistance":2,"model":-444005590}'),
	(73, 'sahp6', '{"coords":{"x":1840.2440185546876,"y":3672.001708984375,"z":34.51080703735351},"groups":{"sahp":0},"doors":false,"state":1,"heading":30,"maxDistance":2,"model":-444005590}'),
	(74, 'sahp7', '{"coords":{"x":1847.258056640625,"y":3684.151123046875,"z":34.49084854125976},"groups":{"sahp":0},"doors":false,"state":1,"heading":300,"maxDistance":3,"model":-1162105668}'),
	(75, 'sahp8', '{"coords":{"x":1845.5745849609376,"y":3687.06689453125,"z":34.49084854125976},"groups":{"sahp":0},"doors":false,"state":1,"heading":300,"maxDistance":3,"model":-1281482811}'),
	(76, 'sahp9', '{"coords":{"x":1843.1717529296876,"y":3691.228759765625,"z":34.49084854125976},"groups":{"sahp":0},"doors":false,"state":1,"heading":300,"maxDistance":3,"model":-1126157751}'),
	(77, 'sahp10', '{"coords":{"x":1841.021728515625,"y":3689.273681640625,"z":34.49084854125976},"groups":{"sahp":0},"doors":false,"state":1,"heading":300,"maxDistance":3,"model":-819276066}'),
	(78, 'sahp11', '{"coords":{"x":1835.8570556640626,"y":3690.876953125,"z":34.49083709716797},"groups":{"sahp":0},"doors":[{"coords":{"x":1834.7198486328126,"y":3690.22021484375,"z":34.49083709716797},"model":1155678475,"heading":30},{"coords":{"x":1836.9942626953126,"y":3691.533447265625,"z":34.49083709716797},"model":-1837343566,"heading":210}],"state":1,"maxDistance":3}'),
	(79, 'sahp12', '{"coords":{"x":1824.2164306640626,"y":3685.2724609375,"z":34.49084854125976},"groups":{"sahp":0},"doors":false,"state":1,"heading":30,"maxDistance":3,"model":236639101}'),
	(80, 'sahp13', '{"coords":{"x":1825.66455078125,"y":3682.76416015625,"z":34.49084854125976},"groups":{"sahp":0},"doors":false,"state":1,"heading":30,"maxDistance":3,"model":1462560160}'),
	(81, 'sahp14', '{"coords":{"x":1834.25341796875,"y":3681.77587890625,"z":34.49084854125976},"groups":{"sahp":0},"doors":false,"state":1,"heading":120,"maxDistance":2,"model":62963401}'),
	(82, 'sahp15', '{"coords":{"x":1834.622802734375,"y":3679.3212890625,"z":34.49083709716797},"groups":{"sahp":0},"doors":[{"coords":{"x":1835.20849609375,"y":3678.306640625,"z":34.49083709716797},"model":-244377050,"heading":120},{"coords":{"x":1834.0369873046876,"y":3680.3359375,"z":34.49083709716797},"model":-244377050,"heading":300}],"state":1,"maxDistance":3}'),
	(83, 'sahp16', '{"coords":{"x":1847.6151123046876,"y":3691.667724609375,"z":39.17879867553711},"groups":{"sahp":0},"doors":false,"state":1,"heading":300,"maxDistance":3,"model":983313535}'),
	(84, 'sahp17', '{"coords":{"x":1850.880126953125,"y":3680.28125,"z":39.09415817260742},"groups":{"sahp":0},"doors":false,"state":1,"heading":120,"maxDistance":3,"model":-358511141}'),
	(85, 'sahp18', '{"coords":{"x":1849.121337890625,"y":3683.32763671875,"z":39.09415817260742},"groups":{"sahp":0},"doors":false,"state":1,"heading":120,"maxDistance":3,"model":-195583673}'),
	(86, 'sahp19', '{"coords":{"x":1847.3599853515626,"y":3686.37841796875,"z":39.09415817260742},"groups":{"sahp":0},"doors":false,"state":1,"heading":120,"maxDistance":3,"model":286644931}'),
	(87, 'sahp20', '{"coords":{"x":1838.0050048828126,"y":3686.201171875,"z":39.09415817260742},"groups":{"sahp":0},"doors":false,"state":1,"heading":300,"maxDistance":3,"model":1751189836}'),
	(88, 'sahp21', '{"coords":{"x":1842.0030517578126,"y":3679.218017578125,"z":39.09415817260742},"groups":{"sahp":0},"doors":false,"state":1,"heading":120,"maxDistance":3,"model":434400344}'),
	(89, 'sahp22', '{"coords":{"x":1845.5484619140626,"y":3673.135498046875,"z":39.09415817260742},"groups":{"sahp":0},"doors":false,"state":1,"heading":120,"maxDistance":3,"model":2021042551}'),
	(90, 'sahp23', '{"coords":{"x":1848.0316162109376,"y":3674.569091796875,"z":39.09415817260742},"groups":{"sahp":0},"doors":false,"state":1,"heading":120,"maxDistance":3,"model":1360058936}'),
	(91, 'sahp24', '{"coords":{"x":1826.65869140625,"y":3678.922119140625,"z":34.49083709716797},"groups":{"sahp":0},"doors":[{"coords":{"x":1827.3153076171876,"y":3677.784912109375,"z":34.49083709716797},"model":1155678475,"heading":120},{"coords":{"x":1826.002197265625,"y":3680.059326171875,"z":34.49083709716797},"model":-1837343566,"heading":300}],"state":0,"maxDistance":3}'),
	(92, 'bcso1', '{"coords":{"x":-437.8791198730469,"y":6013.654296875,"z":32.28851318359375},"groups":{"bcso":0},"doors":[{"coords":{"x":-437.17169189453127,"y":6012.947265625,"z":32.28851318359375},"model":733214349,"heading":135},{"coords":{"x":-438.5865478515625,"y":6014.36181640625,"z":32.28851318359375},"model":965382714,"heading":315}],"state":0,"maxDistance":3}'),
	(93, 'bcso2', '{"coords":{"x":-443.9599914550781,"y":6017.162109375,"z":32.28851318359375},"groups":{"bcso":0},"doors":false,"state":1,"heading":225,"maxDistance":3,"model":1362051455}'),
	(94, 'bcso3', '{"coords":{"x":-447.36383056640627,"y":6004.16064453125,"z":32.28851318359375},"groups":{"bcso":0},"doors":[{"coords":{"x":-448.0712890625,"y":6004.8681640625,"z":32.28851318359375},"model":1857649811,"heading":315},{"coords":{"x":-446.6564025878906,"y":6003.453125,"z":32.28851318359375},"model":1362051455,"heading":135}],"state":1,"maxDistance":3}'),
	(95, 'bcso4', '{"coords":{"x":-450.71728515625,"y":6004.1279296875,"z":32.28851318359375},"groups":{"bcso":0},"doors":[{"coords":{"x":-451.4247131347656,"y":6003.42041015625,"z":32.28851318359375},"model":1362051455,"heading":45},{"coords":{"x":-450.00982666015627,"y":6004.83544921875,"z":32.28851318359375},"model":1857649811,"heading":225}],"state":1,"maxDistance":3}'),
	(96, 'bcso5', '{"coords":{"x":-454.1942138671875,"y":5997.3447265625,"z":32.28851318359375},"groups":{"bcso":0},"doors":[{"coords":{"x":-454.90167236328127,"y":5998.0517578125,"z":32.28851318359375},"model":733214349,"heading":315},{"coords":{"x":-453.48675537109377,"y":5996.63720703125,"z":32.28851318359375},"model":965382714,"heading":135}],"state":1,"maxDistance":3}'),
	(97, 'bcso6', '{"coords":{"x":-450.71728515625,"y":6004.1279296875,"z":36.99581527709961},"groups":{"bcso":0},"doors":[{"coords":{"x":-451.4247131347656,"y":6003.42041015625,"z":36.99581527709961},"model":1362051455,"heading":45},{"coords":{"x":-450.00982666015627,"y":6004.83544921875,"z":36.99581527709961},"model":1857649811,"heading":225}],"state":1,"maxDistance":3}'),
	(98, 'bcso7', '{"coords":{"x":-449.6783752441406,"y":5999.3447265625,"z":36.99581527709961},"groups":{"bcso":0},"doors":false,"state":1,"heading":135,"maxDistance":3,"model":1362051455}'),
	(100, 'bcso9', '{"coords":{"x":-437.1285400390625,"y":6004.658203125,"z":36.99581527709961},"groups":{"bcso":0},"doors":false,"state":1,"heading":315,"maxDistance":3,"model":1362051455}'),
	(101, 'bcso8', '{"coords":{"x":-447.7691650390625,"y":6000.3876953125,"z":37.31838989257812},"groups":{"bcso":0},"doors":[{"coords":{"x":-446.9224548339844,"y":6001.234375,"z":37.29659271240234},"model":899779172,"heading":225},{"coords":{"x":-448.6158447265625,"y":5999.541015625,"z":37.3401870727539},"model":1127654798,"heading":225}],"state":1,"maxDistance":3}'),
	(102, 'bcso10', '{"coords":{"x":-441.672607421875,"y":6009.1435546875,"z":36.99581527709961},"groups":{"bcso":0},"doors":false,"state":1,"heading":315,"maxDistance":3,"model":1362051455}'),
	(103, 'bcso11', '{"coords":{"x":-447.4444885253906,"y":6011.51220703125,"z":36.99581527709961},"groups":{"bcso":0},"doors":false,"state":1,"heading":45,"maxDistance":3,"model":1362051455}'),
	(104, 'bcso12', '{"coords":{"x":-450.71728515625,"y":6004.1279296875,"z":27.58121490478515},"groups":{"bcso":0},"doors":[{"coords":{"x":-450.00982666015627,"y":6004.83544921875,"z":27.58121490478515},"model":1857649811,"heading":225},{"coords":{"x":-451.4247131347656,"y":6003.42041015625,"z":27.58121490478515},"model":1362051455,"heading":45}],"state":1,"maxDistance":3}'),
	(105, 'bcso13', '{"coords":{"x":-443.6405029296875,"y":6006.97265625,"z":27.73100090026855},"groups":{"bcso":0},"doors":false,"state":1,"heading":315,"maxDistance":2,"model":-594854737}'),
	(106, 'bcso14', '{"coords":{"x":-448.9160461425781,"y":6015.85107421875,"z":27.73100090026855},"groups":{"bcso":0},"doors":false,"state":1,"heading":135,"maxDistance":2,"model":-594854737}'),
	(107, 'bcso15', '{"coords":{"x":-445.9456787109375,"y":6012.88037109375,"z":27.73100090026855},"groups":{"bcso":0},"doors":false,"state":1,"heading":135,"maxDistance":2,"model":-594854737}'),
	(108, 'bcso16', '{"coords":{"x":-443.39007568359377,"y":6015.43603515625,"z":27.73100090026855},"groups":{"bcso":0},"doors":false,"state":1,"heading":135,"maxDistance":2,"model":-594854737}'),
	(109, 'bcso17', '{"coords":{"x":-446.3604431152344,"y":6018.40673828125,"z":27.73100090026855},"groups":{"bcso":0},"doors":false,"state":1,"heading":135,"maxDistance":2,"model":-594854737}'),
	(110, 'bcso18', '{"coords":{"x":-442.24334716796877,"y":6012.61962890625,"z":27.73100090026855},"groups":{"bcso":0},"doors":false,"state":1,"heading":45,"maxDistance":2,"model":-594854737}'),
	(111, 'bcso19', '{"coords":{"x":-449.5087890625,"y":5999.46826171875,"z":27.58121490478515},"groups":{"bcso":0},"doors":false,"state":1,"heading":135,"maxDistance":2,"model":1362051455}'),
	(112, 'bcso20', '{"coords":{"x":-447.2913818359375,"y":6000.6923828125,"z":27.58121490478515},"groups":{"bcso":0},"doors":[{"coords":{"x":-447.99884033203127,"y":5999.98486328125,"z":27.58121490478515},"model":1857649811,"heading":45},{"coords":{"x":-446.58392333984377,"y":6001.39990234375,"z":27.58121490478515},"model":1362051455,"heading":225}],"state":1,"maxDistance":2}'),
	(113, 'bcso21', '{"coords":{"x":-443.06121826171877,"y":5999.8740234375,"z":27.58121490478515},"groups":{"bcso":0},"doors":false,"state":1,"heading":135,"maxDistance":2,"model":1362051455}'),
	(114, 'bcso22', '{"coords":{"x":-441.9415588378906,"y":5998.75439453125,"z":27.58121490478515},"groups":{"bcso":0},"doors":false,"state":1,"heading":315,"maxDistance":2,"model":1362051455}'),
	(115, 'bcso23', '{"coords":{"x":-446.4799499511719,"y":5996.46875,"z":27.58121490478515},"groups":{"bcso":0},"doors":false,"state":1,"heading":135,"maxDistance":2,"model":1362051455}'),
	(116, 'bcso24', '{"coords":{"x":-445.35357666015627,"y":5995.34228515625,"z":27.58121490478515},"groups":{"bcso":0},"doors":false,"state":1,"heading":315,"maxDistance":2,"model":1362051455}'),
	(117, 'police1', '{"coords":{"x":434.74444580078127,"y":-981.9168701171875,"z":30.81530380249023},"groups":{"police":0},"doors":[{"coords":{"x":434.74444580078127,"y":-980.7555541992188,"z":30.81530380249023},"model":-1547307588,"heading":270},{"coords":{"x":434.74444580078127,"y":-983.078125,"z":30.81530380249023},"model":-1547307588,"heading":90}],"state":0,"maxDistance":3}'),
	(118, 'police2', '{"coords":{"x":440.52008056640627,"y":-986.2334594726563,"z":30.82319259643554},"groups":{"police":0},"doors":false,"state":1,"heading":180,"maxDistance":2,"model":-96679321}'),
	(119, 'police3', '{"coords":{"x":440.52008056640627,"y":-977.60107421875,"z":30.82319259643554},"groups":{"police":0},"doors":false,"state":1,"heading":0,"maxDistance":3,"model":-1406685646}'),
	(120, 'police4', '{"coords":{"x":445.4067077636719,"y":-984.201416015625,"z":30.82319259643554},"groups":{"police":0},"doors":false,"state":1,"heading":90,"maxDistance":3,"model":-1406685646}'),
	(121, 'police5', '{"coords":{"x":438.19708251953127,"y":-995.1139526367188,"z":30.82319259643554},"groups":{"police":0},"doors":[{"coords":{"x":438.19708251953127,"y":-993.9112548828125,"z":30.82319259643554},"model":-288803980,"heading":270},{"coords":{"x":438.19708251953127,"y":-996.316650390625,"z":30.82319259643554},"model":-288803980,"heading":90}],"state":1,"maxDistance":3}'),
	(122, 'police6', '{"coords":{"x":441.9004821777344,"y":-998.7462158203125,"z":30.81530380249023},"groups":{"police":0},"doors":[{"coords":{"x":440.73919677734377,"y":-998.7462158203125,"z":30.81530380249023},"model":-1547307588,"heading":0},{"coords":{"x":443.061767578125,"y":-998.7462158203125,"z":30.81530380249023},"model":-1547307588,"heading":180}],"state":1,"maxDistance":3}'),
	(123, 'police7', '{"coords":{"x":452.2662658691406,"y":-995.525390625,"z":30.82319259643554},"groups":{"police":0},"doors":false,"state":1,"heading":135,"maxDistance":3,"model":-96679321}'),
	(124, 'police8', '{"coords":{"x":458.08941650390627,"y":-995.524658203125,"z":30.82319259643554},"groups":{"police":0},"doors":false,"state":1,"heading":225,"maxDistance":2,"model":149284793}'),
	(125, 'police9', '{"coords":{"x":458.6543273925781,"y":-990.6497802734375,"z":30.82319259643554},"groups":{"police":0},"doors":false,"state":1,"heading":270,"maxDistance":3,"model":-96679321}'),
	(126, 'police10', '{"coords":{"x":458.6543273925781,"y":-976.8864135742188,"z":30.82319259643554},"groups":{"police":0},"doors":false,"state":1,"heading":270,"maxDistance":3,"model":-1406685646}'),
	(127, 'police11', '{"coords":{"x":457.0474548339844,"y":-972.2542724609375,"z":30.8153076171875},"groups":{"police":0},"doors":[{"coords":{"x":455.88616943359377,"y":-972.2542724609375,"z":30.8153076171875},"model":-1547307588,"heading":0},{"coords":{"x":458.208740234375,"y":-972.2542724609375,"z":30.8153076171875},"model":-1547307588,"heading":180}],"state":1,"maxDistance":2}'),
	(128, 'police12', '{"coords":{"x":469.44061279296877,"y":-986.2344970703125,"z":30.82319259643554},"groups":{"police":0},"doors":[{"coords":{"x":469.44061279296877,"y":-987.4376831054688,"z":30.82319259643554},"model":-288803980,"heading":90},{"coords":{"x":469.44061279296877,"y":-985.0313110351563,"z":30.82319259643554},"model":-288803980,"heading":270}],"state":1,"maxDistance":2}'),
	(129, 'police13', '{"coords":{"x":474.180908203125,"y":-984.3721923828125,"z":30.82319259643554},"groups":{"police":0},"doors":[{"coords":{"x":475.3836975097656,"y":-984.3721923828125,"z":30.82319259643554},"model":149284793,"heading":180},{"coords":{"x":472.97808837890627,"y":-984.3721923828125,"z":30.82319259643554},"model":149284793,"heading":0}],"state":1,"maxDistance":2}'),
	(130, 'police15', '{"coords":{"x":479.7533874511719,"y":-987.417724609375,"z":30.82319259643554},"groups":{"police":0},"doors":[{"coords":{"x":479.7533874511719,"y":-986.215087890625,"z":30.82319259643554},"model":-1406685646,"heading":270},{"coords":{"x":479.7533874511719,"y":-988.620361328125,"z":30.82319259643554},"model":-96679321,"heading":270}],"state":1,"maxDistance":2}'),
	(131, 'police16', '{"coords":{"x":474.1806945800781,"y":-989.82470703125,"z":30.82319259643554},"groups":{"police":0},"doors":[{"coords":{"x":472.9776916503906,"y":-989.82470703125,"z":30.82319259643554},"model":-96679321,"heading":180},{"coords":{"x":475.3836975097656,"y":-989.82470703125,"z":30.82319259643554},"model":-1406685646,"heading":180}],"state":1,"maxDistance":2}'),
	(132, 'police17', '{"coords":{"x":476.75115966796877,"y":-999.6306762695313,"z":30.82319259643554},"groups":{"police":0},"doors":false,"state":1,"heading":90,"maxDistance":2,"model":-1406685646}'),
	(133, 'police18', '{"coords":{"x":479.750732421875,"y":-999.6290283203125,"z":30.7891674041748},"groups":{"police":0},"doors":false,"state":1,"heading":90,"maxDistance":2,"model":-692649124}'),
	(134, 'police19', '{"coords":{"x":487.4378356933594,"y":-1000.1892700195313,"z":30.78697204589843},"groups":{"police":0},"doors":false,"state":1,"heading":181,"maxDistance":3,"model":-692649124}'),
	(135, 'police20', '{"coords":{"x":486.8158874511719,"y":-1002.9019775390625,"z":30.78697204589843},"groups":{"police":0},"doors":[{"coords":{"x":488.0184326171875,"y":-1002.9019775390625,"z":30.78697204589843},"model":-692649124,"heading":180},{"coords":{"x":485.61334228515627,"y":-1002.9019775390625,"z":30.78697204589843},"model":-692649124,"heading":0}],"state":1,"maxDistance":2}'),
	(136, 'police21', '{"coords":{"x":459.9454040527344,"y":-990.705322265625,"z":35.1039810180664},"groups":{"police":0},"doors":false,"state":1,"heading":0,"maxDistance":3,"model":-96679321}'),
	(137, 'police22', '{"coords":{"x":448.98455810546877,"y":-995.5263671875,"z":35.10376358032226},"groups":{"police":0},"doors":false,"state":1,"heading":135,"maxDistance":3,"model":-96679321}'),
	(138, 'police23', '{"coords":{"x":448.98681640625,"y":-990.2007446289063,"z":35.10376358032226},"groups":{"police":0},"doors":false,"state":1,"heading":45,"maxDistance":3,"model":-1406685646}'),
	(139, 'police24', '{"coords":{"x":459.9454040527344,"y":-981.0741577148438,"z":35.1039810180664},"groups":{"police":0},"doors":false,"state":1,"heading":180,"maxDistance":3,"model":-1406685646}'),
	(140, 'police25', '{"coords":{"x":448.98681640625,"y":-981.5784912109375,"z":35.10376358032226},"groups":{"police":0},"doors":false,"state":1,"heading":135,"maxDistance":3,"model":-96679321}'),
	(141, 'police26', '{"coords":{"x":464.3085632324219,"y":-984.5284423828125,"z":43.771240234375},"groups":{"police":0},"doors":false,"state":1,"heading":90,"maxDistance":3,"model":-692649124}'),
	(142, 'police27', '{"coords":{"x":464.1590576171875,"y":-974.6655883789063,"z":26.3707046508789},"groups":{"police":0},"doors":false,"state":1,"heading":270,"maxDistance":3,"model":1830360419}'),
	(143, 'police28', '{"coords":{"x":464.15655517578127,"y":-997.50927734375,"z":26.3707046508789},"groups":{"police":0},"doors":false,"state":1,"heading":90,"maxDistance":3,"model":1830360419}'),
	(144, 'police29', '{"coords":{"x":468.72479248046877,"y":-1000.543701171875,"z":26.40548324584961},"groups":{"police":0},"doors":[{"coords":{"x":469.9273681640625,"y":-1000.543701171875,"z":26.40548324584961},"model":-288803980,"heading":180},{"coords":{"x":467.522216796875,"y":-1000.543701171875,"z":26.40548324584961},"model":-288803980,"heading":0}],"state":1,"maxDistance":3}'),
	(145, 'police30', '{"coords":{"x":468.5714416503906,"y":-1014.406005859375,"z":26.48381614685058},"groups":{"police":0},"doors":[{"coords":{"x":469.7742614746094,"y":-1014.406005859375,"z":26.48381614685058},"model":-692649124,"heading":180},{"coords":{"x":467.3686218261719,"y":-1014.406005859375,"z":26.48381614685058},"model":-692649124,"heading":0}],"state":1,"maxDistance":3}'),
	(146, 'police31', '{"coords":{"x":471.371826171875,"y":-1008.99560546875,"z":26.40548324584961},"groups":{"police":0},"doors":[{"coords":{"x":471.3758239746094,"y":-1010.1978759765625,"z":26.40548324584961},"model":149284793,"heading":90},{"coords":{"x":471.36785888671877,"y":-1007.7933959960938,"z":26.40548324584961},"model":149284793,"heading":270}],"state":1,"maxDistance":3}'),
	(147, 'police32', '{"coords":{"x":475.953857421875,"y":-1006.9378051757813,"z":26.40638542175293},"groups":{"police":0},"doors":false,"state":1,"heading":180,"maxDistance":2,"model":-288803980}'),
	(148, 'police33', '{"coords":{"x":475.953857421875,"y":-1010.8193359375,"z":26.40638542175293},"groups":{"police":0},"doors":false,"state":1,"heading":180,"maxDistance":2,"model":-1406685646}'),
	(149, 'police34', '{"coords":{"x":476.6156921386719,"y":-1008.8754272460938,"z":26.48005485534668},"groups":{"police":0},"doors":false,"state":1,"heading":270,"maxDistance":2,"model":-53345114}'),
	(150, 'police35', '{"groups":{"police":0},"state":1,"maxDistance":2,"doors":false,"heading":0,"model":-53345114,"coords":{"x":477.32135009765627,"y":-1012.158203125,"z":26.48005485534668}}'),
	(151, 'police36', '{"coords":{"x":480.9128112792969,"y":-1012.1886596679688,"z":26.48005485534668},"groups":{"police":0},"doors":false,"state":1,"heading":0,"maxDistance":3,"model":-53345114}'),
	(152, 'police37', '{"coords":{"x":483.9127197265625,"y":-1012.1886596679688,"z":26.48005485534668},"groups":{"police":0},"doors":false,"state":1,"heading":0,"maxDistance":3,"model":-53345114}'),
	(153, 'police38', '{"coords":{"x":486.9131164550781,"y":-1012.1886596679688,"z":26.48005485534668},"groups":{"police":0},"doors":false,"state":1,"heading":0,"maxDistance":3,"model":-53345114}'),
	(154, 'police39', '{"coords":{"x":484.1764221191406,"y":-1007.734375,"z":26.48005485534668},"groups":{"police":0},"doors":false,"state":1,"heading":180,"maxDistance":3,"model":-53345114}'),
	(155, 'police40', '{"coords":{"x":481.00836181640627,"y":-1004.1179809570313,"z":26.48005485534668},"groups":{"police":0},"doors":false,"state":1,"heading":180,"maxDistance":3,"model":-53345114}'),
	(156, 'police41', '{"coords":{"x":479.0599670410156,"y":-1003.1729736328125,"z":26.40650367736816},"groups":{"police":0},"doors":false,"state":1,"heading":90,"maxDistance":3,"model":-288803980}'),
	(157, 'police42', '{"coords":{"x":480.86614990234377,"y":-997.9099731445313,"z":26.40650367736816},"groups":{"police":0},"doors":[{"coords":{"x":482.0685729980469,"y":-997.9099731445313,"z":26.40650367736816},"model":149284793,"heading":180},{"coords":{"x":479.66375732421877,"y":-997.9099731445313,"z":26.40650367736816},"model":149284793,"heading":0}],"state":1,"maxDistance":3}'),
	(158, 'police43', '{"coords":{"x":482.6702575683594,"y":-995.728515625,"z":26.40548324584961},"groups":{"police":0},"doors":false,"state":1,"heading":270,"maxDistance":2,"model":-1406685646}'),
	(159, 'police44', '{"coords":{"x":482.669921875,"y":-992.2991333007813,"z":26.40548324584961},"groups":{"police":0},"doors":false,"state":1,"heading":270,"maxDistance":2,"model":-1406685646}'),
	(160, 'police45', '{"coords":{"x":482.6701354980469,"y":-987.5791625976563,"z":26.40548324584961},"groups":{"police":0},"doors":false,"state":1,"heading":270,"maxDistance":2,"model":-1406685646}'),
	(161, 'police46', '{"coords":{"x":482.66943359375,"y":-983.98681640625,"z":26.40548324584961},"groups":{"police":0},"doors":false,"state":1,"heading":270,"maxDistance":2,"model":-1406685646}'),
	(162, 'police47', '{"coords":{"x":479.0624084472656,"y":-986.2349853515625,"z":26.40548324584961},"groups":{"police":0},"doors":[{"coords":{"x":479.0624084472656,"y":-985.0323486328125,"z":26.40548324584961},"model":149284793,"heading":270},{"coords":{"x":479.0624084472656,"y":-987.4375610351563,"z":26.40548324584961},"model":149284793,"heading":90}],"state":1,"maxDistance":3}'),
	(163, 'police48', '{"coords":{"x":475.83233642578127,"y":-990.4839477539063,"z":26.40548324584961},"groups":{"police":0},"doors":false,"state":1,"heading":135,"maxDistance":3,"model":-692649124}'),
	(164, 'police49', '{"coords":{"x":478.2891540527344,"y":-997.9100952148438,"z":26.40548324584961},"groups":{"police":0},"doors":false,"state":1,"heading":180,"maxDistance":3,"model":149284793}'),
	(165, 'police50', '{"coords":{"x":471.37530517578127,"y":-986.234619140625,"z":26.40548324584961},"groups":{"police":0},"doors":[{"coords":{"x":471.37530517578127,"y":-987.4373779296875,"z":26.40548324584961},"model":-96679321,"heading":270},{"coords":{"x":471.37530517578127,"y":-985.0319213867188,"z":26.40548324584961},"model":-1406685646,"heading":270}],"state":1,"maxDistance":3}'),
	(166, 'police51', '{"coords":{"x":452.3005065917969,"y":-1000.7716674804688,"z":26.69660949707031},"doorRate":1,"groups":{"police":0},"doors":false,"state":1,"heading":0,"autolock":10,"maxDistance":8,"model":2130672747}'),
	(167, 'police52', '{"state":1,"doors":false,"groups":{"police":0},"model":2130672747,"heading":0,"coords":{"x":431.4118957519531,"y":-1000.771728515625,"z":26.69660949707031},"autolock":10,"maxDistance":8,"doorRate":1}'),
	(168, 'burgershot1', '{"coords":{"x":-1181.4556884765626,"y":-886.404052734375,"z":14.09526920318603},"groups":{"burgershot":0},"doors":[{"coords":{"x":-1180.728515625,"y":-887.4773559570313,"z":14.09526920318603},"model":-1890974902,"heading":124},{"coords":{"x":-1182.182861328125,"y":-885.330810546875,"z":14.09526920318603},"model":1143532813,"heading":304}],"state":0,"maxDistance":3}'),
	(169, 'burgershot2', '{"coords":{"x":-1188.0657958984376,"y":-896.6784057617188,"z":13.90556144714355},"groups":{"burgershot":0},"doors":false,"state":1,"heading":304,"maxDistance":2,"model":2010236044}'),
	(170, 'burgershot3', '{"coords":{"x":-1202.9925537109376,"y":-891.7135009765625,"z":13.90556144714355},"groups":{"burgershot":0},"doors":false,"state":0,"heading":214,"maxDistance":3,"model":1963966216}'),
	(171, 'burgershot4', '{"coords":{"x":-1203.7806396484376,"y":-892.2449951171875,"z":13.90556144714355},"groups":{"burgershot":0},"doors":false,"state":0,"heading":34,"maxDistance":2,"model":1963966216}'),
	(172, 'burgershot5', '{"coords":{"x":-1200.7210693359376,"y":-900.771728515625,"z":13.90556144714355},"groups":{"burgershot":0},"doors":false,"state":1,"heading":214,"maxDistance":2,"model":2010236044}'),
	(173, 'burgershot6', '{"coords":{"x":-1197.09912109375,"y":-903.9393920898438,"z":14.03526592254638},"groups":{"burgershot":0},"doors":false,"state":1,"heading":214,"maxDistance":2,"model":1465287574}'),
	(174, 'coolbeans1', '{"coords":{"x":-1206.0234375,"y":-1134.07177734375,"z":8.09148788452148},"groups":{"coolbeans":0},"doors":[{"coords":{"x":-1206.372314453125,"y":-1133.113037109375,"z":8.09148788452148},"model":1963114394,"heading":110},{"coords":{"x":-1205.6744384765626,"y":-1135.030517578125,"z":8.09148788452148},"model":1963114394,"heading":290}],"state":0,"maxDistance":2}'),
	(175, 'coolbeans2', '{"coords":{"x":-1196.5858154296876,"y":-1130.564697265625,"z":8.09148788452148},"groups":{"coolbeans":0},"doors":[{"coords":{"x":-1196.223388671875,"y":-1131.560546875,"z":8.09148788452148},"model":1145438743,"heading":290},{"coords":{"x":-1196.9482421875,"y":-1129.56884765625,"z":8.09148788452148},"model":1145438743,"heading":110}],"state":0,"maxDistance":2}'),
	(176, 'coolbeans3', '{"coords":{"x":-1194.2764892578126,"y":-1137.9267578125,"z":8.0027961730957},"groups":{"coolbeans":0},"doors":false,"state":1,"heading":20,"maxDistance":2,"model":-470980178}'),
	(177, 'coolbeans4', '{"coords":{"x":-1196.783447265625,"y":-1139.7423095703126,"z":8.00532817840576},"groups":{"coolbeans":0},"doors":false,"state":1,"heading":110,"maxDistance":2,"model":-470980178}'),
	(178, 'coolbeans5', '{"coords":{"x":-1189.028076171875,"y":-1136.91552734375,"z":8.00532817840576},"groups":{"coolbeans":0},"doors":false,"state":1,"heading":110,"maxDistance":3,"model":-470980178}'),
	(179, 'coolbeans6', '{"coords":{"x":-1189.33837890625,"y":-1139.3751220703126,"z":8.00532817840576},"groups":{"coolbeans":0},"doors":false,"state":1,"heading":20,"maxDistance":3,"model":2137721}'),
	(180, 'coolbeans7', '{"coords":{"x":-1188.88671875,"y":-1141.8758544921876,"z":8.00532817840576},"groups":{"coolbeans":0},"doors":false,"state":1,"heading":20,"maxDistance":2,"model":-470980178}'),
	(181, 'coolbeans8', '{"coords":{"x":-1191.18408203125,"y":-1142.7120361328126,"z":8.00532817840576},"groups":{"coolbeans":0},"doors":false,"state":1,"heading":20,"maxDistance":2,"model":-470980178}'),
	(182, 'pizzathis1', '{"coords":{"x":-586.65869140625,"y":-884.6571655273438,"z":25.96295738220215},"groups":{"pizzathis":0},"doors":[{"coords":{"x":-587.8485717773438,"y":-884.6571655273438,"z":25.96295738220215},"model":-49173194,"heading":180},{"coords":{"x":-585.4688110351563,"y":-884.6571655273438,"z":25.96295738220215},"model":95403626,"heading":180}],"state":0,"maxDistance":3}'),
	(183, 'pizzathis2', '{"coords":{"x":-596.8756103515625,"y":-894.9806518554688,"z":25.96295738220215},"groups":{"pizzathis":0},"doors":[{"coords":{"x":-596.8756103515625,"y":-893.790771484375,"z":25.96295738220215},"model":95403626,"heading":270},{"coords":{"x":-596.8756103515625,"y":-896.1705322265625,"z":25.96295738220215},"model":-49173194,"heading":270}],"state":0,"maxDistance":2}'),
	(184, 'pizzathis3', '{"coords":{"x":-590.7237548828125,"y":-901.8137817382813,"z":25.8705768585205},"groups":{"pizzathis":0},"doors":false,"state":0,"heading":90,"maxDistance":3,"model":1984391163}'),
	(185, 'pizzathis4', '{"coords":{"x":-590.7122802734375,"y":-900.72216796875,"z":25.8705768585205},"groups":{"pizzathis":0},"doors":false,"state":0,"heading":270,"maxDistance":2,"model":1984391163}'),
	(186, 'pizzathis5', '{"coords":{"x":-580.7175903320313,"y":-893.0022583007813,"z":25.8705768585205},"groups":{"pizzathis":0},"doors":false,"state":1,"heading":0,"maxDistance":3,"model":1984391163}'),
	(187, 'pizzathis6', '{"coords":{"x":-584.8486328125,"y":-902.5388793945313,"z":25.8705768585205},"groups":{"pizzathis":0},"doors":false,"state":1,"heading":180,"maxDistance":2,"model":1984391163}'),
	(188, 'pizzathis7', '{"coords":{"x":-579.2093505859375,"y":-899.1570434570313,"z":25.8705768585205},"groups":{"pizzathis":0},"doors":false,"state":1,"heading":90,"maxDistance":2,"model":1984391163}'),
	(189, 'pizzathis8', '{"coords":{"x":-576.5592651367188,"y":-899.5529174804688,"z":25.98244667053222},"groups":{"pizzathis":0},"doors":false,"state":1,"heading":90,"maxDistance":3,"model":-420112688}'),
	(190, 'pizzathis9', '{"coords":{"x":-586.6409912109375,"y":-904.426513671875,"z":30.35440635681152},"groups":{"pizzathis":0},"doors":false,"state":1,"heading":270,"maxDistance":2,"model":1984391163}'),
	(191, 'pizzathis10', '{"coords":{"x":-584.240966796875,"y":-901.2964477539063,"z":30.35440635681152},"groups":{"pizzathis":0},"doors":false,"state":1,"heading":270,"maxDistance":2,"model":1984391163}'),
	(192, 'pizzathis11', '{"coords":{"x":-592.4420776367188,"y":-900.0580444335938,"z":30.35440635681152},"groups":{"pizzathis":0},"doors":false,"state":1,"heading":0,"maxDistance":2,"model":1984391163}'),
	(193, 'pizzathis12', '{"coords":{"x":-593.7225341796875,"y":-894.9811401367188,"z":30.35440635681152},"groups":{"pizzathis":0},"doors":false,"state":1,"heading":180,"maxDistance":2,"model":1984391163}'),
	(194, 'ambulance1', '{"groups":{"ambulance":0},"maxDistance":3,"state":0,"doors":[{"heading":70,"coords":{"x":299.1461181640625,"y":-585.7518920898438,"z":42.27942657470703},"model":1674378365},{"heading":70,"coords":{"x":299.8409729003906,"y":-583.8428344726563,"z":42.27942657470703},"model":1138474139}],"coords":{"x":299.4935302734375,"y":-584.79736328125,"z":42.27942657470703}}'),
	(195, 'ambulance2', '{"groups":{"ambulance":0},"maxDistance":3,"model":-1999925837,"state":1,"doors":false,"coords":{"x":304.3673095703125,"y":-593.5765991210938,"z":43.41555023193359},"heading":340}'),
	(196, 'ambulance3', '{"model":-1999925837,"coords":{"x":309.28558349609377,"y":-592.2650146484375,"z":43.42947006225586},"heading":340,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(197, 'ambulance4', '{"model":-1999925837,"coords":{"x":317.9701843261719,"y":-595.43115234375,"z":43.41217041015625},"heading":340,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(198, 'ambulance5', '{"model":-1999925837,"coords":{"x":321.6812744140625,"y":-596.7874755859375,"z":43.40998840332031},"heading":340,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(199, 'ambulance6', '{"model":-1999925837,"coords":{"x":318.19293212890627,"y":-595.5053100585938,"z":48.36914825439453},"heading":340,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(200, 'ambulance7', '{"model":-1999925837,"coords":{"x":310.9762268066406,"y":-589.470458984375,"z":50.82203674316406},"heading":70,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(201, 'ambulance8', '{"model":-1999925837,"coords":{"x":321.9991760253906,"y":-589.3641967773438,"z":48.35577011108398},"heading":340,"state":0,"doors":false,"groups":{"ambulance":0},"maxDistance":3}'),
	(202, 'ambulance9', '{"model":2056450362,"coords":{"x":320.5054626464844,"y":-582.4859008789063,"z":48.36480712890625},"heading":70,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":3}'),
	(203, 'ambulance10', '{"model":2056450362,"coords":{"x":323.3689880371094,"y":-574.6046142578125,"z":48.35157775878906},"heading":70,"state":0,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(204, 'ambulance11', '{"model":2056450362,"coords":{"x":330.8155822753906,"y":-577.3305053710938,"z":48.35541915893555},"heading":70,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(205, 'ambulance12', '{"model":2056450362,"coords":{"x":349.9978942871094,"y":-577.1474609375,"z":48.36331939697265},"heading":250,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(206, 'ambulance13', '{"model":2056450362,"coords":{"x":344.41455078125,"y":-578.9430541992188,"z":48.35037994384765},"heading":160,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(207, 'ambulance14', '{"model":2056450362,"coords":{"x":333.3568115234375,"y":-570.9995727539063,"z":48.35575103759765},"heading":70,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(208, 'ambulance15', '{"model":2056450362,"coords":{"x":329.5938415527344,"y":-571.5717163085938,"z":48.34677124023437},"heading":340,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(209, 'ambulance16', '{"model":2056450362,"coords":{"x":327.86834716796877,"y":-585.4100952148438,"z":48.35803985595703},"heading":70,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(210, 'ambulance17', '{"model":-1999925837,"coords":{"x":317.0753173828125,"y":-588.8892211914063,"z":38.48796844482422},"heading":250,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(211, 'ambulance18', '{"model":-1999925837,"coords":{"x":321.1883544921875,"y":-589.0711059570313,"z":38.46952819824219},"heading":340,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(212, 'ambulance19', '{"coords":{"x":321.05255126953127,"y":-581.9819946289063,"z":37.31536102294922},"state":1,"doors":[{"heading":250,"model":-1688620337,"coords":{"x":321.4109802246094,"y":-580.978271484375,"z":37.3149299621582}},{"heading":70,"model":-1688620337,"coords":{"x":320.694091796875,"y":-582.9857177734375,"z":37.31578826904297}}],"groups":{"ambulance":0},"maxDistance":2}'),
	(213, 'ambulance20', '{"model":443953414,"coords":{"x":323.585205078125,"y":-574.9307861328125,"z":37.32090759277344},"heading":250,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(214, 'ambulance21', '{"coords":{"x":325.4977722167969,"y":-569.156982421875,"z":37.32685852050781},"state":1,"doors":[{"heading":250,"model":-320514587,"coords":{"x":325.85516357421877,"y":-568.1544189453125,"z":37.32685852050781}},{"heading":70,"model":-320514587,"coords":{"x":325.140380859375,"y":-570.1596069335938,"z":37.32685852050781}}],"groups":{"ambulance":0},"maxDistance":2}'),
	(215, 'ambulance22', '{"coords":{"x":331.21331787109377,"y":-571.2357177734375,"z":37.3260269165039},"state":1,"doors":[{"heading":70,"model":-320514587,"coords":{"x":330.8543701171875,"y":-572.23828125,"z":37.3260269165039}},{"heading":250,"model":-320514587,"coords":{"x":331.5722351074219,"y":-570.2330932617188,"z":37.3260269165039}}],"groups":{"ambulance":0},"maxDistance":2}'),
	(216, 'ambulance23', '{"model":443953414,"coords":{"x":328.94061279296877,"y":-576.879638671875,"z":37.32550048828125},"heading":250,"state":1,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(217, 'ambulance25', '{"coords":{"x":326.38226318359377,"y":-583.921875,"z":37.31536102294922},"state":1,"doors":[{"heading":250,"model":-1688620337,"coords":{"x":326.74072265625,"y":-582.9180908203125,"z":37.3149299621582}},{"heading":70,"model":-1688620337,"coords":{"x":326.0238342285156,"y":-584.9255981445313,"z":37.31578826904297}}],"groups":{"ambulance":0},"maxDistance":3}'),
	(218, 'ambulance26', '{"model":-32016311,"coords":{"x":331.6625671386719,"y":-584.6835327148438,"z":43.42396926879883},"heading":340,"state":0,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(219, 'ambulance27', '{"model":-32016311,"coords":{"x":333.8495178222656,"y":-587.094482421875,"z":43.42665100097656},"heading":250,"state":0,"doors":false,"groups":{"ambulance":0},"maxDistance":2}'),
	(220, 'ambulance28', '{"coords":{"x":309.2215576171875,"y":-573.7056884765625,"z":43.43328094482422},"state":1,"doors":[{"heading":160,"model":-164945599,"coords":{"x":310.43975830078127,"y":-574.1490478515625,"z":43.43328094482422}},{"heading":340,"model":-164945599,"coords":{"x":308.00335693359377,"y":-573.2622680664063,"z":43.43328094482422}}],"groups":{"ambulance":0},"maxDistance":2}'),
	(221, 'blackmarket', '{"model":-612979079,"passcode":"sgxcore","doors":false,"heading":355,"state":1,"coords":{"x":-583.0362548828125,"y":228.53958129882813,"z":78.37574768066406},"maxDistance":4}'),
	(222, 'ambulance55', '{"model":1494856475,"state":0,"groups":{"ambulance":0},"coords":{"x":1770.031982421875,"y":3636.326171875,"z":34.95380020141601},"doors":false,"heading":30,"maxDistance":2}'),
	(223, 'ambulance56', '{"model":-2047111970,"state":1,"groups":{"ambulance":0},"coords":{"x":1764.720703125,"y":3644.027587890625,"z":34.95380020141601},"doors":false,"heading":30,"maxDistance":2}'),
	(224, 'ambulance57', '{"state":0,"groups":{"ambulance":0},"coords":{"x":1761.8323974609376,"y":3635.95947265625,"z":35.01719665527344},"doors":[{"model":-1322457624,"heading":120,"coords":{"x":1761.2091064453126,"y":3637.038818359375,"z":35.01719665527344}},{"model":-1322457624,"heading":300,"coords":{"x":1762.4556884765626,"y":3634.8798828125,"z":35.01719665527344}}],"maxDistance":2}'),
	(225, 'ambulance58', '{"model":1764905804,"state":1,"groups":{"ambulance":0},"coords":{"x":1739.040283203125,"y":3643.68408203125,"z":34.95380020141601},"doors":false,"heading":30,"maxDistance":2}'),
	(226, 'ambulance59', '{"state":0,"groups":{"ambulance":0},"coords":{"x":1736.764404296875,"y":3640.44140625,"z":35.01759719848633},"doors":[{"model":-1322457624,"heading":300,"coords":{"x":1737.387451171875,"y":3639.3623046875,"z":35.01759719848633}},{"model":-1322457624,"heading":120,"coords":{"x":1736.141357421875,"y":3641.5205078125,"z":35.01759719848633}}],"maxDistance":2}'),
	(227, 'ambulance60', '{"state":0,"groups":{"ambulance":0},"coords":{"x":1743.417724609375,"y":3628.91748046875,"z":35.01503372192383},"doors":[{"model":-1322457624,"heading":120,"coords":{"x":1742.7940673828126,"y":3629.99755859375,"z":35.01503372192383}},{"model":-1322457624,"heading":300,"coords":{"x":1744.041259765625,"y":3627.83740234375,"z":35.01503372192383}}],"maxDistance":2}'),
	(228, 'ambulance61', '{"model":403354678,"state":1,"groups":{"ambulance":0},"coords":{"x":1743.7098388671876,"y":3642.505859375,"z":35.0186653137207},"doors":false,"heading":30,"maxDistance":2}'),
	(229, 'ambulance62', '{"model":403354678,"state":1,"groups":{"ambulance":0},"coords":{"x":1746.7015380859376,"y":3644.233154296875,"z":35.01661682128906},"doors":false,"heading":30,"maxDistance":2}'),
	(230, 'ambulance63', '{"model":403354678,"state":1,"groups":{"ambulance":0},"coords":{"x":1750.3602294921876,"y":3646.3427734375,"z":35.01661682128906},"doors":false,"heading":30,"maxDistance":2}'),
	(231, 'ambulance64', '{"model":403354678,"state":1,"groups":{"ambulance":0},"coords":{"x":1754.18115234375,"y":3633.505126953125,"z":35.01723861694336},"doors":false,"heading":210,"maxDistance":2}'),
	(232, 'ambulance65', '{"model":403354678,"state":1,"groups":{"ambulance":0},"coords":{"x":1749.6634521484376,"y":3630.8955078125,"z":35.01701354980469},"doors":false,"heading":210,"maxDistance":2}'),
	(233, 'ambulance66', '{"model":403354678,"state":1,"groups":{"ambulance":0},"coords":{"x":1746.4559326171876,"y":3629.911376953125,"z":35.01667022705078},"doors":false,"heading":300,"maxDistance":2}'),
	(234, 'ambulance67', '{"model":1943595525,"state":0,"groups":{"ambulance":0},"coords":{"x":1773.0198974609376,"y":3642.800537109375,"z":35.0147705078125},"doors":false,"heading":30,"maxDistance":2}'),
	(235, 'ambulance68', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1785.1551513671876,"y":3647.07177734375,"z":35.0173110961914},"doors":false,"heading":300,"maxDistance":2}'),
	(236, 'ambulance69', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1779.1441650390626,"y":3650.48779296875,"z":35.01700973510742},"doors":false,"heading":120,"maxDistance":2}'),
	(237, 'ambulance70', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1783.22998046875,"y":3650.4072265625,"z":35.01729965209961},"doors":false,"heading":300,"maxDistance":2}'),
	(238, 'ambulance71', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1776.705078125,"y":3654.712646484375,"z":35.01700973510742},"doors":false,"heading":120,"maxDistance":2}'),
	(239, 'ambulance72', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1779.8748779296876,"y":3656.220458984375,"z":35.01184463500976},"doors":false,"heading":300,"maxDistance":2}'),
	(240, 'ambulance73', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1774.2384033203126,"y":3658.994873046875,"z":35.0187759399414},"doors":false,"heading":120,"maxDistance":2}'),
	(241, 'ambulance74', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1777.922119140625,"y":3659.604736328125,"z":35.01750946044922},"doors":false,"heading":300,"maxDistance":2}'),
	(242, 'ambulance75', '{"model":1764905804,"state":1,"groups":{"ambulance":0},"coords":{"x":1772.956787109375,"y":3665.237060546875,"z":34.95380020141601},"doors":false,"heading":30,"maxDistance":2}'),
	(243, 'ambulance76', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1756.185302734375,"y":3651.555419921875,"z":35.01825714111328},"doors":false,"heading":210,"maxDistance":2}'),
	(244, 'ambulance77', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1761.8565673828126,"y":3654.834228515625,"z":35.0168342590332},"doors":false,"heading":210,"maxDistance":2}'),
	(245, 'ambulance78', '{"model":1943595525,"state":1,"groups":{"ambulance":0},"coords":{"x":1765.755615234375,"y":3657.082275390625,"z":35.01807022094726},"doors":false,"heading":210,"maxDistance":2}'),
	(246, 'police150', '{"model":705715602,"state":0,"groups":{"police":0,"bcso":0,"sahp":0},"coords":{"x":1845.3358154296876,"y":2585.34765625,"z":46.08550262451172},"doors":false,"heading":90,"maxDistance":2}'),
	(247, 'police151', '{"model":2024969025,"state":1,"groups":{"police":0,"bcso":0,"sahp":0},"coords":{"x":1844.40380859375,"y":2576.9970703125,"z":46.03560256958008},"doors":false,"heading":0,"maxDistance":2}'),
	(248, 'police153', '{"model":2024969025,"state":1,"groups":{"police":0,"bcso":0,"sahp":0},"coords":{"x":1837.6337890625,"y":2576.99169921875,"z":46.03859710693359},"doors":false,"heading":0,"maxDistance":2}'),
	(249, 'polic155', '{"groups":{"bsco":0,"sasp":1,"police":0},"coords":{"x":1837.0985107421876,"y":2592.161376953125,"z":46.03957366943359},"doors":false,"maxDistance":2,"model":-684929024,"state":0,"heading":0}'),
	(250, 'police156', '{"model":-684929024,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1838.616943359375,"y":2593.705078125,"z":46.03635787963867},"doors":false,"heading":270,"maxDistance":2}'),
	(251, 'police157', '{"model":-684929024,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1827.9814453125,"y":2592.1572265625,"z":46.03718185424805},"doors":false,"heading":180,"maxDistance":2}'),
	(252, 'police168', '{"model":-684929024,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1831.3399658203126,"y":2594.9921875,"z":46.03791046142578},"doors":false,"heading":90,"maxDistance":2}'),
	(253, 'police169', '{"model":705715602,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1819.0728759765626,"y":2594.873291015625,"z":46.09036254882812},"doors":false,"heading":270,"maxDistance":2}'),
	(254, 'police170', '{"model":-1156020871,"state":1,"groups":{"police":0,"bsco":0,"sasp":1},"coords":{"x":1798.0899658203126,"y":2591.68701171875,"z":46.41783905029297},"doors":false,"heading":180,"maxDistance":2}'),
	(255, 'police171', '{"model":-1156020871,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1797.760986328125,"y":2596.56494140625,"z":46.38731002807617},"doors":false,"heading":180,"maxDistance":2}'),
	(256, 'police172', '{"model":741314661,"state":1,"groups":{"police":0,"bsco":0,"sasp":1},"coords":{"x":1844.998046875,"y":2604.81201171875,"z":44.63977813720703},"doors":false,"heading":90,"maxDistance":2}'),
	(257, 'police173', '{"model":741314661,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1818.54296875,"y":2604.81201171875,"z":44.61100006103515},"doors":false,"heading":90,"maxDistance":2}'),
	(258, 'police174', '{"model":741314661,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1799.6080322265626,"y":2616.97509765625,"z":44.6032485961914},"doors":false,"heading":180,"maxDistance":2}'),
	(259, 'police175', '{"model":741314661,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1663.384033203125,"y":2602.679931640625,"z":44.56974029541015},"doors":false,"heading":90,"maxDistance":2}'),
	(260, 'police176', '{"model":741314661,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1798.570556640625,"y":2530.10791015625,"z":44.69487762451172},"doors":false,"heading":185,"maxDistance":2}'),
	(261, 'police177', '{"model":705715602,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1791.595703125,"y":2551.462158203125,"z":45.75320434570312},"doors":false,"heading":90,"maxDistance":2}'),
	(262, 'police178', '{"model":741314661,"state":1,"groups":{"police":0,"bsco":0,"sahp":0},"coords":{"x":1774.64501953125,"y":2534.51708984375,"z":44.69485855102539},"doors":false,"heading":60,"maxDistance":2}'),
	(263, 'autoexotic1', '{"model":-836126368,"state":1,"groups":{"autoexotic":0},"coords":{"x":541.3296508789063,"y":-179.2282257080078,"z":55.50653839111328},"doors":false,"heading":270,"maxDistance":2}'),
	(264, 'autoexotic2', '{"model":-836126368,"state":1,"groups":{"autoexotic":0},"coords":{"x":541.3296508789063,"y":-189.3748016357422,"z":55.51440048217773},"doors":false,"heading":270,"maxDistance":2}'),
	(265, 'autoexotic3', '{"model":-1924863600,"state":1,"groups":{"autoexotic":0},"coords":{"x":540.9420166015625,"y":-195.96514892578126,"z":54.88402557373047},"doors":false,"heading":270,"maxDistance":2}'),
	(266, 'autoexotic4', '{"model":-836126368,"state":1,"groups":{"autoexotic":0},"coords":{"x":548.4612426757813,"y":-201.96029663085938,"z":55.49274826049805},"doors":false,"heading":0,"maxDistance":2}'),
	(267, 'autoexotic5', '{"model":-836126368,"state":1,"groups":{"autoexotic":0},"coords":{"x":548.4612426757813,"y":-165.57164001464845,"z":55.45002365112305},"doors":false,"heading":180,"maxDistance":2}'),
	(268, 'autoexotic6', '{"model":1525532175,"state":1,"groups":{"autoexotic":0},"coords":{"x":553.1067504882813,"y":-201.0788116455078,"z":58.28800201416015},"doors":false,"heading":90,"maxDistance":2}'),
	(269, 'cardealer1', '{"model":675021279,"state":0,"groups":{"cardealer":0},"coords":{"x":546.4442138671875,"y":-253.51318359375,"z":50.06281661987305},"doors":false,"heading":110,"maxDistance":2}'),
	(270, 'cardealer2', '{"model":-1453542142,"state":0,"groups":{"cardealer":0},"coords":{"x":553.3062133789063,"y":-237.44256591796876,"z":49.0053825378418},"doors":false,"heading":65,"maxDistance":2}'),
	(271, 'bennys21', '{"model":-694476256,"state":1,"groups":{"bennys2":0},"coords":{"x":962.4464721679688,"y":-1031.0291748046876,"z":41.83958053588867},"doorRate":1,"doors":false,"heading":90,"maxDistance":2}'),
	(272, 'bennys22', '{"model":-694476256,"state":1,"groups":{"bennys2":0},"coords":{"x":962.4471435546875,"y":-1025.36474609375,"z":41.83958053588867},"doorRate":1,"doors":false,"heading":90,"maxDistance":2}'),
	(273, 'bennys23', '{"model":-694476256,"state":1,"groups":{"bennys2":0},"coords":{"x":962.4478149414063,"y":-1019.7001342773438,"z":41.83958053588867},"doors":false,"heading":90,"maxDistance":2}'),
	(274, 'bennys25', '{"model":-694476256,"state":1,"groups":{"bennys2":0},"coords":{"x":962.448486328125,"y":-1014.038330078125,"z":41.83958053588867},"doorRate":1,"doors":false,"heading":90,"maxDistance":2}'),
	(275, 'bennys27', '{"model":873979204,"state":1,"groups":{"bennys2":0},"coords":{"x":950.2992553710938,"y":-1047.9659423828126,"z":40.99896240234375},"doors":false,"heading":0,"maxDistance":2}'),
	(276, 'bennys29', '{"model":-853859998,"state":1,"groups":{"bennys2":0},"coords":{"x":945.5447998046875,"y":-1052.686279296875,"z":40.98367691040039},"doors":false,"heading":271,"maxDistance":2}'),
	(277, 'redlinemechanic1', '{"model":-1436005319,"state":1,"groups":{"redlinemechanic":0},"coords":{"x":-1607.760009765625,"y":-830.513427734375,"z":11.84185600280761},"doorRate":1,"doors":false,"heading":139,"maxDistance":2}'),
	(278, 'redlinemechanic2', '{"model":-1733711684,"state":1,"groups":{"redlinemechanic":0},"coords":{"x":-1612.2193603515626,"y":-826.6301879882813,"z":11.84185600280761},"doorRate":1,"doors":false,"heading":139,"maxDistance":2}'),
	(279, 'redlinemechanic3', '{"model":-1216387481,"state":1,"groups":{"redlinemechanic":0},"coords":{"x":-1616.6942138671876,"y":-822.7373046875,"z":11.84185600280761},"doorRate":1,"doors":false,"heading":139,"maxDistance":2}'),
	(280, 'redlinemechanic4', '{"model":-1733711684,"state":1,"groups":{"redlinemechanic":0},"coords":{"x":-1621.1563720703126,"y":-818.8241577148438,"z":11.84185600280761},"doorRate":1,"doors":false,"heading":139,"maxDistance":2}'),
	(281, 'redlinemechanic5', '{"model":1195640306,"state":1,"groups":{"redlinemechanic":0},"coords":{"x":-1625.6602783203126,"y":-814.9097900390625,"z":11.84185600280761},"doorRate":1,"doors":false,"heading":139,"maxDistance":2}'),
	(282, 'redlinemechanic6', '{"model":714428445,"state":1,"groups":{"redlinemechanic":0},"coords":{"x":-1605.2120361328126,"y":-832.4472045898438,"z":10.37854957580566},"doors":false,"heading":319,"maxDistance":2}'),
	(283, 'redlinemechanic7', '{"model":-598592616,"state":0,"groups":{"redlinemechanic":0},"coords":{"x":-1607.89892578125,"y":-834.97509765625,"z":10.47097587585449},"doors":false,"heading":229,"maxDistance":2}'),
	(284, 'redlinemechanic8', '{"model":-1611744562,"state":1,"groups":{"redlinemechanic":0},"coords":{"x":-1612.47998046875,"y":-840.25634765625,"z":10.46283912658691},"doors":false,"heading":229,"maxDistance":2}'),
	(285, 'ammunationpillboxhillmain', '{"doors":[{"model":97297972,"coords":{"x":16.12786865234375,"y":-1114.6055908203126,"z":29.94693756103515},"heading":160},{"model":-8873588,"coords":{"x":18.57200241088867,"y":-1115.4951171875,"z":29.94693756103515},"heading":340}],"state":1,"coords":{"x":17.34993553161621,"y":-1115.05029296875,"z":29.94693756103515},"groups":{"ammunation":0},"maxDistance":2}'),
	(286, 'amunationpillboxhillgunrage', '{"doors":false,"heading":160,"state":1,"coords":{"x":6.81789016723632,"y":-1098.20947265625,"z":29.94685363769531},"groups":{"ammunation":0},"maxDistance":2,"model":452874391}'),
	(288, 'amunationlocked1', '{"doors":[{"model":97297972,"coords":{"x":813.1779174804688,"y":-2148.26953125,"z":29.76892471313476},"heading":360},{"model":-8873588,"coords":{"x":810.576904296875,"y":-2148.26953125,"z":29.76892471313476},"heading":180}],"state":1,"coords":{"x":811.87744140625,"y":-2148.26953125,"z":29.76892471313476},"maxDistance":2}'),
	(289, 'amunationlocked2', '{"doors":[{"model":-8873588,"coords":{"x":-662.6414794921875,"y":-944.3255615234375,"z":21.97915267944336},"heading":0},{"model":97297972,"coords":{"x":-665.242431640625,"y":-944.3255615234375,"z":21.97915267944336},"heading":180}],"state":1,"coords":{"x":-663.9419555664063,"y":-944.3255615234375,"z":21.97915267944336},"maxDistance":2}'),
	(290, 'amunationlocked3', '{"doors":[{"model":-8873588,"coords":{"x":-1314.4649658203126,"y":-391.6471862792969,"z":36.84572601318359},"heading":256},{"model":97297972,"coords":{"x":-1313.825927734375,"y":-389.12591552734377,"z":36.84572982788086},"heading":76}],"state":1,"coords":{"x":-1314.1455078125,"y":-390.38653564453127,"z":36.84572601318359},"maxDistance":2}'),
	(291, 'amunationlocked4', '{"doors":[{"model":-8873588,"coords":{"x":1699.937255859375,"y":3753.420166015625,"z":34.85526275634765},"heading":47},{"model":97297972,"coords":{"x":1698.1763916015626,"y":3751.505859375,"z":34.85526275634765},"heading":227}],"state":1,"coords":{"x":1699.056884765625,"y":3752.462890625,"z":34.85526275634765},"maxDistance":2}'),
	(292, 'amunationlocked5', '{"doors":[{"model":-8873588,"coords":{"x":-324.2730407714844,"y":6077.109375,"z":31.60470199584961},"heading":45},{"model":97297972,"coords":{"x":-326.11224365234377,"y":6075.27001953125,"z":31.60470199584961},"heading":225}],"state":1,"coords":{"x":-325.192626953125,"y":6076.189453125,"z":31.60470199584961},"maxDistance":2}'),
	(293, 'amunationlocked6', '{"doors":[{"model":-8873588,"coords":{"x":-1112.07080078125,"y":2691.504638671875,"z":18.70406532287597},"heading":42},{"model":97297972,"coords":{"x":-1114.009033203125,"y":2689.770263671875,"z":18.70406532287597},"heading":222}],"state":1,"coords":{"x":-1113.0399169921876,"y":2690.637451171875,"z":18.70406532287597},"maxDistance":2}'),
	(294, 'amunationlocked7', '{"doors":[{"model":-8873588,"coords":{"x":243.83786010742188,"y":-46.52323532104492,"z":70.09098052978516},"heading":250},{"model":97297972,"coords":{"x":244.7274627685547,"y":-44.07910919189453,"z":70.09098052978516},"heading":70}],"state":1,"coords":{"x":244.28265380859376,"y":-45.30117034912109,"z":70.09098052978516},"maxDistance":2}'),
	(295, 'amunationlocked8', '{"doors":[{"model":-8873588,"coords":{"x":842.7684936523438,"y":-1024.5391845703126,"z":28.34477996826172},"heading":180},{"model":97297972,"coords":{"x":845.3694458007813,"y":-1024.5391845703126,"z":28.34477996826172},"heading":360}],"state":1,"coords":{"x":844.0689697265625,"y":-1024.5391845703126,"z":28.34477996826172},"maxDistance":2}'),
	(296, 'mprd garage pole 01', '{"state":1,"doorRate":1,"heading":270,"coords":{"x":410.0257873535156,"y":-1020.164794921875,"z":29.2202205657959},"maxDistance":5,"model":-1868050792,"groups":{"police":0},"doors":false}'),
	(297, 'mprd garage pole 02', '{"state":1,"doorRate":1,"heading":270,"coords":{"x":410.0257873535156,"y":-1028.3275146484376,"z":29.22019958496093},"maxDistance":5,"model":-1635161509,"groups":{"police":0},"doors":false}'),
	(299, 'pawnshop', '{"heading":124,"maxDistance":2,"model":-2059351422,"groups":{"pawnshop":0},"coords":{"x":1703.1839599609376,"y":3788.682861328125,"z":34.87585067749023},"doors":false,"state":1}');

-- Dumping structure for table sgxcorev1.phone_chatrooms
CREATE TABLE IF NOT EXISTS `phone_chatrooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_code` varchar(10) NOT NULL,
  `room_name` varchar(15) NOT NULL,
  `room_owner_id` varchar(20) DEFAULT NULL,
  `room_owner_name` varchar(60) DEFAULT NULL,
  `room_members` text DEFAULT '{}',
  `room_pin` varchar(50) DEFAULT NULL,
  `unpaid_balance` decimal(10,2) DEFAULT 0.00,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `room_code` (`room_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.phone_chatrooms: ~3 rows (approximately)
INSERT IGNORE INTO `phone_chatrooms` (`id`, `room_code`, `room_name`, `room_owner_id`, `room_owner_name`, `room_members`, `room_pin`, `unpaid_balance`, `is_pinned`, `created`) VALUES
	(1, '411', '411', 'official', 'Government', '{}', NULL, 0.00, 1, '2024-06-09 04:59:13'),
	(2, 'lounge', 'The Lounge', 'official', 'Government', '{}', NULL, 0.00, 1, '2024-06-09 04:59:13'),
	(3, 'events', 'Events', 'official', 'Government', '{}', NULL, 0.00, 1, '2024-06-09 04:59:13');

-- Dumping structure for table sgxcorev1.phone_chatroom_messages
CREATE TABLE IF NOT EXISTS `phone_chatroom_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int(10) unsigned DEFAULT NULL,
  `member_id` varchar(20) DEFAULT NULL,
  `member_name` varchar(50) DEFAULT NULL,
  `message` text NOT NULL,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.phone_chatroom_messages: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.phone_gallery
CREATE TABLE IF NOT EXISTS `phone_gallery` (
  `citizenid` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.phone_gallery: ~1 rows (approximately)
INSERT IGNORE INTO `phone_gallery` (`citizenid`, `image`, `date`) VALUES
	('ZQM42339', 'https://media.discordapp.net/attachments/1236040444740370563/1250678986011316224/screenshot.jpg?ex=666bd112&is=666a7f92&hm=c72d4397c4fe03d5d268e0c7213f5ac94ad65ca6e9382a6c6d752c1942a8bf41&', '2024-06-12 18:11:46'),
	('XGI09387', 'https://media.discordapp.net/attachments/1236040444740370563/1260873089126895647/screenshot.jpg?ex=6690e712&is=668f9592&hm=2fda63a5a5f6bef518669e2a14ba368b3a6da12c283e45e78fd4e303bc538f27&', '2024-07-11 08:19:31');

-- Dumping structure for table sgxcorev1.phone_invoices
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.phone_invoices: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.phone_messages: ~2 rows (approximately)
INSERT IGNORE INTO `phone_messages` (`id`, `citizenid`, `number`, `messages`, `time`) VALUES
	(13, 'QEZ87736', '3898590096', '[{"date":"24-5-2024","messages":[{"type":"message","message":"Hey","time":"08:37","sender":"XGI09387","data":[]},{"type":"message","message":"hello","time":"08:37","sender":"QEZ87736","data":[]}]}]', NULL),
	(14, 'XGI09387', '5497175130', '[{"date":"24-5-2024","messages":[{"type":"message","message":"Hey","time":"08:37","sender":"XGI09387","data":[]},{"type":"message","message":"hello","time":"08:37","sender":"QEZ87736","data":[]}]}]', NULL);

-- Dumping structure for table sgxcorev1.phone_note
CREATE TABLE IF NOT EXISTS `phone_note` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `text` text DEFAULT NULL,
  `lastupdate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.phone_note: ~1 rows (approximately)
INSERT IGNORE INTO `phone_note` (`id`, `citizenid`, `title`, `text`, `lastupdate`) VALUES
	(56, 'BCO92693', '2313', '232332', '2 June 2024 11:36');

-- Dumping structure for table sgxcorev1.phone_tweets
CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `firstName` varchar(25) DEFAULT NULL,
  `lastName` varchar(25) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `url` text DEFAULT NULL,
  `tweetId` varchar(25) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=294 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.phone_tweets: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`citizenid`),
  KEY `id` (`id`),
  KEY `last_updated` (`last_updated`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=4243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.players: ~6 rows (approximately)
INSERT IGNORE INTO `players` (`id`, `citizenid`, `cid`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`) VALUES
	(1912, 'JIY91569', 1, 'license:615cd127368c5800a4a41ca27970b1e8048a0e4f', 'delhisehu213', '{"black_money":0,"bank":-8708,"casino":0,"cash":68,"crypto":0}', '{"firstname":"Aa","cid":"1","gender":0,"phone":"4148725065","birthdate":"2005-05-05","nationality":"sad","lastname":"A","account":"US06QBCore7980423761"}', '{"type":"leo","name":"police","onduty":false,"label":"Los Santos Police Department","isboss":false,"grade":{"payment":500,"isboss":false,"name":"Corporal","level":4}}', '{"grade":{"name":"none","level":0},"isboss":false,"name":"none","label":"No Gang Affiliation"}', '{"x":427.9120788574219,"y":-1003.96484375,"z":30.6951904296875}', '{"laptop":{"background":"./assets/wp1.png","darkfont":false},"bloodtype":"AB+","phonedata":{"InstalledApps":[],"SerialNumber":37988837},"inlaststand":false,"callsign":"NO CALLSIGN","fingerprint":"NP842i12gwZ3889","carboostrep":0,"ishandcuffed":false,"delivery":0,"tracker":false,"stress":0,"criminalrecord":{"date":{"month":6,"wday":5,"yday":172,"min":4,"isdst":false,"sec":29,"year":2024,"hour":21,"day":20},"hasRecord":true},"status":[],"injail":0,"garbage":0,"phone":[],"rep":[],"isdead":false,"jailitems":[{"unique":true,"info":{"firstname":"Aa","birthdate":"2005-05-05","quality":100,"lastname":"A","citizenid":"JIY91569","nationality":"sad","gender":0},"shouldClose":false,"amount":1,"type":"item","useable":true,"image":"id_card.png","name":"id_card","description":"A card containing all your information to identify yourself","slot":1,"label":"ID Card","weight":0,"created":1718895621},{"unique":true,"info":{"firstname":"Aa","type":"Class C Driver License","quality":100,"lastname":"A","birthdate":"2005-05-05"},"shouldClose":false,"amount":1,"type":"item","useable":true,"image":"driver_license.png","name":"driver_license","description":"Permit to show you can drive a vehicle","slot":2,"label":"Drivers License","weight":0,"created":1718895621},{"unique":true,"info":{"quality":100},"shouldClose":false,"amount":1,"type":"item","useable":false,"image":"phone.png","name":"phone","description":"Neat phone ya got there","slot":3,"label":"Phone","weight":700,"created":1718895621},{"unique":false,"info":{"quality":100},"shouldClose":true,"amount":2,"type":"item","useable":false,"image":"tablet.png","name":"tablet","description":"Expensive tablet","slot":4,"label":"Tablet","weight":2000,"created":1718895988},{"unique":false,"info":{"quality":100},"shouldClose":true,"amount":2,"type":"item","useable":true,"image":"handcuffs.png","name":"handcuffs","description":"Comes in handy when people misbehave. Maybe it can be used for something else?","slot":5,"label":"Handcuffs","weight":100,"created":1718896319},null,{"unique":false,"info":{"quality":100},"shouldClose":true,"amount":1,"type":"item","useable":true,"image":"lockpick.png","name":"lockpick","description":"Very useful if you lose your keys a lot.. or if you want to use it for something else...","slot":7,"label":"Lockpick","weight":300,"created":1718896959}],"licences":{"driver":true,"weapon":false,"business":false},"hunger":36.99999999999996,"armor":0,"walletid":"QB-88826982","inside":{"apartment":[]},"thirst":43.00000000000004,"crypto":{"lme":0,"shung":0,"gne":0,"xcoin":0}}', '[{"name":"weapon_pistol","type":"weapon","slot":1,"created":1718919653,"amount":1,"info":{"ammo":230,"quality":0,"serie":"28Iyk2uR323LiEl"}},{"name":"water_bottle","type":"item","slot":2,"created":1718963983,"amount":7,"info":{"quality":100}},{"name":"racingtablet","type":"item","slot":3,"created":1718953154,"amount":2,"info":{"quality":100}},{"name":"laptop","type":"item","slot":4,"created":1718953208,"amount":2,"info":{"quality":100}},{"name":"vpn","type":"item","slot":5,"created":1718970739,"amount":1,"info":{"quality":100}},{"name":"phone","type":"item","slot":6,"created":1718960835,"amount":1,"info":{"quality":100}},{"name":"dusche","type":"item","slot":7,"created":1718963827,"amount":1,"info":{"quality":100}},{"name":"cash","type":"item","slot":8,"created":1718970925,"amount":68,"info":{"quality":100}},{"name":"weapon_smg","type":"weapon","slot":9,"created":1718970738,"amount":1,"info":{"quality":72.09999999999894,"ammo":171,"attachments":[{"component":"COMPONENT_AT_SCOPE_MACRO_02","label":"1x Scope"},{"component":"COMPONENT_AT_AR_FLSH","label":"Flashlight"}],"serie":"06sbV4qr371DAyt"}},{"name":"advancedlockpick","type":"item","slot":10,"created":1718967197,"amount":1,"info":{"quality":100}},{"name":"vpn","type":"item","slot":13,"created":1718970736,"amount":1,"info":{"quality":100}}]', '2024-06-21 11:56:24'),
	(1218, 'KBN48829', 3, 'license:615cd127368c5800a4a41ca27970b1e8048a0e4f', 'delhisehu213', '{"black_money":0,"cash":999930770,"crypto":0,"casino":0,"bank":5025}', '{"lastname":"sasa","phone":"7066139546","gender":0,"birthdate":"2005-05-05","account":"US04QBCore3706551067","nationality":"sas","firstname":"sas","cid":"3"}', '{"onduty":true,"type":"leo","name":"police","isboss":false,"grade":{"isboss":false,"payment":500,"name":"Corporal","level":4},"label":"Los Santos Police Department"}', '{"isboss":false,"grade":{"name":"none","level":0},"name":"none","label":"No Gang Affiliation"}', '{"x":1726.3780517578126,"y":2536.852783203125,"z":45.5399169921875}', '{"injail":0,"ishandcuffed":false,"callsign":"NO CALLSIGN","crypto":{"shung":0,"gne":0,"xcoin":0,"lme":0},"fingerprint":"ou259r73nvQ5164","phonedata":{"InstalledApps":[],"SerialNumber":65812027},"isdead":false,"armor":0,"stress":0,"garbage":0,"rep":[],"phone":[],"carboostrep":0,"status":[],"tracker":false,"bloodtype":"A-","criminalrecord":{"hasRecord":false},"inlaststand":false,"laptop":{"darkfont":false,"background":"default"},"thirst":27.80000000000004,"hunger":20.19999999999995,"jailitems":[],"walletid":"QB-95094865","inside":{"apartment":[]},"delivery":0,"licences":{"business":false,"weapon":false,"driver":true}}', '[{"name":"weapon_knife","info":{"quality":100,"serie":"19Dak1pt067nPtA","ammo":0},"type":"weapon","created":1721258321,"slot":1,"amount":1},{"name":"laptop","info":{"quality":100},"type":"item","created":1718964201,"slot":4,"amount":1},{"name":"cash","info":{"quality":100},"type":"item","created":1721258397,"slot":5,"amount":999930770},{"name":"vpn","info":{"quality":100},"type":"item","created":1718964204,"slot":6,"amount":1},{"name":"weapon_pistol","info":{"quality":95.79999999999984,"serie":"15Ivu4fz196nxMG","ammo":220},"type":"weapon","created":1721231491,"slot":7,"amount":1},{"name":"driver_license","info":{"quality":100,"firstname":"sas","type":"Class C Driver License","lastname":"sasa","birthdate":"2005-05-05"},"type":"item","created":1721258400,"slot":8,"amount":1},{"name":"phone","info":{"quality":100},"type":"item","created":1721258320,"slot":11,"amount":1},{"name":"id_card","info":{"quality":100,"birthdate":"2005-05-05","firstname":"sas","lastname":"sasa","gender":0,"citizenid":"KBN48829","nationality":"sas"},"type":"item","created":1721258401,"slot":9,"amount":1}]', '2024-07-18 01:04:33'),
	(2814, 'OGB23731', 1, 'license:01b8136d46827d1be78a2b279c2bd23c42ad3e72', 'Minami', '{"black_money":0,"cash":500,"crypto":0,"bank":5040,"casino":0}', '{"gender":0,"lastname":"assa","phone":"7316112996","account":"US01QBCore5547811643","birthdate":"2005-05-05","nationality":"asxadasd","firstname":"asas","cid":"1"}', '{"name":"unemployed","isboss":false,"onduty":true,"label":"Civilian","grade":{"name":"Freelancer","payment":10,"isboss":false,"level":0},"type":"none"}', '{"name":"none","label":"No Gang Affiliation","grade":{"name":"none","level":0},"isboss":false}', '{"x":2555.59130859375,"y":2694.2109375,"z":41.17578125}', '{"tracker":false,"jailitems":[],"thirst":100,"bloodtype":"AB+","phonedata":{"InstalledApps":[],"SerialNumber":71548688},"phone":[],"stress":0,"armor":0,"isdead":false,"injail":0,"fingerprint":"gO362u60iKm4066","hunger":100,"licences":{"business":false,"weapon":false,"driver":true},"status":[],"inlaststand":false,"rep":[],"callsign":"NO CALLSIGN","inside":{"apartment":[]},"walletid":"QB-20742232","criminalrecord":{"hasRecord":false},"ishandcuffed":false}', '[{"amount":1,"type":"weapon","name":"weapon_combatpistol","slot":1,"created":1719742857,"info":{"serie":"21Wds2nC934eouX","quality":100,"ammo":-1}},{"amount":5,"type":"item","name":"armor","slot":2,"created":1719742808,"info":{"quality":100}},{"amount":1,"type":"item","name":"driver_license","slot":3,"created":1719742124,"info":{"birthdate":"2005-05-05","type":"Class C Driver License","firstname":"asas","quality":100,"lastname":"assa"}},{"amount":1,"type":"weapon","name":"weapon_revolver","slot":4,"created":1719744678,"info":{"serie":"64Tmf8Ib914lakw","quality":100,"ammo":-1}},{"amount":500,"type":"item","name":"cash","slot":5,"created":1719744676,"info":{"quality":100}},{"amount":1,"type":"weapon","name":"weapon_heavypistol","slot":6,"created":1719742856,"info":{"serie":"75PpQ9Kh228FOyg","quality":100,"ammo":-1}},{"amount":1,"type":"item","name":"id_card","slot":7,"created":1719742296,"info":{"birthdate":"2005-05-05","gender":0,"citizenid":"OGB23731","nationality":"asxadasd","firstname":"asas","lastname":"assa","quality":100}},{"amount":1,"type":"item","name":"phone","slot":8,"created":1719742296,"info":{"quality":100}}]', '2024-06-30 10:53:04'),
	(2312, 'QEZ87736', 4, 'license:615cd127368c5800a4a41ca27970b1e8048a0e4f', 'delhisehu213', '{"casino":0,"cash":0,"crypto":0,"bank":2136512.0,"black_money":0}', '{"account":"US09QBCore7797373674","firstname":"SGX","phone":"5497175130","birthdate":"2005-05-05","nationality":"India","cid":"4","gender":1,"lastname":"FIvem"}', '{"onduty":true,"isboss":false,"label":"Los Santos Police Department","type":"leo","grade":{"level":4,"isboss":false,"payment":500,"name":"Corporal"},"name":"police"}', '{"label":"No Gang Affiliation","isboss":false,"grade":{"level":0,"name":"none"},"name":"none"}', '{"x":1837.92529296875,"y":2582.2021484375,"z":46.01171875}', '{"phone":[],"bloodtype":"B-","inside":{"apartment":[]},"carboostrep":0,"ishandcuffed":false,"thirst":81.00000000000002,"status":[],"isdead":false,"callsign":"Ramdi","walletid":"QB-14268632","crypto":{"lme":0,"gne":0,"xcoin":0,"shung":0},"armor":0,"delivery":0,"rep":[],"garbage":30.0,"injail":0,"hunger":78.99999999999999,"jailitems":[],"laptop":{"background":"default","darkfont":false},"phonedata":{"InstalledApps":[],"SerialNumber":26975960},"tracker":false,"stress":0,"licences":{"business":false,"driver":false},"fingerprint":"nr399P74gEQ8924","inlaststand":false,"criminalrecord":{"hasRecord":false}}', '[{"info":{"serie":"71gyD2RI276KiHi","quality":70.74999999999889,"ammo":69},"created":1721249661,"slot":1,"name":"weapon_pistol","type":"weapon","amount":1},{"info":{"quality":100},"created":1719331691,"slot":2,"name":"burgershot_tomato","type":"item","amount":1},{"info":{"quality":100},"created":1719331687,"slot":3,"name":"burgershot_cheddar","type":"item","amount":1},{"info":{"quality":100},"created":1721250903,"slot":4,"name":"empty_evidence_bag","type":"item","amount":1},{"info":{"serie":"82aDh5xq909ASGU","quality":100,"ammo":0},"created":1721250948,"slot":5,"name":"weapon_flashlight","type":"weapon","amount":1},{"info":{"quality":100},"created":1719331556,"slot":6,"name":"burgershot_frozennuggets","type":"item","amount":1},{"info":{"quality":100},"created":1719331554,"slot":7,"name":"burgershot_frozenrings","type":"item","amount":1},{"info":{"quality":100},"created":1719331552,"slot":8,"name":"burgershot_frozenmeat","type":"item","amount":1},{"info":{"quality":100},"created":1719331866,"slot":9,"name":"burgershot_colas","type":"item","amount":1},{"info":{"quality":100},"created":1719331693,"slot":10,"name":"burgershot_lavash","type":"item","amount":1},{"info":{"quality":100},"created":1719331567,"slot":11,"name":"burgershot_coffeeemptyglass","type":"item","amount":1},{"info":{"quality":100},"created":1719331566,"slot":12,"name":"burgershot_bigcardboard","type":"item","amount":1},{"info":{"quality":100},"created":1719331743,"slot":13,"name":"burgershot_bigemptyglass","type":"item","amount":1},{"info":{"quality":100},"created":1719331744,"slot":14,"name":"burgershot_bigfrozenpotato","type":"item","amount":1},{"info":{"quality":100},"created":1719331607,"slot":162,"name":"burgershot_meat","type":"item","amount":997},{"info":{"quality":100},"created":1719331828,"slot":161,"name":"burgershot_smallfrozenpotato","type":"item","amount":1}]', '2024-07-17 21:26:30'),
	(2075, 'TDN82412', 2, 'license:615cd127368c5800a4a41ca27970b1e8048a0e4f', 'delhisehu213', '{"crypto":0,"cash":214121,"casino":0,"bank":1100,"black_money":0}', '{"phone":"7534841894","birthdate":"2005-05-05","lastname":"asas","firstname":"sas","cid":"2","gender":0,"account":"US09QBCore3661779513","nationality":"as"}', '{"isboss":false,"name":"unemployed","type":"none","label":"Civilian","grade":{"payment":10,"isboss":false,"name":"Freelancer","level":0},"onduty":true}', '{"isboss":false,"label":"No Gang Affiliation","name":"none","grade":{"name":"none","level":0}}', '{"x":-649.92529296875,"y":-820.02197265625,"z":24.7135009765625}', '{"injail":0,"licences":{"weapon":false,"business":false,"driver":true},"stress":0,"callsign":"NO CALLSIGN","rep":[],"delivery":0,"carboostrep":0,"inlaststand":false,"jailitems":[],"crypto":{"shung":0,"xcoin":0,"gne":0,"lme":0},"thirst":100,"tracker":false,"laptop":{"darkfont":false,"background":"default"},"status":[],"phone":[],"bloodtype":"O+","isdead":false,"ishandcuffed":false,"garbage":0,"fingerprint":"Oo707M10fQZ6987","hunger":100,"inside":{"apartment":[]},"armor":0,"criminalrecord":{"hasRecord":false},"walletid":"QB-83732954","phonedata":{"InstalledApps":[],"SerialNumber":96444697}}', '[{"type":"weapon","info":{"ammo":141,"quality":77.34999999999914,"serie":"88cvm8ok543LdAv"},"amount":1,"created":1721000540,"slot":1,"name":"weapon_carbinerifle_mk2"},{"type":"item","info":{"quality":100},"amount":2,"created":1718953535,"slot":4,"name":"racingtablet"},{"type":"item","info":{"quality":100},"amount":214121,"created":1721235448,"slot":5,"name":"cash"},{"type":"weapon","info":{"ammo":241,"quality":96.69999999999988,"serie":"30Pur9UF493ZjkI"},"amount":1,"created":1718953821,"slot":7,"name":"weapon_pistol"},{"type":"item","info":{"quality":100},"amount":1,"created":1720999825,"slot":8,"name":"phone"},{"type":"item","info":{"nationality":"as","birthdate":"2005-05-05","gender":0,"citizenid":"TDN82412","firstname":"sas","lastname":"asas","quality":100},"amount":1,"created":1720999888,"slot":12,"name":"id_card"},{"type":"item","info":{"birthdate":"2005-05-05","type":"Class C Driver License","firstname":"sas","lastname":"asas","quality":100},"amount":1,"created":1720999888,"slot":14,"name":"driver_license"}]', '2024-07-17 16:57:43'),
	(2427, 'XGI09387', 2, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'SGX', '{"cash":58260,"crypto":9945084.825,"black_money":0,"casino":0,"bank":698661.0}', '{"lastname":"Fivem","cid":"2","firstname":"SGX","phone":"3898590096","account":"US08QBCore1357143795","gender":0,"nationality":"Community","birthdate":"2005-05-05"}', '{"isboss":false,"type":"none","payment":10,"name":"vineyard","grade":{"name":"Picker","isboss":false,"payment":50,"level":0},"onduty":true,"label":"Vineyard"}', '{"name":"vagos","isboss":true,"grade":{"name":"Boss","isboss":true,"level":3},"label":"Vagos"}', '{"x":-944.5318603515625,"y":-551.024169921875,"z":18.4622802734375}', '{"callsign":"Ramdi","licences":{"business":false,"weapon":false,"driver":true},"crypto":{"shung":0,"gne":25.74000000000001,"xcoin":0,"lme":0},"carboostrep":0,"tracker":false,"thirst":96.2,"rep":[],"fingerprint":"gf273d44AxI3511","hunger":95.8,"criminalrecord":{"date":{"yday":200,"day":18,"isdst":false,"wday":5,"hour":4,"month":7,"year":2024,"min":45,"sec":1},"hasRecord":true},"isdead":false,"inlaststand":true,"jailitems":[{"weight":0,"useable":false,"unique":false,"description":"Cash","amount":58369,"slot":1,"created":1721257830,"label":"Cash","image":"cash.png","info":{"quality":100},"shouldClose":true,"name":"cash","type":"item"},{"weight":700,"useable":false,"unique":true,"description":"Neat phone ya got there","amount":1,"slot":2,"created":1721257421,"label":"Phone","image":"phone.png","info":{"quality":100},"shouldClose":false,"name":"phone","type":"item"},{"weight":0,"useable":false,"unique":false,"description":"Crypto","amount":9945084.825,"slot":3,"created":1721257830,"label":"Crypto Papers","image":"cryptopaper.png","info":{"quality":100},"shouldClose":true,"name":"crypto","type":"item"}],"status":[],"walletid":"QB-29048754","phone":[],"inside":{"apartment":[]},"armor":0,"phonedata":{"InstalledApps":[],"SerialNumber":18898509},"bloodtype":"A+","garbage":9.0,"injail":0,"laptop":{"background":"./assets/wp3.jpg","darkfont":false},"ishandcuffed":false,"delivery":8.0,"stress":0}', '[{"name":"cash","created":1721393348,"amount":58260,"slot":1,"type":"item","info":{"quality":100}},{"name":"crypto","created":1721393348,"amount":9945084.825,"slot":2,"type":"item","info":{"quality":100}},{"name":"phone","created":1721391037,"amount":1,"slot":3,"type":"item","info":{"quality":100}},{"name":"grape","created":1721392161,"amount":111,"slot":4,"type":"item","info":{"quality":100}},{"name":"diamond","created":1721392379,"amount":9,"slot":5,"type":"item","info":{"quality":100}},{"name":"goldbar","created":1721392379,"amount":9,"slot":6,"type":"item","info":{"quality":100}},{"name":"electronickit","created":1721392379,"amount":9,"slot":7,"type":"item","info":{"quality":100}},{"name":"grapejuice","created":1721392502,"amount":87,"slot":8,"type":"item","info":{"quality":100}},{"name":"wine","created":1721392554,"amount":5,"slot":9,"type":"item","info":{"quality":100}}]', '2024-07-19 19:19:30');

-- Dumping structure for table sgxcorev1.playerskins
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table sgxcorev1.playerskins: ~7 rows (approximately)
INSERT IGNORE INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
	(4, 'JIY91569', 'mp_m_freemode_01', '{"props":[{"prop_id":0,"texture":-1,"drawable":-1},{"prop_id":1,"texture":-1,"drawable":-1},{"prop_id":2,"texture":-1,"drawable":-1},{"prop_id":6,"texture":-1,"drawable":-1},{"prop_id":7,"texture":-1,"drawable":-1}],"components":[{"drawable":0,"component_id":0,"texture":0},{"drawable":0,"component_id":1,"texture":0},{"drawable":0,"component_id":2,"texture":0},{"drawable":0,"component_id":3,"texture":0},{"drawable":0,"component_id":4,"texture":0},{"drawable":0,"component_id":5,"texture":0},{"drawable":0,"component_id":6,"texture":0},{"drawable":0,"component_id":7,"texture":0},{"drawable":0,"component_id":8,"texture":0},{"drawable":0,"component_id":9,"texture":0},{"drawable":0,"component_id":10,"texture":0},{"drawable":0,"component_id":11,"texture":0}],"faceFeatures":{"nosePeakSize":0,"cheeksWidth":0,"jawBoneWidth":0,"chinHole":0,"cheeksBoneHigh":0,"chinBoneLenght":0,"noseBoneHigh":0,"eyeBrownHigh":0,"nosePeakLowering":0,"noseWidth":0,"eyesOpening":0,"cheeksBoneWidth":0,"neckThickness":0,"jawBoneBackSize":0,"eyeBrownForward":0,"chinBoneSize":0,"chinBoneLowering":0,"lipsThickness":0,"noseBoneTwist":0,"nosePeakHigh":0},"headBlend":{"skinFirst":0,"shapeThird":0,"shapeFirst":0,"skinMix":0,"shapeMix":0,"thirdMix":0,"skinSecond":0,"skinThird":0,"shapeSecond":0},"model":"mp_m_freemode_01","hair":{"texture":0,"highlight":0,"color":0,"style":0},"eyeColor":-1,"headOverlays":{"lipstick":{"style":0,"color":0,"opacity":0},"complexion":{"style":0,"color":0,"opacity":0},"makeUp":{"style":0,"opacity":0,"color":0,"secondColor":0},"blemishes":{"style":0,"color":0,"opacity":0},"bodyBlemishes":{"style":0,"color":0,"opacity":0},"chestHair":{"style":0,"color":0,"opacity":0},"sunDamage":{"style":0,"color":0,"opacity":0},"moleAndFreckles":{"style":0,"color":0,"opacity":0},"beard":{"style":0,"color":0,"opacity":0},"blush":{"style":0,"color":0,"opacity":0},"eyebrows":{"style":0,"color":0,"opacity":0},"ageing":{"style":0,"color":0,"opacity":0}},"tattoos":[]}', 1),
	(8, 'TDN82412', 'mp_m_freemode_01', '{"model":"mp_m_freemode_01","headOverlays":{"lipstick":{"opacity":0,"color":0,"style":0},"moleAndFreckles":{"opacity":0,"color":0,"style":0},"complexion":{"opacity":0,"color":0,"style":0},"eyebrows":{"opacity":0,"color":0,"style":0},"sunDamage":{"opacity":0,"color":0,"style":0},"blemishes":{"opacity":0,"color":0,"style":0},"ageing":{"opacity":0,"color":0,"style":0},"blush":{"opacity":0,"color":0,"style":0},"beard":{"opacity":0,"color":0,"style":0},"bodyBlemishes":{"opacity":0,"color":0,"style":0},"chestHair":{"opacity":0,"color":0,"style":0},"makeUp":{"opacity":0,"color":0,"style":0,"secondColor":0}},"tattoos":[],"eyeColor":-1,"hair":{"style":0,"highlight":0,"color":0,"texture":0},"props":[{"drawable":-1,"prop_id":0,"texture":-1},{"drawable":-1,"prop_id":1,"texture":-1},{"drawable":-1,"prop_id":2,"texture":-1},{"drawable":-1,"prop_id":6,"texture":-1},{"drawable":-1,"prop_id":7,"texture":-1}],"headBlend":{"shapeFirst":0,"skinMix":0,"thirdMix":0,"skinThird":0,"shapeSecond":0,"shapeThird":0,"skinSecond":0,"skinFirst":0,"shapeMix":0},"components":[{"texture":0,"component_id":0,"drawable":0},{"texture":0,"component_id":1,"drawable":0},{"texture":0,"component_id":2,"drawable":0},{"texture":0,"component_id":3,"drawable":0},{"texture":0,"component_id":4,"drawable":0},{"texture":0,"component_id":5,"drawable":0},{"texture":0,"component_id":6,"drawable":0},{"texture":0,"component_id":7,"drawable":0},{"texture":0,"component_id":8,"drawable":0},{"texture":0,"component_id":9,"drawable":0},{"texture":0,"component_id":10,"drawable":0},{"texture":0,"component_id":11,"drawable":0}],"faceFeatures":{"chinBoneSize":0,"cheeksBoneHigh":0,"chinBoneLenght":0,"cheeksBoneWidth":0,"noseWidth":0,"chinHole":0,"nosePeakSize":0,"cheeksWidth":0,"jawBoneWidth":0,"noseBoneTwist":0,"neckThickness":0,"lipsThickness":0,"noseBoneHigh":0,"eyeBrownHigh":0,"chinBoneLowering":0,"jawBoneBackSize":0,"nosePeakHigh":0,"nosePeakLowering":0,"eyeBrownForward":0,"eyesOpening":0}}', 1),
	(9, 'KBN48829', 'mp_m_freemode_01', '{"faceFeatures":{"noseBoneTwist":0,"cheeksWidth":0,"lipsThickness":0,"jawBoneWidth":0,"cheeksBoneWidth":0,"jawBoneBackSize":0,"noseWidth":0,"cheeksBoneHigh":0,"chinBoneLowering":0,"nosePeakLowering":0,"eyesOpening":0,"nosePeakHigh":0,"neckThickness":0,"nosePeakSize":0,"noseBoneHigh":0,"chinBoneSize":0,"chinBoneLenght":0,"eyeBrownHigh":0,"eyeBrownForward":0,"chinHole":0},"tattoos":[],"eyeColor":-1,"components":[{"texture":0,"component_id":0,"drawable":0},{"texture":0,"component_id":1,"drawable":0},{"texture":0,"component_id":2,"drawable":0},{"texture":0,"component_id":3,"drawable":0},{"texture":0,"component_id":4,"drawable":0},{"texture":0,"component_id":5,"drawable":0},{"texture":0,"component_id":6,"drawable":0},{"texture":0,"component_id":7,"drawable":0},{"texture":0,"component_id":8,"drawable":0},{"texture":0,"component_id":9,"drawable":0},{"texture":0,"component_id":10,"drawable":0},{"texture":0,"component_id":11,"drawable":0}],"props":[{"texture":-1,"prop_id":0,"drawable":-1},{"texture":-1,"prop_id":1,"drawable":-1},{"texture":-1,"prop_id":2,"drawable":-1},{"texture":-1,"prop_id":6,"drawable":-1},{"texture":-1,"prop_id":7,"drawable":-1}],"hair":{"texture":0,"highlight":0,"style":0,"color":0},"headBlend":{"shapeFirst":0,"shapeThird":0,"skinSecond":0,"skinFirst":0,"skinMix":0,"shapeMix":0,"shapeSecond":0,"thirdMix":0,"skinThird":0},"headOverlays":{"chestHair":{"color":0,"opacity":0,"style":0},"eyebrows":{"color":0,"opacity":0,"style":0},"blemishes":{"color":0,"opacity":0,"style":0},"ageing":{"color":0,"opacity":0,"style":0},"moleAndFreckles":{"color":0,"opacity":0,"style":0},"bodyBlemishes":{"color":0,"opacity":0,"style":0},"complexion":{"color":0,"opacity":0,"style":0},"lipstick":{"color":0,"opacity":0,"style":0},"beard":{"color":0,"opacity":0,"style":0},"sunDamage":{"color":0,"opacity":0,"style":0},"makeUp":{"color":0,"secondColor":0,"style":0,"opacity":0},"blush":{"color":0,"opacity":0,"style":0}},"model":"mp_m_freemode_01"}', 1),
	(12, 'QEZ87736', 'mp_f_freemode_01', '{"model":"mp_f_freemode_01","hair":{"color":3,"style":3,"texture":0,"highlight":0},"headBlend":{"skinMix":0,"shapeThird":0,"shapeSecond":0,"shapeMix":0,"skinSecond":0,"skinThird":0,"shapeFirst":0,"thirdMix":0,"skinFirst":40},"tattoos":[],"props":[{"prop_id":0,"drawable":9,"texture":0},{"prop_id":1,"drawable":4,"texture":5},{"prop_id":2,"drawable":-1,"texture":-1},{"prop_id":6,"drawable":2,"texture":0},{"prop_id":7,"drawable":-1,"texture":-1}],"headOverlays":{"lipstick":{"color":0,"opacity":0,"style":0},"sunDamage":{"color":0,"opacity":0,"style":0},"chestHair":{"color":0,"opacity":0,"style":0},"blemishes":{"color":0,"opacity":0,"style":0},"eyebrows":{"color":0,"opacity":1,"style":5},"complexion":{"color":0,"opacity":0,"style":0},"ageing":{"color":0,"opacity":0,"style":0},"bodyBlemishes":{"color":0,"opacity":0,"style":0},"makeUp":{"color":0,"opacity":0.1,"secondColor":0,"style":0},"beard":{"color":0,"opacity":0,"style":0},"blush":{"color":0,"opacity":0,"style":0},"moleAndFreckles":{"color":0,"opacity":0,"style":0}},"eyeColor":2,"faceFeatures":{"eyeBrownHigh":0,"noseWidth":-0.3,"eyesOpening":0,"chinBoneLowering":0,"neckThickness":0,"nosePeakLowering":0,"cheeksWidth":0,"eyeBrownForward":0,"chinBoneLenght":0,"noseBoneHigh":0,"jawBoneWidth":0,"lipsThickness":0,"cheeksBoneHigh":0,"nosePeakHigh":0,"chinBoneSize":0,"noseBoneTwist":0,"cheeksBoneWidth":0,"jawBoneBackSize":0,"nosePeakSize":0,"chinHole":0},"components":[{"texture":0,"drawable":0,"component_id":0},{"texture":0,"drawable":0,"component_id":1},{"texture":0,"drawable":3,"component_id":2},{"texture":0,"drawable":2,"component_id":3},{"texture":0,"drawable":0,"component_id":5},{"texture":0,"drawable":0,"component_id":7},{"texture":0,"drawable":15,"component_id":8},{"texture":0,"drawable":0,"component_id":9},{"texture":0,"drawable":0,"component_id":10},{"texture":8,"drawable":466,"component_id":11},{"texture":10,"drawable":23,"component_id":4},{"texture":1,"drawable":10,"component_id":6}]}', 1),
	(15, 'OGB23731', 'mp_m_freemode_01', '{"props":[{"texture":-1,"prop_id":0,"drawable":-1},{"texture":-1,"prop_id":1,"drawable":-1},{"texture":-1,"prop_id":2,"drawable":-1},{"texture":-1,"prop_id":6,"drawable":-1},{"texture":-1,"prop_id":7,"drawable":-1}],"tattoos":[],"headBlend":{"shapeFirst":0,"shapeMix":0,"shapeSecond":0,"skinSecond":0,"skinFirst":0,"skinMix":0,"thirdMix":0,"shapeThird":0,"skinThird":0},"model":"mp_m_freemode_01","faceFeatures":{"cheeksBoneWidth":0,"chinHole":0,"eyeBrownForward":0,"noseBoneTwist":0,"nosePeakSize":0,"noseWidth":0,"jawBoneWidth":0,"noseBoneHigh":0,"nosePeakHigh":0,"chinBoneSize":0,"nosePeakLowering":0,"chinBoneLowering":0,"lipsThickness":0,"chinBoneLenght":0,"cheeksWidth":0,"eyesOpening":0,"eyeBrownHigh":0,"neckThickness":0,"cheeksBoneHigh":0,"jawBoneBackSize":0},"eyeColor":-1,"headOverlays":{"blush":{"opacity":0,"style":0,"color":0},"chestHair":{"opacity":0,"style":0,"color":0},"beard":{"opacity":0,"style":0,"color":0},"blemishes":{"opacity":0,"style":0,"color":0},"bodyBlemishes":{"opacity":0,"style":0,"color":0},"makeUp":{"opacity":0,"color":0,"style":0,"secondColor":0},"moleAndFreckles":{"opacity":0,"style":0,"color":0},"lipstick":{"opacity":0,"style":0,"color":0},"sunDamage":{"opacity":0,"style":0,"color":0},"eyebrows":{"opacity":0,"style":0,"color":0},"complexion":{"opacity":0,"style":0,"color":0},"ageing":{"opacity":0,"style":0,"color":0}},"hair":{"texture":0,"color":0,"style":0,"highlight":0},"components":[{"texture":0,"drawable":0,"component_id":0},{"texture":0,"drawable":0,"component_id":1},{"texture":0,"drawable":0,"component_id":2},{"texture":0,"drawable":0,"component_id":3},{"texture":0,"drawable":0,"component_id":4},{"texture":0,"drawable":0,"component_id":5},{"texture":0,"drawable":0,"component_id":6},{"texture":0,"drawable":0,"component_id":7},{"texture":0,"drawable":0,"component_id":8},{"texture":0,"drawable":0,"component_id":9},{"texture":0,"drawable":0,"component_id":10},{"texture":0,"drawable":0,"component_id":11}]}', 1),
	(19, 'XGI09387', 'mp_m_freemode_01', '{"tattoos":[],"hair":{"highlight":0,"style":80,"color":0,"texture":0},"props":[{"prop_id":0,"drawable":7,"texture":0},{"prop_id":1,"drawable":-1,"texture":-1},{"prop_id":2,"drawable":-1,"texture":-1},{"prop_id":6,"drawable":-1,"texture":-1},{"prop_id":7,"drawable":-1,"texture":-1}],"headBlend":{"skinThird":0,"shapeMix":0,"shapeThird":0,"thirdMix":0,"skinSecond":0,"skinFirst":0,"skinMix":0,"shapeFirst":0,"shapeSecond":0},"model":"mp_m_freemode_01","faceFeatures":{"noseWidth":0,"cheeksBoneHigh":0,"nosePeakLowering":0,"eyeBrownHigh":0,"jawBoneBackSize":0,"nosePeakSize":0,"eyeBrownForward":0,"chinBoneLowering":0,"noseBoneHigh":0,"cheeksBoneWidth":0,"neckThickness":0,"cheeksWidth":0,"chinBoneSize":0,"noseBoneTwist":0,"lipsThickness":0,"chinHole":0,"chinBoneLenght":0,"eyesOpening":0,"nosePeakHigh":0,"jawBoneWidth":0},"headOverlays":{"eyebrows":{"color":0,"opacity":1,"style":17},"sunDamage":{"color":0,"opacity":0,"style":0},"ageing":{"color":0,"opacity":0.5,"style":0},"complexion":{"color":0,"opacity":0,"style":0},"blemishes":{"color":0,"opacity":0.4,"style":0},"makeUp":{"color":0,"secondColor":0,"opacity":0,"style":0},"chestHair":{"color":0,"opacity":0,"style":0},"lipstick":{"color":0,"opacity":0,"style":0},"moleAndFreckles":{"color":0,"opacity":0,"style":0},"bodyBlemishes":{"color":0,"opacity":0,"style":0},"blush":{"color":0,"opacity":0,"style":0},"beard":{"color":0,"opacity":0.4,"style":10}},"components":[{"texture":0,"drawable":0,"component_id":0},{"texture":0,"drawable":0,"component_id":1},{"texture":0,"drawable":80,"component_id":2},{"texture":0,"drawable":0,"component_id":4},{"texture":0,"drawable":0,"component_id":5},{"texture":0,"drawable":0,"component_id":6},{"texture":0,"drawable":0,"component_id":7},{"texture":0,"drawable":15,"component_id":8},{"texture":0,"drawable":0,"component_id":9},{"texture":0,"drawable":0,"component_id":10},{"texture":0,"drawable":0,"component_id":11},{"texture":0,"drawable":15,"component_id":3}],"eyeColor":0}', 1);

-- Dumping structure for table sgxcorev1.player_contacts
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.player_contacts: ~2 rows (approximately)
INSERT IGNORE INTO `player_contacts` (`id`, `citizenid`, `name`, `number`) VALUES
	(15, 'XGI09387', 'SGX FIvem', '5497175130'),
	(16, 'QEZ87736', 'SGX Fivem', '3898590096');

-- Dumping structure for table sgxcorev1.player_emotes
CREATE TABLE IF NOT EXISTS `player_emotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` varchar(50) DEFAULT NULL,
  `emote_category` varchar(255) NOT NULL,
  `emote_index` int(11) NOT NULL,
  `emote_type` varchar(255) NOT NULL,
  `emote_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table sgxcorev1.player_emotes: ~1 rows (approximately)
INSERT IGNORE INTO `player_emotes` (`id`, `player_id`, `emote_category`, `emote_index`, `emote_type`, `emote_value`) VALUES
	(20, 'XGI09387', 'placed', 1, 'favorite', 'chair');

-- Dumping structure for table sgxcorev1.player_houses
CREATE TABLE IF NOT EXISTS `player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `house` (`house`),
  KEY `citizenid` (`citizenid`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.player_houses: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.player_jobs
CREATE TABLE IF NOT EXISTS `player_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jobname` varchar(50) DEFAULT NULL,
  `employees` text DEFAULT NULL,
  `maxEmployee` tinyint(11) DEFAULT 15,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.player_jobs: ~25 rows (approximately)
INSERT IGNORE INTO `player_jobs` (`id`, `jobname`, `employees`, `maxEmployee`) VALUES
	(106, 'bennys', '{"BCO92693":{"cid":"BCO92693","grade":4,"name":"sssss ssssssssss"},"CLC04795":{"cid":"CLC04795","name":"SGX SGX","grade":4}}', 15),
	(107, 'taxi', '{"XGI09387":{"grade":0,"cid":"XGI09387","name":"SGX Fivem"}}', 15),
	(108, 'burgershot', '{"XGI09387":{"grade":4,"cid":"XGI09387","name":"SGX Fivem"},"KBN48829":{"grade":2,"cid":"KBN48829","name":"sas sasa"},"QEZ87736":{"cid":"QEZ87736","grade":3,"name":"SGX FIvem"},"ZQM42339":{"grade":2,"cid":"ZQM42339","name":"SGX Hunny"},"BCO92693":{"grade":4,"cid":"BCO92693","name":"sssss ssssssssss"}}', 15),
	(109, 'reporter', '{"XGI09387":{"cid":"XGI09387","name":"SGX Fivem","grade":0}}', 15),
	(110, 'mechanic2', '{"CLC04795":{"cid":"CLC04795","grade":4,"name":"SGX SGX"}}', 15),
	(111, 'vineyard', '{"XGI09387":{"grade":0,"cid":"XGI09387","name":"SGX Fivem"}}', 15),
	(112, 'pizzathis', '{"XGI09387":{"cid":"XGI09387","grade":4,"name":"SGX Fivem"},"CLC04795":{"cid":"CLC04795","grade":4,"name":"SGX SGX"},"ZQM42339":{"cid":"ZQM42339","grade":2,"name":"SGX Hunny"}}', 15),
	(113, 'trucker', '{"BCO92693":{"cid":"BCO92693","name":"sssss ssssssssss","grade":0}}', 15),
	(114, 'judge', '[]', 15),
	(115, 'beeker', '{"CLC04795":{"cid":"CLC04795","grade":4,"name":"SGX SGX"}}', 15),
	(116, 'realestate', '{"JIY91569":{"grade":4,"cid":"JIY91569","name":"Aa A"},"XGI09387":{"grade":4,"cid":"XGI09387","name":"SGX Fivem"},"KWX83656":{"grade":2,"cid":"KWX83656","name":"Hunny singh dhindhsa"},"BCO92693":{"grade":3,"cid":"BCO92693","name":"sssss ssssssssss"},"CLC04795":{"grade":4,"cid":"CLC04795","name":"SGX SGX"},"ZQM42339":{"grade":4,"cid":"ZQM42339","name":"SGX Hunny"}}', 15),
	(117, 'mechanic', '{"XGI09387":{"name":"SGX Fivem","cid":"XGI09387","grade":1},"CLC04795":{"name":"SGX SGX","cid":"CLC04795","grade":1},"BCO92693":{"name":"sssss ssssssssss","cid":"BCO92693","grade":4}}', 15),
	(118, 'taco', '[]', 15),
	(119, 'bus', '{"XGI09387":{"grade":0,"cid":"XGI09387","name":"SGX Fivem"}}', 15),
	(120, 'ambulance', '{"XGI09387":{"cid":"XGI09387","grade":4,"name":"SGX Fivem"},"KBN48829":{"grade":3,"cid":"KBN48829","name":"sas sasa"},"CLC04795":{"grade":4,"cid":"CLC04795","name":"SGX SGX"},"BCO92693":{"grade":4,"cid":"BCO92693","name":"sssss ssssssssss"},"QEZ87736":{"cid":"QEZ87736","grade":1,"name":"SGX FIvem"}}', 15),
	(121, 'garbage', '[]', 15),
	(122, 'mechanic3', '{"CLC04795":{"grade":4,"name":"SGX SGX","cid":"CLC04795"}}', 15),
	(123, 'lawyer', '[]', 15),
	(124, 'coolbeans', '{"XGI09387":{"grade":4,"cid":"XGI09387","name":"SGX Fivem"},"CLC04795":{"grade":4,"cid":"CLC04795","name":"SGX SGX"},"ZQM42339":{"grade":4,"cid":"ZQM42339","name":"SGX Hunny"},"BCO92693":{"grade":4,"cid":"BCO92693","name":"sssss ssssssssss"},"QEZ87736":{"cid":"QEZ87736","grade":3,"name":"SGX FIvem"}}', 15),
	(125, 'tow', '{"XGI09387":{"grade":0,"cid":"XGI09387","name":"SGX Fivem"}}', 15),
	(126, 'hotdog', '[]', 15),
	(127, 'cardealer', '{"QEZ87736":{"name":"SGX FIvem","grade":3,"cid":"QEZ87736"},"XGI09387":{"name":"SGX Fivem","grade":4,"cid":"XGI09387"}}', 15),
	(128, 'police', '{"KBN48829":{"name":"sas sasa","grade":4,"cid":"KBN48829"},"KWX83656":{"name":"Hunny singh dhindhsa","cid":"KWX83656","grade":2},"QEZ87736":{"name":"SGX FIvem","cid":"QEZ87736","grade":4},"CLC04795":{"name":"SGX SGX","cid":"CLC04795","grade":4},"XGI09387":{"name":"SGX Fivem","cid":"XGI09387","grade":11},"BCO92693":{"name":"sssss ssssssssss","cid":"BCO92693","grade":1},"JIY91569":{"name":"Aa A","cid":"JIY91569","grade":4},"ZQM42339":{"name":"SGX Hunny","cid":"ZQM42339","grade":1}}', 15),
	(129, 'bcso', '{"XGI09387":{"cid":"XGI09387","grade":4,"name":"SGX Fivem"},"CLC04795":{"cid":"CLC04795","grade":1,"name":"SGX SGX"},"BCO92693":{"cid":"BCO92693","grade":4,"name":"sssss ssssssssss"}}', 15),
	(130, 'sahp', '{"XGI09387":{"cid":"XGI09387","grade":15,"name":"SGX Fivem"},"CLC04795":{"cid":"CLC04795","grade":4,"name":"SGX SGX"},"BCO92693":{"cid":"BCO92693","grade":1,"name":"sssss ssssssssss"}}', 15);

-- Dumping structure for table sgxcorev1.player_mails
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.player_mails: ~5 rows (approximately)
INSERT IGNORE INTO `player_mails` (`id`, `citizenid`, `sender`, `subject`, `message`, `read`, `mailid`, `date`, `button`) VALUES
	(208, 'XGI09387', 'Pillbox Hospital', 'Hospital Costs', 'Dear Mr. Fivem, <br /><br />Hereby you received an email with the costs of the last hospital visit.<br />The final costs have become: <strong>$2000</strong><br /><br />We wish you a quick recovery!', 0, 114455, '2024-07-17 14:16:39', '[]'),
	(209, 'XGI09387', 'Tyrone', 'Repair', 'Your Pistol is repaired u can pick it up at the location. <br><br> Peace out madafaka', 0, 776474, '2024-07-17 16:46:42', NULL),
	(211, 'XGI09387', 'SGX', 'New Graphics Card', 'Congrats on the new graphics card. Make the most out of it, it is one profitable side hustle or buisness. Congrats, Johnny', 0, 430070, '2024-07-17 18:55:45', NULL),
	(212, 'XGI09387', 'Pawn Shop', 'Melting Items', 'We finished melting your items. You can come pick them up at any time.', 0, 583153, '2024-07-19 11:17:56', '[]'),
	(213, 'XGI09387', 'Larrys RV Sales', 'You have sold a vehicle!', 'You made $8 from the sale of your 10F.', 0, 502408, '2024-07-19 11:52:09', NULL),
	(214, 'XGI09387', 'Pawn Shop', 'Melting Items', 'We finished melting your items. You can come pick them up at any time.', 0, 470072, '2024-07-19 12:32:48', '[]');

-- Dumping structure for table sgxcorev1.player_outfits
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid_outfitname_model` (`citizenid`,`outfitname`,`model`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.player_outfits: ~1 rows (approximately)
INSERT IGNORE INTO `player_outfits` (`id`, `citizenid`, `outfitname`, `model`, `props`, `components`) VALUES
	(30, 'XGI09387', 'SGX', 'mp_m_freemode_01', '[{"drawable":-1,"prop_id":0,"texture":-1},{"drawable":-1,"prop_id":1,"texture":-1},{"drawable":-1,"prop_id":2,"texture":-1},{"drawable":-1,"prop_id":6,"texture":-1},{"drawable":-1,"prop_id":7,"texture":-1}]', '[{"texture":0,"drawable":0,"component_id":0},{"texture":0,"drawable":0,"component_id":1},{"texture":0,"drawable":80,"component_id":2},{"texture":0,"drawable":11,"component_id":3},{"texture":2,"drawable":209,"component_id":4},{"texture":0,"drawable":132,"component_id":5},{"texture":0,"drawable":202,"component_id":6},{"texture":0,"drawable":283,"component_id":7},{"texture":0,"drawable":15,"component_id":8},{"texture":0,"drawable":0,"component_id":9},{"texture":0,"drawable":0,"component_id":10},{"texture":0,"drawable":509,"component_id":11}]');

-- Dumping structure for table sgxcorev1.player_quick_emotes
CREATE TABLE IF NOT EXISTS `player_quick_emotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` varchar(255) NOT NULL,
  `keybinds` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  `emote_index` int(11) NOT NULL,
  `pQuickEmote` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.player_quick_emotes: ~77 rows (approximately)
INSERT IGNORE INTO `player_quick_emotes` (`id`, `player_id`, `keybinds`, `category`, `emote_index`, `pQuickEmote`) VALUES
	(48, 'ZQM42339', 0, 'emotes', 399, 'embrace'),
	(49, 'ZQM42339', 1, 'synced', 9, 'highfive'),
	(50, 'ZQM42339', 2, 'emotes', 386, 'flip'),
	(51, 'ZQM42339', 3, 'emotes', 387, 'slide'),
	(52, 'ZQM42339', 4, 'emotes', 380, 'passout3'),
	(53, 'ZQM42339', 5, 'emotes', 368, 'whistle'),
	(54, 'ZQM42339', 6, 'emotes', 362, 'wave'),
	(55, 'BCO92693', 0, 'dances', 50, ''),
	(56, 'BCO92693', 1, 'dances', 51, ''),
	(57, 'BCO92693', 2, 'dances', 52, ''),
	(58, 'BCO92693', 3, 'dances', 53, ''),
	(59, 'BCO92693', 5, 'dances', 55, ''),
	(60, 'BCO92693', 4, 'dances', 54, ''),
	(61, 'BCO92693', 6, 'dances', 56, ''),
	(62, 'KWX83656', 0, 'emotes', 399, 'wait'),
	(63, 'KWX83656', 1, 'emotes', 393, 'bow'),
	(64, 'KWX83656', 2, 'emotes', 386, 'flip'),
	(65, 'KWX83656', 3, 'emotes', 387, 'slide'),
	(66, 'KWX83656', 4, 'emotes', 380, 'passout3'),
	(67, 'KWX83656', 5, 'emotes', 368, 'whistle'),
	(68, 'KWX83656', 6, 'emotes', 362, 'wave'),
	(69, 'KBN48829', 0, 'emotes', 399, 'wait'),
	(70, 'KBN48829', 1, 'emotes', 393, 'bow'),
	(71, 'KBN48829', 3, 'emotes', 387, 'slide'),
	(72, 'KBN48829', 2, 'emotes', 386, 'flip'),
	(73, 'KBN48829', 4, 'emotes', 380, 'passout3'),
	(74, 'KBN48829', 5, 'emotes', 368, 'whistle'),
	(75, 'KBN48829', 6, 'emotes', 362, 'wave'),
	(76, 'KGK90411', 0, 'emotes', 399, 'wait'),
	(77, 'KGK90411', 2, 'emotes', 386, 'flip'),
	(78, 'KGK90411', 1, 'emotes', 393, 'bow'),
	(79, 'KGK90411', 3, 'emotes', 387, 'slide'),
	(80, 'KGK90411', 4, 'emotes', 380, 'passout3'),
	(81, 'KGK90411', 5, 'emotes', 368, 'whistle'),
	(82, 'KGK90411', 6, 'emotes', 362, 'wave'),
	(83, 'VCK03588', 0, 'emotes', 399, 'wait'),
	(84, 'VCK03588', 1, 'emotes', 393, 'bow'),
	(85, 'VCK03588', 2, 'emotes', 386, 'flip'),
	(86, 'VCK03588', 3, 'emotes', 387, 'slide'),
	(87, 'VCK03588', 4, 'emotes', 380, 'passout3'),
	(88, 'VCK03588', 5, 'emotes', 368, 'whistle'),
	(89, 'VCK03588', 6, 'emotes', 362, 'wave'),
	(90, 'CLC04795', 0, 'dances', 15, ''),
	(91, 'CLC04795', 1, 'dances', 2, ''),
	(92, 'CLC04795', 3, 'dances', 18, ''),
	(93, 'CLC04795', 4, 'dances', 19, ''),
	(94, 'CLC04795', 5, 'dances', 20, ''),
	(95, 'CLC04795', 2, 'dances', 17, ''),
	(96, 'CLC04795', 6, 'dances', 21, ''),
	(97, 'JIY91569', 0, 'emotes', 399, 'wait'),
	(98, 'JIY91569', 2, 'emotes', 386, 'flip'),
	(99, 'JIY91569', 1, 'emotes', 393, 'bow'),
	(100, 'JIY91569', 3, 'emotes', 387, 'slide'),
	(101, 'JIY91569', 4, 'emotes', 380, 'passout3'),
	(102, 'JIY91569', 5, 'emotes', 368, 'whistle'),
	(103, 'JIY91569', 6, 'emotes', 362, 'wave'),
	(104, 'TDN82412', 0, 'emotes', 399, 'wait'),
	(105, 'TDN82412', 2, 'emotes', 386, 'flip'),
	(106, 'TDN82412', 1, 'emotes', 393, 'bow'),
	(107, 'TDN82412', 3, 'emotes', 387, 'slide'),
	(108, 'TDN82412', 4, 'emotes', 380, 'passout3'),
	(109, 'TDN82412', 5, 'emotes', 368, 'whistle'),
	(110, 'TDN82412', 6, 'emotes', 362, 'wave'),
	(111, 'QEZ87736', 0, 'emotes', 399, 'wait'),
	(112, 'QEZ87736', 1, 'emotes', 393, 'bow'),
	(113, 'QEZ87736', 2, 'emotes', 386, 'flip'),
	(114, 'QEZ87736', 3, 'emotes', 387, 'slide'),
	(115, 'QEZ87736', 4, 'emotes', 380, 'passout3'),
	(116, 'QEZ87736', 5, 'emotes', 368, 'whistle'),
	(117, 'QEZ87736', 6, 'emotes', 362, 'wave'),
	(118, 'XGI09387', 0, 'emotes', 399, 'wait'),
	(119, 'XGI09387', 1, 'emotes', 393, 'bow'),
	(120, 'XGI09387', 2, 'emotes', 386, 'flip'),
	(121, 'XGI09387', 3, 'emotes', 387, 'slide'),
	(122, 'XGI09387', 4, 'emotes', 380, 'passout3'),
	(123, 'XGI09387', 5, 'emotes', 368, 'whistle'),
	(124, 'XGI09387', 6, 'emotes', 362, 'wave'),
	(125, 'OGB23731', 0, 'emotes', 399, 'wait'),
	(126, 'OGB23731', 2, 'emotes', 386, 'flip'),
	(127, 'OGB23731', 1, 'emotes', 393, 'bow'),
	(128, 'OGB23731', 3, 'emotes', 387, 'slide'),
	(129, 'OGB23731', 4, 'emotes', 380, 'passout3'),
	(130, 'OGB23731', 5, 'emotes', 368, 'whistle'),
	(131, 'OGB23731', 6, 'emotes', 362, 'wave'),
	(132, 'IOV40313', 0, 'emotes', 399, 'wait'),
	(133, 'IOV40313', 1, 'emotes', 393, 'bow'),
	(134, 'IOV40313', 3, 'emotes', 387, 'slide'),
	(135, 'IOV40313', 2, 'emotes', 386, 'flip'),
	(136, 'IOV40313', 4, 'emotes', 380, 'passout3'),
	(137, 'IOV40313', 5, 'emotes', 368, 'whistle'),
	(138, 'IOV40313', 6, 'emotes', 362, 'wave');

-- Dumping structure for table sgxcorev1.player_vehicles
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `citizenid` varchar(11) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(8) NOT NULL,
  `fakeplate` varchar(8) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  `paymentamount` int(11) NOT NULL DEFAULT 0,
  `paymentsleft` int(11) NOT NULL DEFAULT 0,
  `financetime` int(11) NOT NULL DEFAULT 0,
  `logs` longtext DEFAULT '[]',
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.player_vehicles: ~25 rows (approximately)
INSERT IGNORE INTO `player_vehicles` (`id`, `license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `fakeplate`, `garage`, `fuel`, `engine`, `body`, `state`, `depotprice`, `drivingdistance`, `status`, `balance`, `paymentamount`, `paymentsleft`, `financetime`, `logs`) VALUES
	(50, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'tenf', '-893984159', '{"interiorColor":37,"dirtLevel":0.0,"modSpoilers":-1,"modKit21":-1,"modEngineBlock":-1,"tankHealth":1000.0592475178704,"wheelColor":0,"modSteeringWheel":-1,"modTank":-1,"modTrimB":-1,"modBackWheels":-1,"pearlescentColor":4,"neonEnabled":[false,false,false,false],"modSpeakers":-1,"modWindows":-1,"modKit19":-1,"modHydrolic":-1,"xenonColor":255,"modSmokeEnabled":false,"wheelWidth":1.0,"modPlateHolder":-1,"modHood":-1,"modEngine":-1,"wheels":7,"modDial":-1,"extras":[],"modSeats":-1,"modFrontWheels":-1,"engineHealth":1000.0592475178704,"plateIndex":0,"color1":19,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modRoof":-1,"oilLevel":4.76596940834568,"plate":"42SIK520","modXenon":false,"modCustomTiresF":false,"modKit47":-1,"modAPlate":-1,"neonColor":[255,255,255],"modOrnaments":-1,"modKit17":-1,"windowTint":-1,"wheelSize":1.0,"modRightFender":-1,"modGrille":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrontBumper":-1,"modTransmission":-1,"modFender":-1,"modSideSkirt":-1,"modRearBumper":-1,"modFrame":-1,"modArmor":-1,"color2":0,"modBrakes":-1,"tyreSmokeColor":[255,255,255],"modHorns":-1,"fuelLevel":92.14207522801665,"dashboardColor":156,"modTurbo":false,"modTrunk":-1,"modAerials":-1,"model":-893984159,"modArchCover":-1,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modSuspension":-1,"modLivery":-1,"modKit49":-1,"modVanityPlate":-1,"liveryRoof":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modDoorSpeaker":-1,"bodyHealth":1000.0592475178704,"windowStatus":{"1":true,"2":false,"3":false,"4":false,"5":false,"6":true,"7":true,"0":true},"modShifterLeavers":-1,"modAirFilter":-1,"modStruts":-1,"modDashboard":-1,"modExhaust":-1,"modCustomTiresR":false,"modTrimA":-1}', '42SIK520', NULL, '5', 92, 1000, 1000, 1, 0, NULL, '{"axle":100,"brakes":98,"clutch":100,"fuel":100,"radiator":100}', 0, 0, 0, 0, '[{"garage":"Pillbox Garage Parking","time":"2024-06-23-14:27","type":"Stored"},{"garage":"Pillbox Garage Parking","time":"2024-06-23-14:27","type":"Take Out"},{"garage":"West Mirror Drive5 Garage","time":"2024-06-23-15:34","type":"Stored"},{"garage":"West Mirror Drive5 Garage","time":"2024-06-23-15:37","type":"Take Out"},{"garage":"West Mirror Drive5 Garage","time":"2024-06-23-15:46","type":"Stored"},{"garage":"West Mirror Drive5 Garage","time":"2024-06-23-15:50","type":"Take Out"}]'),
	(51, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'tenf', '-893984159', '{"modArmor":-1,"tyres":[],"color1":19,"modDashboard":-1,"modEngineBlock":-1,"modFender":-1,"tankHealth":1000,"wheelSize":0.0,"modRearBumper":-1,"modPlateHolder":-1,"modStruts":-1,"modLightbar":-1,"modShifterLeavers":-1,"modLivery":-1,"windowTint":-1,"paintType2":0,"modSpeakers":-1,"modRoof":-1,"neonEnabled":[false,false,false,false],"bulletProofTyres":true,"modAirFilter":-1,"modFrontBumper":-1,"driftTyres":false,"modWindows":-1,"modBackWheels":-1,"modSideSkirt":-1,"pearlescentColor":4,"modExhaust":-1,"plateIndex":0,"color2":0,"modTrimB":-1,"modVanityPlate":-1,"bodyHealth":1000,"modCustomTiresR":false,"modSubwoofer":-1,"modSuspension":-1,"modTank":-1,"wheelWidth":0.0,"extras":[],"modFrame":-1,"tyreSmokeColor":[255,255,255],"xenonColor":255,"doors":[],"interiorColor":37,"modTransmission":-1,"fuelLevel":80,"modSeats":-1,"oilLevel":5,"modRightFender":-1,"modAerials":-1,"wheelColor":0,"modAPlate":-1,"modDoorR":-1,"modCustomTiresF":false,"modNitrous":-1,"modHydraulics":false,"modXenon":false,"modDial":-1,"paintType1":0,"modGrille":-1,"modArchCover":-1,"model":-893984159,"modHydrolic":-1,"windows":[2,3,4,5],"modHood":-1,"plate":"23XXF009","modTrunk":-1,"modSmokeEnabled":false,"dashboardColor":156,"modSpoilers":-1,"modFrontWheels":-1,"modBrakes":-1,"modOrnaments":-1,"modDoorSpeaker":-1,"neonColor":[255,255,255],"wheels":7,"modRoofLivery":-1,"dirtLevel":0,"modEngine":-1,"modTurbo":false,"modTrimA":-1,"modHorns":-1,"engineHealth":1000,"modSteeringWheel":-1}', '23XXF009', NULL, NULL, 80, 1000, 1000, 1, 0, NULL, '{"axle":100,"clutch":100,"fuel":100,"brakes":100,"radiator":100}', 0, 0, 0, 0, '[{"garage":"Depot Lot","type":"Take Depot","time":"2024-07-06-03:53"}]'),
	(52, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'cypher', '1755697647', '{"modArmor":-1,"tyres":[],"color1":20,"modDashboard":-1,"modEngineBlock":-1,"modFender":-1,"tankHealth":1000,"wheelSize":0.0,"modRearBumper":-1,"modPlateHolder":-1,"modStruts":-1,"modLightbar":-1,"modShifterLeavers":-1,"modLivery":-1,"windowTint":-1,"paintType2":0,"modSpeakers":-1,"modRoof":-1,"neonEnabled":[false,false,false,false],"bulletProofTyres":true,"modAirFilter":-1,"modFrontBumper":-1,"driftTyres":false,"modWindows":-1,"modBackWheels":-1,"modSideSkirt":-1,"pearlescentColor":5,"modExhaust":-1,"plateIndex":0,"color2":36,"modTrimB":-1,"modVanityPlate":-1,"bodyHealth":1000,"modCustomTiresR":false,"modSubwoofer":-1,"modSuspension":-1,"modTank":-1,"wheelWidth":0.0,"extras":[],"modFrame":-1,"tyreSmokeColor":[255,255,255],"xenonColor":255,"doors":[],"interiorColor":27,"modTransmission":-1,"fuelLevel":46,"modSeats":-1,"oilLevel":7,"modRightFender":-1,"modAerials":-1,"wheelColor":134,"modAPlate":-1,"modDoorR":-1,"modCustomTiresF":false,"modNitrous":-1,"modHydraulics":false,"modXenon":false,"modDial":-1,"paintType1":0,"modGrille":-1,"modArchCover":-1,"model":1755697647,"modHydrolic":-1,"windows":[4,5],"modHood":-1,"plate":"61JGI512","modTrunk":-1,"modSmokeEnabled":false,"dashboardColor":156,"modSpoilers":-1,"modFrontWheels":-1,"modBrakes":-1,"modOrnaments":-1,"modDoorSpeaker":-1,"neonColor":[255,255,255],"wheels":7,"modRoofLivery":-1,"dirtLevel":0,"modEngine":-1,"modTurbo":false,"modTrimA":-1,"modHorns":-1,"engineHealth":1000,"modSteeringWheel":-1}', '61JGI512', NULL, NULL, 45, 1000, 1000, 1, 0, NULL, '{"clutch":100,"fuel":100,"brakes":100,"radiator":100,"axle":100}', 0, 0, 0, 0, '[{"garage":"Depot Lot","type":"Take Depot","time":"2024-07-06-03:53"}]'),
	(53, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'sheriff', '-1683328900', '{"modArmor":-1,"tyres":[],"color1":111,"modDashboard":-1,"modEngineBlock":-1,"modFender":-1,"tankHealth":1000,"wheelSize":0.0,"modRearBumper":-1,"modPlateHolder":-1,"modStruts":-1,"modLightbar":-1,"modShifterLeavers":-1,"modLivery":2,"windowTint":-1,"paintType2":0,"modSpeakers":-1,"modRoof":-1,"neonEnabled":[false,false,false,false],"bulletProofTyres":true,"modAirFilter":-1,"modFrontBumper":-1,"driftTyres":false,"modWindows":-1,"modBackWheels":-1,"modSideSkirt":-1,"pearlescentColor":0,"modExhaust":-1,"plateIndex":4,"color2":111,"modTrimB":-1,"modVanityPlate":-1,"bodyHealth":1000,"modCustomTiresR":false,"modSubwoofer":-1,"modSuspension":-1,"modTank":-1,"wheelWidth":0.0,"extras":[1,0],"modFrame":-1,"tyreSmokeColor":[255,255,255],"xenonColor":255,"doors":[],"interiorColor":0,"modTransmission":-1,"fuelLevel":40,"modSeats":-1,"oilLevel":5,"modRightFender":-1,"modAerials":-1,"wheelColor":156,"modAPlate":-1,"modDoorR":-1,"modCustomTiresF":false,"modNitrous":-1,"modHydraulics":false,"modXenon":false,"modDial":-1,"paintType1":0,"modGrille":-1,"modArchCover":-1,"model":-1683328900,"modHydrolic":-1,"windows":[4,5],"modHood":-1,"plate":"89PCK352","modTrunk":-1,"modSmokeEnabled":false,"dashboardColor":0,"modSpoilers":-1,"modFrontWheels":-1,"modBrakes":-1,"modOrnaments":-1,"modDoorSpeaker":-1,"neonColor":[255,255,255],"wheels":1,"modRoofLivery":-1,"dirtLevel":0,"modEngine":-1,"modTurbo":false,"modTrimA":-1,"modHorns":-1,"engineHealth":1000,"modSteeringWheel":-1}', '89PCK352', NULL, NULL, 40, 1000, 1000, 1, 0, NULL, '{"clutch":100,"fuel":100,"brakes":100,"radiator":100,"axle":100}', 0, 0, 0, 0, '[{"garage":"Depot Lot","type":"Take Depot","time":"2024-07-06-03:53"}]'),
	(54, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'asbo', '1118611807', '{"modKit17":-1,"dashboardColor":160,"modTrunk":-1,"modTank":-1,"modEngineBlock":-1,"modHood":-1,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modSideSkirt":-1,"modArchCover":-1,"modSeats":-1,"modGrille":-1,"modRearBumper":-1,"fuelLevel":96.11371640163806,"engineHealth":997.6762628136975,"modFrontBumper":-1,"wheels":5,"modDoorSpeaker":-1,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"modSpoilers":-1,"tireHealth":{"1":1000.0,"2":999.75,"3":1000.0,"0":1000.0},"modTrimB":-1,"modOrnaments":-1,"modPlateHolder":-1,"modExhaust":-1,"modWindows":-1,"modDial":-1,"modCustomTiresF":false,"modAerials":-1,"modSuspension":-1,"modSpeakers":-1,"color1":29,"modLivery":-1,"modHydrolic":-1,"modXenon":false,"tankHealth":999.2649192831461,"wheelWidth":0.0,"plate":"4AS278LZ","modFender":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modEngine":-1,"modBackWheels":-1,"bodyHealth":998.4705910484217,"neonColor":[255,255,255],"modKit21":-1,"modRoof":-1,"modBrakes":-1,"neonEnabled":[false,false,false,false],"modArmor":-1,"modAPlate":-1,"modFrame":-1,"modFrontWheels":-1,"modKit19":-1,"modShifterLeavers":-1,"oilLevel":4.76596940834568,"tyreSmokeColor":[255,255,255],"modDashboard":-1,"plateIndex":0,"modTurbo":false,"liveryRoof":-1,"wheelSize":0.0,"modSmokeEnabled":false,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"dirtLevel":0.0,"modSteeringWheel":-1,"pearlescentColor":138,"extras":[],"interiorColor":3,"color2":111,"modStruts":-1,"modTransmission":-1,"modRightFender":-1,"modVanityPlate":-1,"model":1118611807,"windowTint":-1,"xenonColor":255,"modKit47":-1,"modKit49":-1,"wheelColor":156,"modTrimA":-1,"modHorns":-1,"modAirFilter":-1,"modCustomTiresR":false}', '4AS278LZ', NULL, 'motelgarage', 97, 998, 999, 1, 0, NULL, '{"axle":100,"clutch":100,"fuel":100,"radiator":100,"brakes":100}', 0, 0, 0, 0, '[{"type":"Stored","time":"2024-06-25-12:07","garage":"Motel Parking"},{"type":"Stored","time":"2024-06-25-12:07","garage":"Motel Parking"},{"type":"Stored","time":"2024-06-25-12:07","garage":"Motel Parking"}]'),
	(55, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'blista3', '-591651781', '{"xenonColor":255,"engineHealth":1000.0592475178704,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"modExhaust":-1,"color1":134,"modHorns":-1,"modDoorSpeaker":-1,"modTank":-1,"modSideSkirt":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modShifterLeavers":-1,"liveryRoof":-1,"modArchCover":-1,"bodyHealth":1000.0592475178704,"modBackWheels":-1,"pearlescentColor":134,"modRoof":-1,"modDial":-1,"modWindows":-1,"modFender":-1,"modArmor":-1,"modTrunk":-1,"modSteeringWheel":-1,"modSuspension":-1,"modGrille":-1,"modLivery":-1,"wheelWidth":1.0,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"extras":{"2":true},"modTransmission":-1,"modPlateHolder":-1,"modAirFilter":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modCustomTiresF":false,"modRightFender":-1,"modHood":-1,"neonColor":[255,255,255],"fuelLevel":98.4967011058109,"modEngineBlock":-1,"modSpoilers":-1,"modFrontBumper":-1,"modTurbo":false,"model":-591651781,"interiorColor":0,"wheelColor":126,"modKit21":-1,"modTrimA":-1,"modSmokeEnabled":false,"modSeats":-1,"modAerials":-1,"color2":134,"modAPlate":-1,"wheelSize":1.0,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrontWheels":-1,"plate":"1EK227OI","modBrakes":-1,"tyreSmokeColor":[255,255,255],"plateIndex":0,"wheels":5,"modSpeakers":-1,"modOrnaments":-1,"modKit47":-1,"modFrame":-1,"neonEnabled":[false,false,false,false],"tankHealth":1000.0592475178704,"modHydrolic":-1,"modRearBumper":-1,"modTrimB":-1,"modVanityPlate":-1,"dirtLevel":3.9716411736214,"dashboardColor":0,"windowTint":-1,"modKit19":-1,"modDashboard":-1,"modCustomTiresR":false,"modKit49":-1,"modStruts":-1,"oilLevel":4.76596940834568,"modKit17":-1,"modXenon":false,"modEngine":-1}', '1EK227OI', NULL, 'pillboxgarage', 99, 1001, 1001, 1, 0, NULL, '{"radiator":98,"clutch":100,"fuel":100,"brakes":100,"axle":100}', 0, 0, 0, 0, '[{"type":"Take Out","time":"2024-07-06-04:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-04:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-04:29","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:10","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:27","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:27","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:27","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:28","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:28","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:29","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:30","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:30","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:30","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:30","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:30","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:30","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:30","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:30","garage":"Pillbox Garage Parking"}]'),
	(56, 'license:615cd127368c5800a4a41ca27970b1e8048a0e4f', 'QEZ87736', 'issi3', '931280609', '{}', '1FR754VR', NULL, 'pillboxgarage', 100, 1000, 1000, 1, 0, NULL, '{"axle":100,"fuel":100,"clutch":100,"brakes":100,"radiator":100}', 0, 0, 0, 0, '[]'),
	(57, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'blista', '-344943009', '{"modArchCover":-1,"oilLevel":4.76596940834568,"modDial":-1,"dashboardColor":0,"modFrame":-1,"xenonColor":255,"modHydrolic":-1,"model":-344943009,"modAerials":-1,"modRoof":-1,"modKit19":-1,"modEngineBlock":-1,"modFrontWheels":-1,"modSpoilers":-1,"wheels":0,"modGrille":-1,"dirtLevel":2.38298470417284,"tyreSmokeColor":[255,255,255],"modHood":-1,"modKit49":-1,"modOrnaments":-1,"wheelWidth":0.0,"modTrunk":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modRightFender":-1,"modKit17":-1,"pearlescentColor":5,"modSuspension":-1,"modHorns":-1,"bodyHealth":1000.0592475178704,"neonEnabled":[false,false,false,false],"modCustomTiresR":false,"modSideSkirt":-1,"modFender":-1,"color1":7,"modCustomTiresF":false,"extras":{"10":true,"12":false},"plateIndex":0,"wheelColor":156,"liveryRoof":-1,"modTrimB":-1,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modSpeakers":-1,"tankHealth":1000.0592475178704,"modTrimA":-1,"fuelLevel":97.70237287108663,"modTurbo":false,"interiorColor":0,"modPlateHolder":-1,"wheelSize":0.0,"modEngine":-1,"modSeats":-1,"modArmor":-1,"modKit21":-1,"windowTint":-1,"modStruts":-1,"modExhaust":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modTank":-1,"modSmokeEnabled":false,"engineHealth":1000.0592475178704,"modTransmission":-1,"modRearBumper":-1,"modAirFilter":-1,"plate":"0LY424YA","modLivery":-1,"modXenon":false,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modAPlate":-1,"modBrakes":-1,"modSteeringWheel":-1,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"modKit47":-1,"modWindows":-1,"modDoorSpeaker":-1,"modDashboard":-1,"color2":0,"neonColor":[255,255,255],"modBackWheels":-1,"modShifterLeavers":-1,"modVanityPlate":-1,"modFrontBumper":-1}', '0LY424YA', NULL, 'motelgarage', 98, 1000, 1000, 1, 0, NULL, '{"axle":100,"fuel":100,"clutch":100,"brakes":99,"radiator":99}', 0, 0, 0, 0, '[{"type":"Stored","garage":"Motel Parking","time":"2024-06-30-13:08"}]'),
	(58, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'asbo', '1118611807', '{"modArchCover":-1,"oilLevel":4.76596940834568,"modDial":-1,"dashboardColor":160,"modFrame":-1,"xenonColor":255,"modHydrolic":-1,"model":1118611807,"modAerials":-1,"modRoof":-1,"modKit19":-1,"modEngineBlock":-1,"modFrontWheels":-1,"modSpoilers":-1,"wheels":5,"modGrille":-1,"dirtLevel":0.0,"tyreSmokeColor":[255,255,255],"modHood":-1,"modKit49":-1,"modOrnaments":-1,"wheelWidth":0.0,"modTrunk":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modRightFender":-1,"modKit17":-1,"pearlescentColor":138,"modSuspension":-1,"modHorns":-1,"bodyHealth":1000.0592475178704,"neonEnabled":[false,false,false,false],"modCustomTiresR":false,"modSideSkirt":-1,"modFender":-1,"color1":53,"modCustomTiresF":false,"extras":[],"plateIndex":0,"wheelColor":156,"liveryRoof":-1,"modTrimB":-1,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modSpeakers":-1,"tankHealth":1000.0592475178704,"modTrimA":-1,"fuelLevel":96.90804463636234,"modTurbo":false,"interiorColor":3,"modPlateHolder":-1,"wheelSize":0.0,"modEngine":-1,"modSeats":-1,"modArmor":-1,"modKit21":-1,"windowTint":-1,"modStruts":-1,"modExhaust":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modTank":-1,"modSmokeEnabled":false,"engineHealth":1000.0592475178704,"modTransmission":-1,"modRearBumper":-1,"modAirFilter":-1,"plate":"9TZ509GU","modLivery":-1,"modXenon":false,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modAPlate":-1,"modBrakes":-1,"modSteeringWheel":-1,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"modKit47":-1,"modWindows":-1,"modDoorSpeaker":-1,"modDashboard":-1,"color2":111,"neonColor":[255,255,255],"modBackWheels":-1,"modShifterLeavers":-1,"modVanityPlate":-1,"modFrontBumper":-1}', '9TZ509GU', NULL, 'motelgarage', 97, 1000, 1000, 1, 0, NULL, '{"axle":100,"fuel":100,"clutch":100,"brakes":100,"radiator":100}', 0, 0, 0, 0, '[{"type":"Stored","garage":"Motel Parking","time":"2024-06-30-13:10"}]'),
	(59, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'buccaneer2', '-1013450936', '{}', '5PM216GG', NULL, 'pillboxgarage', 100, 1000, 1000, 1, 0, NULL, '{"radiator":100,"clutch":100,"fuel":100,"brakes":100,"axle":100}', 0, 0, 0, 0, '[{"type":"Take Out","time":"2024-07-10-17:28","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:28","garage":"Pillbox Garage Parking"}]'),
	(60, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'bullet', '-1696146015', '{"modArchCover":-1,"oilLevel":7.14895411251853,"modDial":-1,"dashboardColor":0,"modFrame":-1,"xenonColor":255,"modHydrolic":-1,"model":-1696146015,"modAerials":-1,"modRoof":-1,"modKit19":-1,"modEngineBlock":-1,"modFrontWheels":-1,"modSpoilers":-1,"wheels":7,"modGrille":-1,"dirtLevel":6.35462587779425,"tyreSmokeColor":[255,255,255],"modHood":-1,"modKit49":-1,"modOrnaments":-1,"wheelWidth":0.0,"modTrunk":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modRightFender":-1,"modKit17":-1,"pearlescentColor":111,"modSuspension":-1,"modHorns":-1,"bodyHealth":1000.0592475178704,"neonEnabled":[false,false,false,false],"modCustomTiresR":false,"modSideSkirt":-1,"modFender":-1,"color1":67,"modCustomTiresF":false,"extras":[],"plateIndex":0,"wheelColor":156,"liveryRoof":-1,"modTrimB":-1,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modSpeakers":-1,"tankHealth":1000.0592475178704,"modTrimA":-1,"fuelLevel":97.70237287108663,"modTurbo":false,"interiorColor":0,"modPlateHolder":-1,"wheelSize":0.0,"modEngine":-1,"modSeats":-1,"modArmor":-1,"modKit21":-1,"windowTint":-1,"modStruts":-1,"modExhaust":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modTank":-1,"modSmokeEnabled":false,"engineHealth":1000.0592475178704,"modTransmission":-1,"modRearBumper":-1,"modAirFilter":-1,"plate":"3ZJ164WI","modLivery":-1,"modXenon":false,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modAPlate":-1,"modBrakes":-1,"modSteeringWheel":-1,"windowStatus":{"1":true,"2":false,"3":false,"4":false,"5":false,"6":true,"7":false,"0":true},"modKit47":-1,"modWindows":-1,"modDoorSpeaker":-1,"modDashboard":-1,"color2":88,"neonColor":[255,255,255],"modBackWheels":-1,"modShifterLeavers":-1,"modVanityPlate":-1,"modFrontBumper":-1}', '3ZJ164WI', NULL, 'motelgarage', 98, 1000, 1000, 1, 0, NULL, '{"axle":100,"fuel":100,"clutch":100,"brakes":100,"radiator":100}', 0, 0, 0, 0, '[{"type":"Stored","garage":"Motel Parking","time":"2024-06-30-13:11"},{"type":"Take Out","garage":"Motel Parking","time":"2024-06-30-13:12"}]'),
	(61, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'sl63amg22', '1501052543', '{"modWindows":-1,"modKit47":-1,"tyreSmokeColor":[255,255,255],"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrame":-1,"modArmor":-1,"tankHealth":998.4705910484217,"modSuspension":-1,"fuelLevel":97.70237287108663,"modVanityPlate":-1,"modCustomTiresF":false,"wheelColor":5,"modTrimB":-1,"modHorns":-1,"modTrimA":-1,"plate":"05JEV483","modTrunk":-1,"bodyHealth":988.9386522317304,"modSteeringWheel":-1,"engineHealth":983.3783545886605,"dirtLevel":0.0,"plateIndex":0,"wheelSize":1.0,"modPlateHolder":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modGrille":-1,"modFender":-1,"modAirFilter":-1,"modXenon":false,"modSeats":-1,"interiorColor":0,"model":1501052543,"modKit49":-1,"modHood":-1,"modKit19":-1,"neonColor":[255,255,255],"modDoorSpeaker":-1,"modHydrolic":-1,"modFrontBumper":-1,"modEngine":-1,"modShifterLeavers":-1,"modRightFender":-1,"modRoof":-1,"modTransmission":-1,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"modBrakes":-1,"modKit17":-1,"modSpeakers":-1,"pearlescentColor":0,"modExhaust":-1,"dashboardColor":0,"wheelWidth":1.0,"modTank":-1,"modKit21":-1,"modDashboard":-1,"modFrontWheels":-1,"modAPlate":-1,"modBackWheels":-1,"modRearBumper":-1,"modAerials":-1,"modArchCover":-1,"modSpoilers":-1,"modSideSkirt":-1,"neonEnabled":[false,false,false,false],"modEngineBlock":-1,"modSmokeEnabled":false,"xenonColor":255,"wheels":7,"oilLevel":4.76596940834568,"color2":0,"modDial":-1,"extras":{"5":false,"3":false,"4":false,"1":true,"2":false},"windowTint":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"liveryRoof":-1,"modOrnaments":-1,"modStruts":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"color1":28,"modLivery":-1,"modCustomTiresR":false,"modTurbo":false}', '05JEV483', NULL, 'pillboxgarage', 98, 984, 989, 1, 0, NULL, '{"brakes":100,"axle":100,"clutch":100,"fuel":100,"radiator":100}', 0, 0, 0, 0, '[{"type":"Stored","time":"2024-07-06-03:46","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-06-04:28","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-04:29","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-06-04:30","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-04:31","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-04:31","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-04:31","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-04:31","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-11-15:49","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-11-15:50","garage":"Pillbox Garage Parking"}]'),
	(62, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'fsf90xx', '1091576299', '{"fuelLevel":96.11371640163806,"modSpoilers":-1,"modKit17":-1,"modKit19":-1,"modBackWheels":-1,"model":1091576299,"color1":5,"modLivery":-1,"modRoof":-1,"color2":36,"modExhaust":-1,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modKit49":-1,"modTank":-1,"modVanityPlate":-1,"modCustomTiresR":false,"plateIndex":3,"modOrnaments":-1,"modDoorSpeaker":-1,"modSuspension":-1,"modRightFender":-1,"modAPlate":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modSteeringWheel":-1,"modBrakes":-1,"modTurbo":false,"modHood":-1,"modFender":-1,"modSideSkirt":-1,"modEngineBlock":-1,"dashboardColor":0,"modFrontWheels":-1,"plate":"05SQE183","wheelSize":1.0,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrontBumper":-1,"dirtLevel":0.0,"modSmokeEnabled":false,"modEngine":-1,"modFrame":-1,"modGrille":-1,"modHydrolic":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modRearBumper":-1,"modShifterLeavers":-1,"modXenon":false,"modArmor":-1,"windowStatus":{"1":true,"2":false,"3":false,"4":false,"5":false,"6":true,"7":true,"0":true},"liveryRoof":-1,"tankHealth":996.0876063442489,"bodyHealth":962.7258204858291,"tyreSmokeColor":[255,255,255],"neonColor":[255,255,255],"modTrimB":-1,"modDashboard":-1,"pearlescentColor":0,"windowTint":-1,"modHorns":-1,"wheelWidth":1.0,"modKit47":-1,"modTransmission":-1,"modAerials":-1,"wheelColor":0,"wheels":7,"modKit21":-1,"modTrunk":-1,"modCustomTiresF":false,"modTrimA":-1,"modDial":-1,"extras":{"4":false,"5":false,"1":false,"2":true,"3":false},"oilLevel":4.76596940834568,"modWindows":-1,"modArchCover":-1,"modStruts":-1,"modSeats":-1,"interiorColor":36,"neonEnabled":[false,false,false,false],"engineHealth":1000.0592475178704,"modPlateHolder":-1,"modSpeakers":-1,"xenonColor":255,"modAirFilter":-1}', '05SQE183', NULL, 'pillboxgarage', 96, 1001, 963, 1, 0, NULL, '{"brakes":100,"radiator":100,"axle":100,"fuel":100,"clutch":100}', 0, 0, 0, 0, '[{"garage":"Pillbox Garage Parking","type":"Stored","time":"2024-07-06-03:49"},{"garage":"Pillbox Garage Parking","type":"Take Out","time":"2024-07-06-03:49"},{"garage":"Pillbox Garage Parking","type":"Take Out","time":"2024-07-06-04:31"},{"garage":"Pillbox Garage Parking","type":"Stored","time":"2024-07-06-04:33"},{"garage":"Pillbox Garage Parking","type":"Take Out","time":"2024-07-11-07:06"},{"garage":"Pillbox Garage Parking","type":"Stored","time":"2024-07-11-07:07"}]'),
	(63, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'sl63amg22', '1501052543', '{"modWindows":-1,"modKit47":-1,"tyreSmokeColor":[255,255,255],"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrame":-1,"modArmor":-1,"tankHealth":999.2649192831461,"modSuspension":-1,"fuelLevel":63.54625877794252,"modVanityPlate":-1,"modCustomTiresF":false,"wheelColor":5,"modTrimB":-1,"modHorns":-1,"modTrimA":-1,"plate":"43ZQZ464","modTrunk":-1,"bodyHealth":996.0876063442489,"modSteeringWheel":-1,"engineHealth":995.2932781095246,"dirtLevel":0.0,"plateIndex":3,"wheelSize":1.0,"modPlateHolder":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modGrille":-1,"modFender":-1,"modAirFilter":-1,"modXenon":false,"modSeats":-1,"interiorColor":0,"model":1501052543,"modKit49":-1,"modHood":-1,"modKit19":-1,"neonColor":[255,255,255],"modDoorSpeaker":-1,"modHydrolic":-1,"modFrontBumper":-1,"modEngine":-1,"modShifterLeavers":-1,"modRightFender":-1,"modRoof":-1,"modTransmission":-1,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"modBrakes":-1,"modKit17":-1,"modSpeakers":-1,"pearlescentColor":0,"modExhaust":-1,"dashboardColor":0,"wheelWidth":1.0,"modTank":-1,"modKit21":-1,"modDashboard":-1,"modFrontWheels":-1,"modAPlate":-1,"modBackWheels":-1,"modRearBumper":-1,"modAerials":-1,"modArchCover":-1,"modSpoilers":-1,"modSideSkirt":-1,"neonEnabled":[false,false,false,false],"modEngineBlock":-1,"modSmokeEnabled":false,"xenonColor":255,"wheels":7,"oilLevel":4.76596940834568,"color2":0,"modDial":-1,"extras":{"5":false,"3":true,"4":false,"1":false,"2":false},"windowTint":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"liveryRoof":-1,"modOrnaments":-1,"modStruts":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"color1":28,"modLivery":-1,"modCustomTiresR":false,"modTurbo":false}', '43ZQZ464', NULL, 'pillboxgarage', 63, 996, 997, 1, 0, NULL, '{"brakes":100,"axle":98,"clutch":100,"fuel":98,"radiator":100}', 0, 0, 0, 0, '[{"type":"Stored","time":"2024-07-06-03:51","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-06-03:52","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-03:52","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-06-04:30","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-04:30","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-11-15:50","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-11-15:50","garage":"Pillbox Garage Parking"}]'),
	(64, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'tenf', '-893984159', '{"modWindows":-1,"modKit47":-1,"tyreSmokeColor":[255,255,255],"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrame":-1,"modArmor":-1,"tankHealth":1000.0592475178704,"modSuspension":-1,"fuelLevel":23.82984704172844,"modVanityPlate":-1,"modCustomTiresF":false,"wheelColor":0,"modTrimB":-1,"modHorns":-1,"modTrimA":-1,"plate":"22YHV116","modTrunk":-1,"bodyHealth":996.8819345789732,"modSteeringWheel":-1,"engineHealth":1000.0592475178704,"dirtLevel":0.0,"plateIndex":0,"wheelSize":1.0,"modPlateHolder":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modGrille":-1,"modFender":-1,"modAirFilter":-1,"modXenon":false,"modSeats":-1,"interiorColor":37,"model":-893984159,"modKit49":-1,"modHood":-1,"modKit19":-1,"neonColor":[255,255,255],"modDoorSpeaker":-1,"modHydrolic":-1,"modFrontBumper":-1,"modEngine":-1,"modShifterLeavers":-1,"modRightFender":-1,"modRoof":-1,"modTransmission":-1,"windowStatus":{"1":true,"2":false,"3":false,"4":false,"5":false,"6":true,"7":true,"0":true},"modBrakes":-1,"modKit17":-1,"modSpeakers":-1,"pearlescentColor":4,"modExhaust":-1,"dashboardColor":156,"wheelWidth":1.0,"modTank":-1,"modKit21":-1,"modDashboard":-1,"modFrontWheels":-1,"modAPlate":-1,"modBackWheels":-1,"modRearBumper":-1,"modAerials":-1,"modArchCover":-1,"modSpoilers":-1,"modSideSkirt":-1,"neonEnabled":[false,false,false,false],"modEngineBlock":-1,"modSmokeEnabled":false,"xenonColor":255,"wheels":7,"oilLevel":4.76596940834568,"color2":0,"modDial":-1,"extras":[],"windowTint":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"liveryRoof":-1,"modOrnaments":-1,"modStruts":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"color1":19,"modLivery":-1,"modCustomTiresR":false,"modTurbo":false}', '22YHV116', NULL, 'pillboxgarage', 24, 1001, 997, 1, 0, NULL, '{"brakes":100,"axle":100,"clutch":100,"fuel":100,"radiator":100}', 0, 0, 0, 0, '[{"type":"Stored","time":"2024-07-06-03:56","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-06-04:30","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-06-04:31","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:14","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:15","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:15","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:16","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:18","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:21","garage":"Pillbox Garage Parking"},{"type":"Take Depot","time":"2024-07-10-17:24","garage":"Depot Lot"},{"type":"Stored","time":"2024-07-10-17:25","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-11-15:50","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-11-15:50","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-11-15:50","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-11-15:51","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-11-15:51","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-11-15:51","garage":"Pillbox Garage Parking"}]'),
	(65, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'buzzard', '788747387', '{"modTurbo":false,"modSeats":-1,"modLivery":-1,"neonEnabled":[false,false,false,false],"wheelSize":1.0,"modTrimB":-1,"xenonColor":255,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"liveryRoof":-1,"modBrakes":-1,"modHorns":-1,"modDoorSpeaker":-1,"modPlateHolder":-1,"bodyHealth":937.3073169746522,"modXenon":false,"modEngineBlock":-1,"modGrille":-1,"modFender":-1,"wheelColor":156,"modKit21":-1,"pearlescentColor":5,"modCustomTiresF":false,"color1":0,"interiorColor":0,"model":788747387,"modStruts":-1,"modKit49":-1,"modRoof":-1,"dashboardColor":0,"dirtLevel":0.0,"modArchCover":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modTank":-1,"modTrunk":-1,"windowTint":-1,"windowStatus":{"1":true,"2":true,"3":false,"4":false,"5":false,"6":false,"7":false,"0":true},"engineHealth":906.3285158204052,"wheels":0,"modRearBumper":-1,"modAerials":-1,"modOrnaments":-1,"tankHealth":937.3073169746522,"modAPlate":-1,"oilLevel":7.94328234724281,"modKit17":-1,"modSideSkirt":-1,"modCustomTiresR":false,"modAirFilter":-1,"modEngine":-1,"tyreSmokeColor":[255,255,255],"modFrame":-1,"modSuspension":-1,"modFrontWheels":-1,"wheelWidth":1.0,"fuelLevel":69.90088465573678,"modSmokeEnabled":false,"color2":0,"modExhaust":-1,"modDashboard":-1,"modTrimA":-1,"plate":"41SQG562","doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modHydrolic":-1,"modShifterLeavers":-1,"modSpoilers":-1,"modKit19":-1,"modDial":-1,"modVanityPlate":-1,"modSteeringWheel":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"neonColor":[255,255,255],"modKit47":-1,"modHood":-1,"modFrontBumper":-1,"modBackWheels":-1,"extras":{"1":true,"2":true,"7":true,"8":true,"9":true},"plateIndex":4,"modTransmission":-1,"modSpeakers":-1,"modWindows":-1,"modArmor":-1,"modRightFender":-1}', '41SQG562', NULL, 'intairport', 70, 907, 938, 1, 0, NULL, NULL, 0, 0, 0, 0, '[{"garage":"Airport Hangar","time":"2024-07-10-17:05","type":"Stored"},{"garage":"Airport Hangar","time":"2024-07-10-17:05","type":"Take Out"},{"garage":"Airport Hangar","time":"2024-07-10-17:07","type":"Take Out"},{"garage":"Airport Hangar","time":"2024-07-10-17:08","type":"Stored"}]'),
	(66, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'police', '2046537925', '{"modWindows":-1,"modKit47":-1,"tyreSmokeColor":[255,255,255],"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrame":-1,"modArmor":-1,"tankHealth":1000.0592475178704,"modSuspension":-1,"fuelLevel":19.85820586810703,"modVanityPlate":-1,"modCustomTiresF":false,"wheelColor":156,"modTrimB":-1,"modHorns":-1,"modTrimA":-1,"plate":"08FAZ273","modTrunk":-1,"bodyHealth":1000.0592475178704,"modSteeringWheel":-1,"engineHealth":1000.0592475178704,"dirtLevel":0.0,"plateIndex":4,"wheelSize":1.0,"modPlateHolder":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modGrille":-1,"modFender":-1,"modAirFilter":-1,"modXenon":false,"modSeats":-1,"interiorColor":0,"model":2046537925,"modKit49":-1,"modHood":-1,"modKit19":-1,"neonColor":[255,255,255],"modDoorSpeaker":-1,"modHydrolic":-1,"modFrontBumper":-1,"modEngine":-1,"modShifterLeavers":-1,"modRightFender":-1,"modRoof":-1,"modTransmission":-1,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"modBrakes":-1,"modKit17":-1,"modSpeakers":-1,"pearlescentColor":0,"modExhaust":-1,"dashboardColor":0,"wheelWidth":1.0,"modTank":-1,"modKit21":-1,"modDashboard":-1,"modFrontWheels":-1,"modAPlate":-1,"modBackWheels":-1,"modRearBumper":-1,"modAerials":-1,"modArchCover":-1,"modSpoilers":-1,"modSideSkirt":-1,"neonEnabled":[false,false,false,false],"modEngineBlock":-1,"modSmokeEnabled":false,"xenonColor":255,"wheels":1,"oilLevel":4.76596940834568,"color2":134,"modDial":-1,"extras":{"1":true,"2":false},"windowTint":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"liveryRoof":-1,"modOrnaments":-1,"modStruts":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"color1":134,"modLivery":2,"modCustomTiresR":false,"modTurbo":false}', '08FAZ273', NULL, 'pillboxgarage', 20, 1001, 1001, 1, 0, NULL, '{"brakes":100,"axle":100,"clutch":100,"fuel":100,"radiator":100}', 0, 0, 0, 0, '[{"type":"Stored","time":"2024-07-10-17:11","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:11","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:12","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-10-17:12","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-10-17:12","garage":"Pillbox Garage Parking"},{"type":"Take Out","time":"2024-07-11-15:50","garage":"Pillbox Garage Parking"},{"type":"Stored","time":"2024-07-11-15:51","garage":"Pillbox Garage Parking"}]'),
	(67, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'tenf', '-893984159', '{"modAPlate":-1,"modTrimA":-1,"modShifterLeavers":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"bodyHealth":1000.0592475178704,"modKit17":-1,"modKit49":-1,"wheels":7,"modTrimB":-1,"tyreSmokeColor":[255,255,255],"modHood":18,"wheelSize":1.0,"modWindows":-1,"modVanityPlate":-1,"modTank":-1,"model":-893984159,"modFrontBumper":17,"modSpoilers":23,"modBackWheels":-1,"dirtLevel":0.0,"modGrille":16,"oilLevel":4.76596940834568,"modTransmission":-1,"modOrnaments":-1,"wheelWidth":1.0,"tankHealth":4000.2369900714818,"modDashboard":-1,"pearlescentColor":4,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"color2":0,"modCustomTiresF":false,"modArchCover":-1,"extras":[],"wheelColor":0,"modKit47":-1,"modHydrolic":-1,"fuelLevel":72.28386935990962,"modStruts":-1,"plateIndex":0,"neonColor":[255,255,255],"modTurbo":false,"liveryRoof":-1,"windowStatus":{"1":true,"2":false,"3":false,"4":false,"5":false,"6":true,"7":true,"0":true},"modExhaust":11,"modEngine":-1,"interiorColor":37,"modSmokeEnabled":false,"modFender":2,"modLivery":-1,"modFrontWheels":-1,"color1":0,"modHorns":-1,"modArmor":-1,"modDial":-1,"modFrame":5,"plate":"07IMX317","modEngineBlock":-1,"modRoof":-1,"neonEnabled":[false,false,false,false],"modSuspension":-1,"windowTint":-1,"modRightFender":3,"modCustomTiresR":false,"modPlateHolder":-1,"modBrakes":-1,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modAirFilter":-1,"modSteeringWheel":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"xenonColor":255,"dashboardColor":156,"modSeats":-1,"modXenon":false,"modSideSkirt":15,"modKit19":-1,"engineHealth":1000.0592475178704,"modRearBumper":17,"modDoorSpeaker":-1,"modKit21":-1,"modAerials":-1,"modTrunk":-1,"modSpeakers":-1}', '07IMX317', NULL, 'pillboxgarage', 73, 1001, 1001, 0, 500, NULL, '{"brakes":100,"radiator":100,"axle":100,"fuel":100,"clutch":100}', 0, 0, 0, 0, '[{"time":"2024-07-11-07:10","type":"Stored","garage":"Pillbox Garage Parking"},{"time":"2024-07-11-07:10","type":"Take Out","garage":"Pillbox Garage Parking"},{"time":"2024-07-11-07:10","type":"Stored","garage":"Pillbox Garage Parking"},{"time":"2024-07-11-07:10","type":"Stored","garage":"Pillbox Garage Parking"},{"time":"2024-07-11-07:10","type":"Take Out","garage":"Pillbox Garage Parking"}]'),
	(68, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'policeb', '-34623805', '{"modWindows":-1,"modKit47":-1,"tyreSmokeColor":[255,255,255],"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrame":-1,"modArmor":-1,"tankHealth":1000.0592475178704,"modSuspension":-1,"fuelLevel":99.29102934053518,"modVanityPlate":-1,"modCustomTiresF":false,"wheelColor":156,"modTrimB":-1,"modHorns":-1,"modTrimA":-1,"plate":"7FZ420RM","modTrunk":-1,"bodyHealth":1000.0592475178704,"modSteeringWheel":-1,"engineHealth":1000.0592475178704,"dirtLevel":7.94328234724281,"plateIndex":4,"wheelSize":0.0,"modPlateHolder":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modGrille":-1,"modFender":-1,"modAirFilter":-1,"modXenon":false,"modSeats":-1,"interiorColor":0,"model":-34623805,"modKit49":-1,"modHood":-1,"modKit19":-1,"neonColor":[255,255,255],"modDoorSpeaker":-1,"modHydrolic":-1,"modFrontBumper":-1,"modEngine":-1,"modShifterLeavers":-1,"modRightFender":-1,"modRoof":-1,"modTransmission":-1,"windowStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"6":true,"7":false,"0":false},"modBrakes":-1,"modKit17":-1,"modSpeakers":-1,"pearlescentColor":134,"modExhaust":-1,"dashboardColor":0,"wheelWidth":0.0,"modTank":-1,"modKit21":-1,"modDashboard":-1,"modFrontWheels":-1,"modAPlate":-1,"modBackWheels":-1,"modRearBumper":-1,"modAerials":-1,"modArchCover":-1,"modSpoilers":-1,"modSideSkirt":-1,"neonEnabled":[false,false,false,false],"modEngineBlock":-1,"modSmokeEnabled":false,"xenonColor":255,"wheels":6,"oilLevel":4.76596940834568,"color2":1,"modDial":-1,"extras":[],"windowTint":-1,"tireHealth":{"1":1000.0,"2":0.0,"3":0.0,"0":1000.0},"liveryRoof":-1,"modOrnaments":-1,"modStruts":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"color1":111,"modLivery":2,"modCustomTiresR":false,"modTurbo":1}', '7FZ420RM', NULL, 'police', 100, 1000, 1000, 0, 500, NULL, '{"brakes":100,"axle":100,"clutch":100,"fuel":100,"radiator":100}', 0, 0, 0, 0, '[{"type":"Stored","time":"2024-07-11-16:03","garage":"Los Santos Police Department"},{"type":"Take Out","time":"2024-07-11-16:03","garage":"Los Santos Police Department"}]'),
	(69, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'police2', '-1627000575', '{"modWindows":-1,"modKit47":-1,"modExhaust":-1,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrame":-1,"modArmor":-1,"tankHealth":4000.2369900714818,"modRoof":-1,"fuelLevel":63.54625877794252,"liveryRoof":-1,"modCustomTiresF":false,"wheelColor":156,"modTrimB":-1,"modSpeakers":-1,"modOrnaments":-1,"plate":"1ZP797UI","modTrunk":-1,"bodyHealth":1000.0592475178704,"modSmokeEnabled":false,"engineHealth":1000.0592475178704,"dirtLevel":6.35462587779425,"plateIndex":5,"wheelSize":1.0,"modPlateHolder":-1,"dashboardColor":0,"modGrille":-1,"modFender":-1,"modAirFilter":-1,"modXenon":false,"windowTint":1,"interiorColor":0,"model":-1627000575,"modTransmission":-1,"modHood":-1,"modKit19":-1,"neonColor":[255,255,255],"modRearBumper":-1,"modHydrolic":-1,"modDoorSpeaker":-1,"modEngine":-1,"modShifterLeavers":-1,"modTurbo":1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modSpoilers":-1,"modKit17":-1,"modBrakes":-1,"tyreSmokeColor":[255,255,255],"modLivery":4,"pearlescentColor":0,"modKit49":-1,"color2":147,"modFrontBumper":-1,"modTank":-1,"modVanityPlate":-1,"modDashboard":-1,"modFrontWheels":-1,"color1":112,"modAPlate":-1,"modDial":-1,"modAerials":-1,"modArchCover":-1,"wheels":0,"modSideSkirt":-1,"neonEnabled":[false,false,false,false],"modEngineBlock":-1,"windowStatus":{"1":true,"2":true,"3":true,"4":true,"5":true,"6":true,"7":true,"0":true},"modRightFender":-1,"modKit21":-1,"oilLevel":4.76596940834568,"wheelWidth":1.0,"modSuspension":-1,"extras":{"1":true,"12":true},"modSteeringWheel":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modTrimA":-1,"modHorns":-1,"modStruts":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modBackWheels":-1,"xenonColor":255,"modCustomTiresR":false,"modSeats":-1}', '1ZP797UI', NULL, 'police', 63, 1001, 1001, 0, 500, NULL, '{"brakes":100,"axle":100,"clutch":100,"fuel":98,"radiator":100}', 0, 0, 0, 0, '[{"garage":"Los Santos Police Department","time":"2024-07-11-16:12","type":"Stored"},{"garage":"Los Santos Police Department","time":"2024-07-11-16:12","type":"Take Out"},{"garage":"Los Santos Police Department","time":"2024-07-11-16:13","type":"Stored"},{"garage":"Los Santos Police Department","time":"2024-07-11-16:17","type":"Take Out"}]'),
	(70, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'fbi2', '-1647941228', '{"modDoorSpeaker":-1,"wheelColor":156,"modTank":-1,"modTransmission":-1,"dashboardColor":0,"fuelLevel":100.08535757525947,"color1":0,"modTrimA":-1,"wheelWidth":1.0,"bodyHealth":1000.0592475178704,"modFrontWheels":-1,"modWindows":-1,"modCustomTiresF":false,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modLivery":2,"modHood":-1,"modArchCover":-1,"wheelSize":1.0,"plate":"5CL360FN","dirtLevel":4.76596940834568,"modAPlate":-1,"tyreSmokeColor":[255,255,255],"oilLevel":4.76596940834568,"modSideSkirt":-1,"color2":0,"engineHealth":1000.0592475178704,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modRearBumper":-1,"modTrimB":-1,"plateIndex":4,"windowTint":-1,"interiorColor":0,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"modTrunk":-1,"modKit21":-1,"modCustomTiresR":false,"modHorns":-1,"modRoof":-1,"modGrille":-1,"pearlescentColor":3,"modTurbo":1,"wheels":3,"modSpoilers":-1,"modEngine":-1,"modKit47":-1,"modShifterLeavers":-1,"liveryRoof":-1,"modVanityPlate":-1,"extras":{"12":true,"10":true},"modAirFilter":-1,"modStruts":-1,"modKit19":-1,"modRightFender":-1,"modXenon":false,"model":-1647941228,"xenonColor":255,"modArmor":-1,"modSteeringWheel":-1,"modSmokeEnabled":false,"modDial":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"tankHealth":1000.0592475178704,"modEngineBlock":-1,"modDashboard":-1,"modFender":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modHydrolic":-1,"modSpeakers":-1,"modPlateHolder":-1,"neonColor":[255,255,255],"modFrontBumper":-1,"modBackWheels":-1,"modOrnaments":-1,"modSeats":-1,"modKit17":-1,"modKit49":-1,"modExhaust":-1,"modFrame":-1,"modSuspension":-1,"modBrakes":-1,"neonEnabled":[false,false,false,false],"modAerials":-1}', '5CL360FN', NULL, 'police', 100, 1001, 1001, 0, 500, NULL, '{"radiator":100,"fuel":100,"brakes":100,"axle":100,"clutch":100}', 0, 0, 0, 0, '[{"garage":"Los Santos Police Department","type":"Stored","time":"2024-07-11-19:16"},{"garage":"Los Santos Police Department","type":"Take Out","time":"2024-07-11-19:16"},{"garage":"Los Santos Police Department","type":"Stored","time":"2024-07-11-19:16"},{"garage":"Los Santos Police Department","type":"Take Out","time":"2024-07-14-16:48"}]'),
	(74, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'policet', '456714581', '{}', '0CA805PA', NULL, 'pillboxgarage', 100, 1000, 1000, 0, 500, NULL, NULL, 0, 0, 0, 0, '[]'),
	(75, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'fbi2', '-1647941228', '{}', '1EA512OQ', NULL, 'pillboxgarage', 100, 1000, 1000, 0, 500, NULL, NULL, 0, 0, 0, 0, '[]'),
	(76, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'fbi2', '-1647941228', '{"plate":"4PB686XQ","neonColor":[255,255,255],"modCustomTiresR":false,"modShifterLeavers":-1,"wheelWidth":1.0,"modGrille":-1,"windowTint":-1,"modDoorSpeaker":-1,"modSmokeEnabled":false,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modVanityPlate":-1,"modDial":-1,"xenonColor":255,"modRearBumper":-1,"modHood":-1,"modXenon":false,"plateIndex":4,"modSideSkirt":-1,"wheelColor":156,"modAPlate":-1,"modArmor":-1,"modHydrolic":-1,"modFender":-1,"modSpoilers":-1,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"liveryRoof":-1,"modRightFender":-1,"modFrontWheels":-1,"modTrunk":-1,"tankHealth":1000.0592475178704,"modSteeringWheel":-1,"pearlescentColor":3,"dirtLevel":3.9716411736214,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modTransmission":-1,"color2":83,"modStruts":-1,"fuelLevel":100.08535757525947,"modKit17":-1,"modFrontBumper":-1,"modEngineBlock":-1,"dashboardColor":0,"modAerials":-1,"interiorColor":0,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"oilLevel":4.76596940834568,"modDashboard":-1,"tyreSmokeColor":[255,255,255],"modWindows":-1,"modTurbo":1,"modKit21":-1,"modLivery":2,"modPlateHolder":-1,"modAirFilter":-1,"modKit19":-1,"modBackWheels":-1,"modFrame":-1,"modBrakes":-1,"modSuspension":-1,"modTrimA":-1,"engineHealth":1000.0592475178704,"wheelSize":1.0,"modArchCover":-1,"modRoof":-1,"wheels":3,"modTank":-1,"modOrnaments":-1,"extras":{"10":true,"12":true},"modCustomTiresF":false,"modEngine":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modTrimB":-1,"modKit47":-1,"modHorns":-1,"model":-1647941228,"bodyHealth":1000.0592475178704,"modKit49":-1,"neonEnabled":[false,false,false,false],"modSeats":-1,"color1":158,"modSpeakers":-1,"modExhaust":-1}', '4PB686XQ', NULL, 'police', 100, 1000, 1000, 1, 0, NULL, '{"clutch":100,"fuel":100,"radiator":100,"axle":100,"brakes":98}', 0, 0, 0, 0, '[{"type":"Stored","time":"2024-07-16-14:39","garage":"Los Santos Police Department"}]'),
	(77, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'police3', '1912215274', '{"modFrame":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modKit47":-1,"extras":{"10":true,"4":true,"5":true,"6":true,"8":true,"9":true},"modKit17":-1,"modSpoilers":-1,"dashboardColor":0,"modCustomTiresF":false,"plateIndex":4,"modSteeringWheel":-1,"tankHealth":1000.0592475178704,"modXenon":false,"modHorns":-1,"modSmokeEnabled":false,"modDial":-1,"modTransmission":-1,"modGrille":-1,"modRoof":-1,"modExhaust":-1,"modFrontWheels":-1,"modSideSkirt":-1,"wheelSize":1.0,"dirtLevel":3.17731293889712,"modHood":-1,"modFrontBumper":-1,"modEngineBlock":-1,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modTurbo":1,"modRightFender":-1,"modStruts":-1,"modWindows":-1,"modSuspension":-1,"modSpeakers":-1,"modAirFilter":-1,"liveryRoof":-1,"interiorColor":0,"modOrnaments":-1,"modKit49":-1,"tyreSmokeColor":[255,255,255],"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"windowStatus":{"1":true,"2":true,"3":true,"4":true,"5":true,"6":true,"7":true,"0":true},"modDashboard":-1,"oilLevel":4.76596940834568,"modCustomTiresR":false,"pearlescentColor":0,"color2":0,"windowTint":-1,"color1":112,"modVanityPlate":-1,"modHydrolic":-1,"modKit19":-1,"wheelColor":1,"modAPlate":-1,"fuelLevel":100.08535757525947,"modDoorSpeaker":-1,"modTrunk":-1,"modLivery":2,"modSeats":-1,"model":1912215274,"neonColor":[255,255,255],"modBackWheels":-1,"wheelWidth":1.0,"modEngine":-1,"modPlateHolder":-1,"modArchCover":-1,"modShifterLeavers":-1,"modKit21":-1,"plate":"6XM780SE","modArmor":-1,"bodyHealth":1000.0592475178704,"modRearBumper":-1,"modTank":-1,"xenonColor":255,"wheels":0,"modBrakes":-1,"modAerials":-1,"modTrimA":-1,"modFender":-1,"neonEnabled":[false,false,false,false],"modTrimB":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"engineHealth":1000.0592475178704}', '6XM780SE', NULL, 'pillboxgarage', 100, 1000, 1000, 0, 500, NULL, NULL, 0, 0, 0, 0, '[]'),
	(82, 'license:ed947330abdbe62d74983ea7eeab79067e08affe', 'XGI09387', 'tenf', '-893984159', '{"modKit47":-1,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"oilLevel":4.76596940834568,"modFrontWheels":-1,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"windowStatus":{"1":true,"2":false,"3":false,"4":false,"5":false,"6":true,"7":true,"0":true},"tyreSmokeColor":[255,255,255],"modHood":-1,"modTurbo":false,"modSteeringWheel":-1,"modFender":-1,"wheelColor":0,"modDial":-1,"modRearBumper":-1,"bodyHealth":1000.0592475178704,"engineHealth":1000.0592475178704,"modOrnaments":-1,"color1":19,"modSuspension":-1,"modPlateHolder":-1,"modEngine":-1,"modSpoilers":-1,"modDashboard":-1,"wheelWidth":1.0,"modVanityPlate":-1,"fuelLevel":76.25551053353103,"extras":[],"modHydrolic":-1,"modHorns":-1,"neonColor":[255,255,255],"modFrame":-1,"wheelSize":1.0,"modKit49":-1,"tankHealth":1000.0592475178704,"modSpeakers":-1,"color2":0,"modArchCover":-1,"windowTint":-1,"plateIndex":0,"dirtLevel":0.0,"modKit21":-1,"modCustomTiresR":false,"modArmor":-1,"modTrimA":-1,"modWindows":-1,"liveryRoof":-1,"modSideSkirt":-1,"modXenon":false,"model":-893984159,"xenonColor":255,"pearlescentColor":4,"modKit19":-1,"dashboardColor":156,"wheels":7,"modTank":-1,"modTrimB":-1,"modSmokeEnabled":false,"modGrille":-1,"modStruts":-1,"modAirFilter":-1,"modDoorSpeaker":-1,"modAerials":-1,"modLivery":-1,"modRoof":-1,"modTransmission":-1,"modSeats":-1,"modBackWheels":-1,"modTrunk":-1,"modBrakes":-1,"modAPlate":-1,"modKit17":-1,"modRightFender":-1,"neonEnabled":[false,false,false,false],"plate":"25XBW820","modEngineBlock":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modExhaust":-1,"modCustomTiresF":false,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrontBumper":-1,"modShifterLeavers":-1,"interiorColor":37}', '25XBW820', NULL, NULL, 100, 1000, 1000, 0, 500, NULL, NULL, 0, 0, 0, 0, '[]');

-- Dumping structure for table sgxcorev1.player_warns
CREATE TABLE IF NOT EXISTS `player_warns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `senderIdentifier` varchar(50) DEFAULT NULL,
  `targetIdentifier` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `warnId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.player_warns: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.properties
CREATE TABLE IF NOT EXISTS `properties` (
  `property_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_citizenid` varchar(50) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `has_access` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT json_array() CHECK (json_valid(`has_access`)),
  `extra_imgs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT json_array() CHECK (json_valid(`extra_imgs`)),
  `furnitures` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT json_array() CHECK (json_valid(`furnitures`)),
  `for_sale` tinyint(1) NOT NULL DEFAULT 1,
  `price` int(11) NOT NULL DEFAULT 0,
  `shell` varchar(50) NOT NULL,
  `apartment` varchar(50) DEFAULT NULL,
  `door_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`door_data`)),
  `garage_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`garage_data`)),
  PRIMARY KEY (`property_id`),
  UNIQUE KEY `UQ_owner_apartment` (`owner_citizenid`,`apartment`),
  CONSTRAINT `FK_owner_citizenid` FOREIGN KEY (`owner_citizenid`) REFERENCES `players` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sgxcorev1.properties: ~3 rows (approximately)
INSERT IGNORE INTO `properties` (`property_id`, `owner_citizenid`, `street`, `region`, `description`, `has_access`, `extra_imgs`, `furnitures`, `for_sale`, `price`, `shell`, `apartment`, `door_data`, `garage_data`) VALUES
	(4, 'XGI09387', 'West Mirror Drive', 'Mirror Park', 'SGX Core', '[]', '[]', '[{"label":"Old striped couch","id":"3420954","rotation":{"x":0.0,"y":-0.0,"z":0.0},"object":"prop_ld_farm_couch02","position":{"x":-4.81,"y":-2.93,"z":-1.25}},{"label":"Storage Unit","id":"8082384","type":"storage","rotation":{"x":0.0,"y":-0.0,"z":0.0},"object":"v_res_tre_storagebox","position":{"x":4.5599,"y":-5.11,"z":-1.74}},{"label":"Wardrobe","id":"1799114","type":"clothing","rotation":{"x":0.0,"y":-0.0,"z":-96.0},"object":"v_res_tre_wardrobe","position":{"x":4.2399,"y":-3.87,"z":-1.7}},{"label":"Crypto Mining Rig","id":"7615294","rotation":{"x":0.0,"y":-0.0,"z":0.0},"object":"v_corp_servercln","position":{"x":-0.41,"y":-0.65,"z":-1.76}}]', 0, 10, 'Office', NULL, '{"locked":false,"z":58.44,"width":2.2,"length":1.5,"y":-669.84,"h":114.29,"x":959.94}', '{"z":58.01,"width":5.0,"length":3.0,"y":-666.1,"h":112.78,"x":953.82}'),
	(5, 'XGI09387', 'West Mirror Drive', 'La Mesa', 'SGX Core', '[]', '[]', '[{"label":"Old treesits couch","id":"8610015","rotation":{"x":0.0,"y":-0.0,"z":0.0},"object":"prop_ld_farm_couch01","position":{"x":3.57,"y":2.3981,"z":-1.1501}},{"label":"Wardrobe","id":"3161195","type":"clothing","rotation":{"x":0.0,"y":-0.0,"z":0.0},"object":"v_res_tre_wardrobe","position":{"x":-2.1216,"y":4.4699,"z":-1.7001}},{"label":"Crypto Mining Rig","id":"7385725","rotation":{"x":0.0,"y":-0.0,"z":-95.0},"object":"v_corp_servercln","position":{"x":3.44,"y":-2.5121,"z":-1.6101}}]', 0, 10, 'Store', NULL, '{"locked":false,"z":57.99,"width":2.2,"length":1.5,"y":-562.66,"h":10.39,"x":843.93}', '{"z":57.7,"width":5.0,"length":3.0,"y":-566.54,"h":268.64,"x":844.06}'),
	(6, 'XGI09387', 'Fantastic Pl', 'Mission Row', 'xxx', '[]', '[]', '[{"id":"8112056","rotation":{"x":0.0,"y":-0.0,"z":0.0},"object":"v_corp_servercln","position":{"z":-1.4201,"y":3.6198,"x":-8.1603},"label":"Crypto Mining Rig"}]', 0, 10, 'House 4', NULL, '{"z":29.4,"locked":false,"length":1.5,"x":291.34,"width":2.2,"y":-1078.48,"h":91.2}', '{"z":29.31,"length":3.0,"x":299.91,"width":5.0,"y":-1080.76,"h":180.37}');

-- Dumping structure for table sgxcorev1.races
CREATE TABLE IF NOT EXISTS `races` (
  `owner` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `reward` int(11) DEFAULT NULL,
  `date` longtext DEFAULT NULL,
  `maxplayers` int(11) DEFAULT NULL,
  `route` longtext DEFAULT NULL,
  `id` bigint(20) DEFAULT NULL,
  `players` longtext DEFAULT NULL,
  `luadate` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.races: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.rentvehs
CREATE TABLE IF NOT EXISTS `rentvehs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `vehicle` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `time` int(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.rentvehs: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.selldrugs_phone
CREATE TABLE IF NOT EXISTS `selldrugs_phone` (
  `player` varchar(255) NOT NULL,
  `settings` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.selldrugs_phone: ~5 rows (approximately)
INSERT IGNORE INTO `selldrugs_phone` (`player`, `settings`) VALUES
	('XGI09387', '{"statusAlertsSound":true,"statusAlerts":true}'),
	('CLC04795', '{"statusAlerts":true,"statusAlertsSound":true}'),
	('TDN82412', '{"statusAlerts":true,"statusAlertsSound":true}'),
	('KBN48829', '{"statusAlerts":true,"statusAlertsSound":true}'),
	('QEZ87736', '{"statusAlertsSound":true,"statusAlerts":true}');

-- Dumping structure for table sgxcorev1.selldrugs_players
CREATE TABLE IF NOT EXISTS `selldrugs_players` (
  `player` varchar(255) DEFAULT NULL,
  `respect` int(11) NOT NULL DEFAULT 0,
  `sale_skill` int(11) NOT NULL DEFAULT 0,
  `mole` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.selldrugs_players: ~5 rows (approximately)
INSERT IGNORE INTO `selldrugs_players` (`player`, `respect`, `sale_skill`, `mole`) VALUES
	('XGI09387', 0, 48, '{"professional":{},"junkie":{},"criminal":[]}'),
	('CLC04795', 0, 0, '{"junkie":[],"criminal":[],"professional":[]}'),
	('TDN82412', 0, 0, '{"criminal":[],"professional":[],"junkie":[]}'),
	('KBN48829', 0, 0, '{"criminal":[],"junkie":[],"professional":[]}'),
	('QEZ87736', 0, 0, '{"criminal":[],"professional":[],"junkie":[]}');

-- Dumping structure for table sgxcorev1.sgx_racing
CREATE TABLE IF NOT EXISTS `sgx_racing` (
  `identifier` varchar(50) DEFAULT NULL,
  `routes` longtext DEFAULT NULL,
  `racehistory` longtext DEFAULT NULL,
  `win` int(11) DEFAULT NULL,
  `lose` int(11) DEFAULT NULL,
  `favouritecar` longtext DEFAULT NULL,
  `distance` bigint(20) DEFAULT NULL,
  `charname` varchar(50) DEFAULT NULL,
  `incomingrace` int(11) DEFAULT NULL,
  `lastrace` varchar(50) DEFAULT NULL,
  `playerphoto` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.sgx_racing: ~2 rows (approximately)
INSERT IGNORE INTO `sgx_racing` (`identifier`, `routes`, `racehistory`, `win`, `lose`, `favouritecar`, `distance`, `charname`, `incomingrace`, `lastrace`, `playerphoto`) VALUES
	('CLC04795', '[]', '[]', 0, 0, '[]', 0, 'SGX SGX', 0, 'Unknown', 'https://dunb17ur4ymx4.cloudfront.net/webstore/logos/b9e02fad49fb6c1e4205ae6abcb7890a5ed7743a.png'),
	('QEZ87736', '[]', '[]', 0, 0, '[]', 0, 'SGX FIvem', 0, 'Unknown', 'https://dunb17ur4ymx4.cloudfront.net/webstore/logos/b9e02fad49fb6c1e4205ae6abcb7890a5ed7743a.png');

-- Dumping structure for table sgxcorev1.sgx_vehicleshop_showroom_vehicles
CREATE TABLE IF NOT EXISTS `sgx_vehicleshop_showroom_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealershipId` int(11) DEFAULT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.sgx_vehicleshop_showroom_vehicles: ~1 rows (approximately)
INSERT IGNORE INTO `sgx_vehicleshop_showroom_vehicles` (`id`, `dealershipId`, `data`) VALUES
	(3, 1, '[{"vehicle":6173698,"vehicleModel":"italirsx","spotId":1,"coords":{"x":551.6300048828125,"y":-264.0799865722656,"z":49.97999954223633,"w":26.30999946594238}},{"vehicle":6173954,"vehicleModel":"tenf2","spotId":2,"coords":{"x":549.2999877929688,"y":-268.20001220703127,"z":49.97999954223633,"w":16.18000030517578}},{"vehicle":6174210,"vehicleModel":"primo2","spotId":3,"coords":{"x":547.280029296875,"y":-272.6700134277344,"z":49.97999954223633,"w":12.60999965667724}},{"vehicle":6174466,"vehicleModel":"cognoscenti","spotId":4,"coords":{"x":545.5,"y":-276.4800109863281,"z":49.97999954223633,"w":23.36000061035156}},{"vehicle":6174722,"vehicleModel":"italirsx","spotId":5,"coords":{"x":561.2999877929688,"y":-245.6300048828125,"z":49.33000183105469,"w":1.90999996662139}}]');

-- Dumping structure for table sgxcorev1.sgx_vehicleshop_stocks
CREATE TABLE IF NOT EXISTS `sgx_vehicleshop_stocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealershipId` int(11) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.sgx_vehicleshop_stocks: ~1 rows (approximately)
INSERT IGNORE INTO `sgx_vehicleshop_stocks` (`id`, `dealershipId`, `data`) VALUES
	(6, 1, '[{"stock":99,"model":"asbo"},{"stock":100,"model":"blista"},{"stock":101,"model":"brioso"},{"stock":101,"model":"club"},{"stock":101,"model":"dilettante"},{"stock":101,"model":"dilettante2"},{"stock":101,"model":"kanjo"},{"stock":101,"model":"issi2"},{"stock":100,"model":"issi3"},{"stock":101,"model":"issi4"},{"stock":101,"model":"issi5"},{"stock":101,"model":"issi6"},{"stock":101,"model":"panto"},{"stock":101,"model":"prairie"},{"stock":101,"model":"rhapsody"},{"stock":101,"model":"brioso2"},{"stock":101,"model":"weevil"},{"stock":101,"model":"issi7"},{"stock":101,"model":"blista2"},{"stock":100,"model":"blista3"},{"stock":101,"model":"brioso3"},{"stock":101,"model":"boor"},{"stock":101,"model":"asea"},{"stock":101,"model":"asterope"},{"stock":101,"model":"cog55"},{"stock":101,"model":"cognoscenti"},{"stock":101,"model":"emperor"},{"stock":101,"model":"fugitive"},{"stock":101,"model":"glendale"},{"stock":101,"model":"glendale2"},{"stock":101,"model":"ingot"},{"stock":101,"model":"intruder"},{"stock":101,"model":"premier"},{"stock":101,"model":"primo"},{"stock":101,"model":"primo2"},{"stock":101,"model":"regina"},{"stock":101,"model":"stafford"},{"stock":101,"model":"stanier"},{"stock":101,"model":"stratum"},{"stock":101,"model":"stretch"},{"stock":101,"model":"superd"},{"stock":101,"model":"surge"},{"stock":101,"model":"tailgater"},{"stock":101,"model":"warrener"},{"stock":101,"model":"washington"},{"stock":101,"model":"tailgater2"},{"stock":101,"model":"cinquemila"},{"stock":101,"model":"deity"},{"stock":101,"model":"oracle"},{"stock":101,"model":"schafter2"},{"stock":101,"model":"warrener2"},{"stock":101,"model":"rhinehart"},{"stock":101,"model":"eudora"},{"stock":101,"model":"baller"},{"stock":101,"model":"baller2"},{"stock":101,"model":"baller3"},{"stock":101,"model":"baller4"},{"stock":101,"model":"baller5"},{"stock":101,"model":"baller6"},{"stock":101,"model":"iwagen"},{"stock":101,"model":"astron"},{"stock":101,"model":"baller7"},{"stock":101,"model":"baller8"},{"stock":101,"model":"jubilee"},{"stock":101,"model":"bjxl"},{"stock":101,"model":"cavalcade"},{"stock":101,"model":"cavalcade2"},{"stock":101,"model":"contender"},{"stock":101,"model":"dubsta"},{"stock":101,"model":"dubsta2"},{"stock":101,"model":"fq2"},{"stock":101,"model":"granger"},{"stock":101,"model":"gresley"},{"stock":101,"model":"habanero"},{"stock":101,"model":"huntley"},{"stock":101,"model":"landstalker"},{"stock":101,"model":"landstalker2"},{"stock":101,"model":"novak"},{"stock":101,"model":"patriot"},{"stock":101,"model":"patriot2"},{"stock":101,"model":"radi"},{"stock":101,"model":"rebla"},{"stock":101,"model":"rocoto"},{"stock":101,"model":"seminole"},{"stock":101,"model":"seminole2"},{"stock":101,"model":"serrano"},{"stock":101,"model":"toros"},{"stock":101,"model":"xls"},{"stock":101,"model":"granger2"},{"stock":101,"model":"patriot3"},{"stock":101,"model":"comet7"},{"stock":101,"model":"cogcabrio"},{"stock":101,"model":"exemplar"},{"stock":101,"model":"f620"},{"stock":101,"model":"felon"},{"stock":101,"model":"felon2"},{"stock":101,"model":"jackal"},{"stock":101,"model":"oracle2"},{"stock":101,"model":"sentinel"},{"stock":101,"model":"sentinel2"},{"stock":101,"model":"windsor"},{"stock":101,"model":"windsor2"},{"stock":101,"model":"zion"},{"stock":101,"model":"zion2"},{"stock":101,"model":"previon"},{"stock":101,"model":"champion"},{"stock":101,"model":"futo"},{"stock":101,"model":"sentinel3"},{"stock":101,"model":"kanjosj"},{"stock":101,"model":"postlude"},{"stock":101,"model":"tahoma"},{"stock":101,"model":"broadway"},{"stock":101,"model":"blade"},{"stock":101,"model":"buccaneer"},{"stock":100,"model":"buccaneer2"},{"stock":101,"model":"chino"},{"stock":101,"model":"chino2"},{"stock":101,"model":"clique"},{"stock":101,"model":"coquette3"},{"stock":101,"model":"deviant"},{"stock":101,"model":"dominator"},{"stock":101,"model":"dominator2"},{"stock":101,"model":"dominator3"},{"stock":101,"model":"dominator4"},{"stock":101,"model":"dominator7"},{"stock":101,"model":"dominator8"},{"stock":101,"model":"dukes"},{"stock":101,"model":"dukes2"},{"stock":101,"model":"dukes3"},{"stock":101,"model":"faction"},{"stock":101,"model":"faction2"},{"stock":101,"model":"faction3"},{"stock":101,"model":"ellie"},{"stock":101,"model":"gauntlet"},{"stock":101,"model":"gauntlet2"},{"stock":101,"model":"gauntlet3"},{"stock":101,"model":"gauntlet4"},{"stock":101,"model":"gauntlet5"},{"stock":101,"model":"hermes"},{"stock":101,"model":"hotknife"},{"stock":101,"model":"hustler"},{"stock":101,"model":"impaler"},{"stock":101,"model":"impaler2"},{"stock":101,"model":"impaler3"},{"stock":101,"model":"impaler4"},{"stock":101,"model":"imperator"},{"stock":101,"model":"imperator2"},{"stock":101,"model":"imperator3"},{"stock":101,"model":"lurcher"},{"stock":101,"model":"nightshade"},{"stock":101,"model":"phoenix"},{"stock":101,"model":"picador"},{"stock":101,"model":"ratloader2"},{"stock":101,"model":"ruiner"},{"stock":101,"model":"ruiner2"},{"stock":101,"model":"sabregt"},{"stock":101,"model":"sabregt2"},{"stock":101,"model":"slamvan"},{"stock":101,"model":"slamvan2"},{"stock":101,"model":"slamvan3"},{"stock":101,"model":"stalion"},{"stock":101,"model":"stalion2"},{"stock":101,"model":"tampa"},{"stock":101,"model":"tulip"},{"stock":101,"model":"vamos"},{"stock":101,"model":"vigero"},{"stock":101,"model":"virgo"},{"stock":101,"model":"virgo2"},{"stock":101,"model":"virgo3"},{"stock":101,"model":"voodoo"},{"stock":101,"model":"yosemite"},{"stock":101,"model":"yosemite2"},{"stock":101,"model":"buffalo4"},{"stock":101,"model":"manana"},{"stock":101,"model":"manana2"},{"stock":101,"model":"tampa2"},{"stock":101,"model":"ruiner4"},{"stock":101,"model":"vigero2"},{"stock":101,"model":"weevil2"},{"stock":101,"model":"buffalo5"},{"stock":101,"model":"tulip2"},{"stock":101,"model":"clique2"},{"stock":101,"model":"brigham"},{"stock":101,"model":"greenwood"},{"stock":101,"model":"ardent"},{"stock":101,"model":"btype"},{"stock":101,"model":"btype2"},{"stock":101,"model":"btype3"},{"stock":101,"model":"casco"},{"stock":101,"model":"deluxo"},{"stock":101,"model":"dynasty"},{"stock":101,"model":"fagaloa"},{"stock":101,"model":"feltzer3"},{"stock":101,"model":"gt500"},{"stock":101,"model":"infernus2"},{"stock":101,"model":"jb700"},{"stock":101,"model":"jb7002"},{"stock":101,"model":"mamba"},{"stock":101,"model":"michelli"},{"stock":101,"model":"monroe"},{"stock":101,"model":"nebula"},{"stock":101,"model":"peyote"},{"stock":101,"model":"peyote3"},{"stock":101,"model":"pigalle"},{"stock":101,"model":"rapidgt3"},{"stock":101,"model":"retinue"},{"stock":101,"model":"retinue2"},{"stock":101,"model":"savestra"},{"stock":101,"model":"stinger"},{"stock":101,"model":"stingergt"},{"stock":101,"model":"stromberg"},{"stock":101,"model":"swinger"},{"stock":101,"model":"torero"},{"stock":101,"model":"tornado"},{"stock":101,"model":"tornado2"},{"stock":101,"model":"tornado5"},{"stock":101,"model":"turismo2"},{"stock":101,"model":"viseris"},{"stock":101,"model":"z190"},{"stock":101,"model":"ztype"},{"stock":101,"model":"zion3"},{"stock":101,"model":"cheburek"},{"stock":101,"model":"toreador"},{"stock":101,"model":"peyote2"},{"stock":101,"model":"coquette2"},{"stock":101,"model":"alpha"},{"stock":101,"model":"banshee"},{"stock":101,"model":"bestiagts"},{"stock":101,"model":"buffalo"},{"stock":101,"model":"buffalo2"},{"stock":101,"model":"carbonizzare"},{"stock":101,"model":"comet2"},{"stock":101,"model":"comet3"},{"stock":101,"model":"comet4"},{"stock":101,"model":"comet5"},{"stock":101,"model":"coquette"},{"stock":101,"model":"coquette4"},{"stock":101,"model":"drafter"},{"stock":101,"model":"elegy"},{"stock":101,"model":"elegy2"},{"stock":101,"model":"feltzer2"},{"stock":101,"model":"flashgt"},{"stock":101,"model":"furoregt"},{"stock":101,"model":"gb200"},{"stock":101,"model":"komoda"},{"stock":101,"model":"imorgon"},{"stock":101,"model":"italigto"},{"stock":101,"model":"jugular"},{"stock":101,"model":"jester"},{"stock":101,"model":"jester2"},{"stock":101,"model":"jester3"},{"stock":101,"model":"khamelion"},{"stock":101,"model":"kuruma"},{"stock":101,"model":"kuruma2"},{"stock":101,"model":"locust"},{"stock":101,"model":"lynx"},{"stock":101,"model":"massacro"},{"stock":101,"model":"massacro2"},{"stock":101,"model":"neo"},{"stock":101,"model":"neon"},{"stock":101,"model":"ninef"},{"stock":101,"model":"ninef2"},{"stock":101,"model":"omnis"},{"stock":101,"model":"paragon"},{"stock":101,"model":"pariah"},{"stock":101,"model":"penumbra"},{"stock":101,"model":"penumbra2"},{"stock":101,"model":"rapidgt"},{"stock":101,"model":"rapidgt2"},{"stock":101,"model":"raptor"},{"stock":101,"model":"revolter"},{"stock":101,"model":"ruston"},{"stock":101,"model":"schafter3"},{"stock":101,"model":"schafter4"},{"stock":101,"model":"schlagen"},{"stock":101,"model":"schwarzer"},{"stock":101,"model":"seven70"},{"stock":101,"model":"specter"},{"stock":101,"model":"streiter"},{"stock":101,"model":"sugoi"},{"stock":101,"model":"sultan"},{"stock":101,"model":"sultan2"},{"stock":101,"model":"surano"},{"stock":101,"model":"tropos"},{"stock":101,"model":"verlierer2"},{"stock":101,"model":"vstr"},{"stock":101,"model":"italirsx"},{"stock":101,"model":"zr350"},{"stock":101,"model":"calico"},{"stock":101,"model":"futo2"},{"stock":101,"model":"euros"},{"stock":101,"model":"jester4"},{"stock":101,"model":"remus"},{"stock":101,"model":"comet6"},{"stock":101,"model":"growler"},{"stock":101,"model":"vectre"},{"stock":101,"model":"cypher"},{"stock":101,"model":"sultan3"},{"stock":101,"model":"rt3000"},{"stock":101,"model":"sultanrs"},{"stock":101,"model":"visione"},{"stock":101,"model":"cheetah2"},{"stock":101,"model":"stingertt"},{"stock":101,"model":"omnisegt"},{"stock":101,"model":"sentinel4"},{"stock":101,"model":"sm722"},{"stock":101,"model":"tenf"},{"stock":101,"model":"tenf2"},{"stock":101,"model":"everon2"},{"stock":101,"model":"issi8"},{"stock":101,"model":"corsita"},{"stock":101,"model":"gauntlet6"},{"stock":101,"model":"coureur"},{"stock":101,"model":"r300"},{"stock":101,"model":"panthere"},{"stock":101,"model":"adder"},{"stock":101,"model":"autarch"},{"stock":101,"model":"banshee2"},{"stock":100,"model":"bullet"},{"stock":101,"model":"cheetah"},{"stock":101,"model":"cyclone"},{"stock":101,"model":"entity2"},{"stock":101,"model":"entityxf"},{"stock":101,"model":"emerus"},{"stock":101,"model":"fmj"},{"stock":101,"model":"furia"},{"stock":101,"model":"gp1"},{"stock":101,"model":"infernus"},{"stock":101,"model":"italigtb"},{"stock":101,"model":"italigtb2"},{"stock":101,"model":"krieger"},{"stock":101,"model":"le7b"},{"stock":101,"model":"nero"},{"stock":101,"model":"nero2"},{"stock":101,"model":"osiris"},{"stock":101,"model":"penetrator"},{"stock":101,"model":"pfister811"},{"stock":101,"model":"prototipo"},{"stock":101,"model":"reaper"},{"stock":101,"model":"s80"},{"stock":101,"model":"sc1"},{"stock":101,"model":"sheava"},{"stock":101,"model":"t20"},{"stock":101,"model":"taipan"},{"stock":101,"model":"tempesta"},{"stock":101,"model":"tezeract"},{"stock":101,"model":"thrax"},{"stock":101,"model":"tigon"},{"stock":101,"model":"turismor"},{"stock":101,"model":"tyrant"},{"stock":101,"model":"tyrus"},{"stock":101,"model":"vacca"},{"stock":101,"model":"vagner"},{"stock":101,"model":"voltic"},{"stock":101,"model":"voltic2"},{"stock":101,"model":"xa21"},{"stock":101,"model":"zentorno"},{"stock":101,"model":"zorrusso"},{"stock":101,"model":"ignus"},{"stock":101,"model":"zeno"},{"stock":101,"model":"deveste"},{"stock":101,"model":"lm87"},{"stock":101,"model":"torero2"},{"stock":101,"model":"entity3"},{"stock":101,"model":"virtue"},{"stock":101,"model":"akuma"},{"stock":101,"model":"avarus"},{"stock":101,"model":"bagger"},{"stock":101,"model":"bati"},{"stock":101,"model":"bati2"},{"stock":101,"model":"bf400"},{"stock":101,"model":"carbonrs"},{"stock":101,"model":"chimera"},{"stock":101,"model":"cliffhanger"},{"stock":101,"model":"daemon"},{"stock":101,"model":"daemon2"},{"stock":101,"model":"defiler"},{"stock":101,"model":"deathbike"},{"stock":101,"model":"deathbike2"},{"stock":101,"model":"deathbike3"},{"stock":101,"model":"diablous"},{"stock":101,"model":"diablous2"},{"stock":101,"model":"double"},{"stock":101,"model":"enduro"},{"stock":101,"model":"esskey"},{"stock":101,"model":"faggio"},{"stock":101,"model":"faggio2"},{"stock":101,"model":"faggio3"},{"stock":101,"model":"fcr"},{"stock":101,"model":"fcr2"},{"stock":101,"model":"gargoyle"},{"stock":101,"model":"hakuchou"},{"stock":101,"model":"hakuchou2"},{"stock":101,"model":"hexer"},{"stock":101,"model":"innovation"},{"stock":101,"model":"lectro"},{"stock":101,"model":"manchez"},{"stock":101,"model":"nemesis"},{"stock":101,"model":"nightblade"},{"stock":101,"model":"oppressor"},{"stock":101,"model":"pcj"},{"stock":101,"model":"ratbike"},{"stock":101,"model":"ruffian"},{"stock":101,"model":"sanchez"},{"stock":101,"model":"sanchez2"},{"stock":101,"model":"sanctus"},{"stock":101,"model":"shotaro"},{"stock":101,"model":"sovereign"},{"stock":101,"model":"stryder"},{"stock":101,"model":"thrust"},{"stock":101,"model":"vader"},{"stock":101,"model":"vindicator"},{"stock":101,"model":"vortex"},{"stock":101,"model":"wolfsbane"},{"stock":101,"model":"zombiea"},{"stock":101,"model":"zombieb"},{"stock":101,"model":"manchez2"},{"stock":101,"model":"shinobi"},{"stock":101,"model":"reever"},{"stock":101,"model":"manchez3"},{"stock":101,"model":"powersurge"},{"stock":101,"model":"bfinjection"},{"stock":101,"model":"bifta"},{"stock":101,"model":"blazer"},{"stock":101,"model":"blazer2"},{"stock":101,"model":"blazer3"},{"stock":101,"model":"blazer4"},{"stock":101,"model":"blazer5"},{"stock":101,"model":"brawler"},{"stock":101,"model":"caracara"},{"stock":101,"model":"caracara2"},{"stock":101,"model":"dubsta3"},{"stock":101,"model":"dune"},{"stock":101,"model":"everon"},{"stock":101,"model":"freecrawler"},{"stock":101,"model":"hellion"},{"stock":101,"model":"kalahari"},{"stock":101,"model":"kamacho"},{"stock":101,"model":"mesa3"},{"stock":101,"model":"outlaw"},{"stock":101,"model":"rancherxl"},{"stock":101,"model":"rebel2"},{"stock":101,"model":"riata"},{"stock":101,"model":"sandking"},{"stock":101,"model":"sandking2"},{"stock":101,"model":"trophytruck"},{"stock":101,"model":"trophytruck2"},{"stock":101,"model":"vagrant"},{"stock":101,"model":"verus"},{"stock":101,"model":"winky"},{"stock":101,"model":"yosemite3"},{"stock":101,"model":"mesa"},{"stock":101,"model":"ratel"},{"stock":101,"model":"l35"},{"stock":101,"model":"monstrociti"},{"stock":101,"model":"draugur"},{"stock":101,"model":"guardian"},{"stock":101,"model":"mixer2"},{"stock":101,"model":"tiptruck2"},{"stock":101,"model":"tiptruck"},{"stock":101,"model":"rubble"},{"stock":101,"model":"mixer"},{"stock":101,"model":"flatbed"},{"stock":101,"model":"dump"},{"stock":101,"model":"bulldozer"},{"stock":101,"model":"handler"},{"stock":101,"model":"cutter"},{"stock":101,"model":"slamtruck"},{"stock":101,"model":"caddy3"},{"stock":101,"model":"caddy2"},{"stock":101,"model":"caddy3"},{"stock":101,"model":"utillitruck"},{"stock":101,"model":"utillitruck2"},{"stock":101,"model":"utillitruck3"},{"stock":101,"model":"tractor"},{"stock":101,"model":"tractor2"},{"stock":101,"model":"tractor3"},{"stock":101,"model":"towtruck"},{"stock":101,"model":"towtruck2"},{"stock":101,"model":"scrap"},{"stock":101,"model":"sadler"},{"stock":101,"model":"ripley"},{"stock":101,"model":"mower"},{"stock":101,"model":"forklift"},{"stock":101,"model":"docktug"},{"stock":101,"model":"airtug"},{"stock":101,"model":"bison"},{"stock":101,"model":"bobcatxl"},{"stock":101,"model":"burrito3"},{"stock":101,"model":"gburrito2"},{"stock":101,"model":"rumpo"},{"stock":101,"model":"journey"},{"stock":101,"model":"minivan"},{"stock":101,"model":"minivan2"},{"stock":101,"model":"paradise"},{"stock":101,"model":"rumpo3"},{"stock":101,"model":"speedo"},{"stock":101,"model":"speedo4"},{"stock":101,"model":"surfer"},{"stock":101,"model":"youga3"},{"stock":101,"model":"youga"},{"stock":101,"model":"youga2"},{"stock":101,"model":"youga4"},{"stock":101,"model":"moonbeam"},{"stock":101,"model":"moonbeam2"},{"stock":101,"model":"boxville"},{"stock":101,"model":"boxville2"},{"stock":101,"model":"boxville3"},{"stock":101,"model":"boxville4"},{"stock":101,"model":"boxville5"},{"stock":101,"model":"pony"},{"stock":101,"model":"pony2"},{"stock":101,"model":"journey2"},{"stock":101,"model":"surfer3"},{"stock":101,"model":"speedo5"},{"stock":101,"model":"mule2"},{"stock":101,"model":"mule3"},{"stock":101,"model":"taco"},{"stock":101,"model":"bmx"},{"stock":101,"model":"cruiser"},{"stock":101,"model":"fixter"},{"stock":101,"model":"scorcher"},{"stock":101,"model":"tribike"},{"stock":101,"model":"tribike2"},{"stock":101,"model":"tribike3"},{"stock":101,"model":"inductor"},{"stock":101,"model":"inductor2"},{"stock":101,"model":"dinghy4"},{"stock":101,"model":"avisa"},{"stock":101,"model":"patrolboat"},{"stock":101,"model":"longfin"},{"stock":101,"model":"tug"},{"stock":101,"model":"toro"},{"stock":101,"model":"toro2"},{"stock":101,"model":"submersible2"},{"stock":101,"model":"speeder"},{"stock":101,"model":"speeder2"},{"stock":101,"model":"tropic"},{"stock":101,"model":"tropic2"},{"stock":101,"model":"suntrap"},{"stock":101,"model":"submersible"},{"stock":101,"model":"squalo"},{"stock":101,"model":"seashark"},{"stock":101,"model":"seashark3"},{"stock":101,"model":"marquis"},{"stock":101,"model":"jetmax"},{"stock":101,"model":"dinghy"},{"stock":101,"model":"dinghy2"},{"stock":101,"model":"dinghy3"},{"stock":101,"model":"dinghy4"},{"stock":101,"model":"conada2"},{"stock":101,"model":"conada"},{"stock":101,"model":"seasparrow2"},{"stock":101,"model":"annihilator2"},{"stock":101,"model":"seasparrow"},{"stock":101,"model":"akula"},{"stock":101,"model":"hunter"},{"stock":101,"model":"havok"},{"stock":101,"model":"volatus"},{"stock":101,"model":"supervolito2"},{"stock":101,"model":"supervolito"},{"stock":101,"model":"swift2"},{"stock":101,"model":"valkyrie"},{"stock":101,"model":"savage"},{"stock":101,"model":"swift"},{"stock":101,"model":"annihilator"},{"stock":101,"model":"cargobob2"},{"stock":101,"model":"skylift"},{"stock":101,"model":"maverick"},{"stock":101,"model":"frogger"},{"stock":101,"model":"frogger2"},{"stock":101,"model":"cargobob"},{"stock":101,"model":"cargobob3"},{"stock":101,"model":"seasparrow3"},{"stock":101,"model":"buzzard"},{"stock":101,"model":"buzzard2"},{"stock":101,"model":"streamer216"},{"stock":101,"model":"raiju"},{"stock":101,"model":"alkonost"},{"stock":101,"model":"strikeforce"},{"stock":101,"model":"blimp3"},{"stock":101,"model":"avenger"},{"stock":101,"model":"avenger2"},{"stock":101,"model":"volatol"},{"stock":101,"model":"nokota"},{"stock":101,"model":"seabreeze"},{"stock":101,"model":"pyro"},{"stock":101,"model":"mogul"},{"stock":101,"model":"howard"},{"stock":101,"model":"bombushka"},{"stock":101,"model":"molotok"},{"stock":101,"model":"microlight"},{"stock":101,"model":"tula"},{"stock":101,"model":"rogue"},{"stock":101,"model":"starling"},{"stock":101,"model":"alphaz1"},{"stock":101,"model":"nimbus"},{"stock":101,"model":"luxor2"},{"stock":101,"model":"velum2"},{"stock":101,"model":"hydra"},{"stock":101,"model":"blimp2"},{"stock":101,"model":"dodo"},{"stock":101,"model":"miljet"},{"stock":101,"model":"besra"},{"stock":101,"model":"vestra"},{"stock":101,"model":"cargoplane"},{"stock":101,"model":"velum"},{"stock":101,"model":"titan"},{"stock":101,"model":"shamal"},{"stock":101,"model":"lazer"},{"stock":101,"model":"mammatus"},{"stock":101,"model":"stunt"},{"stock":101,"model":"luxor"},{"stock":101,"model":"jet"},{"stock":101,"model":"duster"},{"stock":101,"model":"cuban800"},{"stock":101,"model":"blimp"},{"stock":101,"model":"brickade"},{"stock":101,"model":"brickade2"},{"stock":101,"model":"pbus2"},{"stock":101,"model":"wastelander"},{"stock":101,"model":"rallytruck"},{"stock":101,"model":"metrotrain"},{"stock":101,"model":"freight"},{"stock":101,"model":"cablecar"},{"stock":101,"model":"trash"},{"stock":101,"model":"trash2"},{"stock":101,"model":"tourbus"},{"stock":101,"model":"taxi"},{"stock":101,"model":"rentalbus"},{"stock":101,"model":"coach"},{"stock":101,"model":"bus"},{"stock":101,"model":"airbus"},{"stock":101,"model":"riot"},{"stock":101,"model":"riot2"},{"stock":101,"model":"pbus"},{"stock":101,"model":"police"},{"stock":101,"model":"police2"},{"stock":101,"model":"police3"},{"stock":101,"model":"police4"},{"stock":101,"model":"sheriff"},{"stock":101,"model":"sheriff2"},{"stock":101,"model":"policeold1"},{"stock":101,"model":"policeold2"},{"stock":101,"model":"policet"},{"stock":101,"model":"policeb"},{"stock":101,"model":"polmav"},{"stock":101,"model":"ambulance"},{"stock":101,"model":"firetruk"},{"stock":101,"model":"lguard"},{"stock":101,"model":"seashark2"},{"stock":101,"model":"pranger"},{"stock":101,"model":"fbi"},{"stock":101,"model":"fbi2"},{"stock":101,"model":"predator"},{"stock":101,"model":"vetir"},{"stock":101,"model":"kosatka"},{"stock":101,"model":"minitank"},{"stock":101,"model":"scarab"},{"stock":101,"model":"terbyte"},{"stock":101,"model":"thruster"},{"stock":101,"model":"khanjali"},{"stock":101,"model":"chernobog"},{"stock":101,"model":"barrage"},{"stock":101,"model":"trailerlarge"},{"stock":101,"model":"halftrack"},{"stock":101,"model":"apc"},{"stock":101,"model":"trailersmall2"},{"stock":101,"model":"rhino"},{"stock":101,"model":"crusader"},{"stock":101,"model":"barracks"},{"stock":101,"model":"barracks2"},{"stock":101,"model":"barracks3"},{"stock":101,"model":"cerberus"},{"stock":101,"model":"pounder2"},{"stock":101,"model":"mule4"},{"stock":101,"model":"phantom3"},{"stock":101,"model":"hauler2"},{"stock":101,"model":"phantom2"},{"stock":101,"model":"mule5"},{"stock":101,"model":"stockade"},{"stock":101,"model":"pounder"},{"stock":101,"model":"phantom"},{"stock":101,"model":"packer"},{"stock":101,"model":"mule"},{"stock":101,"model":"hauler"},{"stock":101,"model":"biff"},{"stock":101,"model":"benson"},{"stock":101,"model":"openwheel2"},{"stock":101,"model":"openwheel1"},{"stock":101,"model":"formula2"},{"stock":101,"model":"formula"}]');

-- Dumping structure for table sgxcorev1.shared_vehicles
CREATE TABLE IF NOT EXISTS `shared_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) NOT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT 'None',
  `hash` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` varchar(50) DEFAULT 'Stored',
  `faction` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`),
  KEY `category` (`category`),
  KEY `garage` (`garage`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.shared_vehicles: ~0 rows (approximately)

-- Dumping structure for table sgxcorev1.stashitems
CREATE TABLE IF NOT EXISTS `stashitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`stash`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table sgxcorev1.stashitems: ~42 rows (approximately)
INSERT IGNORE INTO `stashitems` (`id`, `stash`, `items`) VALUES
	(100, 'ambulancestash_CLC04795', '[]'),
	(81, 'ambulancestash_KBN48829', '[]'),
	(144, 'ambulancestash_XGI09387', '[]'),
	(177, 'ammunation1', '[]'),
	(104, 'apartment17953', '[]'),
	(124, 'apartment18617', '[]'),
	(148, 'autoexotic_stash', '[]'),
	(105, 'bennys2_stash', '[]'),
	(109, 'BennyShop_CLC04795', '[{"info":[],"useable":false,"image":"laptop.png","weight":4000,"label":"Laptop","slot":1,"name":"laptop","unique":false,"description":"Expensive laptop","type":"item","amount":2}]'),
	(163, 'BennyShop_QEZ87736', '[]'),
	(160, 'BennyShop_XGI09387', '[]'),
	(85, 'bennys_stash', '[]'),
	(103, 'bossballas', '[]'),
	(147, 'bossbcso', '[]'),
	(10, 'bossburgershot', '[]'),
	(9, 'bosscoolbeans', '[]'),
	(169, 'bossinfernalmc', '[]'),
	(4, 'bosslostmc', '[]'),
	(170, 'bossmafia', '[]'),
	(2, 'bosspizzathis', '[]'),
	(79, 'bosspolice', '[]'),
	(14, 'coolbeans_Counter', '[]'),
	(16, 'coolbeans_LegionStash', '[]'),
	(112, 'DarkWebCrate_1', '[{"info":[],"unique":true,"useable":false,"weight":1000,"slot":1,"label":"Key Frequency Radar","image":"weapon_digiscanner.png","type":"weapon","description":"","name":"weapon_digiscanner","amount":1}]'),
	(71, 'General Evidence Stash | #1', '[]'),
	(58, 'General Evidence Stash | #2', '[]'),
	(76, 'General Evidence Stash | #3', '[]'),
	(166, 'pizza_CounterLeft', '[]'),
	(165, 'pizza_CounterRight', '[]'),
	(30, 'policestash_BCO92693', '[]'),
	(99, 'policestash_CLC04795', '[]'),
	(143, 'policestash_XGI09387', '[]'),
	(59, 'policestash_ZQM42339', '[]'),
	(126, 'property_4', '[]'),
	(92, 'redlinemechanic_stash', '[]'),
	(138, 'storge', '[]'),
	(1, 'storge2', '[]'),
	(17, 'tray', '[{"info":{"wheelSmokeColor":"None","interiorColor":"Metallic Classic Gold","vehicleCosmetics":"Carbon Splitter","wheelColor":"Metallic Black","secondaryColor":"Metallic Black","dashboardColor":"DEFAULT ALLOY COLOR","xenonColor":"Stock","quality":100,"windowTint":"None","wheelName":"None","pearlescentColour":"Metallic Silver","primaryColor":"Util Gun Metal","neonColor":"None"},"type":"item","slot":1,"amount":1,"weight":10,"unique":true,"image":"customs_receipt.png","name":"customs_receipt","useable":false,"label":"Receipt"},{"info":{"wheelSmokeColor":"None","interiorColor":"Metallic Classic Gold","vehicleCosmetics":"Forged Spoiler","wheelColor":"Metallic Black","secondaryColor":"Metallic Black","dashboardColor":"DEFAULT ALLOY COLOR","xenonColor":"Stock","quality":100,"windowTint":"None","wheelName":"None","pearlescentColour":"Metallic Silver","primaryColor":"Util Gun Metal","neonColor":"None"},"type":"item","slot":2,"amount":1,"weight":10,"unique":true,"image":"customs_receipt.png","name":"customs_receipt","useable":false,"label":"Receipt"},{"info":{"wheelSmokeColor":"None","interiorColor":"Metallic Black","vehicleCosmetics":"","wheelColor":"DEFAULT ALLOY COLOR","secondaryColor":"MODSHOP BLACK1","dashboardColor":"Matte Gray","xenonColor":"Stock","quality":100,"windowTint":"None","wheelName":"None","pearlescentColour":"Metallic Black","primaryColor":"Pure White","neonColor":"None"},"type":"item","slot":3,"amount":1,"weight":10,"unique":true,"image":"customs_receipt.png","name":"customs_receipt","useable":false,"label":"Receipt"}]'),
	(18, 'tray2', '[{"info":{"quality":100},"type":"item","slot":1,"amount":50,"weight":100,"unique":false,"image":"weed_baggy.png","name":"weed_baggy","useable":false,"label":"Bag of Weed"}]'),
	(226, 'tray3', '[]'),
	(227, 'tray4', '[]'),
	(108, 'weaponbunker_stash', '[]');

-- Dumping structure for table sgxcorev1.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table sgxcorev1.transactions: ~13 rows (approximately)
INSERT IGNORE INTO `transactions` (`id`, `citizenid`, `amount`, `type`, `description`) VALUES
	(1, 'RDB18388', 100, 'deposit', 'Deposited $100 into bank'),
	(2, 'RDB18388', 20, 'deposit', 'Deposited $20 into bank'),
	(3, 'BCO92693', 100, 'withdraw', 'Withdrawn $100 from bank'),
	(4, 'BCO92693', 10, 'withdraw', 'Withdrawn $10 from bank'),
	(5, 'BCO92693', 100, 'withdraw', 'Withdrawn $100 from bank'),
	(6, 'JIY91569', 12, 'deposit', 'Deposited $12 into bank'),
	(7, 'CLC04795', 150, 'deposit', 'Deposited $150 into bank'),
	(8, 'XGI09387', 5000, 'withdraw', 'Withdrawn $5000 from bank'),
	(9, 'XGI09387', 5000, 'deposit', 'Deposited $5000 into bank'),
	(10, 'XGI09387', 5000, 'withdraw', 'Withdrawn $5000 from bank'),
	(11, 'CLC04795', 0, 'deposit', 'Deposited $0 into bank'),
	(12, 'CLC04795', 0, 'deposit', 'Deposited $0 into bank'),
	(13, 'CLC04795', 0, 'deposit', 'Deposited $0 into bank'),
	(14, 'CLC04795', 0, 'deposit', 'Deposited $0 into bank'),
	(15, 'XGI09387', 74000, 'withdraw', 'Withdrawn $74000 from bank'),
	(16, 'CLC04795', 1000, 'withdraw', 'Withdrawn $1000 from bank');

-- Dumping structure for table sgxcorev1.trunkitems
CREATE TABLE IF NOT EXISTS `trunkitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table sgxcorev1.trunkitems: ~4 rows (approximately)
INSERT IGNORE INTO `trunkitems` (`id`, `plate`, `items`) VALUES
	(4, '42SIK520', '[]'),
	(2, '48ZSA984', '[]'),
	(9, '4AS278LZ', '[]'),
	(1, '9AO207SL', '[]');
