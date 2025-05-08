CREATE TABLE IF NOT EXISTS `configs` (
  `name` varchar(20) NOT NULL,
  `config` text DEFAULT NULL,
  PRIMARY KEY (`name`)
);

INSERT INTO `configs` (`name`, `config`) VALUES (
	'keylabs', '{"worth1":0,"worth3":0,"washer3":0,"cokelab":0,"weedlab":0,"worth4":0,"methlab":0,"methlab2":0,"washer1":0,"worth2":0,"washer4":0,"washer2":0}'
);
	