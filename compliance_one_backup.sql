/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.0.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: compliance_one
-- ------------------------------------------------------
-- Server version	12.0.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `compliance_one`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `compliance_one` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `compliance_one`;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` mediumint(8) unsigned NOT NULL,
  `address_lines` varchar(255) NOT NULL,
  `locality` varchar(63) DEFAULT NULL,
  `region` varchar(63) DEFAULT NULL,
  `postcode` varchar(31) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country` (`country_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(63) DEFAULT NULL,
  `name` varchar(63) DEFAULT NULL,
  `local_name` varchar(63) DEFAULT NULL,
  `is_branch` tinyint(1) NOT NULL DEFAULT 0,
  `address_id` int(11) DEFAULT NULL,
  `branch_address_id` int(11) DEFAULT NULL,
  `website` varchar(127) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `comercial_registery` varchar(127) DEFAULT NULL,
  `branch_registery` varchar(127) DEFAULT NULL,
  `listing_country_id` mediumint(8) unsigned DEFAULT NULL,
  `lei` varchar(127) DEFAULT NULL,
  `pep` tinyint(1) NOT NULL DEFAULT 0,
  `soe` tinyint(1) NOT NULL DEFAULT 0,
  `regulated` tinyint(1) NOT NULL DEFAULT 0,
  `ancillary` tinyint(1) NOT NULL DEFAULT 0,
  `acer` varchar(127) DEFAULT NULL,
  `exchange` char(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `local_name` (`local_name`),
  UNIQUE KEY `address_id` (`address_id`),
  UNIQUE KEY `branch_address_id` (`branch_address_id`),
  UNIQUE KEY `website` (`website`),
  UNIQUE KEY `comercial_registery` (`comercial_registery`),
  UNIQUE KEY `branch_registery` (`branch_registery`),
  KEY `contact_id` (`contact_id`),
  KEY `listing_country_id` (`listing_country_id`),
  CONSTRAINT `company_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `company_ibfk_2` FOREIGN KEY (`branch_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `company_ibfk_3` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `company_ibfk_4` FOREIGN KEY (`listing_country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `company_group`
--

DROP TABLE IF EXISTS `company_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(63) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_group`
--

LOCK TABLES `company_group` WRITE;
/*!40000 ALTER TABLE `company_group` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `company_group` VALUES
(4,'Corporate (non-trading)'),
(3,'Finance'),
(2,'Logistics'),
(1,'Trading');
/*!40000 ALTER TABLE `company_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `company_type`
--

DROP TABLE IF EXISTS `company_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `name` varchar(63) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `risk_score` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `company_type_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `company_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_type`
--

LOCK TABLES `company_type` WRITE;
/*!40000 ALTER TABLE `company_type` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `company_type` VALUES
(2,3,'Trading',NULL,0),
(3,1,'Broker (Financial)',NULL,0),
(4,1,'Broker (Phisical)',NULL,0),
(5,1,'Agent',NULL,0);
/*!40000 ALTER TABLE `company_type` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Temporary table structure for view `company_view`
--

DROP TABLE IF EXISTS `company_view`;
/*!50001 DROP VIEW IF EXISTS `company_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `company_view` AS SELECT
 1 AS `id`,
  1 AS `name`,
  1 AS `local_name`,
  1 AS `contact_id`,
  1 AS `address_id` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `family_name` varchar(63) DEFAULT NULL,
  `forenames` varchar(63) DEFAULT NULL,
  `email` varchar(127) DEFAULT NULL,
  `calling_code` varchar(8) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `iso3` char(3) DEFAULT NULL,
  `numeric_code` char(3) DEFAULT NULL,
  `phonecode` varchar(255) DEFAULT NULL,
  `region_id` mediumint(8) unsigned DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `emoji` varchar(191) DEFAULT NULL,
  `wikiDataId` varchar(255) DEFAULT NULL COMMENT 'Rapid API GeoDB Cities',
  `ranking` tinyint(3) unsigned NOT NULL,
  `fatf` tinyint(3) unsigned NOT NULL,
  `transparency` tinyint(3) unsigned NOT NULL,
  `world_bank` tinyint(3) unsigned NOT NULL,
  `sovereignty_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sovereignty_id` (`sovereignty_id`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `country_ibfk_1` FOREIGN KEY (`sovereignty_id`) REFERENCES `country` (`id`),
  CONSTRAINT `country_ibfk_2` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `country` VALUES
(1,'Afghanistan','AFG','004','93',3,33.00000000,65.00000000,'🇦🇫','Q889',0,1,20,0,NULL),
(2,'Aland Islands','ALA','248','+358-18',4,60.11666700,19.90000000,'🇦🇽',NULL,0,1,0,0,213),
(3,'Albania','ALB','008','355',4,41.00000000,20.00000000,'🇦🇱','Q222',0,1,37,0,NULL),
(4,'Algeria','DZA','012','213',1,28.00000000,3.00000000,'🇩🇿','Q262',0,1,36,0,NULL),
(5,'American Samoa','ASM','016','+1-684',5,-14.33333333,-170.00000000,'🇦🇸',NULL,0,1,0,0,233),
(6,'Andorra','AND','020','376',4,42.50000000,1.50000000,'🇦🇩','Q228',0,1,0,0,NULL),
(7,'Angola','AGO','024','244',1,-12.50000000,18.50000000,'🇦🇴','Q916',0,1,33,0,NULL),
(8,'Anguilla','AIA','660','+1-264',2,18.25000000,-63.16666666,'🇦🇮',NULL,0,1,0,0,232),
(9,'Antarctica','ATA','010','672',6,-74.65000000,4.48000000,'🇦🇶',NULL,0,1,0,0,NULL),
(10,'Antigua And Barbuda','ATG','028','+1-268',2,17.05000000,-61.80000000,'🇦🇬','Q781',0,1,0,0,NULL),
(11,'Argentina','ARG','032','54',2,-34.00000000,-64.00000000,'🇦🇷','Q414',0,2,37,0,NULL),
(12,'Armenia','ARM','051','374',3,40.00000000,45.00000000,'🇦🇲','Q399',0,1,47,0,NULL),
(13,'Aruba','ABW','533','297',2,12.50000000,-69.96666666,'🇦🇼',NULL,0,1,0,0,156),
(14,'Australia','AUS','036','61',5,-27.00000000,133.00000000,'🇦🇺','Q408',0,2,75,0,NULL),
(15,'Austria','AUT','040','43',4,47.33333333,13.33333333,'🇦🇹','Q40',0,2,71,0,NULL),
(16,'Azerbaijan','AZE','031','994',3,40.50000000,47.50000000,'🇦🇿','Q227',0,1,23,0,NULL),
(17,'The Bahamas','BHS','044','+1-242',2,24.25000000,-76.00000000,'🇧🇸','Q778',0,1,64,0,NULL),
(18,'Bahrain','BHR','048','973',3,26.00000000,50.55000000,'🇧🇭','Q398',0,1,42,0,NULL),
(19,'Bangladesh','BGD','050','880',3,24.00000000,90.00000000,'🇧🇩','Q902',0,1,24,0,NULL),
(20,'Barbados','BRB','052','+1-246',2,13.16666666,-59.53333333,'🇧🇧','Q244',0,1,69,0,NULL),
(21,'Belarus','BLR','112','375',4,53.00000000,28.00000000,'🇧🇾','Q184',0,1,37,0,NULL),
(22,'Belgium','BEL','056','32',4,50.83333333,4.00000000,'🇧🇪','Q31',0,2,73,0,NULL),
(23,'Belize','BLZ','084','501',2,17.25000000,-88.75000000,'🇧🇿','Q242',0,1,0,0,NULL),
(24,'Benin','BEN','204','229',1,9.50000000,2.25000000,'🇧🇯','Q962',0,1,43,0,NULL),
(25,'Bermuda','BMU','060','+1-441',2,32.33333333,-64.75000000,'🇧🇲',NULL,0,1,0,0,232),
(26,'Bhutan','BTN','064','975',3,27.50000000,90.50000000,'🇧🇹','Q917',0,1,68,0,NULL),
(27,'Bolivia','BOL','068','591',2,-17.00000000,-65.00000000,'🇧🇴','Q750',0,1,29,0,NULL),
(28,'Bosnia and Herzegovina','BIH','070','387',4,44.00000000,18.00000000,'🇧🇦','Q225',0,1,35,0,NULL),
(29,'Botswana','BWA','072','267',1,-22.00000000,24.00000000,'🇧🇼','Q963',0,1,59,0,NULL),
(30,'Bouvet Island','BVT','074','0055',NULL,-54.43333333,3.40000000,'🇧🇻',NULL,0,1,0,0,165),
(31,'Brazil','BRA','076','55',2,-10.00000000,-55.00000000,'🇧🇷','Q155',0,2,36,0,NULL),
(32,'British Indian Ocean Territory','IOT','086','246',1,-6.00000000,71.50000000,'🇮🇴',NULL,0,1,0,0,232),
(33,'Brunei','BRN','096','673',3,4.50000000,114.66666666,'🇧🇳','Q921',0,1,0,0,NULL),
(34,'Bulgaria','BGR','100','359',4,43.00000000,25.00000000,'🇧🇬','Q219',0,0,45,0,NULL),
(35,'Burkina Faso','BFA','854','226',1,13.00000000,-2.00000000,'🇧🇫','Q965',0,0,41,0,NULL),
(36,'Burundi','BDI','108','257',1,-3.50000000,30.00000000,'🇧🇮','Q967',0,1,20,0,NULL),
(37,'Cambodia','KHM','116','855',3,13.00000000,105.00000000,'🇰🇭','Q424',0,1,22,0,NULL),
(38,'Cameroon','CMR','120','237',1,6.00000000,12.00000000,'🇨🇲','Q1009',0,0,27,0,NULL),
(39,'Canada','CAN','124','1',2,60.00000000,-95.00000000,'🇨🇦','Q16',0,2,76,0,NULL),
(40,'Cape Verde','CPV','132','238',1,16.00000000,-24.00000000,'🇨🇻','Q1011',0,1,64,0,NULL),
(41,'Cayman Islands','CYM','136','+1-345',2,19.50000000,-80.50000000,'🇰🇾',NULL,0,1,0,0,232),
(42,'Central African Republic','CAF','140','236',1,7.00000000,21.00000000,'🇨🇫','Q929',0,1,24,0,NULL),
(43,'Chad','TCD','148','235',1,15.00000000,19.00000000,'🇹🇩','Q657',0,1,20,0,NULL),
(44,'Chile','CHL','152','56',2,-30.00000000,-71.00000000,'🇨🇱','Q298',0,1,66,0,NULL),
(45,'China','CHN','156','86',3,35.00000000,105.00000000,'🇨🇳','Q148',0,2,42,0,NULL),
(46,'Christmas Island','CXR','162','61',5,-10.50000000,105.66666666,'🇨🇽',NULL,0,1,0,0,14),
(47,'Cocos (Keeling) Islands','CCK','166','61',5,-12.50000000,96.83333333,'🇨🇨',NULL,0,1,0,0,14),
(48,'Colombia','COL','170','57',2,4.00000000,-72.00000000,'🇨🇴','Q739',0,1,40,0,NULL),
(49,'Comoros','COM','174','269',1,-12.16666666,44.25000000,'🇰🇲','Q970',0,1,20,0,NULL),
(50,'Congo','COG','178','242',1,-1.00000000,15.00000000,'🇨🇬','Q971',0,1,22,0,NULL),
(51,'Democratic Republic of the Congo','COD','180','243',1,0.00000000,25.00000000,'🇨🇩','Q974',0,0,20,0,NULL),
(52,'Cook Islands','COK','184','682',5,-21.23333333,-159.76666666,'🇨🇰','Q26988',0,1,0,0,158),
(53,'Costa Rica','CRI','188','506',2,10.00000000,-84.00000000,'🇨🇷','Q800',0,1,55,0,NULL),
(54,'Cote D\'Ivoire (Ivory Coast)','CIV','384','225',1,8.00000000,-5.00000000,'🇨🇮','Q1008',0,1,40,0,NULL),
(55,'Croatia','HRV','191','385',4,45.16666666,15.50000000,'🇭🇷','Q224',0,0,50,0,NULL),
(56,'Cuba','CUB','192','53',2,21.50000000,-80.00000000,'🇨🇺','Q241',0,1,42,0,NULL),
(57,'Cyprus','CYP','196','357',4,35.00000000,33.00000000,'🇨🇾','Q229',0,1,53,0,NULL),
(58,'Czech Republic','CZE','203','420',4,49.75000000,15.50000000,'🇨🇿','Q213',0,1,57,0,NULL),
(59,'Denmark','DNK','208','45',4,56.00000000,10.00000000,'🇩🇰','Q35',0,2,90,0,NULL),
(60,'Djibouti','DJI','262','253',1,11.50000000,43.00000000,'🇩🇯','Q977',0,1,30,0,NULL),
(61,'Dominica','DMA','212','+1-767',2,15.41666666,-61.33333333,'🇩🇲','Q784',0,1,56,0,NULL),
(62,'Dominican Republic','DOM','214','+1-809 and 1-829',2,19.00000000,-70.66666666,'🇩🇴','Q786',0,1,35,0,NULL),
(63,'East Timor','TLS','626','670',3,-8.83333333,125.91666666,'🇹🇱','Q574',0,1,43,0,NULL),
(64,'Ecuador','ECU','218','593',2,-2.00000000,-77.50000000,'🇪🇨','Q736',0,1,34,0,NULL),
(65,'Egypt','EGY','818','20',1,27.00000000,30.00000000,'🇪🇬','Q79',0,1,35,0,NULL),
(66,'El Salvador','SLV','222','503',2,13.83333333,-88.91666666,'🇸🇻','Q792',0,1,31,0,NULL),
(67,'Equatorial Guinea','GNQ','226','240',1,2.00000000,10.00000000,'🇬🇶','Q983',0,1,17,0,NULL),
(68,'Eritrea','ERI','232','291',1,15.00000000,39.00000000,'🇪🇷','Q986',0,1,21,0,NULL),
(69,'Estonia','EST','233','372',4,59.00000000,26.00000000,'🇪🇪','Q191',0,1,76,0,NULL),
(70,'Ethiopia','ETH','231','251',1,8.00000000,38.00000000,'🇪🇹','Q115',0,1,37,0,NULL),
(71,'Falkland Islands','FLK','238','500',2,-51.75000000,-59.00000000,'🇫🇰',NULL,0,1,0,0,232),
(72,'Faroe Islands','FRO','234','298',4,62.00000000,-7.00000000,'🇫🇴',NULL,0,1,0,0,59),
(73,'Fiji Islands','FJI','242','679',5,-18.00000000,175.00000000,'🇫🇯','Q712',0,1,0,0,NULL),
(74,'Finland','FIN','246','358',4,64.00000000,26.00000000,'🇫🇮','Q33',0,2,87,0,NULL),
(75,'France','FRA','250','33',4,46.00000000,2.00000000,'🇫🇷','Q142',0,2,71,0,NULL),
(76,'French Guiana','GUF','254','594',2,4.00000000,-53.00000000,'🇬🇫',NULL,0,1,0,0,75),
(77,'French Polynesia','PYF','258','689',5,-15.00000000,-140.00000000,'🇵🇫',NULL,0,1,0,0,75),
(78,'French Southern Territories','ATF','260','262',1,-49.25000000,69.16700000,'🇹🇫',NULL,0,1,0,0,75),
(79,'Gabon','GAB','266','241',1,-1.00000000,11.75000000,'🇬🇦','Q1000',0,1,28,0,NULL),
(80,'Gambia The','GMB','270','220',1,13.46666666,-16.56666666,'🇬🇲','Q1005',0,1,37,0,NULL),
(81,'Georgia','GEO','268','995',3,42.00000000,43.50000000,'🇬🇪','Q230',0,1,53,0,NULL),
(82,'Germany','DEU','276','49',4,51.00000000,9.00000000,'🇩🇪','Q183',0,2,78,0,NULL),
(83,'Ghana','GHA','288','233',1,8.00000000,-2.00000000,'🇬🇭','Q117',0,1,43,0,NULL),
(84,'Gibraltar','GIB','292','350',4,36.13333333,-5.35000000,'🇬🇮',NULL,0,1,0,0,232),
(85,'Greece','GRC','300','30',4,39.00000000,22.00000000,'🇬🇷','Q41',0,2,49,0,NULL),
(86,'Greenland','GRL','304','299',2,72.00000000,-40.00000000,'🇬🇱',NULL,0,1,0,0,59),
(87,'Grenada','GRD','308','+1-473',2,12.11666666,-61.66666666,'🇬🇩','Q769',0,1,53,0,NULL),
(88,'Guadeloupe','GLP','312','590',2,16.25000000,-61.58333300,'🇬🇵',NULL,0,1,0,0,75),
(89,'Guam','GUM','316','+1-671',5,13.46666666,144.78333333,'🇬🇺',NULL,0,1,0,0,233),
(90,'Guatemala','GTM','320','502',2,15.50000000,-90.25000000,'🇬🇹','Q774',0,1,23,0,NULL),
(91,'Guernsey and Alderney','GGY','831','+44-1481',4,49.46666666,-2.58333333,'🇬🇬',NULL,0,1,0,0,232),
(92,'Guinea','GIN','324','224',1,11.00000000,-10.00000000,'🇬🇳','Q1006',0,1,26,0,NULL),
(93,'Guinea-Bissau','GNB','624','245',1,12.00000000,-15.00000000,'🇬🇼','Q1007',0,1,22,0,NULL),
(94,'Guyana','GUY','328','592',2,5.00000000,-59.00000000,'🇬🇾','Q734',0,1,40,0,NULL),
(95,'Haiti','HTI','332','509',2,19.00000000,-72.41666666,'🇭🇹','Q790',0,0,17,0,NULL),
(96,'Heard Island and McDonald Islands','HMD','334','672',NULL,-53.10000000,72.51666666,'🇭🇲',NULL,0,1,0,0,14),
(97,'Honduras','HND','340','504',2,15.00000000,-86.50000000,'🇭🇳','Q783',0,1,23,0,NULL),
(98,'Hong Kong S.A.R.','HKG','344','852',3,22.25000000,114.16666666,'🇭🇰','Q8646',0,2,75,0,NULL),
(99,'Hungary','HUN','348','36',4,47.00000000,20.00000000,'🇭🇺','Q28',0,1,42,0,NULL),
(100,'Iceland','ISL','352','354',4,65.00000000,-18.00000000,'🇮🇸','Q189',0,2,72,0,NULL),
(101,'India','IND','356','91',3,20.00000000,77.00000000,'🇮🇳','Q668',0,2,39,0,NULL),
(102,'Indonesia','IDN','360','62',3,-5.00000000,120.00000000,'🇮🇩','Q252',0,2,34,0,NULL),
(103,'Iran','IRN','364','98',3,32.00000000,53.00000000,'🇮🇷','Q794',0,0,24,0,NULL),
(104,'Iraq','IRQ','368','964',3,33.00000000,44.00000000,'🇮🇶','Q796',0,1,23,0,NULL),
(105,'Ireland','IRL','372','353',4,53.00000000,-8.00000000,'🇮🇪','Q27',0,2,77,0,NULL),
(106,'Israel','ISR','376','972',3,31.50000000,34.75000000,'🇮🇱','Q801',0,2,62,0,NULL),
(107,'Italy','ITA','380','39',4,42.83333333,12.83333333,'🇮🇹','Q38',0,2,56,0,NULL),
(108,'Jamaica','JAM','388','+1-876',2,18.25000000,-77.50000000,'🇯🇲','Q766',0,1,44,0,NULL),
(109,'Japan','JPN','392','81',3,36.00000000,138.00000000,'🇯🇵','Q17',0,2,73,0,NULL),
(110,'Jersey','JEY','832','+44-1534',4,49.25000000,-2.16666666,'🇯🇪','Q785',0,1,0,0,232),
(111,'Jordan','JOR','400','962',3,31.00000000,36.00000000,'🇯🇴','Q810',0,1,46,0,NULL),
(112,'Kazakhstan','KAZ','398','7',3,48.00000000,68.00000000,'🇰🇿','Q232',0,1,39,0,NULL),
(113,'Kenya','KEN','404','254',1,1.00000000,38.00000000,'🇰🇪','Q114',0,0,31,0,NULL),
(114,'Kiribati','KIR','296','686',5,1.41666666,173.00000000,'🇰🇮','Q710',0,1,0,0,NULL),
(115,'North Korea','PRK','408','850',3,40.00000000,127.00000000,'🇰🇵','Q423',0,0,17,0,NULL),
(116,'South Korea','KOR','410','82',3,37.00000000,127.50000000,'🇰🇷','Q884',0,2,63,0,NULL),
(117,'Kuwait','KWT','414','965',3,29.50000000,45.75000000,'🇰🇼','Q817',0,1,46,0,NULL),
(118,'Kyrgyzstan','KGZ','417','996',3,41.00000000,75.00000000,'🇰🇬','Q813',0,1,26,0,NULL),
(119,'Laos','LAO','418','856',3,18.00000000,105.00000000,'🇱🇦','Q819',0,1,28,0,NULL),
(120,'Latvia','LVA','428','371',4,57.00000000,25.00000000,'🇱🇻','Q211',0,1,60,0,NULL),
(121,'Lebanon','LBN','422','961',3,33.83333333,35.83333333,'🇱🇧','Q822',0,1,24,0,NULL),
(122,'Lesotho','LSO','426','266',1,-29.50000000,28.50000000,'🇱🇸','Q1013',0,1,39,0,NULL),
(123,'Liberia','LBR','430','231',1,6.50000000,-9.50000000,'🇱🇷','Q1014',0,1,25,0,NULL),
(124,'Libya','LBY','434','218',1,25.00000000,17.00000000,'🇱🇾','Q1016',0,1,18,0,NULL),
(125,'Liechtenstein','LIE','438','423',4,47.26666666,9.53333333,'🇱🇮','Q347',0,1,0,0,NULL),
(126,'Lithuania','LTU','440','370',4,56.00000000,24.00000000,'🇱🇹','Q37',0,1,61,0,NULL),
(127,'Luxembourg','LUX','442','352',4,49.75000000,6.16666666,'🇱🇺','Q32',0,2,78,0,NULL),
(128,'Macau S.A.R.','MAC','446','853',3,22.16666666,113.55000000,'🇲🇴',NULL,0,1,0,0,45),
(129,'North Macedonia','MKD','807','389',4,41.83333333,22.00000000,'🇲🇰','Q221',0,1,42,0,NULL),
(130,'Madagascar','MDG','450','261',1,-20.00000000,47.00000000,'🇲🇬','Q1019',0,1,25,0,NULL),
(131,'Malawi','MWI','454','265',1,-13.50000000,34.00000000,'🇲🇼','Q1020',0,1,34,0,NULL),
(132,'Malaysia','MYS','458','60',3,2.50000000,112.50000000,'🇲🇾','Q833',0,2,50,0,NULL),
(133,'Maldives','MDV','462','960',3,3.25000000,73.00000000,'🇲🇻','Q826',0,1,39,0,NULL),
(134,'Mali','MLI','466','223',1,17.00000000,-4.00000000,'🇲🇱','Q912',0,0,28,0,NULL),
(135,'Malta','MLT','470','356',4,35.83333333,14.58333333,'🇲🇹','Q233',0,1,51,0,NULL),
(136,'Man (Isle of)','IMN','833','+44-1624',4,54.25000000,-4.50000000,'🇮🇲',NULL,0,1,0,0,232),
(137,'Marshall Islands','MHL','584','692',5,9.00000000,168.00000000,'🇲🇭','Q709',0,1,0,0,NULL),
(138,'Martinique','MTQ','474','596',2,14.66666700,-61.00000000,'🇲🇶',NULL,0,1,0,0,75),
(139,'Mauritania','MRT','478','222',1,20.00000000,-12.00000000,'🇲🇷','Q1025',0,1,30,0,NULL),
(140,'Mauritius','MUS','480','230',1,-20.28333333,57.55000000,'🇲🇺','Q1027',0,1,51,0,NULL),
(141,'Mayotte','MYT','175','262',1,-12.83333333,45.16666666,'🇾🇹',NULL,0,1,0,0,75),
(142,'Mexico','MEX','484','52',2,23.00000000,-102.00000000,'🇲🇽','Q96',0,2,31,0,NULL),
(143,'Micronesia','FSM','583','691',5,6.91666666,158.25000000,'🇫🇲','Q702',0,1,0,0,NULL),
(144,'Moldova','MDA','498','373',4,47.00000000,29.00000000,'🇲🇩','Q217',0,1,42,0,NULL),
(145,'Monaco','MCO','492','377',4,43.73333333,7.40000000,'🇲🇨','Q235',0,0,0,0,NULL),
(146,'Mongolia','MNG','496','976',3,46.00000000,105.00000000,'🇲🇳','Q711',0,1,33,0,NULL),
(147,'Montenegro','MNE','499','382',4,42.50000000,19.30000000,'🇲🇪','Q236',0,1,46,0,NULL),
(148,'Montserrat','MSR','500','+1-664',2,16.75000000,-62.20000000,'🇲🇸',NULL,0,1,0,0,232),
(149,'Morocco','MAR','504','212',1,32.00000000,-5.00000000,'🇲🇦','Q1028',0,1,38,0,NULL),
(150,'Mozambique','MOZ','508','258',1,-18.25000000,35.00000000,'🇲🇿','Q1029',0,0,25,0,NULL),
(151,'Myanmar','MMR','104','95',3,22.00000000,98.00000000,'🇲🇲','Q836',0,0,20,0,NULL),
(152,'Namibia','NAM','516','264',1,-22.00000000,17.00000000,'🇳🇦','Q1030',0,0,49,0,NULL),
(153,'Nauru','NRU','520','674',5,-0.53333333,166.91666666,'🇳🇷','Q697',0,1,0,0,NULL),
(154,'Nepal','NPL','524','977',3,28.00000000,84.00000000,'🇳🇵','Q837',0,1,35,0,NULL),
(155,'Bonaire, Sint Eustatius and Saba','BES','535','599',2,12.15000000,-68.26666700,'🇧🇶','Q27561',0,1,0,0,156),
(156,'Netherlands','NLD','528','31',4,52.50000000,5.75000000,'🇳🇱','Q55',0,2,79,0,NULL),
(157,'New Caledonia','NCL','540','687',5,-21.50000000,165.50000000,'🇳🇨',NULL,0,1,0,0,75),
(158,'New Zealand','NZL','554','64',5,-41.00000000,174.00000000,'🇳🇿','Q664',0,2,85,0,NULL),
(159,'Nicaragua','NIC','558','505',2,13.00000000,-85.00000000,'🇳🇮','Q811',0,1,17,0,NULL),
(160,'Niger','NER','562','227',1,16.00000000,8.00000000,'🇳🇪','Q1032',0,1,32,0,NULL),
(161,'Nigeria','NGA','566','234',1,10.00000000,8.00000000,'🇳🇬','Q1033',0,0,25,0,NULL),
(162,'Niue','NIU','570','683',5,-19.03333333,-169.86666666,'🇳🇺','Q34020',0,1,0,0,158),
(163,'Norfolk Island','NFK','574','672',5,-29.03333333,167.95000000,'🇳🇫',NULL,0,1,0,0,14),
(164,'Northern Mariana Islands','MNP','580','+1-670',5,15.20000000,145.75000000,'🇲🇵',NULL,0,1,0,0,233),
(165,'Norway','NOR','578','47',4,62.00000000,10.00000000,'🇳🇴','Q20',0,2,84,0,NULL),
(166,'Oman','OMN','512','968',3,21.00000000,57.00000000,'🇴🇲','Q842',0,1,43,0,NULL),
(167,'Pakistan','PAK','586','92',3,30.00000000,70.00000000,'🇵🇰','Q843',0,1,29,0,NULL),
(168,'Palau','PLW','585','680',5,7.50000000,134.50000000,'🇵🇼','Q695',0,1,0,0,NULL),
(169,'Palestinian Territory Occupied','PSE','275','970',3,31.90000000,35.20000000,'🇵🇸',NULL,0,1,0,0,NULL),
(170,'Panama','PAN','591','507',2,9.00000000,-80.00000000,'🇵🇦','Q804',0,1,35,0,NULL),
(171,'Papua new Guinea','PNG','598','675',5,-6.00000000,147.00000000,'🇵🇬','Q691',0,1,29,0,NULL),
(172,'Paraguay','PRY','600','595',2,-23.00000000,-58.00000000,'🇵🇾','Q733',0,1,28,0,NULL),
(173,'Peru','PER','604','51',2,-10.00000000,-76.00000000,'🇵🇪','Q419',0,1,33,0,NULL),
(174,'Philippines','PHL','608','63',3,13.00000000,122.00000000,'🇵🇭','Q928',0,0,34,0,NULL),
(175,'Pitcairn Island','PCN','612','870',5,-25.06666666,-130.10000000,'🇵🇳',NULL,0,1,0,0,232),
(176,'Poland','POL','616','48',4,52.00000000,20.00000000,'🇵🇱','Q36',0,1,54,0,NULL),
(177,'Portugal','PRT','620','351',4,39.50000000,-8.00000000,'🇵🇹','Q45',0,2,61,0,NULL),
(178,'Puerto Rico','PRI','630','+1-787',2,18.25000000,-66.50000000,'🇵🇷',NULL,0,1,0,0,233),
(179,'Qatar','QAT','634','974',3,25.50000000,51.25000000,'🇶🇦','Q846',0,1,58,0,NULL),
(180,'Reunion','REU','638','262',1,-21.15000000,55.50000000,'🇷🇪',NULL,0,1,0,0,75),
(181,'Romania','ROU','642','40',4,46.00000000,25.00000000,'🇷🇴','Q218',0,1,46,0,NULL),
(182,'Russia','RUS','643','7',4,60.00000000,100.00000000,'🇷🇺','Q159',0,1,26,0,NULL),
(183,'Rwanda','RWA','646','250',1,-2.00000000,30.00000000,'🇷🇼','Q1037',0,1,53,0,NULL),
(184,'Saint Helena','SHN','654','290',1,-15.95000000,-5.70000000,'🇸🇭',NULL,0,1,0,0,232),
(185,'Saint Kitts And Nevis','KNA','659','+1-869',2,17.33333333,-62.75000000,'🇰🇳','Q763',0,1,0,0,NULL),
(186,'Saint Lucia','LCA','662','+1-758',2,13.88333333,-60.96666666,'🇱🇨','Q760',0,1,55,0,NULL),
(187,'Saint Pierre and Miquelon','SPM','666','508',2,46.83333333,-56.33333333,'🇵🇲',NULL,0,1,0,0,75),
(188,'Saint Vincent And The Grenadines','VCT','670','+1-784',2,13.25000000,-61.20000000,'🇻🇨','Q757',0,1,60,0,NULL),
(189,'Saint-Barthelemy','BLM','652','590',2,18.50000000,-63.41666666,'🇧🇱',NULL,0,1,0,0,75),
(190,'Saint-Martin (French part)','MAF','663','590',2,18.08333333,-63.95000000,'🇲🇫',NULL,0,1,0,0,75),
(191,'Samoa','WSM','882','685',5,-13.58333333,-172.33333333,'🇼🇸','Q683',0,1,0,0,NULL),
(192,'San Marino','SMR','674','378',4,43.76666666,12.41666666,'🇸🇲','Q238',0,1,0,0,NULL),
(193,'Sao Tome and Principe','STP','678','239',1,1.00000000,7.00000000,'🇸🇹','Q1039',0,1,45,0,NULL),
(194,'Saudi Arabia','SAU','682','966',3,25.00000000,45.00000000,'🇸🇦','Q851',0,2,52,0,NULL),
(195,'Senegal','SEN','686','221',1,14.00000000,-14.00000000,'🇸🇳','Q1041',0,0,43,0,NULL),
(196,'Serbia','SRB','688','381',4,44.00000000,21.00000000,'🇷🇸','Q403',0,1,36,0,NULL),
(197,'Seychelles','SYC','690','248',1,-4.58333333,55.66666666,'🇸🇨','Q1042',0,1,71,0,NULL),
(198,'Sierra Leone','SLE','694','232',1,8.50000000,-11.50000000,'🇸🇱','Q1044',0,1,35,0,NULL),
(199,'Singapore','SGP','702','65',3,1.36666666,103.80000000,'🇸🇬','Q334',0,2,83,0,NULL),
(200,'Slovakia','SVK','703','421',4,48.66666666,19.50000000,'🇸🇰','Q214',0,1,54,0,NULL),
(201,'Slovenia','SVN','705','386',4,46.11666666,14.81666666,'🇸🇮','Q215',0,1,56,0,NULL),
(202,'Solomon Islands','SLB','090','677',5,-8.00000000,159.00000000,'🇸🇧','Q685',0,1,43,0,NULL),
(203,'Somalia','SOM','706','252',1,10.00000000,49.00000000,'🇸🇴','Q1045',0,1,11,0,NULL),
(204,'South Africa','ZAF','710','27',1,-29.00000000,24.00000000,'🇿🇦','Q258',0,0,41,0,NULL),
(205,'South Georgia','SGS','239','500',2,-54.50000000,-37.00000000,'🇬🇸',NULL,0,1,0,0,232),
(206,'South Sudan','SSD','728','211',1,7.00000000,30.00000000,'🇸🇸','Q958',0,0,13,0,NULL),
(207,'Spain','ESP','724','34',4,40.00000000,-4.00000000,'🇪🇸','Q29',0,2,60,0,NULL),
(208,'Sri Lanka','LKA','144','94',3,7.00000000,81.00000000,'🇱🇰','Q854',0,1,34,0,NULL),
(209,'Sudan','SDN','729','249',1,15.00000000,30.00000000,'🇸🇩','Q1049',0,1,20,0,NULL),
(210,'Suriname','SUR','740','597',2,4.00000000,-56.00000000,'🇸🇷','Q730',0,1,40,0,NULL),
(211,'Svalbard And Jan Mayen Islands','SJM','744','47',4,78.00000000,20.00000000,'🇸🇯',NULL,0,1,0,0,165),
(212,'Swaziland','SWZ','748','268',1,-26.50000000,31.50000000,'🇸🇿','Q1050',0,1,0,0,NULL),
(213,'Sweden','SWE','752','46',4,62.00000000,15.00000000,'🇸🇪','Q34',0,2,82,0,NULL),
(214,'Switzerland','CHE','756','41',4,47.00000000,8.00000000,'🇨🇭','Q39',0,2,82,0,NULL),
(215,'Syria','SYR','760','963',3,35.00000000,38.00000000,'🇸🇾','Q858',0,0,13,0,NULL),
(216,'Taiwan','TWN','158','886',3,23.50000000,121.00000000,'🇹🇼','Q865',0,1,67,0,NULL),
(217,'Tajikistan','TJK','762','992',3,39.00000000,71.00000000,'🇹🇯','Q863',0,1,20,0,NULL),
(218,'Tanzania','TZA','834','255',1,-6.00000000,35.00000000,'🇹🇿','Q924',0,0,40,0,NULL),
(219,'Thailand','THA','764','66',3,15.00000000,100.00000000,'🇹🇭','Q869',0,1,35,0,NULL),
(220,'Togo','TGO','768','228',1,8.00000000,1.16666666,'🇹🇬','Q945',0,1,31,0,NULL),
(221,'Tokelau','TKL','772','690',5,-9.00000000,-172.00000000,'🇹🇰',NULL,0,1,0,0,158),
(222,'Tonga','TON','776','676',5,-20.00000000,-175.00000000,'🇹🇴','Q678',0,1,0,0,NULL),
(223,'Trinidad And Tobago','TTO','780','+1-868',2,11.00000000,-61.00000000,'🇹🇹','Q754',0,1,42,0,NULL),
(224,'Tunisia','TUN','788','216',1,34.00000000,9.00000000,'🇹🇳','Q948',0,1,40,0,NULL),
(225,'Turkey','TUR','792','90',3,39.00000000,35.00000000,'🇹🇷','Q43',0,2,34,0,NULL),
(226,'Turkmenistan','TKM','795','993',3,40.00000000,60.00000000,'🇹🇲','Q874',0,1,18,0,NULL),
(227,'Turks And Caicos Islands','TCA','796','+1-649',2,21.75000000,-71.58333333,'🇹🇨',NULL,0,1,0,0,232),
(228,'Tuvalu','TUV','798','688',5,-8.00000000,178.00000000,'🇹🇻','Q672',0,1,0,0,NULL),
(229,'Uganda','UGA','800','256',1,1.00000000,32.00000000,'🇺🇬','Q1036',0,1,26,0,NULL),
(230,'Ukraine','UKR','804','380',4,49.00000000,32.00000000,'🇺🇦','Q212',0,1,36,0,NULL),
(231,'United Arab Emirates','ARE','784','971',3,24.00000000,54.00000000,'🇦🇪','Q878',0,1,68,0,NULL),
(232,'United Kingdom','GBR','826','44',4,54.00000000,-2.00000000,'🇬🇧','Q145',0,2,71,0,NULL),
(233,'United States','USA','840','1',2,38.00000000,-97.00000000,'🇺🇸','Q30',0,2,69,0,NULL),
(234,'United States Minor Outlying Islands','UMI','581','1',2,0.00000000,0.00000000,'🇺🇲',NULL,0,1,0,0,233),
(235,'Uruguay','URY','858','598',2,-33.00000000,-56.00000000,'🇺🇾','Q77',0,1,73,0,NULL),
(236,'Uzbekistan','UZB','860','998',3,41.00000000,64.00000000,'🇺🇿','Q265',0,1,33,0,NULL),
(237,'Vanuatu','VUT','548','678',5,-16.00000000,167.00000000,'🇻🇺','Q686',0,1,48,0,NULL),
(238,'Vatican City State (Holy See)','VAT','336','379',4,41.90000000,12.45000000,'🇻🇦','Q237',0,1,0,0,238),
(239,'Venezuela','VEN','862','58',2,8.00000000,-66.00000000,'🇻🇪','Q717',0,0,13,0,NULL),
(240,'Vietnam','VNM','704','84',3,16.16666666,107.83333333,'🇻🇳','Q881',0,0,41,0,NULL),
(241,'Virgin Islands (British)','VGB','092','+1-284',2,18.43138300,-64.62305000,'🇻🇬',NULL,0,1,0,0,232),
(242,'Virgin Islands (US)','VIR','850','+1-340',2,18.34000000,-64.93000000,'🇻🇮',NULL,0,1,0,0,233),
(243,'Wallis And Futuna Islands','WLF','876','681',5,-13.30000000,-176.20000000,'🇼🇫',NULL,0,1,0,0,75),
(244,'Western Sahara','ESH','732','212',1,24.50000000,-13.00000000,'🇪🇭',NULL,0,1,0,0,207),
(245,'Yemen','YEM','887','967',3,15.00000000,48.00000000,'🇾🇪','Q805',0,0,16,0,NULL),
(246,'Zambia','ZMB','894','260',1,-15.00000000,30.00000000,'🇿🇲','Q953',0,1,37,0,NULL),
(247,'Zimbabwe','ZWE','716','263',1,-20.00000000,30.00000000,'🇿🇼','Q954',0,1,24,0,NULL),
(248,'Kosovo','XKX','926','383',4,42.56129090,20.34030350,'🇽🇰','Q1246',0,1,41,0,NULL),
(249,'Curaçao','CUW','531','599',2,12.11666700,-68.93333300,'🇨🇼','Q25279',0,1,0,0,156),
(250,'Sint Maarten (Dutch part)','SXM','534','1721',2,18.03333300,-63.05000000,'🇸🇽','Q26273',0,1,0,0,156);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `exchange`
--

DROP TABLE IF EXISTS `exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(3) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=777 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange`
--

LOCK TABLES `exchange` WRITE;
/*!40000 ALTER TABLE `exchange` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `exchange` VALUES
(1,'ASE','American Stock Exchange'),
(2,'NYS','New York Stock Exchange'),
(3,'BOS','Boston Stock Exchange'),
(4,'CIN','National Stock Exchange (formerly Cincinnati Stock Exchange)'),
(5,'PSE','NYSE Arca'),
(6,'XPH','Philadelphia Stock Exchange'),
(7,'THM','Third Market Stock'),
(8,'MID','Chicago Stock Exchange'),
(9,'NYQ','Consolidated Issue, listed by NYSE'),
(10,'TOR','Toronto Stock Exchange'),
(11,'MON','Montreal Stock Exchange'),
(12,'TSX','TSX Venture Exchange'),
(13,'ALB','Alberta Stock Exchange'),
(14,'AOE','American Options Exchange'),
(15,'NYO','New York Options Exchange'),
(16,'PHO','Philadelphia Options Exchange'),
(17,'PAO','NYSE Arca Options'),
(18,'WCB','Chicago Board Options Exchange'),
(19,'ASQ','Consolidated Issue, listed by AMSE'),
(20,'CME','CME:Chicago Mercantile Commodities'),
(21,'IMM','CME:International Monetary Market'),
(22,'IOM','CME:Index and Options Market'),
(23,'CBT','Chicago Board of Trade'),
(24,'ITS','NYSE Alerts'),
(25,'WPG','Winnipeg Commodity Exchange'),
(26,'MGE','Minneapolis Grain Exchange'),
(27,'PBT','Philadelphia Board of Trade'),
(28,'CMX','CEI:Commodities Exchange Centre'),
(29,'CSC','CEI:Coffee, Sugar and Cocoa'),
(30,'NYC','CEI:New York Cotton'),
(31,'NYM','CEI:New York Mercantile'),
(32,'FIS','FTSE SINGAPORE'),
(33,'CSO','CEI:Coffee, Sugar and Cocoa Options'),
(34,'CEO','CEI:Commodities Exchange Centre Options'),
(35,'SHC','Shanghai Commodity Exchange'),
(36,'NYF','New York Futures Exchange'),
(37,'TFE','Toronto Futures Exchange'),
(38,'MIO','Montreal SE IOM division'),
(39,'NMS','NASDAQ Stock Market Exchange Large Cap (formally known as NASDAQ NATIONAL MARKET SYSTEM)'),
(40,'TOE','Toronto Options Exchange'),
(41,'MOE','Montreal Options Exchange'),
(42,'VAO','Vancouver Options Exchange'),
(43,'NAS','NASDAQ Capital Market (from NASDAQ SmallCap)'),
(44,'MDM','Montreal SE Mercantile Division'),
(45,'SCE','Shanghai Cereals & Oils Exchange'),
(46,'BSQ','Consolidated Issue, listed by Boston SE'),
(47,'INS','Instinet ECN'),
(48,'WCQ','Consolidated Issue, listed by CBOE'),
(49,'CRC','Chicago Rice and Cotton Exchange'),
(50,'KBT','Kansas City Board of Trade'),
(51,'SOM','Stockholmsborsen - derivatives (was Om Stockholm)'),
(52,'ADS','NASD Alternative Display Facility for Nasdaq Capital Market'),
(53,'ADF','NASD Alternative Display Facility for Nasdaq Large Cap'),
(54,'MIF','Manila International Futures Exchange'),
(55,'JSF','Japan Securities Finance'),
(56,'TCE','Tokyo Commodity Exchange'),
(57,'TFF','Tokyo Financial Futures Exchange'),
(58,'EME','European Mercantile Exchange'),
(59,'HOM','Helsinki Options and Futures Exchange'),
(60,'FOM','Finland Options Market (Suomen Optiomeklait)'),
(61,'FIR','Florence Stock Exchange'),
(62,'ATH','Athens Stock Exchange'),
(63,'SFF','Swiss Options and Financial Futures Exchange'),
(64,'LSE','London Stock Exchange'),
(65,'JNB','Johannesburg Stock Exchange'),
(66,'LIF','LIFFE'),
(67,'TLV','Tel Aviv Stock Exchange'),
(68,'CPH','Copenhagen Stock Exchange'),
(69,'OSL','Oslo Stock Exchange'),
(70,'STO','Stockholmsborsen - cash (was Stockholm Stock Exchange)'),
(71,'CMA','Madrid SE - Chi-X'),
(72,'LUX','Luxembourg Stock Exchange'),
(73,'BRU','Brussels Stock Exchange'),
(74,'PAR','Paris Stock Exchange'),
(75,'MAD','Madrid Stock Exchange'),
(76,'BAR','Barcelona Stock Exchange'),
(77,'AMS','Amsterdam Stock Exchange'),
(78,'EOE','European Options Exchange'),
(79,'ATA','Amsterdam Agricultural Futures Exchange'),
(80,'VIE','Vienna Stock Exchange'),
(81,'DUS','Dusseldorf Stock Exchange'),
(82,'FRA','Frankfurt Stock Exchange'),
(83,'HAM','Hamburg Stock Exchange'),
(84,'MUN','Munich Stock Exchange'),
(85,'ZRH','Zurich Stock Exchange'),
(86,'GVA','Geneva Stock Exchange'),
(87,'BSL','Basel Stock Exchange'),
(88,'MIL','Milan Stock Exchange'),
(89,'CSM','Sibe Mercado Espanola - Chi-X'),
(90,'CML','Milan SE - Chi-X'),
(91,'NZE','New Zealand Stock Exchange'),
(92,'HKG','Stock Exchange of Hong Kong Limited'),
(93,'SIM','Singapore Exchange Derivatives Trading'),
(94,'KLC','Mdex Commodity Market'),
(95,'CCH','Copenhagen SE - Chi-X'),
(96,'CXE','Xetra - Chi-X'),
(97,'CAM','Amsterdam SE - Chi-X'),
(98,'CBS','Brussels SE - Chi-X'),
(99,'LME','London Metals Exchange'),
(100,'CLB','Lisbon SE - Chi-X'),
(101,'LCE','London Commodity Exchange'),
(102,'CPA','Paris SE - Chi-X'),
(103,'CFR','Frankfurt SE - Chi-X'),
(104,'CLO','London SE - Chi-X'),
(105,'SFE','Sydney Futures Exchange'),
(106,'TYO','Tokyo Stock Exchange'),
(107,'NGO','Nagoya Stock Exchange'),
(108,'SAP','Sapporo Stock Exchange'),
(109,'NII','Niigata Stock Exchange'),
(110,'KYO','Kyoto Stock Exchange'),
(111,'HIR','Hiroshima Stock Exchange'),
(112,'FKA','Fukuoku Stock Exchange'),
(113,'OSA','Osaka Stock Exchange'),
(114,'HFE','Hong Kong Futures Exchange Limited'),
(115,'BER','Berlin Stock Exchange'),
(116,'HAN','Hanover Stock Exchange'),
(117,'STU','Stuttgart Stock Exchange'),
(118,'BRE','Bremen Stock Exchange'),
(119,'COK','Osaka Mercantile SE - Chi-X'),
(120,'BRN','Berne Stock Exchange'),
(121,'CSS','Swiss SE - Chi-X'),
(122,'CHE','Helsinki SE - Chi-X'),
(123,'CVX','Virt-X - Chi-X'),
(124,'ROM','Rome Stock Exchange'),
(125,'TRN','Turin Stock Exchange'),
(126,'GOA','Genoa Stock Exchange'),
(127,'NAP','Naples Stock Exchange'),
(128,'PAL','Palermo Stock Exchange'),
(129,'BLO','Bologna Stock Exchange'),
(130,'VCE','Venice Stock Exchange'),
(131,'ISF','Istanbul Stock Exchange (Mutual Funds)'),
(132,'AQC','NASDAQ Limit Order Matching System (NAQCESS)'),
(133,'HEX','Helsinki Exchange'),
(134,'WSE','Warsaw Stock Exchange'),
(135,'BOR','Bordeaux Stock Exchange'),
(136,'LIL','Lille Stock Exchange'),
(137,'LYO','Lyon Stock Exchange'),
(138,'MRS','Marseilles Stock Exchange'),
(139,'NAY','Nancy Stock Exchange'),
(140,'NAN','Nantes Stock Exchange'),
(141,'JDE','Joint Asian Derivatives Exchange'),
(142,'LAG','Lagos Stock Exchange'),
(143,'ZSE','Zimbabwe Stock Exchange'),
(144,'SHH','Shanghai Stock Exchange'),
(145,'BSE','Bombay Stock Exchange'),
(146,'CAL','Calcutta Stock Exchange'),
(147,'DES','Delhi Stock Exchange'),
(148,'MDS','Madras Stock Exchange'),
(149,'JKT','Indonesia Stock Exchange (formerly Jakarta SE)'),
(150,'KLS','Bursa Malaysia Consolidated Equities and Derivatives (formerly Kuala Lumpur Stock Exchange)'),
(151,'KAR','Karachi Stock Exchange'),
(152,'MAK','Makati Stock Exchange'),
(153,'MNL','Manila Stock Exchange'),
(154,'FTM','Financiele Termijn Markt, Amsterdam'),
(155,'SES','Singapore Exchange Securities Trading Ltd'),
(156,'KSC','Korea Exchange - KSE'),
(157,'MAU','Mauritius Stock Exchange'),
(158,'SET','The Stock Exchange of Thailand'),
(159,'BAH','Bahrain Stock Exchange'),
(160,'CAI','Cairo Stock Exchange'),
(161,'AMM','Amman Stock Exchange'),
(162,'KUW','Kuwait Stock Exchange'),
(163,'BUE','Buenos Aires Stock Exchange'),
(164,'RIO','Rio Fixed Income Exchange'),
(165,'SAO','Sao Paolo Stock Exchange'),
(166,'SGO','Santiago Stock Exchange'),
(167,'BOG','Bogota Stock Exchange'),
(168,'MEX','Mexico SE Principal Market'),
(169,'CCS','Caracas Stock Exchange'),
(170,'NFE','New Zealand Futures Exchange'),
(171,'IND','World Indices'),
(172,'FIX','Fixings'),
(173,'LOT','London Over The Counter Market'),
(174,'MAT','Paris Financial Futures Exchange ( MATIF )'),
(175,'TAI','Taiwan Stock Exchange'),
(176,'IPE','ICE Futures'),
(177,'CVI','Vienna SE - Chi-X'),
(178,'CIR','Irish SE - Chi-X'),
(179,'CLU','Luxemburg SE - Chi-X'),
(180,'SOP','Suomen Optioporssi'),
(181,'REU','Reuters'),
(182,'LIS','Lisbon Stock Exchange'),
(183,'OPO','Oporto Stock Exchange'),
(184,'NOM','Norwegian Options Market (Norsk Opsjonmarked)'),
(185,'CLT','Latino / America Market in Spain - Chi-X'),
(186,'RTS','RUSSIAN TRADING SYSTEM (PAUFOR) - RTS'),
(187,'ASX','Australian Stock Exchange - SEATS'),
(188,'IFX','Irish Options and Futures Exchange'),
(189,'PmI','Stockholmsborsen - fixed income (was Penningsmarknads Information AB)'),
(190,'MCE','SIBE - Mercado continuo Espanol'),
(191,'CVA','Valencia SE - Chi-X'),
(192,'TGE','Tokyo Grain Exchange'),
(193,'TSU','Tokyo Sugar Exchange'),
(194,'KRE','Kobe Rubber Exchange'),
(195,'MRV','MEFF Renta Variable'),
(196,'AOM','Australian Options market'),
(197,'BFX','Brussels Futures and Options Exchange'),
(198,'BRT','Brussels SE Forward Market'),
(199,'DTB','Deutsche Terminboerse'),
(200,'MRF','MEFF Renta Fija'),
(201,'CBA','Barcelona SE - Chi-X'),
(202,'GER','Xetra Level 1'),
(203,'MTS','MTS Italy'),
(204,'IST','Istanbul Stock Exchange'),
(205,'MUS','Muscat Stock Exchange'),
(206,'ABJ','Bourse de Valeurs d\'Abidjan'),
(207,'NAI','Nairobi Stock Exchange'),
(208,'TUN','Tunis Stock Exchange'),
(209,'FSI','FT-SE International'),
(210,'NIN','NASDAQ International (pending SEC approval)'),
(211,'MCP','Interbolsa - Portuguese Continuous Market'),
(212,'OTB','Osterreichische Termin und Optionenboerse (Austrian FOX)'),
(213,'SIC','Singapore Commodity Exchange'),
(214,'RCT','Source is a Reuter contributor'),
(215,'IGF','Italian Government Forwards'),
(216,'MWQ','Consolidated issue, listed by Midwest SE'),
(217,'PSQ','Consolidated issue, listed by Pacific SE'),
(218,'PHQ','Consolidated issue, listed by Philadelphia SE'),
(219,'JSD','JASDAQ'),
(220,'ECM','American SE Emerging Company Marketplace'),
(221,'OBB','NASD OTC Bulletin Board Market'),
(222,'IFM','SIA Futures Market'),
(223,'MFI','Madrid Fixed Income'),
(224,'SME','Shanghai Metal Exchange'),
(225,'SHZ','Shenzhen Stock Exchange'),
(226,'RSA','South African Quotations'),
(227,'BUD','Budapest Stock Exchange'),
(228,'PHS','Philippine Stock Exchange'),
(229,'MLT','Malta Stock Exchange'),
(230,'COX','OFEX - Chi-X'),
(231,'SZM','Shenzhen Mercantile Exchange'),
(232,'SZF','Shenzhen Futures Exchange'),
(233,'JBT','Japan Bond Trading Co. Ltd.'),
(234,'MDC','Maebashi Dried Cocoon Exchange'),
(235,'NTC','Nagoya Textile Exchange'),
(236,'YSE','Yokohama Silk Exchange'),
(237,'OTE','Osaka Textile Exchange'),
(238,'NAK','Nakadachi Securities'),
(239,'CBE','Berlin SE - Chi-X'),
(240,'TOT','Thailand OTC Exchange'),
(241,'AHM','Ahemdebad Stock Exchange'),
(242,'KLF','Kuala Lumpur Options and Financial Futures Exchange'),
(243,'CSE','Colombo Stock Exchange'),
(244,'BEC','Chile Electronic Exchange, Santiago'),
(245,'MXI','Mexico SE Intermediate Market'),
(246,'ZHC','China Zhengzhou Commodity Exchange'),
(247,'BJC','Beijing Commodities Exchange'),
(248,'CBU','Budapest SE - Chi-X'),
(249,'GUF','Guangdong United Futures Exchange'),
(250,'BMF','Brazilian Commodties and Futures Exchange'),
(251,'VSE','Ho Chi Minh City Securities Trading Center'),
(252,'SFX','South African Futures Exchange'),
(253,'CMU','Munich SE - Chi-X'),
(254,'DLC','Dalian Commodities Exchange'),
(255,'CSW','China Swap Centres'),
(256,'COO','Oslo SE - Chi-X'),
(257,'NIK','Nihon Keizai Shinbun (Nikkei)'),
(258,'OGE','Osaka Grain Exchange'),
(259,'OSU','Osaka Sugar Exchange'),
(260,'DPG','Deute Public de la Generalitat de Cataluna (Spain)'),
(261,'ISE','Irish Stock Exchange'),
(262,'CAS','Casablanca Stock Exchange'),
(263,'BSM','Botswana Share Market'),
(264,'NSE','Namibian Stock Exchange'),
(265,'CPL','Plus Market Group - Chi-X'),
(266,'CPR','Prague SE - Chi-X'),
(267,'CWS','Warsaw SE - Chi-X'),
(268,'CST','Stockholm SE - Chi-X'),
(269,'CAT','Athens SE - Chi-X'),
(270,'BSW','Beijing Swap Centres'),
(271,'BAT','BATS ECN - RDFD'),
(272,'OML','OMLX:London Securities & Derivatives Exchange'),
(273,'PRA','Prague Stock Exchange'),
(274,'CDN','Canadian over the counter Echange'),
(275,'TMO','Tjumen Moscow Oil Exchange'),
(276,'BSC','Bashkirian Spec.Exchange'),
(277,'RCR','Russian Commodities and Raw Materials'),
(278,'RUS','Russian Stock Exchange'),
(279,'RIM','Russian Intl.Money and Stock Exchange'),
(280,'MCS','Moscow Central Stock Exchange'),
(281,'MOS','Moscow Commodity Exchange'),
(282,'SPS','St.Petersburg Stock Exchange'),
(283,'STP','St.Petersburg Commodity Exchange'),
(284,'SAR','Saratov Stock Exchange'),
(285,'NIZ','Nizhegorodskaya Stock Exchange'),
(286,'NCS','North Caucasian Stock Exchange'),
(287,'SUE','South Urals Stock Exchange'),
(288,'UKR','Ukraine Commodity Exchange'),
(289,'EKA','Ekaterinburg Stock Exchange'),
(290,'SIB','Siberian Stock Exchange'),
(291,'WSS','West Siberian Stock Exchange'),
(292,'VLA','Vladivostok Stock Exchange'),
(293,'ISI','International Sec.Inst.'),
(294,'BCE','Budapest Commodities Exchange'),
(295,'CFE','China Commodity Futures Exchange, Inc.of Hainan'),
(296,'SUC','Suzhou Commodities Exchange'),
(297,'CUC','Changchun United Commodity Exchange'),
(298,'CLM','CLIMEX'),
(299,'SYC','Shenyang Commodity Exchange'),
(300,'CUF','Chengdu United Futures Exchange'),
(301,'NET','Beijing National Electronic Trading'),
(302,'MAE','Mercado Abierto Electronico'),
(303,'CYS','Cyprus Stock Exchange'),
(304,'BES','Beirut Secondary Markets'),
(305,'BBF','Brazilian Futures Exchange'),
(306,'LMA','Bolsa Valores de Lima, Peru'),
(307,'PP','Private Placements'),
(308,'MED','Bolsa de Medellin'),
(309,'QTO','Bolsa de Quito'),
(310,'GYQ','Bolsa de Guayaquil'),
(311,'OSE','Occidente SE'),
(312,'MRC','Maracaibo Stock Exchange'),
(313,'BEV','Electronic Stock Exchange of Venezuela'),
(314,'MTV','Bolsa de Montevideo'),
(315,'NFM','NanFang Non-ferrous Metal Exchange'),
(316,'ANT','Antwerp Stock Exchange'),
(317,'BAS','Buenos Aires Mercado de Valores Rueda Continua (OTC)'),
(318,'RCN','Buenos Aires Mercado de Valores (consolidated)'),
(319,'GTQ','Bolsa de Valores de Guatemala'),
(320,'OTC','Over the Counter Markets'),
(321,'TUF','Tianjin United Futures Exchange'),
(322,'NSI','National Stock Exchange of India'),
(323,'OTI','OTC Exchange of India'),
(324,'VAL','Valencia Stock Exchange'),
(325,'tst','Test'),
(326,'CQC','Chongqing Commodities Exchange'),
(327,'BOB','Bratislava Options Exchange'),
(328,'BRA','Bratislava Stock Exchange'),
(329,'BLG','Bulgarian Stock Exchange'),
(330,'BUH','Bucharest Stock Exchange'),
(331,'KAB','Kabu.com Securities Co Ltd'),
(332,'ZAG','Zagreb Stock Exchange'),
(333,'MME','Mdex Non-Equity Financial Market'),
(334,'BIL','Bilbao Stock Exchange'),
(335,'SWX','Swiss Exchange (Elektronische Boersen Schwiez)'),
(336,'FCM','Futuros de Citricos y Mercaderias De Valencia'),
(337,'BDP','Bolsa de Derivados do Porto'),
(338,'FDI','Fondos de Inversion Espanoles'),
(339,'BDC','The Thai Bond Market Association'),
(340,'BDB','Beirut Stock Exchange'),
(341,'LJU','Ljubljana Stock Exchange'),
(342,'MCX','Micex'),
(343,'CCF','Chicago Climate Futures Exchange'),
(344,'WCE','Warsaw Commodity Exchange'),
(345,'LJC','Ljubljana Commodity Exchange'),
(346,'SUB','Indonesia Stock Exchange (formerly Surabaya SE)'),
(347,'BCC','Mercado A Termino de Buenos Aires S.A (formerly Buenos Aires Cereal Market)'),
(348,'LAH','Lahore Stock Exchange'),
(349,'CHT','Chittagong Stock Exchange'),
(350,'F4K','FTSE4Good UK 50 ICW'),
(351,'DSE','Dhaka Stock Exchange'),
(352,'MNP','Monep'),
(353,'LNM','Le Nouveau Marche (EURO NM)'),
(354,'TPT','Tradepoint Exchange'),
(355,'GEM','Growth and Emerging Markets - Chicago Mercantile Exchange'),
(356,'RUO','Russian OTC Exchange'),
(357,'IGE','Istanbul Gold Exchange'),
(358,'KEX','Kansai Commodities Exchange'),
(359,'NGE','Nagoya Grain Exchange'),
(360,'F4S','FTSE4Good US 100 ICW'),
(361,'F4I','FTSE4Good Global 100 ICW'),
(362,'TDC','Toyohashi Dried Cocoon Exchange'),
(363,'IZC','Izmir Commodity Exchange'),
(364,'JSN','FTSE/JSE EOD CORE INDICES CONSTITUENT & TRACKER'),
(365,'EAS','European Association of Securities Dealers Automated Quotations (EASDAQ)'),
(366,'TIR','Tirana Stock Exchange'),
(367,'ELX','Finnish Electricity Exchange'),
(368,'ICX','Iceland Stock Exchange'),
(369,'HKO','Hong Kong Stock Exchange Options'),
(370,'CCX','Central Japan Commodity Exchange'),
(371,'WPE','Winnipeg'),
(372,'AIF','Association de Intermediarios de Activos Financieros'),
(373,'RIX','Riga Stock Exchange'),
(374,'VLX','Vilnius Stock Exchange'),
(375,'TLX','Joint Baltic Markets'),
(376,'SNC','SINAC'),
(377,'GSE','Ghana Stock Exchange'),
(378,'NCE','North Cyprus Exchange'),
(379,'BZA','Bond Exchange of South Africa'),
(380,'KOE','Korea Exchange - KOSDAQ'),
(381,'ASG','Agrarian Stock Exchange of Guatemala'),
(382,'SMA','Rio de Janeiro OTC'),
(383,'DIN','Dubai International Financial Exchange Non-Members Level 1'),
(384,'BFO','Buenos Aires Futures and Options Exchange (Argentina)'),
(385,'MFE','Mexico Futures and Options Exchange'),
(386,'ROS','Rosario Stock Exchange (Argentina)'),
(387,'DIM','Dubai International Financial Exchange Members Level 1'),
(388,'DPP','Direct Participation Program - NASDAQ'),
(389,'AEX','Amsterdam Exchanges'),
(390,'TWO','GreTai Securities Market'),
(391,'NPX','Nordpool Power Exchange'),
(392,'PUX','PULPEX Exchange'),
(393,'SPC','Saint Petersburg Currency Exchange'),
(394,'AVK','AVK Brokerage St Petersburg'),
(395,'NEO','Norwegian Electricity OTC'),
(396,'OME','Osaka Mercantile Exchange'),
(397,'TIM','Taiwan Futures Exchange'),
(398,'IBS','IBIS Interbank information system'),
(399,'DJI','Dow Jones Index'),
(400,'NZI','New Zealand Interest Rate Indices'),
(401,'FMF','French Mutual Funds'),
(402,'LUS','Lusaka Stock Exchange'),
(403,'RSQ','RASDAQ'),
(404,'CT1','Ceto OTC Regulated Market'),
(405,'SSU','Sisinau SE (Moldova)'),
(406,'MSE','Moscow SE'),
(407,'DI2','Dubai International Financial Exchange Members Level 2'),
(408,'DN2','Dubai International Financial Exchange Non-Members Level 2'),
(409,'OTK','Kazakhstan OTC Market'),
(410,'WTB','Warenterminboerse Hannover (Commodity Exchange Hannover/WTB)'),
(411,'STX','STOXX Ltd.'),
(412,'ENM','(EURO NM)'),
(413,'ANM','AMSTERDAM - Nieuwe Markt NMAX (EURO NM)'),
(414,'BNM','BRUSSELS - EURO NM Belgium (EURO NM)'),
(415,'FNM','FRANKFURT - Neuer Markt (EURO NM)'),
(416,'RUX','Russian Exchange'),
(417,'FST','FT-SE Trader'),
(418,'EUX','EUREX'),
(419,'CFF','Cantor Financial Futures Exchange'),
(420,'SAU','Saudi Arabian Stock Exchange'),
(421,'SPF','SPOIF'),
(422,'BFE','Baltic Full Service (was Baltic Stock Exchange)'),
(423,'KAZ','Kazakhstan Stock Exchange'),
(424,'CIE','Channel Islands Stock Exchange'),
(425,'YCE','Yokohama Commodity Exchange'),
(426,'CMM','Commodity & Monetary Exchange of Malaysia'),
(427,'APX','Amsterdam Power Exchange'),
(428,'MDE','Mexican Derivatives Exchange Futures Service'),
(429,'KFE','Korea Exchange - KOFEX'),
(430,'BEL','Belgrade Stock Exchange'),
(431,'RMS','RM System (Czech Republic)'),
(432,'BXS','Brussels Exchanges'),
(433,'BKG','Bank of Greece'),
(434,'MDQ','Malaysian Exch of Securities Dealing (MESDAQ)'),
(435,'EWX','European Warrant Exchange (EUWAX)'),
(436,'DBX','Dubai Financial Market'),
(437,'TNL','Romanian Equities traded but not listed.'),
(438,'ADE','ATHENS DERIVATIVES EXCHANGE'),
(439,'FFE','Fukuoka Futures Exchange'),
(440,'PNK','US \'Other OTC\'(Pink Sheets)'),
(441,'MSI','Morgan Stanley Capital International.'),
(442,'LID','Liffe delayed 15min'),
(443,'IBK','Indian Government Benchmarks'),
(444,'DSM','Doha Securities Market'),
(445,'TOS','Tokyo Stock Exchange Trading Network System'),
(446,'WBT','Warsaw Board Of Trade'),
(447,'ISO','International Securities Exchange'),
(448,'UVR','Unidad de Valor Real Constante'),
(449,'BNC','Bank Negara Malaysia'),
(450,'MLS','Malawi Stock Exchange'),
(451,'NAJ','Nasdaq - Japan'),
(452,'LAT','LatinoAmerican Market in Spain'),
(453,'CVE','TSX Venture Exchange (formerly known as Canadian Ventures Exchange)'),
(454,'EMT','EuroMOT'),
(455,'#KR','Korean OTC Bonds'),
(456,'HSI','HSI Services Limited'),
(457,'CAE','Computer Assisted Execution (US)'),
(458,'#PH','Philippines Non-exchange FI update'),
(459,'MPL','Standard & Poor\'s Micropal SA'),
(460,'ABD','Abu Dhabi Securities Market'),
(461,'ARC','NYSE Arca (for ArcaBook Feed)'),
(462,'ISL','The Island ECN, Inc'),
(463,'MNM','Madrid New Market'),
(464,'EEX','European Energy Exchange'),
(465,'LPX','Leipzig Power Exchange'),
(466,'CMF','Canadian Mutual Fund Exchange'),
(467,'PFT','PFTS Securities Trading System'),
(468,'ALG','Algiers Stock Exchange'),
(469,'T0$','Monitor Tokyo Rates'),
(470,'PWX','UK Power Exchange'),
(471,'NQB','NQB US Pink Sheet Quotation'),
(472,'LIP','Lipper'),
(473,'NGM','Nordic Growth Market'),
(474,'MTE','MTS Euro'),
(475,'MTA','MTS Amsterdam'),
(476,'ADX','Australian Derivatives Exchange'),
(477,'NFF','Norwegian Fund Broker Association'),
(478,'CUQ','Consolidated UK Quotes'),
(479,'CEQ','Consolidated European Quotes'),
(480,'TR2','TURQUOISE LEVEL 2 DATA'),
(481,'JK$','Central Bank of Indonesia'),
(482,'GBE','Global Best'),
(483,'SPD','Sao Paulo Stock Exchange Delayed'),
(484,'BIX','Bahamas International Securities Exchange'),
(485,'MT1','MTS Portugal'),
(486,'NXT','Euronext'),
(487,'WMC','WM Co (Specialist Data)'),
(488,'CHX','Swiss Stock Exchange'),
(489,'IMD','eMID Marke (Money Mkt Exch, Milan)'),
(490,'ITX','Italian Exchange'),
(491,'JIW','Jiway Ltd'),
(492,'NWX','NewEx'),
(493,'AU$','Australian Money Rates'),
(494,'JFX','Jakarta Futures Exchange'),
(495,'UIT','NASDAQ Unit Trust'),
(496,'VTX','Virt-X'),
(497,'EAX','Australian Energy Data'),
(498,'OFX','OFEX'),
(499,'ENR','ENRON'),
(500,'TH$','Thailand Money Rates'),
(501,'MY$','Malaysian Money Rates'),
(502,'LK$','Sri Lanka Money Rates'),
(503,'EBI','Eurobench Indicies'),
(504,'PH$','Philippines Money Rates'),
(505,'VN$','Vietnam Money Rates'),
(506,'CN$','China Money Rates'),
(507,'GPR','Global Property Research Indices'),
(508,'UEX','Uruguayan electronic Exchange'),
(509,'SFC','Sibiu Monetary - Financial & Commodities Exchange'),
(510,'EQ1','Equiduct Level 1 Data'),
(511,'#KS','Korea Non-Exchange FI Update'),
(512,'JAQ','JASDAQ'),
(513,'COL','Columbia Stock Exchange'),
(514,'KSB','Korea Exchange - Korean SE Bonds'),
(515,'NLX','LIFFE/NASDAQ Single Stock futures'),
(516,'SHF','Shanghai Futures Exchange'),
(517,'PLS','Palestine Securities Exchange'),
(518,'NY2','New York Stock Exchange OpenBook'),
(519,'TW$','Taiwan Money Rates'),
(520,'NBI','New York Board of Trade Indices'),
(521,'#SA','Saudi Arabian Non-Exchange FI update'),
(522,'BSX','Bermuda Stock Exchange'),
(523,'MDX','Bursa Malaysia Derivatives Data'),
(524,'NQE','NASDAQ Europe'),
(525,'AIM','Alternative Stock Exchange'),
(526,'NBT','New York Board of Trade'),
(527,'MTF','MTS France'),
(528,'MTC','MTS Belgium'),
(529,'SPN','SPECTRON'),
(530,'APE','Automated Power Exchange'),
(531,'POX','Polish Power Exchange'),
(532,'RED','RediBook'),
(533,'IBX','iBOXX Ltd'),
(534,'PNX','Powernext'),
(535,'BQT','Bequoted.com'),
(536,'#RO','Romanian Non-Exchange FI Update'),
(537,'ILT','The Island Trading'),
(538,'TXX','TLX Mercato Regolamentato'),
(539,'EMO','EnMO - Energy Futures'),
(540,'ONE','OneChicago Exchange'),
(541,'GS1','German Spot Market Level 1'),
(542,'GS2','German Spot Market Level 2'),
(543,'RSM','Regional German Market'),
(544,'IFE','Island Futures Exchange, LLC'),
(545,'EXA','EXAA Energy Exchange Austria'),
(546,'AFE','AMEX Stock Futures'),
(547,'DSS','Dar es Salaam Stock Exchange'),
(548,'NL2','Nasdaq Liffe LLC Level 2'),
(549,'ADC','NASD Alternative Display Facility for NYSE/AMEX Issues'),
(550,'IMQ','US Intermarket Level 2'),
(551,'LCA','American Stock Exchange for Nasdaq Large Cap'),
(552,'LCB','Boston Stock Exchange for Nasdaq Large Cap'),
(553,'LCC','Cincinnati Stock Exchange for Nasdaq Large Cap'),
(554,'LCM','Chicago Stock Exchange for Nasdaq Large Cap'),
(555,'LCN','New York Stock Exchange for Nasdaq Large Cap'),
(556,'LCP','NYSE Arca FOR NASDAQ LARGE CAP'),
(557,'LCW','Chicago Board Options Exchange for Nasdaq Large Cap Equity'),
(558,'LCX','Philadelphia Stock Exchange for Nasdaq Large Cap'),
(559,'NAQ','Nasdaq Stock Exchange Consolidated Capital Market'),
(560,'NMQ','NASDAQ Stock Market Exchange Consolidated Large Cap'),
(561,'SCA','American Stock Exchange for Nasdaq Capital Market'),
(562,'SCB','Boston Stock Exchange for Nasdaq Capital Market'),
(563,'SCC','Cincinnati Stock Exchange for Nasdaq Capital Market'),
(564,'SCM','Chicago Stock Exchange for Nasdaq Capital Market'),
(565,'SCN','New York Stock Exchange for Nasdaq Capital Market'),
(566,'SCP','NYSE Arca FOR NASDAQ SMALL CAP'),
(567,'SCW','Chicago Board Options Exchange for Nasdaq Capital Market'),
(568,'SCX','Philadelphia Stock Exchange for Nasdaq Capital Market'),
(569,'LPR','Lipper Fund Indices'),
(570,'NSD','NASD Bond Trade Dissemmination Service (BTDS) (formerly NASD Trace Feed)'),
(571,'NDV','Nasdaq Depth View'),
(572,'NTV','Nasdaq Total View'),
(573,'NQS','NASD Alternative Quotation Systems'),
(574,'BOX','Boston Options Exchange'),
(575,'OPQ','Options Price Reporting Authority BBO'),
(576,'FBF','Swedish Mutual Fund Association'),
(577,'IBU','International Brunei Exchange'),
(578,'TEJ','Taiwan Economic Journal'),
(579,'HER','Heren Energy'),
(580,'SGE','Shanghai Gold Exchange'),
(581,'NQD','NASDAQ Deutschland'),
(582,'LPC','Lipper Canadian Mutual Funds'),
(583,'EQ2','Equiduct Level 2 Data'),
(584,'POD','NEX Montenegro Exchange'),
(585,'BNL','Banja Luka Exchange'),
(586,'BCS','Belarusian Currency and Stock Exchange'),
(587,'KEC','Korea Electronic Communications Network'),
(588,'NEX','TSX Venture Exchange (Inactive Board)'),
(589,'CVC','TSX Venture Exchange (Capital Pool Company)'),
(590,'CVT','TSX Venture Exchange (Inactive Issue)'),
(591,'CNQ','Canadian Trading and Quotation System Inc.'),
(592,'BRR','Barra'),
(593,'AFT','The Agricultural Futures Exchange of Thailand'),
(594,'CDG','CanDeal - Government Bonds'),
(595,'CBF','CBOE Futures Exchange, LLC'),
(596,'EUS','US Futures Exchange'),
(597,'CPX','CanPX'),
(598,'UGS','Uganda Securities Exchange'),
(599,'MCI','Multi Commodity Exchange of India'),
(600,'POS','ITG posit'),
(601,'SEN','Sistema Electronica de Negociaici=n Colombia'),
(602,'RTE','RUSSIAN TRADING SYSTEMS - RTE'),
(603,'ISG','Istanbul Stock Exchange - Treasury'),
(604,'ITE','European Composite'),
(605,'DJW','Dow Jones Wilshire'),
(606,'XEF','Executable Fixed Income'),
(607,'NCX','National Commodity and Derivatives Exchange of India'),
(608,'#IN','India Non-Exchange FI update'),
(609,'PCQ','CONSOLIDATED ISSUE LISTED BY NYSE Arca'),
(610,'NSX','Newcastle Stock Exchange'),
(611,'ISX','Iraq Stock Exchange'),
(612,'TOJ','Asia Composite'),
(613,'DEU','German Composite'),
(614,'JSY','Johannesburg Stock Exchange Interest Rate'),
(615,'CCE','Chicago Climate Exchange'),
(616,'JEP','Japan Electric Power Exchange'),
(617,'EPD','Primary Dealers Market'),
(618,'LFX','Labuan International Financial Exchange'),
(619,'KRX','Korea Exchange'),
(620,'TDE','Turkish Derivatives Exchange Level 1'),
(621,'CBC','Central Bank of China, Taiwan'),
(622,'HAS','Hanoi Securities Trading Center'),
(623,'KRB','Korea Interbank Offered Rate'),
(624,'LOP','London Metal Exchange - Plastic'),
(625,'RCU','Source is a Reuters FI Contributor'),
(626,'RCV','Source is a London Broker'),
(627,'FTY','FTSE Xinhua - China'),
(628,'PLU','Plus Markets Group PLC'),
(629,'DIX','Dubai International Financial Exchange'),
(630,'TYP','Tokyo Stock Exchange - DUB purpose only'),
(631,'TKS','Istanbul Stock Exchange Settlement and Custody Bank'),
(632,'RRC','Russian Composite exchange data'),
(633,'TFX','Thailand Futures Exchange Public Company Limited'),
(634,'DGX','Dubai Gold & Commodities Exchange'),
(635,'ISS','International Securities Exchange, when trading NYSE Stock'),
(636,'LCI','International Securities Exchange, when trading Nasdaq National Market Stocks'),
(637,'SCI','International Securities Exchange, when trading Nasdaq Capital Market Stocks'),
(638,'TRF','The Trade Reporting Facility, when trading NYSE Stocks'),
(639,'LCL','The Trade Reporting Facility, when trading Nasdaq National Market Stocks'),
(640,'SCL','The Trade Reporting Facility, when trading Nasdaq Capital Market Stocks'),
(641,'VIX','Nordic Viking Indices - OMX Exchanges'),
(642,'PTX','Pure Trading'),
(643,'NMC','National Multi Commodity Exchange of India Limited'),
(644,'NSM','Nasdaq Stock Exchange Global Select Market'),
(645,'GSX','PHLX when trading Nasdaq Global Select Market'),
(646,'NSQ','Consolidated Issue Listed on Nasdaq Global Select Market'),
(647,'GSN','NYSE when trading Nasdaq Global Select Market'),
(648,'GSA','AMEX when trading Nasdaq Global Select Market'),
(649,'GSB','Boston SE when trading Nasdaq Global Select Market'),
(650,'GSW','CBOE when trading Nasdaq Global Select Market'),
(651,'GSM','Chicago SE when trading Nasdaq Global Select Market'),
(652,'GSC','National SE when trading Nasdaq Global Select Market'),
(653,'GSI','ISE when trading Nasdaq Global Select Market'),
(654,'GSL','NASD TRF when trading Nasdaq Global Select Market'),
(655,'GSP','NYSE Arca when trading Nasdaq Global Select Market'),
(656,'GSD','NASD ADF when trading Nasdaq Global Select Market'),
(657,'CCI','The Clearing Corporation of India Limited'),
(658,'DDT','Delayed Data Timer'),
(659,'ETX','Euro TLX'),
(660,'SAC','South African Contributed Bonds'),
(661,'MKE','Macedonia Stock Exchange'),
(662,'MTT','MTS Israel'),
(663,'MTX','MTS Reference Pricing'),
(664,'SPX','SHANGHAI PETROLEUM EXCHANGE'),
(665,'CDC','CHINA GOVT SECURITIES DEPOSITORY TRUST'),
(666,'MXP','Market Data Express'),
(667,'MBS','Mortgage Backed Securities'),
(668,'MSA','Mortgage Backed Securities Analytics'),
(669,'CFX','China Financial Futures Exchange'),
(670,'CDS','Credit Default Swap'),
(671,'PSM','Professional Securities Market'),
(672,'EMF','Euro MTF'),
(673,'BCI','Bombay Commodity Exchange'),
(674,'NBO','National Board of Trade'),
(675,'TDS','Trade Data Service'),
(676,'XDS','Cross-market Data Service'),
(677,'RMX','Risk Management Exchange (RMX)'),
(678,'ISA','Istanbul Stock Exchange - Trsy A'),
(679,'QMH','SWX Quotematch'),
(680,'PQX','Pink Sheets LLC - OTCQX'),
(681,'ABM','Norwegian Alternative Bond Market'),
(682,'DMX','Dubai Mercantile Exchange'),
(683,'BLP','Belgium Power Exchange'),
(684,'JNX','SBI Japan Next'),
(685,'AXE','NEWCO ELECTRONICS COMMUNICATIONS NETWORK (ECN)'),
(686,'AUX','ASX/ECN Combined Equity RIC'),
(687,'NOX','NASDAQ Options Market, LLC'),
(688,'PXE','Prague Energy Exchange'),
(689,'IVN','ICE-NYMEX Spreads'),
(690,'ICS','ICE Spreads'),
(691,'SRJ','Sarajevo Stock Exchange'),
(692,'BDS','BOAT - MIFID Aggregator Feed'),
(693,'UDA','US Department of Agriculture'),
(694,'NFX','NYFIX Euro Millennium'),
(695,'MTR','MTS Austria'),
(696,'MQI','EuroMTS Quasi Government Market'),
(697,'MTG','MTS Germany'),
(698,'MTU','MTS Spain'),
(699,'MTI','MTS Ireland'),
(700,'MTD','MTS Denmark'),
(701,'MTW','MTS Poland'),
(702,'MTL','MTS Finland'),
(703,'MTQ','MTS EuroCredit'),
(704,'MTK','MTS Greece'),
(705,'MTO','NewEuroMTS'),
(706,'CLS','MTS Cedulas'),
(707,'LQN','LiquidNet'),
(708,'MSB','Municipal Securities Rulemaking Board - MSRB'),
(709,'GSU','Guangxi Sugar Exchange'),
(710,'TCM','Triact'),
(711,'BBK','Blockbook'),
(712,'OMG','Omega - Candian ATS'),
(713,'ALP','Alpha - Canadian ATS'),
(714,'CXC','Instinet Chi-X Canada- Canadian ATS'),
(715,'CTR','Cantor CO2E'),
(716,'MAN','MF Global (Man Financial Global )'),
(717,'EVO','Evolution Markets'),
(718,'TUB','Tullett Prebon'),
(719,'NRC','Nuclear Regulatory Commission'),
(720,'CSX','Cayman Islands Stock Exchange'),
(721,'TRA','Tradition Financial Services'),
(722,'GFI','GFI'),
(723,'MGS','Mongolian Stock Exchange'),
(724,'CEI','CMIE'),
(725,'YDS','Cross-market Data Service (alternative)'),
(726,'MCL','Montreal Climate Exchange'),
(727,'TRQ','Turquoise'),
(728,'QXP','Pink OTC Markets Inc - Premier QX'),
(729,'EQD','Equiduct'),
(730,'QXI','Pink OTC Markets Inc - International Premier QX'),
(731,'QXR','Pink OTC Markets Inc - Prime QX'),
(732,'QXE','Pink OTC Markets Inc - International Prime QX'),
(733,'PKC','Pink OTC Markets Inc - (Current Information)'),
(734,'PKL','Pink OTC Markets Inc - (Limited Information)'),
(735,'RTF','RUSSIAN TRADING SYSTEM - RTF'),
(736,'PKN','Pink OTC Markets Inc - (No Information)'),
(737,'SEE','Shanghai Steel Electronic Exchange'),
(738,'GRN','Green Exchange'),
(739,'SWS','SWISSIX'),
(740,'TGX','TRIAXDAQ ICS S.A'),
(741,'FGT','FTSE ET50 ICW'),
(742,'FGE','FTSE4Good Europe ICW'),
(743,'FGG','FTSE4Good Global ICW'),
(744,'FGS','FTSE4Good US ICW'),
(745,'FGC','FTSE ST Constituents R/T (SGX subscribers only)'),
(746,'FTC','STI Constituents R/T (SGX subscribers only)'),
(747,'EIM','EURONEXT MARKET INDICES'),
(748,'EIV','EURONEXT VOLATILITY INDICES'),
(749,'EIS','EURONEXT STRATEGY INDICES'),
(750,'SWI','SWX INDICES'),
(751,'EN1','EURONEXT CASH BBO1'),
(752,'TD3','TURKISH DERIVATIVES EXCHANGE LEVEL 3'),
(753,'FGK','FTSE4Good UK ICW'),
(754,'ELB','ELBIS Polish Power Market'),
(755,'TSA','TSO East EU Power Transmission Auction'),
(756,'PSO','PSE Polish Power Market'),
(757,'OTZ','OTE Czech Power Market'),
(758,'IEU','Intercontinental Exchange Europe'),
(759,'IUS','Intercontinental Exchange US'),
(760,'ICA','Intercontinental Exchange Canada'),
(761,'EXR','EUREX REPO EUR'),
(762,'EXS','EUREX REPO -GERMANY/SWITZERLAND'),
(763,'NQX','NASDAQ OMX EUROPE (NEURO)'),
(764,'BTE','BATS TRADING EUROPE'),
(765,'IDX','Indonesia Stock Exchange'),
(766,'ARG','ARGUS'),
(767,'AXS','AXS MARINE'),
(768,'IMX','IMAREX'),
(769,'MFO','MFAO ( Mercado de Futuros Aceite de Oliva)'),
(770,'NGY','Next Generation Energy'),
(771,'NEE','New Edge Electricity'),
(772,'BGC','BGC Partners'),
(773,'EDX','European Energy Derivatives Exchange'),
(774,'GME','Gestore Mercato Elettrico'),
(775,'FMC','Forward Market Curve'),
(776,'OCN','OCEAN CONNECT');
/*!40000 ALTER TABLE `exchange` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `individual`
--

DROP TABLE IF EXISTS `individual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) DEFAULT NULL,
  `local_name` varchar(63) DEFAULT NULL,
  `local_forenames` varchar(63) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `passport` varchar(63) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `issuing` mediumint(8) unsigned DEFAULT NULL,
  `pep` tinyint(1) NOT NULL DEFAULT 0,
  `pep_country` mediumint(8) unsigned DEFAULT NULL,
  `pep_notes` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_id` (`contact_id`),
  UNIQUE KEY `contact_id_2` (`contact_id`),
  UNIQUE KEY `passport` (`passport`),
  KEY `issuing` (`issuing`),
  KEY `pep_country` (`pep_country`),
  KEY `address` (`address_id`),
  CONSTRAINT `individual_ibfk_2` FOREIGN KEY (`issuing`) REFERENCES `country` (`id`),
  CONSTRAINT `individual_ibfk_3` FOREIGN KEY (`pep_country`) REFERENCES `country` (`id`),
  CONSTRAINT `individual_ibfk_4` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `individual_ibfk_5` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual`
--

LOCK TABLES `individual` WRITE;
/*!40000 ALTER TABLE `individual` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `individual` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Temporary table structure for view `individual_view`
--

DROP TABLE IF EXISTS `individual_view`;
/*!50001 DROP VIEW IF EXISTS `individual_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `individual_view` AS SELECT
 1 AS `id`,
  1 AS `pep`,
  1 AS `local_name`,
  1 AS `local_forenames`,
  1 AS `contact_id`,
  1 AS `family_name`,
  1 AS `forenames`,
  1 AS `address_id` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `jurisdiction`
--

DROP TABLE IF EXISTS `jurisdiction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `jurisdiction` (
  `regulator_id` int(11) NOT NULL,
  `country_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`regulator_id`,`country_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `jurisdiction_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jurisdiction`
--

LOCK TABLES `jurisdiction` WRITE;
/*!40000 ALTER TABLE `jurisdiction` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `jurisdiction` VALUES
(1,1),
(2,3),
(3,4),
(4,6),
(5,8),
(6,10),
(7,11),
(8,12),
(9,14),
(10,14),
(11,14),
(12,15),
(13,15),
(14,15),
(15,16),
(16,17),
(17,18),
(18,19),
(19,20),
(20,22),
(21,22),
(22,23),
(23,24),
(24,25),
(25,27),
(26,28),
(27,28),
(28,31),
(29,31),
(30,31),
(32,33),
(33,34),
(23,35),
(34,39),
(35,39),
(36,39),
(37,39),
(38,39),
(39,39),
(40,39),
(41,39),
(171,39),
(177,39),
(42,41),
(43,44),
(44,45),
(45,45),
(46,48),
(47,53),
(48,53),
(23,54),
(49,55),
(50,57),
(51,57),
(52,57),
(53,58),
(54,59),
(55,62),
(56,62),
(57,64),
(58,65),
(59,66),
(60,69),
(61,69),
(62,72),
(63,74),
(64,75),
(65,75),
(66,75),
(67,81),
(68,82),
(69,83),
(70,83),
(71,85),
(72,87),
(73,90),
(74,91),
(23,93),
(75,97),
(76,98),
(77,98),
(78,99),
(79,100),
(167,100),
(80,101),
(81,101),
(82,101),
(83,101),
(84,101),
(85,102),
(86,102),
(87,104),
(88,105),
(89,105),
(91,106),
(92,107),
(93,107),
(94,108),
(95,109),
(96,109),
(97,110),
(98,111),
(99,112),
(130,116),
(131,116),
(100,120),
(101,121),
(102,125),
(103,126),
(104,127),
(105,127),
(118,129),
(106,132),
(23,134),
(107,135),
(90,136),
(108,139),
(109,140),
(110,140),
(111,142),
(112,144),
(113,147),
(114,148),
(115,149),
(116,156),
(117,158),
(23,160),
(179,161),
(119,165),
(120,166),
(121,167),
(122,170),
(123,173),
(124,174),
(125,176),
(126,177),
(127,177),
(128,179),
(129,179),
(132,181),
(133,182),
(134,185),
(135,185),
(136,186),
(137,188),
(138,192),
(139,194),
(23,195),
(140,196),
(141,197),
(142,199),
(143,200),
(144,201),
(145,204),
(146,204),
(147,204),
(182,207),
(148,213),
(149,214),
(150,218),
(151,219),
(180,219),
(152,225),
(153,229),
(154,231),
(155,231),
(156,232),
(157,232),
(158,232),
(159,233),
(160,233),
(161,233),
(163,233),
(168,233),
(172,233),
(173,233),
(174,233),
(176,233),
(178,233),
(181,233),
(162,235),
(164,238),
(165,239),
(166,240),
(31,241);
/*!40000 ALTER TABLE `jurisdiction` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `commodity` varchar(63) NOT NULL,
  `risk_score` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `product_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `product` VALUES
(1,1,'Corn',3),
(3,2,'Electricity',2),
(4,3,'truck',0),
(5,4,'Iron',2),
(6,4,'Bronze',0);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `product_group`
--

DROP TABLE IF EXISTS `product_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_group`
--

LOCK TABLES `product_group` WRITE;
/*!40000 ALTER TABLE `product_group` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `product_group` VALUES
(1,'Agricultural Products'),
(4,'Base Metals'),
(2,'Energy Products'),
(3,'Freight'),
(21,'LNG');
/*!40000 ALTER TABLE `product_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `wikiDataId` varchar(255) DEFAULT NULL COMMENT 'Rapid API GeoDB Cities',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `region` VALUES
(1,'Africa','Q15'),
(2,'Americas','Q828'),
(3,'Asia','Q48'),
(4,'Europe','Q46'),
(5,'Oceania','Q55643'),
(6,'Polar','Q51');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `regulator`
--

DROP TABLE IF EXISTS `regulator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `regulator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `region_id` mediumint(8) unsigned DEFAULT NULL,
  `website` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `website` (`website`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `regulator_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `country` (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regulator`
--

LOCK TABLES `regulator` WRITE;
/*!40000 ALTER TABLE `regulator` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `regulator` VALUES
(1,'Da Afghanistan Bank',3,'https://dab.gov.af/'),
(2,'Albanian Financial Supervisory Authority',4,'https://amf.gov.al/'),
(3,'Commission of the Organization and Supervision of the Algiers Stock Exchange',1,'http://www.cosob.org/'),
(4,'Andorran Financial Authority',4,'https://www.afa.ad/'),
(5,'Anguilla Financial Services Commission',2,'https://www.fsc.org.ai/'),
(6,'Financial Services Regulatory Commission',2,'https://www.fsrc.gov.ag/'),
(7,'National Securities Commission',2,'https://www.argentina.gob.ar/cnv/'),
(8,'Central Bank of Armenia',3,'https://www.cba.am/'),
(9,'Australian Prudential Regulation Authority',5,'https://www.apra.gov.au/'),
(10,'Australian Securities and Investments Commission',5,'https://asic.gov.au/'),
(11,'Australian Takeovers Panel',5,'https://www.takeovers.gov.au/'),
(12,'Financial Market Authority',4,'https://www.fma.gv.at/'),
(13,'Oesterreichische Nationalbank',4,'https://www.oenb.at/'),
(14,'Austrian Takeover Commission',4,'https://www.takeover.at/'),
(15,'Central Bank of the Republic of Azerbaijan',3,'https://www.cbar.az/'),
(16,'Securities Commission of the Bahamas',2,'http://www.scb.gov.bs/'),
(17,'Central Bank of Bahrain',3,'http://www.cbb.gov.bh/'),
(18,'Securities and Exchange Commission',3,'https://www.sec.gov.bd/'),
(19,'Central Bank of Barbados',2,'http://www.centralbank.org.bb/'),
(20,'Financial Services and Markets Authority',4,'https://www.fsma.be/'),
(21,'National Bank of Belgium',4,'https://www.nbb.be/'),
(22,'International Financial Services Commission',2,'https://www.ifsc.gov.bz/'),
(23,'Central Bank of the States of West Africa',1,'https://www.bceao.int/'),
(24,'Bermuda Monetary Authority',2,'https://www.bma.bm/'),
(25,'Supervisory Authority of the Financial System',2,'https://www.asfi.gob.bo/'),
(26,'Securities Commission of the Federation of Bosnia and Herzegovina',4,'http://www.komvp.gov.ba/'),
(27,'Securities Commission for Republika Srpska',4,'http://www.secrs.gov.ba/'),
(28,'Central Bank of Brazil',2,'https://www.bcb.gov.br/'),
(29,'Securities and Exchange Commission of Brazil',2,'https://www.gov.br/cvm/pt-br/'),
(30,'Supervisory Agent for Private Insurance',2,'http://novosite.susep.gov.br/'),
(31,'British Virgin Islands Financial Services Commission',2,'https://www.bvifsc.vg/'),
(32,'Ministry of Finance and Economy',3,'https://www.mofe.gov.bn/'),
(33,'Financial Supervision Commission',4,'https://www.fsc.bg/'),
(34,'Financial Markets Authority',2,'https://lautorite.qc.ca/'),
(35,'British Columbia Securities Commission',2,'https://www.bcsc.bc.ca/'),
(36,'Canadian Securities Administrators',2,'https://www.securities-administrators.ca/'),
(37,'Financial Services Commission of Ontario',2,'http://www.fsco.gov.on.ca/'),
(38,'Investment Industry Regulatory Organization of Canada',2,'https://www.iiroc.ca/'),
(39,'Mutual Fund Dealers Association',2,'http://www.mfda.ca/'),
(40,'Ontario Securities Commission',2,'https://www.osc.gov.on.ca/'),
(41,'Office of the Superintendent of Financial Institutions',2,'https://www.osfi-bsif.gc.ca/'),
(42,'Cayman Islands Monetary Authority',2,'https://www.cima.ky/'),
(43,'Commission for the Financial Market',2,'http://www.cmfchile.cl/'),
(44,'China Banking and Insurance Regulatory Commission',3,'https://www.cbirc.gov.cn/'),
(45,'China Securities Regulatory Commission',3,'http://www.csrc.gov.cn/'),
(46,'Financial Supervision of Colombia',2,'https://www.superfinanciera.gov.co/'),
(47,'General Supervision of Insurance',2,'https://www.sugese.fi.cr/'),
(48,'General Supervision of Securities',2,'https://www.sugeval.fi.cr/'),
(49,'Croatian Financial Services Supervisory Agency',4,'https://www.hanfa.hr/'),
(50,'Central Bank of Cyprus',4,'https://www.centralbank.cy/'),
(51,'Cyprus Securities and Exchange Commission',4,'https://www.cysec.gov.cy/'),
(52,'Cyprus Insurance Companies Control Service',4,'http://mof.gov.cy/gr/'),
(53,'Czech National Bank',4,'https://www.cnb.cz/'),
(54,'Danish Financial Services Authority',4,'https://www.dfsa.dk/'),
(55,'Supervision of the Banks of the Dominican Republic',2,'https://sb.gob.do/'),
(56,'Central Bank of the Dominican Republic',2,'https://www.bancentral.gov.do/'),
(57,'Supervision of Companies',2,'https://www.supercias.gob.ec/'),
(58,'Finance Regulatory Authority',1,'http://www.fra.gov.eg/'),
(59,'Superintendence of the Financial System',2,'https://ssf.gob.sv/'),
(60,'Financial Supervision Authority',4,'http://www.fi.ee/'),
(61,'Estonian Bank',4,'http://www.eestipank.ee/'),
(62,'Insurance Authority of the Faroe Islands',4,'https://www.tryggingareftirlitid.fo/'),
(63,'Financial Supervisory Authority',4,'https://www.finanssivalvonta.fi/'),
(64,'French Prudential Supervisory Authority',4,'https://www.banque-france.fr/'),
(65,'Financial Markets Authority',4,'https://www.amf-france.org/'),
(66,'Single Register of Insurance Intermediaries, Banking & Finance',4,'https://www.orias.fr/'),
(67,'National Bank of Georgia',3,'https://www.nbg.gov.ge/'),
(68,'Federal Financial Supervisory Authority',4,'http://www.bafin.de/'),
(69,'Bank of Ghana',1,'http://www.bog.gov.gh/'),
(70,'Securities and Exchange Commission',1,'http://www.sec.gov.gh/'),
(71,'Hellenic Capital Market Commission',4,'http://www.hcmc.gr/'),
(72,'Grenada Authority for the Regulation of Financial Institutions',2,'http://www.garfin.gd/'),
(73,'Supervision of Banks',2,'http://www.sib.gob.gt/'),
(74,'Guernsey Financial Services Commission',4,'http://www.gfsc.gg/'),
(75,'National Banks and Securities Commission',2,'https://gpuf.cnbs.gob.hn/'),
(76,'Hong Kong Monetary Authority',3,'http://www.hkma.gov.hk/'),
(77,'Securities and Futures Commission',3,'http://www.sfc.hk/'),
(78,'The Central Bank of Hungary',4,'http://felugyelet.mnb.hu/'),
(79,'Central Bank of Iceland',4,'https://www.cb.is/'),
(80,'Insurance Regulatory and Development Authority',3,'https://www.irda.gov.in/'),
(81,'Ministry of Corporate Affairs',3,'http://www.mca.gov.in/'),
(82,'Pension Fund Regulatory and Development Authority',3,'http://pfrda.org.in/'),
(83,'Reserve Bank of India',3,'http://www.rbi.org.in/'),
(84,'Securities and Exchange Board of India',3,'https://www.sebi.gov.in/'),
(85,'Financial Services Authority',3,'http://www.ojk.go.id/'),
(86,'Bank of Indonesia',3,'http://www.bi.go.id/'),
(87,'Iraq Securities Commission',3,'https://www.isc.gov.iq/'),
(88,'Central Bank and Financial Services Authority of Ireland',4,'https://www.centralbank.ie/'),
(89,'Irish Takeover Panel',4,'http://irishtakeoverpanel.ie/'),
(90,'Isle of Man Financial Services Authority',4,'https://www.iomfsa.im/'),
(91,'Israel Securities Authority',3,'http://www.isa.gov.il/'),
(92,'National Commission for Companies and the Stock Exchange',4,'http://www.consob.it/'),
(93,'Institute for the Supervision of Insurance',4,'https://www.ivass.it/'),
(94,'Financial Services Commission',2,'http://www.fscjamaica.org/'),
(95,'Securities and Exchange Commission',3,'http://www.fsa.go.jp/'),
(96,'Securities and Exchange Surveillance Commission',3,'http://www.fsa.go.jp/sesc/'),
(97,'Jersey Financial Services Commission',4,'http://www.jerseyfsc.org/'),
(98,'Jordan Securities Commission',3,'https://jsc.gov.jo/'),
(99,'Agency for Regulation and Development of the Financial Market of the Republic of Kazakhstan',3,'https://www.gov.kz/memleket/entities/ardfm'),
(100,'Financial and Capital Market Commission',4,'http://www.fktk.lv/'),
(101,'Banking Control Commission of Lebanon',3,'http://www.bccl.gov.lb/'),
(102,'Financial Market Authority',4,'https://www.fma-li.li/'),
(103,'Bank of Lithuania',4,'https://www.lb.lt/'),
(104,'Insurance Commission',4,'http://www.caa.lu/'),
(105,'Commission de Surveillance du Secteur Financier',4,'https://www.cssf.lu/'),
(106,'Securities Commission Malaysia',3,'http://www.sc.com.my/'),
(107,'Malta Financial Services Authority',4,'http://www.mfsa.com.mt/'),
(108,'Central Bank of Mauritania',1,'https://www.bcm.mr/'),
(109,'Bank of Mauritius',1,'https://www.bom.mu/'),
(110,'Financial Services Commission',1,'https://www.fscmauritius.org/'),
(111,'National Commission for Banks and Securities',2,'http://www.cnbv.gob.mx/'),
(112,'National Commission for Financial Markets',4,'https://www.cnpf.md/'),
(113,'Insurance Supervision Agency',4,'http://ano.me/'),
(114,'Montserrat Financial Services Commission',2,'http://www.fscmontserrat.org/'),
(115,'Moroccan Capital Market Authority',1,'http://www.ammc.ma/'),
(116,'Dutch Authority for the Financial Markets',4,'http://www.afm.nl/'),
(117,'Financial Markets Authority',5,'https://www.fma.govt.nz/'),
(118,'National Bank of the Republic of North Macedonia',4,'http://www.nbrm.mk/'),
(119,'Financial Supervisory Authority of Norway',4,'http://www.finanstilsynet.no/'),
(120,'Capital Market Authority',3,'http://www.cma.gov.om/'),
(121,'Securities and Exchange Commission of Pakistan',3,'http://www.secp.gov.pk/'),
(122,'Superintendence of the Panama Stock Market',2,'https://www.supervalores.gob.pa/'),
(123,'Superintendence of the Securities Market',2,'http://www.smv.gob.pe/'),
(124,'Securities and Exchange Commission Philippines',3,'http://www.sec.gov.ph/'),
(125,'Polish Financial Supervision Authority',4,'https://www.knf.gov.pl/'),
(126,'Insurance and Pension Funds Supervisory Authority',4,'https://www.asf.com.pt/'),
(127,'Portuguese Securities Market Commission',4,'https://www.cmvm.pt/'),
(128,'Qatar Financial Centre Regulatory Authority',3,'http://www.qfcra.com/'),
(129,'Qatar Financial Markets Authority',3,'https://www.qfma.org.qa/'),
(130,'Financial Services Commission',3,'http://www.fsc.go.kr/'),
(131,'Financial Supervisory Service',3,'http://www.fss.or.kr/'),
(132,'Romanian Financial Supervisory Authority',4,'https://asfromania.ro/'),
(133,'Central Bank of the Russian Federation (Bank of Russia)',4,'https://www.cbr.ru/'),
(134,'Financial Services Regulatory Commission (St. Kitts branch)',2,'http://fsrc.kn/'),
(135,'Nevis Financial Services Regulation and Supervision Department',2,'http://www.nevisfsrc.com/'),
(136,'Financial Services Regulatory Authority Saint Lucia',2,'https://fsrastlucia.org/'),
(137,'Financial Services Authority',2,'http://svgfsa.com/'),
(138,'Central Bank of the Republic of San Marino',4,'https://www.bcsm.sm/'),
(139,'Capital Market Authority',3,'https://cma.org.sa/'),
(140,'Republic of Serbia Securities Commission',4,'http://www.sec.gov.rs/'),
(141,'Central Bank of Seychelles',1,'http://www.cbs.sc/'),
(142,'Monetary Authority of Singapore',3,'http://www.mas.gov.sg/'),
(143,'National Bank of Slovakia',4,'http://www.nbs.sk/'),
(144,'Securities Market Agency',4,'http://www.a-tvp.si/'),
(145,'The Financial Sector Conduct Authority',1,'https://www.fsca.co.za/'),
(146,'National Credit Regulator',1,'http://www.ncr.org.za/'),
(147,'South African Reserve Bank',1,'https://www.resbank.co.za/'),
(148,'Swedish Financial Supervisory Authority',4,'https://www.fi.se/'),
(149,'Swiss Financial Market Supervisory Authority',4,'http://www.finma.ch/'),
(150,'Capital Markets and Securities Authority',1,'http://www.cmsa-tz.org/'),
(151,'Bank of Thailand',3,'https://www.bot.or.th/'),
(152,'Capital Markets Board of Turkey',3,'http://www.cmb.gov.tr/'),
(153,'Capital Markets Authority',1,'http://www.cmauganda.co.ug/'),
(154,'Dubai Financial Services Authority',3,'https://www.dfsa.ae/'),
(155,'Securities and Commodities Authority',3,'https://www.sca.gov.ae/'),
(156,'Financial Conduct Authority',4,'http://www.fca.org.uk/'),
(157,'Panel on Takeovers and Mergers',4,'http://www.thetakeoverpanel.org.uk/'),
(158,'Prudential Regulation Authority',4,'http://www.bankofengland.co.uk/'),
(159,'Office of the Comptroller of the Currency',2,'http://www.occ.gov/'),
(160,'Securities and Exchange Commission',2,'http://www.sec.gov/'),
(161,'US Department of the Treasury',2,'http://www.treasury.gov/'),
(162,'Central Bank of Uruguay',2,'http://www.bcu.gub.uy/'),
(163,'Commodity Futures Trading Commission',2,'http://www.cftc.gov/'),
(164,'Financial Information Authority',4,'http://www.aif.va/'),
(165,'National Superintendency of Securities of Venezuela',2,'https://www.sunaval.gob.ve/quienes-somos/'),
(166,'State Securities Commission',3,'http://www.ssc.gov.vn/'),
(167,'Financial Supervisory Authority',4,'https://en.fme.is/'),
(168,'Consumer Financial Protection Bureau',2,'https://www.consumerfinance.gov/'),
(169,'European Securities and Markets Association',NULL,'https://www.esma.europa.eu/'),
(170,'Financial Action Task Force',NULL,'https://www.fatf-gafi.org/'),
(171,'Financial and Consumer Services Commission',2,'https://fcnb.ca/en/'),
(172,'Federal Deposit Insurance Corporation',2,'https://www.fdic.gov/'),
(173,'Financial Crimes Enforcement Network',2,'https://www.fincen.gov/'),
(174,'Financial Industry Regulatory Authority',2,'https://www.finra.org/'),
(175,'International Organization of Securities Commissions',NULL,'https://www.iosco.org/'),
(176,'National Futures Association',2,'https://www.nfa.futures.org/'),
(177,'Manitoba Securities Commission',2,'https://mbsecurities.ca/'),
(178,'Office of Foreign Assets Control',2,'https://home.treasury.gov/'),
(179,'Securities and Exchange Commission',1,'https://sec.gov.ng/'),
(180,'Securities and Exchange Commission',3,'https://www.sec.or.th/'),
(181,'Federal Reserve System',2,'https://www.federalreserve.gov/'),
(182,'Comisión Nacional del Mercado de Valores',4,'https://www.cnmv.es/'),
(183,'European Insurance and Occupational Pensions Authority',NULL,'https://www.eiopa.europa.eu/');
/*!40000 ALTER TABLE `regulator` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `subregions`
--

DROP TABLE IF EXISTS `subregions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subregions` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `translations` text DEFAULT NULL,
  `region_id` mediumint(8) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `flag` tinyint(1) NOT NULL DEFAULT 1,
  `wikiDataId` varchar(255) DEFAULT NULL COMMENT 'Rapid API GeoDB Cities',
  PRIMARY KEY (`id`),
  KEY `subregion_continent` (`region_id`),
  CONSTRAINT `subregion_continent_final` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subregions`
--

LOCK TABLES `subregions` WRITE;
/*!40000 ALTER TABLE `subregions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `subregions` VALUES
(1,'Northern Africa','{\"korean\":\"북아프리카\",\"portuguese\":\"Norte de África\",\"dutch\":\"Noord-Afrika\",\"croatian\":\"Sjeverna Afrika\",\"persian\":\"شمال آفریقا\",\"german\":\"Nordafrika\",\"spanish\":\"Norte de África\",\"french\":\"Afrique du Nord\",\"japanese\":\"北アフリカ\",\"italian\":\"Nordafrica\",\"chinese\":\"北部非洲\"}',1,'2023-08-14 07:11:03','2023-08-24 20:10:23',1,'Q27381'),
(2,'Middle Africa','{\"korean\":\"중앙아프리카\",\"portuguese\":\"África Central\",\"dutch\":\"Centraal-Afrika\",\"croatian\":\"Srednja Afrika\",\"persian\":\"مرکز آفریقا\",\"german\":\"Zentralafrika\",\"spanish\":\"África Central\",\"french\":\"Afrique centrale\",\"japanese\":\"中部アフリカ\",\"italian\":\"Africa centrale\",\"chinese\":\"中部非洲\"}',1,'2023-08-14 07:11:03','2023-08-24 20:22:09',1,'Q27433'),
(3,'Western Africa','{\"korean\":\"서아프리카\",\"portuguese\":\"África Ocidental\",\"dutch\":\"West-Afrika\",\"croatian\":\"Zapadna Afrika\",\"persian\":\"غرب آفریقا\",\"german\":\"Westafrika\",\"spanish\":\"África Occidental\",\"french\":\"Afrique de l\'Ouest\",\"japanese\":\"西アフリカ\",\"italian\":\"Africa occidentale\",\"chinese\":\"西非\"}',1,'2023-08-14 07:11:03','2023-08-24 20:22:09',1,'Q4412'),
(4,'Eastern Africa','{\"korean\":\"동아프리카\",\"portuguese\":\"África Oriental\",\"dutch\":\"Oost-Afrika\",\"croatian\":\"Istočna Afrika\",\"persian\":\"شرق آفریقا\",\"german\":\"Ostafrika\",\"spanish\":\"África Oriental\",\"french\":\"Afrique de l\'Est\",\"japanese\":\"東アフリカ\",\"italian\":\"Africa orientale\",\"chinese\":\"东部非洲\"}',1,'2023-08-14 07:11:03','2023-08-24 20:22:10',1,'Q27407'),
(5,'Southern Africa','{\"korean\":\"남아프리카\",\"portuguese\":\"África Austral\",\"dutch\":\"Zuidelijk Afrika\",\"croatian\":\"Južna Afrika\",\"persian\":\"جنوب آفریقا\",\"german\":\"Südafrika\",\"spanish\":\"África austral\",\"french\":\"Afrique australe\",\"japanese\":\"南部アフリカ\",\"italian\":\"Africa australe\",\"chinese\":\"南部非洲\"}',1,'2023-08-14 07:11:03','2023-08-24 20:22:10',1,'Q27394'),
(6,'Northern America','{\"korean\":\"북미\",\"portuguese\":\"América Setentrional\",\"dutch\":\"Noord-Amerika\",\"persian\":\"شمال آمریکا\",\"german\":\"Nordamerika\",\"spanish\":\"América Norteña\",\"french\":\"Amérique septentrionale\",\"japanese\":\"北部アメリカ\",\"italian\":\"America settentrionale\",\"chinese\":\"北美地區\"}',2,'2023-08-14 07:11:03','2023-08-24 20:22:10',1,'Q2017699'),
(7,'Caribbean','{\"korean\":\"카리브\",\"portuguese\":\"Caraíbas\",\"dutch\":\"Caraïben\",\"croatian\":\"Karibi\",\"persian\":\"کارائیب\",\"german\":\"Karibik\",\"spanish\":\"Caribe\",\"french\":\"Caraïbes\",\"japanese\":\"カリブ海地域\",\"italian\":\"Caraibi\",\"chinese\":\"加勒比地区\"}',2,'2023-08-14 07:11:03','2023-08-24 20:22:10',1,'Q664609'),
(8,'South America','{\"korean\":\"남아메리카\",\"portuguese\":\"América do Sul\",\"dutch\":\"Zuid-Amerika\",\"croatian\":\"Južna Amerika\",\"persian\":\"آمریکای جنوبی\",\"german\":\"Südamerika\",\"spanish\":\"América del Sur\",\"french\":\"Amérique du Sud\",\"japanese\":\"南アメリカ\",\"italian\":\"America meridionale\",\"chinese\":\"南美洲\"}',2,'2023-08-14 07:11:03','2023-08-24 20:22:10',1,'Q18'),
(9,'Central America','{\"korean\":\"중앙아메리카\",\"portuguese\":\"América Central\",\"dutch\":\"Centraal-Amerika\",\"croatian\":\"Srednja Amerika\",\"persian\":\"آمریکای مرکزی\",\"german\":\"Zentralamerika\",\"spanish\":\"América Central\",\"french\":\"Amérique centrale\",\"japanese\":\"中央アメリカ\",\"italian\":\"America centrale\",\"chinese\":\"中美洲\"}',2,'2023-08-14 07:11:03','2023-08-24 20:22:11',1,'Q27611'),
(10,'Central Asia','{\"korean\":\"중앙아시아\",\"portuguese\":\"Ásia Central\",\"dutch\":\"Centraal-Azië\",\"croatian\":\"Srednja Azija\",\"persian\":\"آسیای میانه\",\"german\":\"Zentralasien\",\"spanish\":\"Asia Central\",\"french\":\"Asie centrale\",\"japanese\":\"中央アジア\",\"italian\":\"Asia centrale\",\"chinese\":\"中亚\"}',3,'2023-08-14 07:11:03','2023-08-24 20:22:11',1,'Q27275'),
(11,'Western Asia','{\"korean\":\"서아시아\",\"portuguese\":\"Sudoeste Asiático\",\"dutch\":\"Zuidwest-Azië\",\"croatian\":\"Jugozapadna Azija\",\"persian\":\"غرب آسیا\",\"german\":\"Vorderasien\",\"spanish\":\"Asia Occidental\",\"french\":\"Asie de l\'Ouest\",\"japanese\":\"西アジア\",\"italian\":\"Asia occidentale\",\"chinese\":\"西亚\"}',3,'2023-08-14 07:11:03','2023-08-24 20:22:11',1,'Q27293'),
(12,'Eastern Asia','{\"korean\":\"동아시아\",\"portuguese\":\"Ásia Oriental\",\"dutch\":\"Oost-Azië\",\"croatian\":\"Istočna Azija\",\"persian\":\"شرق آسیا\",\"german\":\"Ostasien\",\"spanish\":\"Asia Oriental\",\"french\":\"Asie de l\'Est\",\"japanese\":\"東アジア\",\"italian\":\"Asia orientale\",\"chinese\":\"東亞\"}',3,'2023-08-14 07:11:03','2023-08-24 20:22:11',1,'Q27231'),
(13,'South-Eastern Asia','{\"korean\":\"동남아시아\",\"portuguese\":\"Sudeste Asiático\",\"dutch\":\"Zuidoost-Azië\",\"croatian\":\"Jugoistočna Azija\",\"persian\":\"جنوب شرق آسیا\",\"german\":\"Südostasien\",\"spanish\":\"Sudeste Asiático\",\"french\":\"Asie du Sud-Est\",\"japanese\":\"東南アジア\",\"italian\":\"Sud-est asiatico\",\"chinese\":\"东南亚\"}',3,'2023-08-14 07:11:03','2023-08-24 20:22:12',1,'Q11708'),
(14,'Southern Asia','{\"korean\":\"남아시아\",\"portuguese\":\"Ásia Meridional\",\"dutch\":\"Zuid-Azië\",\"croatian\":\"Južna Azija\",\"persian\":\"جنوب آسیا\",\"german\":\"Südasien\",\"spanish\":\"Asia del Sur\",\"french\":\"Asie du Sud\",\"japanese\":\"南アジア\",\"italian\":\"Asia meridionale\",\"chinese\":\"南亚\"}',3,'2023-08-14 07:11:03','2023-08-24 20:22:12',1,'Q771405'),
(15,'Eastern Europe','{\"korean\":\"동유럽\",\"portuguese\":\"Europa de Leste\",\"dutch\":\"Oost-Europa\",\"croatian\":\"Istočna Europa\",\"persian\":\"شرق اروپا\",\"german\":\"Osteuropa\",\"spanish\":\"Europa Oriental\",\"french\":\"Europe de l\'Est\",\"japanese\":\"東ヨーロッパ\",\"italian\":\"Europa orientale\",\"chinese\":\"东欧\"}',4,'2023-08-14 07:11:03','2023-08-24 20:22:12',1,'Q27468'),
(16,'Southern Europe','{\"korean\":\"남유럽\",\"portuguese\":\"Europa meridional\",\"dutch\":\"Zuid-Europa\",\"croatian\":\"Južna Europa\",\"persian\":\"جنوب اروپا\",\"german\":\"Südeuropa\",\"spanish\":\"Europa del Sur\",\"french\":\"Europe du Sud\",\"japanese\":\"南ヨーロッパ\",\"italian\":\"Europa meridionale\",\"chinese\":\"南欧\"}',4,'2023-08-14 07:11:03','2023-08-24 20:22:12',1,'Q27449'),
(17,'Western Europe','{\"korean\":\"서유럽\",\"portuguese\":\"Europa Ocidental\",\"dutch\":\"West-Europa\",\"croatian\":\"Zapadna Europa\",\"persian\":\"غرب اروپا\",\"german\":\"Westeuropa\",\"spanish\":\"Europa Occidental\",\"french\":\"Europe de l\'Ouest\",\"japanese\":\"西ヨーロッパ\",\"italian\":\"Europa occidentale\",\"chinese\":\"西欧\"}',4,'2023-08-14 07:11:03','2023-08-24 20:22:12',1,'Q27496'),
(18,'Northern Europe','{\"korean\":\"북유럽\",\"portuguese\":\"Europa Setentrional\",\"dutch\":\"Noord-Europa\",\"croatian\":\"Sjeverna Europa\",\"persian\":\"شمال اروپا\",\"german\":\"Nordeuropa\",\"spanish\":\"Europa del Norte\",\"french\":\"Europe du Nord\",\"japanese\":\"北ヨーロッパ\",\"italian\":\"Europa settentrionale\",\"chinese\":\"北歐\"}',4,'2023-08-14 07:11:03','2023-08-24 20:22:13',1,'Q27479'),
(19,'Australia and New Zealand','{\"korean\":\"오스트랄라시아\",\"portuguese\":\"Australásia\",\"dutch\":\"Australazië\",\"croatian\":\"Australazija\",\"persian\":\"استرالزی\",\"german\":\"Australasien\",\"spanish\":\"Australasia\",\"french\":\"Australasie\",\"japanese\":\"オーストララシア\",\"italian\":\"Australasia\",\"chinese\":\"澳大拉西亞\"}',5,'2023-08-14 07:11:03','2023-08-24 20:22:13',1,'Q45256'),
(20,'Melanesia','{\"korean\":\"멜라네시아\",\"portuguese\":\"Melanésia\",\"dutch\":\"Melanesië\",\"croatian\":\"Melanezija\",\"persian\":\"ملانزی\",\"german\":\"Melanesien\",\"spanish\":\"Melanesia\",\"french\":\"Mélanésie\",\"japanese\":\"メラネシア\",\"italian\":\"Melanesia\",\"chinese\":\"美拉尼西亚\"}',5,'2023-08-14 07:11:03','2023-08-24 20:22:13',1,'Q37394'),
(21,'Micronesia','{\"korean\":\"미크로네시아\",\"portuguese\":\"Micronésia\",\"dutch\":\"Micronesië\",\"croatian\":\"Mikronezija\",\"persian\":\"میکرونزی\",\"german\":\"Mikronesien\",\"spanish\":\"Micronesia\",\"french\":\"Micronésie\",\"japanese\":\"ミクロネシア\",\"italian\":\"Micronesia\",\"chinese\":\"密克罗尼西亚群岛\"}',5,'2023-08-14 07:11:03','2023-08-24 20:22:13',1,'Q3359409'),
(22,'Polynesia','{\"korean\":\"폴리네시아\",\"portuguese\":\"Polinésia\",\"dutch\":\"Polynesië\",\"croatian\":\"Polinezija\",\"persian\":\"پلی‌نزی\",\"german\":\"Polynesien\",\"spanish\":\"Polinesia\",\"french\":\"Polynésie\",\"japanese\":\"ポリネシア\",\"italian\":\"Polinesia\",\"chinese\":\"玻里尼西亞\"}',5,'2023-08-14 07:11:03','2023-08-24 20:22:13',1,'Q35942');
/*!40000 ALTER TABLE `subregions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(63) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `clearance` varchar(255) NOT NULL,
  `session_id` uuid DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `username_2` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `user` VALUES
(1,'thibaudk','540F17CA4C63BF3AE96299AC263BD5E69CA48CBBF8D48AFE9FDE9B5E07D7F244','3','cc46c71d-c8d5-489c-ab54-881f35f74d33'),
(5,'oliver.h','B70EB3E4019EFAE4FC721A2AAC9003B04140C552D3EA4D0BE06599FDE393F393','3','bb1ec4e7-0253-4fa5-9324-a926bf178d43');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `vessel`
--

DROP TABLE IF EXISTS `vessel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vessel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(63) DEFAULT NULL,
  `imo` varchar(63) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `vessel_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `company` (`id`),
  CONSTRAINT `vessel_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vessel`
--

LOCK TABLES `vessel` WRITE;
/*!40000 ALTER TABLE `vessel` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `vessel` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Current Database: `compliance_one`
--

USE `compliance_one`;

--
-- Final view structure for view `company_view`
--

/*!50001 DROP VIEW IF EXISTS `company_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`compliance_one`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `company_view` AS select `company`.`id` AS `id`,`company`.`name` AS `name`,`company`.`local_name` AS `local_name`,`company`.`contact_id` AS `contact_id`,`company`.`address_id` AS `address_id` from ((`company` join `contact`) join `address`) where `contact`.`id` = `company`.`contact_id` and `address`.`id` = `company`.`address_id` */
/*!50002 WITH CASCADED CHECK OPTION */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `individual_view`
--

/*!50001 DROP VIEW IF EXISTS `individual_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`compliance_one`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `individual_view` AS select `individual`.`id` AS `id`,`individual`.`pep` AS `pep`,`individual`.`local_name` AS `local_name`,`individual`.`local_forenames` AS `local_forenames`,`individual`.`contact_id` AS `contact_id`,`contact`.`family_name` AS `family_name`,`contact`.`forenames` AS `forenames`,`individual`.`address_id` AS `address_id` from ((`individual` join `contact`) join `address`) where `contact`.`id` = `individual`.`contact_id` and `address`.`id` = `individual`.`address_id` */
/*!50002 WITH CASCADED CHECK OPTION */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-08-16 10:11:26
