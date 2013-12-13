# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Hôte: localhost (MySQL 5.6.10)
# Base de données: node_test_db
# Temps de génération: 2013-12-13 16:11:02 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Affichage de la table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(50) NOT NULL,
  `salted_pwd` varchar(128) NOT NULL,
  `salt` varchar(128) NOT NULL,
  `token` varchar(128) DEFAULT NULL,
  `token_validity` int(11) DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `login`, `salted_pwd`, `salt`, `token`, `token_validity`, `attempts`)
VALUES
	(1,'dummy','fa6a2185b3e0a9a85ef41ffb67ef3c1fb6f74980f8ebf970e4e72e353ed9537d593083c201dfd6e43e1c8a7aac2bc8dbb119c7dfb7d4b8f131111395bd70e97f','salt','thisismyhouse',NULL,0),
	(9,'Van_awesome','ab38ae6218199457c67f1c3f1511049c1e541cd4ec0fd9b3d8826deb6b7c960d741c8d81357687e84d3c5a4159f74532676c59803a6c756a8e0343233569fc7b','9e0e2001dab445b6abea15769c7ef75d',NULL,NULL,0),
	(10,'elvis','58662c674caa3d7e7b518569555f2fa658771d054330ff12a70cef858fecebc0a9efa898d9b10073404d088d89fb7345d632bb6b4dd24a313f44b1f18ff7bdcb','0a77d1f57492407da47b10635db09940',NULL,NULL,0),
	(11,'gustav','d25841d0f409938f6ef74f5c49dc8ea0af15e51855f9f8dea36aab4dfb6a3e9ab7d209f07dba63e2858bad21e675a4537a8f741d5da304ca877122b377898704','76e5f146ffbc4bf0b01ad042f1077958',NULL,NULL,0),
	(13,'mrtambourine','5f8473d1ee0edb2cf739cc723b3216b1190cc9fd39d48c3ba86e5e098916ec83c35ca268483408becd8c1586bb68cffad5ee73411de67cf09b6e529cc1cb439c','907a68ba1f9942bfb7f547415d373fa2','cea55ac921a249249f10bf8da748b2b4',NULL,0),
	(14,'tony','a5d566553cb66557888f2b3af14081d44e261972f4bc0ee4098a1a794ce211c7286726ddb693b5908719c86948910add032cb94c24c4c90a6221ed1c9735d352','672a13bf94ea4f338968f9585c868d80','1af88b79873640daa73f426ac08748c7',NULL,0);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
