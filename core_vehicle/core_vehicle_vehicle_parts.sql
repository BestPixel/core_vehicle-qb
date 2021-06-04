
DROP TABLE IF EXISTS `vehicle_parts`;
CREATE TABLE `vehicle_parts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(100) NOT NULL,
  `parts` longtext NOT NULL,
  `mileage` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;