# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Hôte: localhost (MySQL 5.6.10)
# Base de données: node_test_db
# Temps de génération: 2014-01-11 18:39:18 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Affichage de la table answer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `answer`;

CREATE TABLE `answer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fk_poll` int(11) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;

INSERT INTO `answer` (`id`, `fk_poll`, `description`)
VALUES
	(1,1,'answer yes to poll'),
	(2,1,'answer no to poll'),
	(3,3,'maybe'),
	(4,4,'never'),
	(5,2,'johnny cash'),
	(6,2,'bob dylan'),
	(7,2,'bruce springsteen'),
	(8,5,'YES TO POLL'),
	(9,5,'NO TO POLL'),
	(10,6,'hey ho ha'),
	(11,6,'lalalala'),
	(12,7,'abcd'),
	(13,8,'Alfred is a good boy'),
	(14,9,'please work'),
	(15,10,'bleu'),
	(16,10,'rouge'),
	(17,10,'orange'),
	(18,10,'vert'),
	(19,11,'Jacque dupont'),
	(20,11,'Edgar Silvestre'),
	(21,11,'Gildas Saint claire'),
	(22,11,'Eric Poultre'),
	(23,11,'Silvio Dasilva'),
	(24,11,'Edmond riche'),
	(25,12,'IF26 est genial'),
	(26,12,'la meilleur UV de l\'utt');

/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table poll
# ------------------------------------------------------------

DROP TABLE IF EXISTS `poll`;

CREATE TABLE `poll` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `poll` WRITE;
/*!40000 ALTER TABLE `poll` DISABLE KEYS */;

INSERT INTO `poll` (`id`, `title`, `description`)
VALUES
	(1,'first test poll','fun times'),
	(2,'second test poll','twice the fun times'),
	(3,'third test poll','three times the fun??? that can\'t be right!'),
	(4,'fourth test poll','this one just sucks'),
	(5,'5 answer test','TEST TEST TEST'),
	(6,'6 Popoll','sound and vision'),
	(7,'AZERTY','AZERTYUIOP'),
	(8,'QWERTY','QWERTYUIOP'),
	(9,'hope','hope this works'),
	(10,'Couleur de l\'utt','choisir la couleur des uniformes des equipes sportives de l\'utt'),
	(11,'President du BDE','votez pour le president du BDE de l\'utt'),
	(12,'IF26 avis','donnez votre avis sur IF26');

/*!40000 ALTER TABLE `poll` ENABLE KEYS */;
UNLOCK TABLES;


# Affichage de la table response
# ------------------------------------------------------------

DROP TABLE IF EXISTS `response`;

CREATE TABLE `response` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fk_poll` int(11) NOT NULL,
  `fk_answer` int(11) NOT NULL,
  `fk_user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `response` WRITE;
/*!40000 ALTER TABLE `response` DISABLE KEYS */;

INSERT INTO `response` (`id`, `fk_poll`, `fk_answer`, `fk_user`)
VALUES
	(1,1,1,1),
	(2,3,4,1),
	(3,5,8,1),
	(4,5,8,33),
	(5,5,8,36),
	(6,6,11,36),
	(7,1,2,38),
	(8,9,14,38),
	(9,9,14,36),
	(10,2,6,1),
	(11,9,14,1),
	(12,1,1,40),
	(13,3,3,40),
	(14,6,10,40),
	(15,8,13,40),
	(16,9,14,40),
	(17,8,13,1),
	(18,7,12,1),
	(19,1,2,41),
	(20,10,15,1),
	(21,12,26,1);

