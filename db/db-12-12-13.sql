-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 11, 2013 at 09:07 
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `node_test_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(50) NOT NULL,
  `salted_pwd` varchar(128) NOT NULL,
  `salt` varchar(128) NOT NULL,
  `token` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `login`, `salted_pwd`, `salt`, `token`) VALUES
(1, 'dummy', 'fa6a2185b3e0a9a85ef41ffb67ef3c1fb6f74980f8ebf970e4e72e353ed9537d593083c201dfd6e43e1c8a7aac2bc8dbb119c7dfb7d4b8f131111395bd70e97f', 'salt', NULL),
(9, 'Van_awesome', 'ab38ae6218199457c67f1c3f1511049c1e541cd4ec0fd9b3d8826deb6b7c960d741c8d81357687e84d3c5a4159f74532676c59803a6c756a8e0343233569fc7b', '9e0e2001dab445b6abea15769c7ef75d', '123'),
(10, 'elvis', '58662c674caa3d7e7b518569555f2fa658771d054330ff12a70cef858fecebc0a9efa898d9b10073404d088d89fb7345d632bb6b4dd24a313f44b1f18ff7bdcb', '0a77d1f57492407da47b10635db09940', '123'),
(11, 'gustav', 'd25841d0f409938f6ef74f5c49dc8ea0af15e51855f9f8dea36aab4dfb6a3e9ab7d209f07dba63e2858bad21e675a4537a8f741d5da304ca877122b377898704', '76e5f146ffbc4bf0b01ad042f1077958', '123');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
