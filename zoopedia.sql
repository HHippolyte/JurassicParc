-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mer. 28 mars 2018 à 14:31
-- Version du serveur :  5.7.19
-- Version de PHP :  5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `zoopedia`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `SP_afficher_espaces_correspondant_numanimal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_afficher_espaces_correspondant_numanimal` (`numanimal` INT UNSIGNED)  BEGIN
    
SELECT *
FROM espace
WHERE

espace.TYPE_ESPACE=
(SELECT espece.MILIEU_DE_VIE FROM espece INNER JOIN animal ON espece.CODE_ESPECE=animal.CODE_ESPECE
AND animal.NUM_ANIMAL=numanimal)

AND
espace.TAILLE_ESPACE>=(
SELECT espece.ESPACE_MIN_DE_VIE FROM espece INNER JOIN animal ON espece.CODE_ESPECE=animal.CODE_ESPECE
AND animal.NUM_ANIMAL=numanimal)

AND
espace.TEMPERATURE_MINIMUM_ESPACE>=(
SELECT espece.TEMPERATURE_MIN_ESPECE FROM espece INNER JOIN animal ON espece.CODE_ESPECE=animal.CODE_ESPECE
AND animal.NUM_ANIMAL=numanimal)

AND
espace.TEMPERATURE_MAXIMUM_ESPACE<=(
SELECT espece.TEMPERATURE_MAX_ESPECE FROM espece INNER JOIN animal ON espece.CODE_ESPECE=animal.CODE_ESPECE
AND animal.NUM_ANIMAL=numanimal)

AND
espace.SURCAPACITE_ESPACE=0;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `affection`
--