/*!40000 ALTER TABLE `response` ENABLE KEYS */;
UNLOCK TABLES;


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
  `mail_token` varchar(128) DEFAULT '',
  `ban_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `login`, `salted_pwd`, `salt`, `token`, `token_validity`, `attempts`, `mail_token`, `ban_date`)
VALUES
	(1,'dummy','fa6a2185b3e0a9a85ef41ffb67ef3c1fb6f74980f8ebf970e4e72e353ed9537d593083c201dfd6e43e1c8a7aac2bc8dbb119c7dfb7d4b8f131111395bd70e97f','salt','5c13f30332ff487dac3425ac83b06a48',1389462107,0,NULL,NULL),
	(9,'Van_awesome','ab38ae6218199457c67f1c3f1511049c1e541cd4ec0fd9b3d8826deb6b7c960d741c8d81357687e84d3c5a4159f74532676c59803a6c756a8e0343233569fc7b','9e0e2001dab445b6abea15769c7ef75d',NULL,NULL,0,NULL,NULL),
	(10,'elvis','58662c674caa3d7e7b518569555f2fa658771d054330ff12a70cef858fecebc0a9efa898d9b10073404d088d89fb7345d632bb6b4dd24a313f44b1f18ff7bdcb','0a77d1f57492407da47b10635db09940',NULL,NULL,0,NULL,NULL),
	(11,'gustav','d25841d0f409938f6ef74f5c49dc8ea0af15e51855f9f8dea36aab4dfb6a3e9ab7d209f07dba63e2858bad21e675a4537a8f741d5da304ca877122b377898704','76e5f146ffbc4bf0b01ad042f1077958',NULL,NULL,0,NULL,NULL),
	(13,'mrtambourine','5f8473d1ee0edb2cf739cc723b3216b1190cc9fd39d48c3ba86e5e098916ec83c35ca268483408becd8c1586bb68cffad5ee73411de67cf09b6e529cc1cb439c','907a68ba1f9942bfb7f547415d373fa2','cea55ac921a249249f10bf8da748b2b4',NULL,0,NULL,NULL),
	(14,'tony','a5d566553cb66557888f2b3af14081d44e261972f4bc0ee4098a1a794ce211c7286726ddb693b5908719c86948910add032cb94c24c4c90a6221ed1c9735d352','672a13bf94ea4f338968f9585c868d80','67c90706380b4e98b2a6e8610a34339b',1387287427,0,NULL,NULL),
	(15,'yvon','97f7017fcc2a0f5118eba4957c095db41dc4d3f93b800647b651e32ec1fa26b984d4e1c5fb771124ffde47b99bdaa6aac3452b2aa2838d46a2059377094b57c9','6bcd8b4c2eeb49bd88726d8b925982ef','tok',123,0,NULL,NULL),
	(16,'nicolas','e89a46e22f315611e97d99adf9afe7e8fe979652c2effc6f949bca7976c6d1de1f2819666666f87c5ca221b1e04c8aff020f95b291b51800bf08841bf1a123c4','210870d4da544cb894bef1dacade6ebd','1c99c70b4c6e48c28c67a125460abe93',NULL,0,NULL,NULL),
	(30,'c','9d71fd2fba8f671aa3af41d0c5a9ed9bb1eb248ad8dd69d75e06b9a28152824262ae5ec23e02a3e77c26afbd27574298b7810df17854d150db63d8f45cf97eef','24dea66b8f7f4115bb56c710cddaaeeb','ec4e047deb6c4bfebef55624b2781433',NULL,0,NULL,NULL),
	(31,'efg','feb345ae8cb9fd6844bed3160a6c95a59697951d59e5318318275ddf3ee48090a9c0af3c37f317d7bcee217669b4fa391d85c0983fa38efba1dc78423905b756','5c587ba937134452b477b37c7bbd3ada','07c3c3f10c8f412c90e1be5e19f6eba8',NULL,0,NULL,NULL),
	(32,'artic','9c1b9a384b3750c6222c3be156ba8880c0367c563cf15fd85eb284abe1018573b1770a558c28a9468c8a24f7d4f24372cb7cf0c32804acb0288d06acbb8111fb','5aaa61ed3f904b73b40650cd9f7ad51a','d99f2ef90efb4eb4b000d4d9823df656',NULL,0,NULL,NULL),
	(33,'edgar','f18893234669364a120a01faf47fdd3c8d43ea5ed52130d61f15c4baf09c37dd7d99eff9fa4d6fd378dd12aed41bb9ebdf066807541c14811e9c8cd4bfb80e55','29dccc4fe403466e9c2816c3d53d7a4a','3a28fc0964304bd0a5ac10f7ab94aa31',1388926767,1,'',NULL),
	(34,'marcel','23eb28d78c2854279eb95626d347c1b1764b39c79e046bb9b71a9159b27a9fef9be5e5737c43830e8a6b7403a0e85d6cf189430e983509134b2899f19b72ff07','4cad2c7b9a5740f3bce304d04852fb04','eafb8861860d4fe08fc7d7edd5389770',NULL,0,'',NULL),
	(35,'xyz','3ce719f2e7041c11234b7dacb97ca2907c9f341abae11dd1e51fd5c74d8f99c3452374030483f9135f26176c0fccd45757a7378b14f957c40164566c89d70030','8a76e3d0e3b44876b9e115f8231420e2','645c207dfcbd4f659a6e5a5a546d3f1d',NULL,0,'',NULL),
	(36,'RRR','68e265c7ce314cbc5e8d882d1bf56814d0186fa35fb67413b56cda42feecec9f540bcb9b9aa838dae7d3e5c34fd23623d5542ed6905dac66d20faae3f3230cf5','31bb451605db47eaa313a2550a8e5183','3fd1dbc34db6405688b5485550f1b6af',1388959515,12,'',1388959622),
	(38,'richard','c97708baeca4156620520da457a0b812e960703e269b9cd24b19ab860a9659b61928da680caef378cb00ce0c8b6fbe4660fda944a9b4af3a0cc3fb716eb35c1f','7d054f18d658432b8ea519082a819c5d','27fae62f59234ec7aa0ba97517a088c4',1388958162,0,'',NULL),
	(39,'orwell','b6f4a3490ee337ba7b348dff64c8f0e54785ce1be9ece19b9eed545562667de141ff90d17fe4b0044e4128297067d0fea7a4a71b0007caff49c042bfdc55fc04','a99f903df8f946a38ba3ded8e767af04','87bfc6c657a4400e947e2ec6590a902f',1389038306,0,'',NULL),
	(40,'dasilva','d658ee003c1faf9f78aefdf432197e3d237f8217c33bcebb556bb46ce129fb9366150135a977728e72e4d65ab47820cd55950865b57dbb5bbd303542d63c7c8b','f8d4f249bdee45d78498ef6eeff98a3f','4f1193a4b62c469191f62e3839b5116d',1389368914,0,'',NULL),
	(41,'toto','c8782c7546a5fa810495fd781bb5cb2aae258ddba45e7dd3caf11802ce252bfb7f42c5f3caa4290b8be3d2a04138c617f63ad3be6dccb645f0b80f671d7e08d6','a876689e064e45e1b36b40ab4dc79455','dbf04dc97a514b47a6fb4054ce74883b',1389374869,0,'',NULL);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
