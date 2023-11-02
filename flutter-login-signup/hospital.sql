-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 25 août 2022 à 18:49
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `hospital`
--

-- --------------------------------------------------------

--
-- Structure de la table `approved_appointments`
--

DROP TABLE IF EXISTS `approved_appointments`;
CREATE TABLE IF NOT EXISTS `approved_appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `age` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `ilness_description` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `doctors` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `requested_appointements`
--

DROP TABLE IF EXISTS `requested_appointements`;
CREATE TABLE IF NOT EXISTS `requested_appointements` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `age` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `ilnessdescription` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `doctors` varchar(45) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `requested_appointements`
--

INSERT INTO `requested_appointements` (`UID`, `firstname`, `lastname`, `age`, `email`, `ilnessdescription`, `date`, `doctors`) VALUES
(13, 'reda', 'benali', '26', 'reda.benali@outlook.com', 'flu', '2022-08-27', 'Doctor Djellouli Zakaria(General)');

-- --------------------------------------------------------

--
-- Structure de la table `requests`
--

DROP TABLE IF EXISTS `requests`;
CREATE TABLE IF NOT EXISTS `requests` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `age` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `ethereumAddress` varchar(45) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) NOT NULL DEFAULT '',
  `lastname` varchar(45) NOT NULL,
  `age` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL DEFAULT '',
  `pass` varchar(45) NOT NULL DEFAULT '',
  `ethereumAddress` varchar(45) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`UID`, `firstname`, `lastname`, `age`, `role`, `email`, `pass`, `ethereumAddress`) VALUES
(99, 'samir', 'djellouli', '29', 'director', 'samir.djelloul@yahoo.com', 'samir.djelloul26', '0x1D673E0d38baCCfd295a0397c7EC81d8CcE03Be1'),
(98, 'reda', 'benali', '26', 'patient', 'reda.benali@outlook.com', 'reda.benali15', '0x78186b48b7e6a8bCE443e5Fe4A05233F3FbB6232'),
(97, 'zakaria', 'djellouli', '25', 'doctor', 'zakidjellouli@gmail.com', 'zaki.djellouli@.com4*', '0xd5b6858a1858B6c25B2AC268bd92Ce4Da6C453dB'),
(95, 'ahmed', 'sofiane', '25', 'admin', 'ahmedsofiane@gmail.com', 'ahmed.sofiane@.com', '0x321297929C8be1dA3E4514F20A5FC52d46780a85'),
(96, 'karim', 'oudah', '29', 'receptionist', 'karim.oudah@gmail.com', 'karim.oudah@.com14', '0x13B3Cb1079c0CC6566aD6238Ffa91C0bd27a1b3d');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