DROP TABLE IF EXISTS `affection`;
CREATE TABLE IF NOT EXISTS `affection` (
  `CODE_AFFECTION` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LIBELLE_AFFECTION` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CODE_AFFECTION`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `affection`
--

INSERT INTO `affection` (`CODE_AFFECTION`, `LIBELLE_AFFECTION`) VALUES
(1, 'Rhume'),
(2, 'Grippe');

-- --------------------------------------------------------

--
-- Structure de la table `aliment`
--

DROP TABLE IF EXISTS `aliment`;
CREATE TABLE IF NOT EXISTS `aliment` (
  `CODE_ALIMENT` tinyint(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NOM_ALIMENT` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TYPE_ALIMENT` char(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TEMPERATURE_CONSERVATION_ALIMENT` float(5,2) DEFAULT NULL,
  PRIMARY KEY (`CODE_ALIMENT`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `aliment`
--

INSERT INTO `aliment` (`CODE_ALIMENT`, `NOM_ALIMENT`, `TYPE_ALIMENT`, `TEMPERATURE_CONSERVATION_ALIMENT`) VALUES
(1, 'Porc', 'Viandes', 20.00),
(2, 'Escalope', 'Viandes', 10.00),
(3, 'Dorade', 'Poisson', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `animal`
--

DROP TABLE IF EXISTS `animal`;
CREATE TABLE IF NOT EXISTS `animal` (
  `NUM_ANIMAL` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NOM_ANIMAL` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `CODE_ESPECE` smallint(5) UNSIGNED NOT NULL,
  `CODE_GROUPE` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `DATE_NAISSANCE_ANIMAL` datetime NOT NULL,
  `DATE_ARRIVEE_ANIMAL` date NOT NULL,
  `POIDS_ANIMAL_KG` float(7,2) NOT NULL,
  `SEXE_ANIMAL` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `PROVENANCE_ANIMAL` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_DECES_ANIMAL` datetime DEFAULT NULL,
  `COMMENTAIRE_ANIMAL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NUM_ANIMAL`),
  KEY `IX_NOM_ANIMAL_CODE_ESPECE` (`NOM_ANIMAL`,`CODE_ESPECE`),
  KEY `FK_APPARTIENT` (`CODE_GROUPE`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `animal`
--

INSERT INTO `animal` (`NUM_ANIMAL`, `NOM_ANIMAL`, `CODE_ESPECE`, `CODE_GROUPE`, `DATE_NAISSANCE_ANIMAL`, `DATE_ARRIVEE_ANIMAL`, `POIDS_ANIMAL_KG`, `SEXE_ANIMAL`, `PROVENANCE_ANIMAL`, `DATE_DECES_ANIMAL`, `COMMENTAIRE_ANIMAL`) VALUES
(1, 'rachni', 1, 0, '2005-01-10 06:45:00', '2018-03-22', 0.02, 'F', 'Zoomania', NULL, NULL),
(2, 'fly', 2, 0, '2010-03-10 07:00:04', '2018-03-22', 0.06, 'F', 'Zooland', NULL, NULL),
(3, 'firebird', 2, 0, '2018-03-23 00:00:00', '2018-03-23', 0.06, 'F', 'Zooland', NULL, NULL);

--
-- Déclencheurs `animal`
--
DROP TRIGGER IF EXISTS `before_datenaiss_insert_animal`;
DELIMITER $$
CREATE TRIGGER `before_datenaiss_insert_animal` BEFORE INSERT ON `animal` FOR EACH ROW BEGIN
IF  NEW.DATE_NAISSANCE_ANIMAL>CURRENT_TIMESTAMP()
THEN 
SET NEW.DATE_NAISSANCE_ANIMAL=NULL;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `atelier`
--

DROP TABLE IF EXISTS `atelier`;
CREATE TABLE IF NOT EXISTS `atelier` (
  `CODE_ATELIER` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NOM_ATELIER` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `PRIX_ATELIER` float(5,2) NOT NULL DEFAULT '8.00',
  `CAPACITE_MAX_ATELIER` int(6) NOT NULL,
  `DATE_ATELIER` date NOT NULL,
  `HEURE_DEBUT_ATELIER` time NOT NULL,
  `HEURE_FIN_ATELIER` time NOT NULL,
  `LOCALISATION_ATELIER` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`CODE_ATELIER`),
  KEY `IX_NOM_ATELIER_DATE_DEBUT` (`NOM_ATELIER`,`HEURE_DEBUT_ATELIER`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `atelier`
--

INSERT INTO `atelier` (`CODE_ATELIER`, `NOM_ATELIER`, `PRIX_ATELIER`, `CAPACITE_MAX_ATELIER`, `DATE_ATELIER`, `HEURE_DEBUT_ATELIER`, `HEURE_FIN_ATELIER`, `LOCALISATION_ATELIER`) VALUES
(1, 'Gouter des gorilles', 8.00, 40, '2018-04-10', '14:00:00', '15:00:00', 'A7'),
(2, 'Nourrir les dauphins', 8.00, 20, '2018-04-03', '09:00:00', '11:00:00', 'B17'),
(3, 'Voyage chez les crustaces', 8.00, 25, '2018-04-19', '10:00:00', '13:00:00', 'H9'),
(4, 'Danse des canards', 8.00, 30, '2018-04-14', '09:00:00', '11:00:00', 'B7');

--
-- Déclencheurs `atelier`
--
DROP TRIGGER IF EXISTS `before_dateatelier_insert_atelier`;
DELIMITER $$
CREATE TRIGGER `before_dateatelier_insert_atelier` BEFORE INSERT ON `atelier` FOR EACH ROW BEGIN
IF NEW.DATE_ATELIER<= CURRENT_TIMESTAMP()
THEN 
SET NEW.DATE_ATELIER=NULL;
END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `before_heuredebut_insert_atelier`;
DELIMITER $$
CREATE TRIGGER `before_heuredebut_insert_atelier` BEFORE INSERT ON `atelier` FOR EACH ROW BEGIN
IF NEW.HEURE_DEBUT_ATELIER>=NEW.HEURE_FIN_ATELIER
THEN 
SET NEW.HEURE_DEBUT_ATELIER=NULL;
END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `before_heurefin_insert_atelier`;
DELIMITER $$
CREATE TRIGGER `before_heurefin_insert_atelier` BEFORE INSERT ON `atelier` FOR EACH ROW BEGIN
IF NEW.HEURE_FIN_ATELIER<=NEW.HEURE_DEBUT_ATELIER
THEN 
SET NEW.HEURE_FIN_ATELIER=NULL;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `distribution`
--

DROP TABLE IF EXISTS `distribution`;
CREATE TABLE IF NOT EXISTS `distribution` (
  `NUM_DISTRIBUTION` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CODE_EMPLOYE` smallint(5) UNSIGNED NOT NULL,
  `CODE_MENUALIMENTAIRE` smallint(5) UNSIGNED NOT NULL,
  `NUM_ESPACE` tinyint(3) UNSIGNED NOT NULL,
  `QUANTITE_KG_DISTRIBUEE` float(7,2) DEFAULT NULL,
  `DATE_DISTRIBUTION` datetime NOT NULL,
  PRIMARY KEY (`NUM_DISTRIBUTION`),
  KEY `FK_DISTRIBUE` (`NUM_ESPACE`),
  KEY `FK_DISTRIBUE2` (`CODE_MENUALIMENTAIRE`),
  KEY `FK_DISTRIBUE3` (`CODE_EMPLOYE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `distribution`
--

INSERT INTO `distribution` (`NUM_DISTRIBUTION`, `CODE_EMPLOYE`, `CODE_MENUALIMENTAIRE`, `NUM_ESPACE`, `QUANTITE_KG_DISTRIBUEE`, `DATE_DISTRIBUTION`) VALUES
(1, 1, 2, 1, 6.00, '2018-04-07 11:00:00'),
(2, 1, 5, 2, 3.00, '2018-04-02 12:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `dosage`
--

DROP TABLE IF EXISTS `dosage`;
CREATE TABLE IF NOT EXISTS `dosage` (
  `NUM_DOSAGE_MENU` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CODE_MENUALIMENTAIRE` smallint(5) UNSIGNED NOT NULL,
  `CODE_ALIMENT` tinyint(1) UNSIGNED NOT NULL,
  `POURCENTAGE_ALIMENT` float(4,2) NOT NULL,
  PRIMARY KEY (`NUM_DOSAGE_MENU`),
  KEY `FK_COMPOSEDE` (`CODE_ALIMENT`),
  KEY `FK_COMPOSE` (`CODE_MENUALIMENTAIRE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `dosage`
--

INSERT INTO `dosage` (`NUM_DOSAGE_MENU`, `CODE_MENUALIMENTAIRE`, `CODE_ALIMENT`, `POURCENTAGE_ALIMENT`) VALUES
(1, 5, 2, 23.00),
(2, 4, 1, 37.00);

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

DROP TABLE IF EXISTS `employe`;
CREATE TABLE IF NOT EXISTS `employe` (
  `CODE_EMPLOYE` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `FONCTION_EMPLOYE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `NOM_EMPLOYE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `PRENOM_EMPLOYE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PASS_EMPLOYE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TEL_EMPLOYE` int(10) NOT NULL,
  `MAIL_EMPLOYE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CODE_EMPLOYE`),
  UNIQUE KEY `TEL_EMPLOYE` (`TEL_EMPLOYE`),
  UNIQUE KEY `MAIL_EMPLOYE` (`MAIL_EMPLOYE`),
  KEY `IX_FONCTION_EMPLOYE_NOM_EMPLOYE` (`FONCTION_EMPLOYE`,`NOM_EMPLOYE`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `employe`
--

INSERT INTO `employe` (`CODE_EMPLOYE`, `FONCTION_EMPLOYE`, `NOM_EMPLOYE`, `PRENOM_EMPLOYE`, `PASS_EMPLOYE`, `TEL_EMPLOYE`, `MAIL_EMPLOYE`) VALUES
(1, 'Soigneur', 'Morin', 'Edgar', 'edgar', 897986789, 'edgarmorin@gmail.com'),
(2, 'Agent accueil', 'Rousseau', 'Guillaume', 'guigui', 978678909, 'guigui@hotmail.fr'),
(3, 'Agent accueil', 'Fernandez', 'Luis', 'luis', 687902347, 'luisfer@yahoo.fr'),
(4, 'Agent accueil', 'Loup', 'Tristan', 'triste', 936475628, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `entree`
--

DROP TABLE IF EXISTS `entree`;
CREATE TABLE IF NOT EXISTS `entree` (
  `NUM_ENTREE` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CODE_VISITEUR` int(10) UNSIGNED NOT NULL,
  `CODE_TARIF_TICKET` tinyint(3) UNSIGNED NOT NULL,
  `CODE_EMPLOYE` smallint(5) UNSIGNED NOT NULL,
  `DATE_ACHAT_ENTREE` datetime NOT NULL,
  `DATE_VISITE` date DEFAULT NULL,
  `PRIX_ENTREE` smallint(6) NOT NULL DEFAULT '10',
  PRIMARY KEY (`NUM_ENTREE`),
  KEY `IX_NUM_ENTREE_DATE_VISITE` (`NUM_ENTREE`,`DATE_VISITE`),
  KEY `FK_CORRESPOND` (`CODE_TARIF_TICKET`),
  KEY `FK_PASSE` (`CODE_VISITEUR`),
  KEY `FK_REALISE` (`CODE_EMPLOYE`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `entree`
--

INSERT INTO `entree` (`NUM_ENTREE`, `CODE_VISITEUR`, `CODE_TARIF_TICKET`, `CODE_EMPLOYE`, `DATE_ACHAT_ENTREE`, `DATE_VISITE`, `PRIX_ENTREE`) VALUES
(1, 1, 2, 3, '2018-03-27 11:00:00', '2018-04-01', 10),
(2, 4, 1, 2, '2018-03-26 07:00:00', '2018-04-02', 10),
(3, 3, 3, 2, '2018-03-22 00:00:00', '2018-04-04', 10),
(4, 4, 1, 2, '2018-03-27 00:00:00', '2018-04-05', 10),
(5, 5, 4, 3, '2018-03-23 00:00:00', '2018-04-06', 10),
(6, 6, 4, 3, '2018-03-20 00:00:00', '2018-04-07', 10),
(7, 7, 1, 4, '2018-03-22 00:00:00', '2018-04-08', 10),
(8, 8, 2, 3, '2018-03-22 00:00:00', '2018-04-09', 10),
(9, 9, 3, 2, '2018-03-23 00:00:00', '2018-04-10', 10),
(10, 10, 4, 2, '2018-03-23 00:00:00', '2018-04-11', 10),
(11, 11, 1, 2, '2018-03-15 00:00:00', '2018-04-12', 10),
(12, 12, 2, 4, '2018-03-14 00:00:00', '2018-04-13', 10),
(13, 13, 3, 3, '2018-03-22 00:00:00', '2018-04-14', 10),
(14, 14, 4, 2, '2018-03-27 00:00:00', '2018-04-15', 10),
(15, 15, 1, 2, '2018-03-22 00:00:00', '2018-04-17', 10),
(16, 16, 2, 3, '2018-03-22 00:00:00', '2018-03-18', 10),
(17, 17, 3, 2, '2018-03-22 00:00:00', '2018-04-19', 10),
(18, 18, 4, 2, '2018-03-22 00:00:00', '2018-04-20', 10),
(19, 19, 1, 3, '2018-03-27 00:00:00', '2018-04-21', 10),
(20, 20, 2, 4, '2018-03-20 00:00:00', '2018-04-22', 10);

--
-- Déclencheurs `entree`
--
DROP TRIGGER IF EXISTS `before_dateachat_insert_entree`;
DELIMITER $$
CREATE TRIGGER `before_dateachat_insert_entree` BEFORE INSERT ON `entree` FOR EACH ROW BEGIN
IF NEW.DATE_ACHAT_ENTREE>=CURRENT_TIMESTAMP()
THEN 
SET NEW.DATE_ACHAT_ENTREE=NULL;
END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `before_datevisite_insert_entree`;
DELIMITER $$
CREATE TRIGGER `before_datevisite_insert_entree` BEFORE INSERT ON `entree` FOR EACH ROW BEGIN
IF NEW.DATE_VISITE>=CURRENT_TIMESTAMP()
THEN 
SET NEW.DATE_VISITE=NULL;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `espace`
--

DROP TABLE IF EXISTS `espace`;
CREATE TABLE IF NOT EXISTS `espace` (
  `NUM_ESPACE` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LIBELLE_ESPACE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `TYPE_ESPACE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `TAILLE_ESPACE` float(7,2) NOT NULL,
  `TEMPERATURE_MINIMUM_ESPACE` float(5,2) NOT NULL,
  `TEMPERATURE_MAXIMUM_ESPACE` float(5,2) NOT NULL,
  `TAUX_HUMIDITE_ESPACE` float(4,2) NOT NULL,
  `LOCALISATION_ESPACE` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `SURCAPACITE_ESPACE` tinyint(1) NOT NULL,
  PRIMARY KEY (`NUM_ESPACE`),
  UNIQUE KEY `LIBELLE_ESPACE` (`LIBELLE_ESPACE`),
  KEY `IX_LIBELLE_ESPACE_TYPE_TAILLE` (`LIBELLE_ESPACE`,`TYPE_ESPACE`,`TAILLE_ESPACE`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `espace`
--

INSERT INTO `espace` (`NUM_ESPACE`, `LIBELLE_ESPACE`, `TYPE_ESPACE`, `TAILLE_ESPACE`, `TEMPERATURE_MINIMUM_ESPACE`, `TEMPERATURE_MAXIMUM_ESPACE`, `TAUX_HUMIDITE_ESPACE`, `LOCALISATION_ESPACE`, `SURCAPACITE_ESPACE`) VALUES
(1, 'Espace des dauphins', 'Vivarium', 56.00, 10.00, 15.00, 67.00, 'A8', 9),
(2, 'Lieu de vie des singes', 'Plein air', 40.00, 20.00, 25.00, 65.00, 'B7', 6),
(3, 'aquarium1', 'marin', 6.00, 15.00, 20.00, 50.00, 'B6', 0);

-- --------------------------------------------------------

--
-- Structure de la table `espace_spectacle`
--

DROP TABLE IF EXISTS `espace_spectacle`;
CREATE TABLE IF NOT EXISTS `espace_spectacle` (
  `CODE_ESPACE_SPECTACLE` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CAPACITE_MAX_ESPACE_SPECTACLE` smallint(5) UNSIGNED NOT NULL,
  `TYPE_ESPACE_SPECTACLE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `LOCALISATION_ESPACE_SPECTACLE` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`CODE_ESPACE_SPECTACLE`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `espace_spectacle`
--

INSERT INTO `espace_spectacle` (`CODE_ESPACE_SPECTACLE`, `CAPACITE_MAX_ESPACE_SPECTACLE`, `TYPE_ESPACE_SPECTACLE`, `LOCALISATION_ESPACE_SPECTACLE`) VALUES
(1, 35, 'Auditorium', 'B8'),
(2, 10, 'Vivarium', 'A3'),
(3, 35, 'Plein air', 'E8'),
(4, 30, 'Plein air', 'E4');

-- --------------------------------------------------------

--
-- Structure de la table `espece`
--

DROP TABLE IF EXISTS `espece`;
CREATE TABLE IF NOT EXISTS `espece` (
  `CODE_ESPECE` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LIBELLE_ESPECE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `CODE_MENUALIMENTAIRE` smallint(5) UNSIGNED NOT NULL,
  `MILIEU_DE_VIE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ESPACE_MIN_DE_VIE` float(7,2) NOT NULL,
  `TEMPERATURE_MIN_ESPECE` float(5,2) NOT NULL,
  `TEMPERATURE_MAX_ESPECE` float(5,2) NOT NULL,
  `TAUX_HUMIDITE_ESPECE` float(5,2) NOT NULL,
  `DESCRIPTION_ESPECE` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `INSCRIPTION_PROGRAMME_CONSERVATION` tinyint(1) NOT NULL,
  PRIMARY KEY (`CODE_ESPECE`),
  KEY `IX_LIBELLE_ESPECE` (`LIBELLE_ESPECE`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `espece`
--

INSERT INTO `espece` (`CODE_ESPECE`, `LIBELLE_ESPECE`, `CODE_MENUALIMENTAIRE`, `MILIEU_DE_VIE`, `ESPACE_MIN_DE_VIE`, `TEMPERATURE_MIN_ESPECE`, `TEMPERATURE_MAX_ESPECE`, `TAUX_HUMIDITE_ESPECE`, `DESCRIPTION_ESPECE`, `INSCRIPTION_PROGRAMME_CONSERVATION`) VALUES
(1, 'Araignee de mer', 2, 'marin', 6.00, 15.00, 20.00, 17.00, 'Un crustacé est un animal arthropode, le plus souvent aquatique.', 0),
(2, 'hirondelle', 3, 'air', 6.00, 10.00, 20.00, 25.00, 'Un oiseau est un animal appartenant à la classe des vertébrés.', 0),
(3, 'chat', 1, 'plein air', 10.00, 18.00, 24.00, 50.00, NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `SIRET_FOURNISSEUR` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `NOM_FOURNISSEUR` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `TYPE_MARCHANDISE_FOURNISSEUR` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ADRESSE_FOURNISSEUR` text COLLATE utf8_unicode_ci NOT NULL,
  `PAYS_FOURNISSEUR` text COLLATE utf8_unicode_ci NOT NULL,
  `TEL_FOURNISSEUR` int(10) NOT NULL,
  `MAIL_FOURNISSEUR` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SIRET_FOURNISSEUR`),
  UNIQUE KEY `SIRET_FOURNISSEUR` (`SIRET_FOURNISSEUR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `fournisseur`
--

INSERT INTO `fournisseur` (`SIRET_FOURNISSEUR`, `NOM_FOURNISSEUR`, `TYPE_MARCHANDISE_FOURNISSEUR`, `ADRESSE_FOURNISSEUR`, `PAYS_FOURNISSEUR`, `TEL_FOURNISSEUR`, `MAIL_FOURNISSEUR`) VALUES
('SIREN746382746', 'Laboheme', 'Aliment', '67 rue de la mouette\r\n56000 VULCA', 'PEROU', 776372850, 'peruvien@yahoo.fr'),
('SIREN898989908', 'Foutre', 'Medicament', '45 rue de la victoire\r\n68007 PARIS', 'FRANCE', 938274637, 'tueugi@gmail.fr');

-- --------------------------------------------------------

--
-- Structure de la table `groupe_petits_animaux`
--

DROP TABLE IF EXISTS `groupe_petits_animaux`;
CREATE TABLE IF NOT EXISTS `groupe_petits_animaux` (
  `CODE_GROUPE` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NOM_GROUPE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `CODE_ESPECE` smallint(5) UNSIGNED NOT NULL,
  `POIDS_GLOBAL_GROUPE` smallint(6) NOT NULL,
  `POIDS_MAX_ANIMAUX_GROUPE` float(7,2) NOT NULL,
  `DATE_DEBUT_GROUPE` date NOT NULL,
  `DATE_FIN_GROUPE` date DEFAULT NULL,
  PRIMARY KEY (`CODE_GROUPE`),
  KEY `IX_NOM_GROUPE_CODE_ESPECE` (`NOM_GROUPE`,`CODE_ESPECE`),
  KEY `FK_COMPOSE_DE` (`CODE_ESPECE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `groupe_petits_animaux`
--

INSERT INTO `groupe_petits_animaux` (`CODE_GROUPE`, `NOM_GROUPE`, `CODE_ESPECE`, `POIDS_GLOBAL_GROUPE`, `POIDS_MAX_ANIMAUX_GROUPE`, `DATE_DEBUT_GROUPE`, `DATE_FIN_GROUPE`) VALUES
(1, '5 - Oiseaux', 4, 8, 6.00, '2018-03-14', '2018-04-05'),
(2, '4 - Araignée de mer', 1, 5, 3.00, '2018-03-07', NULL);

--
-- Déclencheurs `groupe_petits_animaux`
--
DROP TRIGGER IF EXISTS `before_insert_datedebut_groupepetitsanimaux`;
DELIMITER $$
CREATE TRIGGER `before_insert_datedebut_groupepetitsanimaux` BEFORE INSERT ON `groupe_petits_animaux` FOR EACH ROW BEGIN
IF NEW.DATE_DEBUT_GROUPE>CURRENT_TIMESTAMP()
THEN
SET NEW.DATE_DEBUT_GROUPE=NULL;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `lotaliment`
--

DROP TABLE IF EXISTS `lotaliment`;
CREATE TABLE IF NOT EXISTS `lotaliment` (
  `NUM_LOTALIMENT` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CODE_ALIMENT` tinyint(1) UNSIGNED NOT NULL,
  `QUANTITE_KG_ALIMENT_LOT` float(8,2) NOT NULL,
  `SIRET_FOURNISSEUR` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `CODE_STOCKAGE` smallint(5) UNSIGNED DEFAULT NULL,
  `PRIX_ACHAT_LOTALIMENT` float(5,2) NOT NULL,
  `DATE_ACHAT_LOTALIMENT` datetime NOT NULL,
  `DATE_PEREMPTION_LOT` date NOT NULL,
  `DATE_ENTREE_ALIMENT_STOCKAGE` datetime NOT NULL,
  `DATE_SORTIE_ALIMENT_STOCKAGE` datetime DEFAULT NULL,
  PRIMARY KEY (`NUM_LOTALIMENT`),
  UNIQUE KEY `SIRET_FOURNISSEUR` (`SIRET_FOURNISSEUR`),
  KEY `FK_CONSERVEDANS` (`CODE_STOCKAGE`),
  KEY `FK_PROVIENTDE` (`CODE_ALIMENT`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `lotaliment`
--

INSERT INTO `lotaliment` (`NUM_LOTALIMENT`, `CODE_ALIMENT`, `QUANTITE_KG_ALIMENT_LOT`, `SIRET_FOURNISSEUR`, `CODE_STOCKAGE`, `PRIX_ACHAT_LOTALIMENT`, `DATE_ACHAT_LOTALIMENT`, `DATE_PEREMPTION_LOT`, `DATE_ENTREE_ALIMENT_STOCKAGE`, `DATE_SORTIE_ALIMENT_STOCKAGE`) VALUES
(5, 2, 5.00, 'SIREN898989908', 1, 10.00, '2018-03-27 09:00:00', '2018-03-30', '2018-03-28 10:00:00', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `lotmedicament`
--

DROP TABLE IF EXISTS `lotmedicament`;
CREATE TABLE IF NOT EXISTS `lotmedicament` (
  `NUM_LOTMEDICAMENT` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CODE_MEDICAMENT` smallint(5) UNSIGNED NOT NULL,
  `SIRET_FOURNISSEUR` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `QUANTITE_MEDICAMENT_LOT` smallint(6) NOT NULL,
  `CODE_STOCKAGE` smallint(5) UNSIGNED DEFAULT NULL,
  `PRIX_ACHAT_LOTMEDICAMENT` float(5,2) NOT NULL,
  `DATE_ACHAT_MEDICAMENT` date NOT NULL,
  `DATE_PEREMPTION_LOTMEDICAMENT` date NOT NULL,
  `DATE_ENTREE_MEDICAMENT_STOCKAGE` datetime NOT NULL,
  `DATE_SORTIE_MEDICAMENT_STOCKAGE` datetime DEFAULT NULL,
  PRIMARY KEY (`NUM_LOTMEDICAMENT`),
  KEY `FK_ACHETEA` (`SIRET_FOURNISSEUR`),
  KEY `FK_ACHETEEN` (`CODE_MEDICAMENT`),
  KEY `FK_STOCKEDANS` (`CODE_STOCKAGE`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `lotmedicament`
--

INSERT INTO `lotmedicament` (`NUM_LOTMEDICAMENT`, `CODE_MEDICAMENT`, `SIRET_FOURNISSEUR`, `QUANTITE_MEDICAMENT_LOT`, `CODE_STOCKAGE`, `PRIX_ACHAT_LOTMEDICAMENT`, `DATE_ACHAT_MEDICAMENT`, `DATE_PEREMPTION_LOTMEDICAMENT`, `DATE_ENTREE_MEDICAMENT_STOCKAGE`, `DATE_SORTIE_MEDICAMENT_STOCKAGE`) VALUES
(1, 2, 'SIREN898989908', 7, 3, 23.00, '2018-03-15', '2019-06-19', '2018-03-21 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `medicament`
--

DROP TABLE IF EXISTS `medicament`;
CREATE TABLE IF NOT EXISTS `medicament` (
  `CODE_MEDICAMENT` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LIBELLE_MEDICAMENT` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `TYPE_MEDICAMENT` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `DUREE_EFFET_MEDICAMENT` time DEFAULT NULL,
  `TEMPERATURE_CONSERVATION_MEDICAMENT` float(5,2) NOT NULL,
  `CONTREINDICATION_MEDICAMENT` text COLLATE utf8_unicode_ci,
  `FREQUENCE_JOUR_PRISE_MEDICAMENT` tinyint(4) NOT NULL,
  PRIMARY KEY (`CODE_MEDICAMENT`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `medicament`
--

INSERT INTO `medicament` (`CODE_MEDICAMENT`, `LIBELLE_MEDICAMENT`, `TYPE_MEDICAMENT`, `DUREE_EFFET_MEDICAMENT`, `TEMPERATURE_CONSERVATION_MEDICAMENT`, `CONTREINDICATION_MEDICAMENT`, `FREQUENCE_JOUR_PRISE_MEDICAMENT`) VALUES
(1, 'Dermalovaloc', 'Antalgique', '08:00:00', 6.00, NULL, 2),
(2, 'Nurtivol', 'Comprimé', '04:00:00', 10.00, NULL, 3);

-- --------------------------------------------------------

--
-- Structure de la table `menualimentaire`
--

DROP TABLE IF EXISTS `menualimentaire`;
CREATE TABLE IF NOT EXISTS `menualimentaire` (
  `CODE_MENUALIMENTAIRE` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LIBELLE_MENUALIMENTAIRE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `TYPE_MENUALIMENTAIRE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `QUANTITE_KG_RECOMMANDEE_PARKG` float(4,2) NOT NULL,
  PRIMARY KEY (`CODE_MENUALIMENTAIRE`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `menualimentaire`
--

INSERT INTO `menualimentaire` (`CODE_MENUALIMENTAIRE`, `LIBELLE_MENUALIMENTAIRE`, `TYPE_MENUALIMENTAIRE`, `QUANTITE_KG_RECOMMANDEE_PARKG`) VALUES
(1, 'Jour 1 - Girafe', 'Vegetarien', 5.00),
(2, 'Jour 3 - Dauphins', 'Vegetarien', 3.00),
(3, 'Jour 3 - Oiseaux', 'Carnivore', 6.00),
(4, 'Jour 4 - Lion', 'Carnivore', 5.00),
(5, 'Jour 5 - Singe', 'Vegetarien', 4.00);

-- --------------------------------------------------------

--
-- Structure de la table `parent_de`
--

DROP TABLE IF EXISTS `parent_de`;
CREATE TABLE IF NOT EXISTS `parent_de` (
  `NUM_ANIMAL_PARENT` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `NUM_ANIMAL_ENFANT` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`NUM_ANIMAL_PARENT`,`NUM_ANIMAL_ENFANT`),
  KEY `FK_ENFANT` (`NUM_ANIMAL_ENFANT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `parent_de`
--

INSERT INTO `parent_de` (`NUM_ANIMAL_PARENT`, `NUM_ANIMAL_ENFANT`) VALUES
(2, 3);

-- --------------------------------------------------------

--
-- Structure de la table `placement`
--

DROP TABLE IF EXISTS `placement`;
CREATE TABLE IF NOT EXISTS `placement` (
  `NUM_PLACEMENT` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NUM_ESPACE` tinyint(3) UNSIGNED NOT NULL,
  `NUM_ANIMAL` int(10) UNSIGNED NOT NULL,
  `DATE_DEBUT_PLACEMENT` datetime NOT NULL,
  `DATE_FIN_PLACEMENT` datetime DEFAULT NULL,
  PRIMARY KEY (`NUM_PLACEMENT`),
  KEY `FK_EST_PLACE` (`NUM_ANIMAL`),
  KEY `PLACE_DANS` (`NUM_ESPACE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `placement`
--

INSERT INTO `placement` (`NUM_PLACEMENT`, `NUM_ESPACE`, `NUM_ANIMAL`, `DATE_DEBUT_PLACEMENT`, `DATE_FIN_PLACEMENT`) VALUES
(1, 1, 2, '2011-03-14 16:00:00', NULL),
(2, 1, 3, '2018-03-24 10:00:00', NULL);

--
-- Déclencheurs `placement`
--
DROP TRIGGER IF EXISTS `before_insert_datedebut_placement`;
DELIMITER $$
CREATE TRIGGER `before_insert_datedebut_placement` BEFORE INSERT ON `placement` FOR EACH ROW BEGIN
IF NEW.DATE_DEBUT_PLACEMENT>CURRENT_TIMESTAMP()
THEN 
SET NEW.DATE_DEBUT_PLACEMENT=NULL;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `place_atelier`
--

DROP TABLE IF EXISTS `place_atelier`;
CREATE TABLE IF NOT EXISTS `place_atelier` (
  `NUM_PLACE_ATELIER` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NUM_ENTREE` int(10) UNSIGNED NOT NULL,
  `CODE_ATELIER` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`NUM_PLACE_ATELIER`),
  KEY `FK_RESERVE_ATELIER` (`CODE_ATELIER`),
  KEY `FK_CONTIENT` (`NUM_ENTREE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `place_atelier`
--

INSERT INTO `place_atelier` (`NUM_PLACE_ATELIER`, `NUM_ENTREE`, `CODE_ATELIER`) VALUES
(1, 2, 1),
(2, 3, 2);

-- --------------------------------------------------------

--
-- Structure de la table `place_spectacle`
--

DROP TABLE IF EXISTS `place_spectacle`;
CREATE TABLE IF NOT EXISTS `place_spectacle` (
  `NUM_PLACE_SPECTACLE` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CODE_SPECTACLE` int(10) UNSIGNED NOT NULL,
  `NUM_ENTREE` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`NUM_PLACE_SPECTACLE`),
  KEY `FK_COMPRIS_DANS` (`NUM_ENTREE`),
  KEY `FK_EST_ASSOCIE_A` (`CODE_SPECTACLE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `place_spectacle`
--

INSERT INTO `place_spectacle` (`NUM_PLACE_SPECTACLE`, `CODE_SPECTACLE`, `NUM_ENTREE`) VALUES
(1, 2, 1),
(2, 1, 3),
(3, 1, 13),
(4, 2, 17),
(5, 3, 17),
(6, 5, 13);

-- --------------------------------------------------------

--
-- Structure de la table `predation`
--

DROP TABLE IF EXISTS `predation`;
CREATE TABLE IF NOT EXISTS `predation` (
  `CODE_ESPECE_PREDATEUR` smallint(5) UNSIGNED NOT NULL,
  `CODE_ESPECE_PROIE` smallint(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`CODE_ESPECE_PREDATEUR`,`CODE_ESPECE_PROIE`),
  KEY `FK_EST_LA_PROIE_DE` (`CODE_ESPECE_PROIE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `predation`
--

INSERT INTO `predation` (`CODE_ESPECE_PREDATEUR`, `CODE_ESPECE_PROIE`) VALUES
(2, 3);

-- --------------------------------------------------------

--
-- Structure de la table `prise_medicament`
--

DROP TABLE IF EXISTS `prise_medicament`;
CREATE TABLE IF NOT EXISTS `prise_medicament` (
  `NUM_PRISE_MEDICAMENT` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CODE_MEDICAMENT` smallint(5) UNSIGNED NOT NULL,
  `CODE_SOIN` int(10) UNSIGNED NOT NULL,
  `DATE_PRISE_MEDICAMENT` datetime NOT NULL,
  `QUANTITE_MEDICAMENT_MG` float(6,2) NOT NULL,
  PRIMARY KEY (`NUM_PRISE_MEDICAMENT`),
  KEY `FK_COMPREND` (`CODE_MEDICAMENT`),
  KEY `FK_COMPREND2` (`CODE_SOIN`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `prise_medicament`
--

INSERT INTO `prise_medicament` (`NUM_PRISE_MEDICAMENT`, `CODE_MEDICAMENT`, `CODE_SOIN`, `DATE_PRISE_MEDICAMENT`, `QUANTITE_MEDICAMENT_MG`) VALUES
(1, 2, 1, '2018-03-23 06:00:00', 0.50),
(2, 1, 2, '2018-03-28 07:00:00', 1.00);

-- --------------------------------------------------------

--
-- Structure de la table `soins`
--

DROP TABLE IF EXISTS `soins`;
CREATE TABLE IF NOT EXISTS `soins` (
  `CODE_SOIN` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NUM_ANIMAL` int(10) UNSIGNED NOT NULL,
  `CODE_AFFECTION` smallint(5) UNSIGNED DEFAULT NULL,
  `CODE_ORDINAL_VETERINAIRE` smallint(6) NOT NULL,
  `LIBELLE_SOIN` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `TYPE_SOIN` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATE_DEBUT_SOIN` date NOT NULL,
  `DATE_FIN_SOIN` date DEFAULT NULL,
  `RECOMMANDATION_SOIN` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`CODE_SOIN`),
  KEY `FK_EFFECTUE` (`CODE_ORDINAL_VETERINAIRE`),
  KEY `FK_RECOIT` (`NUM_ANIMAL`),
  KEY `FK_SOIGNE` (`CODE_AFFECTION`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `soins`
--

INSERT INTO `soins` (`CODE_SOIN`, `NUM_ANIMAL`, `CODE_AFFECTION`, `CODE_ORDINAL_VETERINAIRE`, `LIBELLE_SOIN`, `TYPE_SOIN`, `DATE_DEBUT_SOIN`, `DATE_FIN_SOIN`, `RECOMMANDATION_SOIN`) VALUES
(1, 2, 1, 2, 'Soigner le pied', NULL, '2018-03-21', NULL, NULL),
(2, 3, NULL, 2, 'Soin de contrôle', 'Contrôle de routine', '2018-03-23', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `spectacle`
--

DROP TABLE IF EXISTS `spectacle`;
CREATE TABLE IF NOT EXISTS `spectacle` (
  `CODE_SPECTACLE` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CODE_ESPACE_SPECTACLE` tinyint(3) UNSIGNED NOT NULL,
  `NOM_SPECTACLE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_SPECTACLE` date NOT NULL,
  `HEURE_DEBUT_SPECTACLE` time NOT NULL,
  `HEURE_FIN_SPECTACLE` time NOT NULL,
  PRIMARY KEY (`CODE_SPECTACLE`),
  KEY `IX_NOM_SPECTACLE_HEURE_DEBUT` (`NOM_SPECTACLE`,`HEURE_DEBUT_SPECTACLE`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `spectacle`
--

INSERT INTO `spectacle` (`CODE_SPECTACLE`, `CODE_ESPACE_SPECTACLE`, `NOM_SPECTACLE`, `DATE_SPECTACLE`, `HEURE_DEBUT_SPECTACLE`, `HEURE_FIN_SPECTACLE`) VALUES
(1, 4, 'Ocean en mouvement', '2018-04-14', '06:00:00', '08:00:00'),
(2, 3, 'Joie des oiseaux', '2018-04-19', '07:00:00', '08:00:00'),
(3, 3, 'Vive les crustaces', '2018-04-19', '10:00:00', '12:00:00'),
(4, 3, 'Tourner le dos aux singes', '2018-04-21', '17:00:00', '19:00:00'),
(5, 2, 'Voyons la vie des meduses', '2018-04-14', '10:00:00', '11:30:00');

--
-- Déclencheurs `spectacle`
--
DROP TRIGGER IF EXISTS `before_datespectacle_insert_spectacle`;
DELIMITER $$
CREATE TRIGGER `before_datespectacle_insert_spectacle` BEFORE INSERT ON `spectacle` FOR EACH ROW BEGIN
IF NEW.DATE_SPECTACLE< CURRENT_TIMESTAMP()
THEN 
SET NEW.DATE_SPECTACLE=NULL;
END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `before_heuredebut_insert_spectacle`;
DELIMITER $$
CREATE TRIGGER `before_heuredebut_insert_spectacle` BEFORE INSERT ON `spectacle` FOR EACH ROW BEGIN
IF NEW.HEURE_DEBUT_SPECTACLE>= NEW.HEURE_FIN_SPECTACLE
THEN 
SET NEW.HEURE_DEBUT_SPECTACLE=NULL;
END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `before_heurefin_insert_spectacle`;
DELIMITER $$
CREATE TRIGGER `before_heurefin_insert_spectacle` BEFORE INSERT ON `spectacle` FOR EACH ROW BEGIN
IF NEW.HEURE_FIN_SPECTACLE<= NEW.HEURE_DEBUT_SPECTACLE
THEN 
SET NEW.HEURE_FIN_SPECTACLE=NULL;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `stockage`
--

DROP TABLE IF EXISTS `stockage`;
CREATE TABLE IF NOT EXISTS `stockage` (
  `CODE_STOCKAGE` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `TYPE_STOCKAGE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TEMPERATURE_STOCKAGE` float(5,2) NOT NULL,
  `LOCALISATION_STOCKAGE` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CODE_STOCKAGE`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `stockage`
--

INSERT INTO `stockage` (`CODE_STOCKAGE`, `TYPE_STOCKAGE`, `TEMPERATURE_STOCKAGE`, `LOCALISATION_STOCKAGE`) VALUES
(1, 'Frigo', -9.00, 'B6'),
(2, 'Frigo', -6.00, 'B9'),
(3, 'Etagère', 5.00, 'A9'),
(4, 'Boîte', 5.00, 'E9');

-- --------------------------------------------------------

--
-- Structure de la table `tarif_ticket`
--

DROP TABLE IF EXISTS `tarif_ticket`;
CREATE TABLE IF NOT EXISTS `tarif_ticket` (
  `CODE_TARIF_TICKET` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LIBELLE_TARIF_TICKET` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `RATIO_TARIF_TICKET` float(5,2) NOT NULL,
  PRIMARY KEY (`CODE_TARIF_TICKET`),
  UNIQUE KEY `LIBELLE_TARIF_TICKET` (`LIBELLE_TARIF_TICKET`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `tarif_ticket`
--

INSERT INTO `tarif_ticket` (`CODE_TARIF_TICKET`, `LIBELLE_TARIF_TICKET`, `RATIO_TARIF_TICKET`) VALUES
(1, 'Ticket entrée enfant', 0.50),
(2, 'Ticket entrée étudiant', 0.70),
(3, 'Ticket entrée adulte', 1.00),
(4, 'Ticket entrée senior', 0.80);

--
-- Déclencheurs `tarif_ticket`
--
DROP TRIGGER IF EXISTS `before_insert_ratio_tarifticket`;
DELIMITER $$
CREATE TRIGGER `before_insert_ratio_tarifticket` BEFORE INSERT ON `tarif_ticket` FOR EACH ROW BEGIN
IF new.RATIO_TARIF_TICKET<=0 
OR new.RATIO_TARIF_TICKET>1
THEN 
SET new.RATIO_TARIF_TICKET=NULL;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `veterinaire`
--

DROP TABLE IF EXISTS `veterinaire`;
CREATE TABLE IF NOT EXISTS `veterinaire` (
  `CODE_ORDINAL_VETERINAIRE` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NOM_VETERINAIRE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `PRENOM_VETERINAIRE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PASS_VETO` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ADRESSE_VETERINAIRE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TEL_VETERINAIRE` int(10) NOT NULL,
  `MAIL_VETERINAIRE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SPECIALISATION_VETERINAIRE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROVENANCE_VETERINAIRE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CODE_ORDINAL_VETERINAIRE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `veterinaire`
--

INSERT INTO `veterinaire` (`CODE_ORDINAL_VETERINAIRE`, `NOM_VETERINAIRE`, `PRENOM_VETERINAIRE`, `PASS_VETO`, `ADRESSE_VETERINAIRE`, `TEL_VETERINAIRE`, `MAIL_VETERINAIRE`, `SPECIALISATION_VETERINAIRE`, `PROVENANCE_VETERINAIRE`) VALUES
(1, 'Duboit', 'Lucile', 'lulu', '78, rue du man', 946378193, 'duduli@yahooo.fr', 'Chrirurgie', 'Laboratoire de Villa'),
(2, 'Marx', 'Karl', 'kalo', '32, rue du bois', 678983456, 'dialo@hotmail.fr', 'Chirurgie du pied', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `visiteur`
--

DROP TABLE IF EXISTS `visiteur`;
CREATE TABLE IF NOT EXISTS `visiteur` (
  `CODE_VISITEUR` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NOM_VISITEUR` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `PRENOM_VISITEUR` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `CATEGORIE_VISITEUR` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `CODEPOSTAL_VISITEUR` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `MAIL_VISITEUR` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CODE_VISITEUR`),
  UNIQUE KEY `MAIL_VISITEUR` (`MAIL_VISITEUR`),
  KEY `IX_NOM_VISITEUR_CATEGORIE` (`NOM_VISITEUR`,`CATEGORIE_VISITEUR`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `visiteur`
--

INSERT INTO `visiteur` (`CODE_VISITEUR`, `NOM_VISITEUR`, `PRENOM_VISITEUR`, `CATEGORIE_VISITEUR`, `CODEPOSTAL_VISITEUR`, `MAIL_VISITEUR`) VALUES
(1, 'Dubocage', 'Maximilien', 'Etudiant', '65009', 'maxdub@gmail.com'),
(2, 'Humbert', 'Hippolyte', 'Etudiant', '69005', 'tylte@yahoo.fr'),
(3, 'Schmidt', 'Angèle', 'Adulte', '68009', 'angele@gmail.com'),
(4, 'Razafindrabe', 'Diana', 'Enfant', '69006', 'dididu74@yahoo.fr'),
(5, 'Chabaka', 'Lola', 'Senior', '35008', 'lolagirl@hotmail.fr'),
(6, 'Nouris', 'Paulo', 'Senior', '67009', NULL),
(7, 'Poulon', 'Lola', 'Enfant', '67009', NULL),
(8, 'Dubolus', 'Maxime', 'Etudiant', '67009', NULL),
(9, 'Frantour', 'Manon', 'Adulte', '38009', NULL),
(10, 'Moulina', 'Nicolas', 'Senior', '59008', NULL),
(11, 'Pimor', 'Joris', 'Enfant', '67009', 'jojo@yahoo.fr'),
(12, 'Pourtinau', 'Lucas', 'Etudiant', '74009', 'lulu@gmail.com'),
(13, 'Marinou', 'Julie', 'Adulte', '98000', NULL),
(14, 'Malon', 'Christophe', 'Senior', '69008', NULL),
(15, 'Ramaloi', 'Lohan', 'Enfant', '74100', 'lolohan@gmail.com'),
(16, 'Jourini', 'Lucile', 'Etudiant', '89000', NULL),
(17, 'Kouliba', 'Mohamed', 'Adulte', '89000', NULL),
(18, 'Marx', 'Antoine', 'Senior', '89000', NULL),
(19, 'Molinar', 'Marie', 'Enfant', '67009', NULL),
(20, 'Loutin', 'Manon', 'Etudiant', '69008', NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `distribution`
--
ALTER TABLE `distribution`
  ADD CONSTRAINT `FK_DISTRIBUE` FOREIGN KEY (`NUM_ESPACE`) REFERENCES `espace` (`NUM_ESPACE`),
  ADD CONSTRAINT `FK_DISTRIBUE2` FOREIGN KEY (`CODE_MENUALIMENTAIRE`) REFERENCES `menualimentaire` (`CODE_MENUALIMENTAIRE`),
  ADD CONSTRAINT `FK_DISTRIBUE3` FOREIGN KEY (`CODE_EMPLOYE`) REFERENCES `employe` (`CODE_EMPLOYE`);

--
-- Contraintes pour la table `dosage`
--
ALTER TABLE `dosage`
  ADD CONSTRAINT `FK_COMPOSE` FOREIGN KEY (`CODE_MENUALIMENTAIRE`) REFERENCES `menualimentaire` (`CODE_MENUALIMENTAIRE`),
  ADD CONSTRAINT `FK_COMPOSEDE` FOREIGN KEY (`CODE_ALIMENT`) REFERENCES `aliment` (`CODE_ALIMENT`);

--
-- Contraintes pour la table `lotaliment`
--
ALTER TABLE `lotaliment`
  ADD CONSTRAINT `FK_CONSERVEDANS` FOREIGN KEY (`CODE_STOCKAGE`) REFERENCES `stockage` (`CODE_STOCKAGE`),
  ADD CONSTRAINT `FK_FOURNIPAR` FOREIGN KEY (`SIRET_FOURNISSEUR`) REFERENCES `fournisseur` (`SIRET_FOURNISSEUR`),
  ADD CONSTRAINT `FK_PROVIENTDE` FOREIGN KEY (`CODE_ALIMENT`) REFERENCES `aliment` (`CODE_ALIMENT`);

--
-- Contraintes pour la table `lotmedicament`
--
ALTER TABLE `lotmedicament`
  ADD CONSTRAINT `FK_ACHETEA` FOREIGN KEY (`SIRET_FOURNISSEUR`) REFERENCES `fournisseur` (`SIRET_FOURNISSEUR`),
  ADD CONSTRAINT `FK_ACHETEEN` FOREIGN KEY (`CODE_MEDICAMENT`) REFERENCES `medicament` (`CODE_MEDICAMENT`),
  ADD CONSTRAINT `FK_STOCKEDANS` FOREIGN KEY (`CODE_STOCKAGE`) REFERENCES `stockage` (`CODE_STOCKAGE`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
