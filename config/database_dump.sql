-- MySQL dump 10.13  Distrib 5.5.33, for osx10.6 (i386)
--
-- Host: localhost    Database: ss_saltedherring_ss_base
-- ------------------------------------------------------
-- Server version	5.5.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ArchiveWidget`
--

DROP TABLE IF EXISTS `ArchiveWidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArchiveWidget` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DisplayMode` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ArchiveWidget`
--

LOCK TABLES `ArchiveWidget` WRITE;
/*!40000 ALTER TABLE `ArchiveWidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `ArchiveWidget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogCategory`
--

DROP TABLE IF EXISTS `BlogCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogCategory` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('BlogCategory') DEFAULT 'BlogCategory',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `URLSegment` varchar(255) DEFAULT NULL,
  `Title` varchar(250) DEFAULT NULL,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogCategory`
--

LOCK TABLES `BlogCategory` WRITE;
/*!40000 ALTER TABLE `BlogCategory` DISABLE KEYS */;
INSERT INTO `BlogCategory` VALUES (1,'BlogCategory','2014-06-11 11:06:56','2014-06-11 11:06:56','test','test',10),(2,'BlogCategory','2014-06-11 11:07:26','2014-06-11 11:07:26','x','x',10);
/*!40000 ALTER TABLE `BlogCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogEntry`
--

DROP TABLE IF EXISTS `BlogEntry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogEntry` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` datetime DEFAULT NULL,
  `Author` mediumtext,
  `Tags` mediumtext,
  `SEOPageSubject` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogEntry`
--

LOCK TABLES `BlogEntry` WRITE;
/*!40000 ALTER TABLE `BlogEntry` DISABLE KEYS */;
INSERT INTO `BlogEntry` VALUES (11,'2014-06-11 00:55:37',NULL,'silverstripe, blog',NULL);
/*!40000 ALTER TABLE `BlogEntry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogEntry_BlogCategories`
--

DROP TABLE IF EXISTS `BlogEntry_BlogCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogEntry_BlogCategories` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BlogEntryID` int(11) NOT NULL DEFAULT '0',
  `BlogCategoryID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `BlogEntryID` (`BlogEntryID`),
  KEY `BlogCategoryID` (`BlogCategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogEntry_BlogCategories`
--

LOCK TABLES `BlogEntry_BlogCategories` WRITE;
/*!40000 ALTER TABLE `BlogEntry_BlogCategories` DISABLE KEYS */;
INSERT INTO `BlogEntry_BlogCategories` VALUES (1,11,1),(2,11,2);
/*!40000 ALTER TABLE `BlogEntry_BlogCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogEntry_Live`
--

DROP TABLE IF EXISTS `BlogEntry_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogEntry_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` datetime DEFAULT NULL,
  `Author` mediumtext,
  `Tags` mediumtext,
  `SEOPageSubject` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogEntry_Live`
--

LOCK TABLES `BlogEntry_Live` WRITE;
/*!40000 ALTER TABLE `BlogEntry_Live` DISABLE KEYS */;
INSERT INTO `BlogEntry_Live` VALUES (11,'2014-06-11 00:55:37',NULL,'silverstripe, blog',NULL);
/*!40000 ALTER TABLE `BlogEntry_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogEntry_versions`
--

DROP TABLE IF EXISTS `BlogEntry_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogEntry_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `Date` datetime DEFAULT NULL,
  `Author` mediumtext,
  `Tags` mediumtext,
  `SEOPageSubject` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogEntry_versions`
--

LOCK TABLES `BlogEntry_versions` WRITE;
/*!40000 ALTER TABLE `BlogEntry_versions` DISABLE KEYS */;
INSERT INTO `BlogEntry_versions` VALUES (1,11,1,'2014-06-11 00:55:37',NULL,'silverstripe, blog',NULL),(2,11,2,'2014-06-11 00:55:37',NULL,'silverstripe, blog',NULL),(3,11,3,'2014-06-11 00:55:37',NULL,'silverstripe, blog',NULL),(4,11,4,'2014-06-11 00:55:37','default admin','silverstripe, blog',NULL),(5,11,5,'2014-06-11 00:55:37',NULL,'silverstripe, blog',NULL);
/*!40000 ALTER TABLE `BlogEntry_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogHolder`
--

DROP TABLE IF EXISTS `BlogHolder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogHolder` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AllowCustomAuthors` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ShowFullEntry` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `OwnerID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `OwnerID` (`OwnerID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogHolder`
--

LOCK TABLES `BlogHolder` WRITE;
/*!40000 ALTER TABLE `BlogHolder` DISABLE KEYS */;
INSERT INTO `BlogHolder` VALUES (10,0,0,1);
/*!40000 ALTER TABLE `BlogHolder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogHolder_Live`
--

DROP TABLE IF EXISTS `BlogHolder_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogHolder_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AllowCustomAuthors` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ShowFullEntry` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `OwnerID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `OwnerID` (`OwnerID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogHolder_Live`
--

LOCK TABLES `BlogHolder_Live` WRITE;
/*!40000 ALTER TABLE `BlogHolder_Live` DISABLE KEYS */;
INSERT INTO `BlogHolder_Live` VALUES (10,0,0,1);
/*!40000 ALTER TABLE `BlogHolder_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogHolder_versions`
--

DROP TABLE IF EXISTS `BlogHolder_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogHolder_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `AllowCustomAuthors` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ShowFullEntry` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `OwnerID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `OwnerID` (`OwnerID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogHolder_versions`
--

LOCK TABLES `BlogHolder_versions` WRITE;
/*!40000 ALTER TABLE `BlogHolder_versions` DISABLE KEYS */;
INSERT INTO `BlogHolder_versions` VALUES (1,10,1,0,0,0),(2,10,2,0,0,0),(3,10,3,1,0,0),(4,10,4,0,0,1);
/*!40000 ALTER TABLE `BlogHolder_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogTree`
--

DROP TABLE IF EXISTS `BlogTree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogTree` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `LandingPageFreshness` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogTree`
--

LOCK TABLES `BlogTree` WRITE;
/*!40000 ALTER TABLE `BlogTree` DISABLE KEYS */;
INSERT INTO `BlogTree` VALUES (10,NULL,NULL);
/*!40000 ALTER TABLE `BlogTree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogTree_Live`
--

DROP TABLE IF EXISTS `BlogTree_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogTree_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `LandingPageFreshness` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogTree_Live`
--

LOCK TABLES `BlogTree_Live` WRITE;
/*!40000 ALTER TABLE `BlogTree_Live` DISABLE KEYS */;
INSERT INTO `BlogTree_Live` VALUES (10,NULL,NULL);
/*!40000 ALTER TABLE `BlogTree_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BlogTree_versions`
--

DROP TABLE IF EXISTS `BlogTree_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BlogTree_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `Name` varchar(255) DEFAULT NULL,
  `LandingPageFreshness` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BlogTree_versions`
--

LOCK TABLES `BlogTree_versions` WRITE;
/*!40000 ALTER TABLE `BlogTree_versions` DISABLE KEYS */;
INSERT INTO `BlogTree_versions` VALUES (1,10,1,NULL,NULL),(2,10,2,NULL,NULL),(3,10,3,NULL,NULL),(4,10,4,NULL,NULL);
/*!40000 ALTER TABLE `BlogTree_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CategoryCloudWidget`
--

DROP TABLE IF EXISTS `CategoryCloudWidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CategoryCloudWidget` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(50) DEFAULT NULL,
  `Limit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CategoryCloudWidget`
--

LOCK TABLES `CategoryCloudWidget` WRITE;
/*!40000 ALTER TABLE `CategoryCloudWidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `CategoryCloudWidget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EditableFormField`
--

DROP TABLE IF EXISTS `EditableFormField`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EditableFormField` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('EditableEmailField','EditableDropdown','EditableTextField','EditableFormField','EditableCheckbox','EditableCountryDropdownField','EditableDateField','EditableFileField','EditableFormHeading','EditableLiteralField','EditableMemberListField','EditableMultipleOptionField','EditableCheckboxGroupField','EditableRadioField','EditableNumericField') DEFAULT 'EditableEmailField',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Default` varchar(50) DEFAULT NULL,
  `Sort` int(11) NOT NULL DEFAULT '0',
  `Required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `CustomErrorMessage` varchar(255) DEFAULT NULL,
  `CustomRules` mediumtext,
  `CustomSettings` mediumtext,
  `CustomParameter` varchar(200) DEFAULT NULL,
  `Version` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EditableFormField`
--

LOCK TABLES `EditableFormField` WRITE;
/*!40000 ALTER TABLE `EditableFormField` DISABLE KEYS */;
INSERT INTO `EditableFormField` VALUES (1,'EditableTextField','2014-02-28 10:02:18','2014-02-28 17:33:27','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9,9),(2,'EditableTextField','2014-02-28 10:03:00','2014-02-28 17:33:27','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9,9),(4,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 17:33:27','EditableEmailField4','email',NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField1\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField2\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9,9),(5,'EditableDropdown','2014-02-28 17:11:05','2014-02-28 17:33:27','EditableDropdown5','select',NULL,5,0,NULL,'a:0:{}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,5,9),(6,'EditableTextField','2014-02-28 17:12:20','2014-02-28 17:33:27','EditableTextField6','textarea',NULL,6,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:0:\"\";s:4:\"Rows\";s:2:\"10\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,4,9);
/*!40000 ALTER TABLE `EditableFormField` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EditableFormField_Live`
--

DROP TABLE IF EXISTS `EditableFormField_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EditableFormField_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('EditableEmailField','EditableDropdown','EditableTextField','EditableFormField','EditableCheckbox','EditableCountryDropdownField','EditableDateField','EditableFileField','EditableFormHeading','EditableLiteralField','EditableMemberListField','EditableMultipleOptionField','EditableCheckboxGroupField','EditableRadioField','EditableNumericField') DEFAULT 'EditableEmailField',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Default` varchar(50) DEFAULT NULL,
  `Sort` int(11) NOT NULL DEFAULT '0',
  `Required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `CustomErrorMessage` varchar(255) DEFAULT NULL,
  `CustomRules` mediumtext,
  `CustomSettings` mediumtext,
  `CustomParameter` varchar(200) DEFAULT NULL,
  `Version` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EditableFormField_Live`
--

LOCK TABLES `EditableFormField_Live` WRITE;
/*!40000 ALTER TABLE `EditableFormField_Live` DISABLE KEYS */;
INSERT INTO `EditableFormField_Live` VALUES (1,'EditableTextField','2014-02-28 10:02:18','2014-06-12 13:00:51','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9,9),(2,'EditableTextField','2014-02-28 10:03:00','2014-06-12 13:00:51','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9,9),(4,'EditableEmailField','2014-02-28 10:03:29','2014-06-12 13:00:51','EditableEmailField4','email',NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField1\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField2\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9,9),(5,'EditableDropdown','2014-02-28 17:11:05','2014-06-12 13:00:51','EditableDropdown5','select',NULL,5,0,NULL,'a:0:{}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,5,9),(6,'EditableTextField','2014-02-28 17:12:20','2014-06-12 13:00:51','EditableTextField6','textarea',NULL,6,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:0:\"\";s:4:\"Rows\";s:2:\"10\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,4,9);
/*!40000 ALTER TABLE `EditableFormField_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EditableFormField_versions`
--

DROP TABLE IF EXISTS `EditableFormField_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EditableFormField_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `WasPublished` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `AuthorID` int(11) NOT NULL DEFAULT '0',
  `PublisherID` int(11) NOT NULL DEFAULT '0',
  `ClassName` enum('EditableEmailField','EditableDropdown','EditableTextField','EditableFormField','EditableCheckbox','EditableCountryDropdownField','EditableDateField','EditableFileField','EditableFormHeading','EditableLiteralField','EditableMemberListField','EditableMultipleOptionField','EditableCheckboxGroupField','EditableRadioField','EditableNumericField') DEFAULT 'EditableEmailField',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Default` varchar(50) DEFAULT NULL,
  `Sort` int(11) NOT NULL DEFAULT '0',
  `Required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `CustomErrorMessage` varchar(255) DEFAULT NULL,
  `CustomRules` mediumtext,
  `CustomSettings` mediumtext,
  `CustomParameter` varchar(200) DEFAULT NULL,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `AuthorID` (`AuthorID`),
  KEY `PublisherID` (`PublisherID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EditableFormField_versions`
--

LOCK TABLES `EditableFormField_versions` WRITE;
/*!40000 ALTER TABLE `EditableFormField_versions` DISABLE KEYS */;
INSERT INTO `EditableFormField_versions` VALUES (1,1,1,0,1,0,'EditableTextField','2014-02-28 10:02:18','2014-02-28 10:02:18','EditableTextField0',NULL,NULL,1,0,NULL,NULL,NULL,NULL,9),(2,2,1,0,1,0,'EditableTextField','2014-02-28 10:03:00','2014-02-28 10:03:00','EditableTextField0',NULL,NULL,2,0,NULL,NULL,NULL,NULL,9),(3,3,1,0,1,0,'EditableTextField','2014-02-28 10:03:20','2014-02-28 10:03:20','EditableTextField0',NULL,NULL,3,0,NULL,NULL,NULL,NULL,9),(4,4,1,0,1,0,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 10:03:29','EditableEmailField0',NULL,NULL,4,0,NULL,NULL,NULL,NULL,9),(5,1,2,0,1,0,'EditableTextField','2014-02-28 10:02:18','2014-02-28 10:04:16','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:10:\"First Name\";s:9:\"MinLength\";s:1:\"0\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(6,2,2,0,1,0,'EditableTextField','2014-02-28 10:03:00','2014-02-28 10:04:16','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:9:\"Last Name\";s:9:\"MinLength\";s:1:\"0\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(7,4,2,0,1,0,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 10:04:16','EditableEmailField4',NULL,NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:19:\"EditableEmailField0\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField0\";s:15:\"ConditionOption\";s:0:\"\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:5:\"Email\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9),(8,1,3,1,1,1,'EditableTextField','2014-02-28 10:02:18','2014-02-28 10:04:28','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:10:\"First Name\";s:9:\"MinLength\";s:1:\"0\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(9,2,3,1,1,1,'EditableTextField','2014-02-28 10:03:00','2014-02-28 10:04:28','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:9:\"Last Name\";s:9:\"MinLength\";s:1:\"0\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(10,4,3,1,1,1,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 10:04:28','EditableEmailField4',NULL,NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:19:\"EditableEmailField0\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField0\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:5:\"Email\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9),(11,1,4,1,1,1,'EditableTextField','2014-02-28 10:02:18','2014-02-28 10:05:46','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:10:\"First Name\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(12,2,4,1,1,1,'EditableTextField','2014-02-28 10:03:00','2014-02-28 10:05:46','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:9:\"Last Name\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(13,4,4,1,1,1,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 10:05:46','EditableEmailField4','email',NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:0:\"\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:0:\"\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:5:\"Email\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9),(14,1,5,0,1,0,'EditableTextField','2014-02-28 10:02:18','2014-02-28 10:05:57','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:10:\"First Name\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(15,2,5,0,1,0,'EditableTextField','2014-02-28 10:03:00','2014-02-28 10:05:57','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:9:\"Last Name\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(16,4,5,0,1,0,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 10:05:57','EditableEmailField4','email',NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField1\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField2\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:5:\"Email\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9),(17,5,1,0,1,0,'EditableDropdown','2014-02-28 17:11:05','2014-02-28 17:11:05','EditableDropdown0',NULL,NULL,5,0,NULL,NULL,NULL,NULL,9),(18,1,6,1,1,1,'EditableTextField','2014-02-28 10:02:18','2014-02-28 17:11:31','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(19,2,6,1,1,1,'EditableTextField','2014-02-28 10:03:00','2014-02-28 17:11:31','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(20,4,6,1,1,1,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 17:11:31','EditableEmailField4','email',NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField1\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField2\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9),(21,5,2,1,1,1,'EditableDropdown','2014-02-28 17:11:05','2014-02-28 17:11:31','EditableDropdown5','select',NULL,5,0,NULL,'a:0:{}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(22,6,1,0,1,0,'EditableTextField','2014-02-28 17:12:20','2014-02-28 17:12:20','EditableTextField0',NULL,NULL,6,0,NULL,NULL,NULL,NULL,9),(23,1,7,1,1,1,'EditableTextField','2014-02-28 10:02:18','2014-02-28 17:12:34','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(24,2,7,1,1,1,'EditableTextField','2014-02-28 10:03:00','2014-02-28 17:12:34','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(25,4,7,1,1,1,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 17:12:34','EditableEmailField4','email',NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField1\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField2\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9),(26,5,3,1,1,1,'EditableDropdown','2014-02-28 17:11:05','2014-02-28 17:12:34','EditableDropdown5','select',NULL,5,0,NULL,'a:0:{}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(27,6,2,1,1,1,'EditableTextField','2014-02-28 17:12:20','2014-02-28 17:12:34','EditableTextField6','textarea',NULL,6,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:0:\"\";s:4:\"Rows\";s:2:\"10\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(28,1,8,1,1,1,'EditableTextField','2014-02-28 10:02:18','2014-02-28 17:32:14','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(29,2,8,1,1,1,'EditableTextField','2014-02-28 10:03:00','2014-02-28 17:32:14','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(30,4,8,1,1,1,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 17:32:14','EditableEmailField4','email',NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField1\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField2\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9),(31,5,4,1,1,1,'EditableDropdown','2014-02-28 17:11:05','2014-02-28 17:32:14','EditableDropdown5','select',NULL,5,0,NULL,'a:0:{}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(32,6,3,1,1,1,'EditableTextField','2014-02-28 17:12:20','2014-02-28 17:32:14','EditableTextField6','textarea',NULL,6,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:0:\"\";s:4:\"Rows\";s:2:\"10\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(33,1,9,1,1,1,'EditableTextField','2014-02-28 10:02:18','2014-02-28 17:33:27','EditableTextField1','first name',NULL,1,1,'your First Name is required','a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(34,2,9,1,1,1,'EditableTextField','2014-02-28 10:03:00','2014-02-28 17:33:27','EditableTextField2','last name',NULL,2,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:3:\"256\";s:4:\"Rows\";s:1:\"1\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(35,4,9,1,1,1,'EditableEmailField','2014-02-28 10:03:29','2014-02-28 17:33:27','EditableEmailField4','email',NULL,4,1,NULL,'a:2:{i:0;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField1\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}i:1;a:4:{s:7:\"Display\";s:4:\"Show\";s:14:\"ConditionField\";s:18:\"EditableTextField2\";s:15:\"ConditionOption\";s:10:\"IsNotBlank\";s:5:\"Value\";s:0:\"\";}}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Hide\";}',NULL,9),(36,5,5,1,1,1,'EditableDropdown','2014-02-28 17:11:05','2014-02-28 17:33:27','EditableDropdown5','select',NULL,5,0,NULL,'a:0:{}','a:3:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9),(37,6,4,1,1,1,'EditableTextField','2014-02-28 17:12:20','2014-02-28 17:33:27','EditableTextField6','textarea',NULL,6,0,NULL,'a:0:{}','a:6:{s:10:\"ExtraClass\";s:0:\"\";s:10:\"RightTitle\";s:0:\"\";s:9:\"MinLength\";s:0:\"\";s:9:\"MaxLength\";s:0:\"\";s:4:\"Rows\";s:2:\"10\";s:10:\"ShowOnLoad\";s:4:\"Show\";}',NULL,9);
/*!40000 ALTER TABLE `EditableFormField_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EditableOption`
--

DROP TABLE IF EXISTS `EditableOption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EditableOption` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('EditableOption') DEFAULT 'EditableOption',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EditableOption`
--

LOCK TABLES `EditableOption` WRITE;
/*!40000 ALTER TABLE `EditableOption` DISABLE KEYS */;
INSERT INTO `EditableOption` VALUES (1,'EditableOption','2014-02-28 17:11:16','2014-02-28 17:33:27','option1','select',0,1,6,5),(2,'EditableOption','2014-02-28 17:11:25','2014-02-28 17:33:27','option2','one',0,2,6,5);
/*!40000 ALTER TABLE `EditableOption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EditableOption_Live`
--

DROP TABLE IF EXISTS `EditableOption_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EditableOption_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('EditableOption') DEFAULT 'EditableOption',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EditableOption_Live`
--

LOCK TABLES `EditableOption_Live` WRITE;
/*!40000 ALTER TABLE `EditableOption_Live` DISABLE KEYS */;
INSERT INTO `EditableOption_Live` VALUES (1,'EditableOption','2014-02-28 17:11:16','2014-06-12 13:00:51','option1','select',0,1,6,5),(2,'EditableOption','2014-02-28 17:11:25','2014-06-12 13:00:51','option2','one',0,2,6,5);
/*!40000 ALTER TABLE `EditableOption_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EditableOption_versions`
--

DROP TABLE IF EXISTS `EditableOption_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EditableOption_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `WasPublished` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `AuthorID` int(11) NOT NULL DEFAULT '0',
  `PublisherID` int(11) NOT NULL DEFAULT '0',
  `ClassName` enum('EditableOption') DEFAULT 'EditableOption',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `AuthorID` (`AuthorID`),
  KEY `PublisherID` (`PublisherID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EditableOption_versions`
--

LOCK TABLES `EditableOption_versions` WRITE;
/*!40000 ALTER TABLE `EditableOption_versions` DISABLE KEYS */;
INSERT INTO `EditableOption_versions` VALUES (1,1,1,0,1,0,'EditableOption','2014-02-28 17:11:16','2014-02-28 17:11:16',NULL,NULL,0,0,0),(2,1,2,0,1,0,'EditableOption','2014-02-28 17:11:16','2014-02-28 17:11:16','option1',NULL,0,1,5),(3,2,1,0,1,0,'EditableOption','2014-02-28 17:11:25','2014-02-28 17:11:25',NULL,NULL,0,0,0),(4,2,2,0,1,0,'EditableOption','2014-02-28 17:11:25','2014-02-28 17:11:25','option2',NULL,0,2,5),(5,1,3,1,1,1,'EditableOption','2014-02-28 17:11:16','2014-02-28 17:11:31','option1','select',0,1,5),(6,2,3,1,1,1,'EditableOption','2014-02-28 17:11:25','2014-02-28 17:11:31','option2','one',0,2,5),(7,1,4,1,1,1,'EditableOption','2014-02-28 17:11:16','2014-02-28 17:12:34','option1','select',0,1,5),(8,2,4,1,1,1,'EditableOption','2014-02-28 17:11:25','2014-02-28 17:12:34','option2','one',0,2,5),(9,1,5,1,1,1,'EditableOption','2014-02-28 17:11:16','2014-02-28 17:32:14','option1','select',0,1,5),(10,2,5,1,1,1,'EditableOption','2014-02-28 17:11:25','2014-02-28 17:32:14','option2','one',0,2,5),(11,1,6,1,1,1,'EditableOption','2014-02-28 17:11:16','2014-02-28 17:33:27','option1','select',0,1,5),(12,2,6,1,1,1,'EditableOption','2014-02-28 17:11:25','2014-02-28 17:33:27','option2','one',0,2,5);
/*!40000 ALTER TABLE `EditableOption_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ErrorPage`
--

DROP TABLE IF EXISTS `ErrorPage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ErrorPage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ErrorCode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ErrorPage`
--

LOCK TABLES `ErrorPage` WRITE;
/*!40000 ALTER TABLE `ErrorPage` DISABLE KEYS */;
INSERT INTO `ErrorPage` VALUES (4,404),(5,500);
/*!40000 ALTER TABLE `ErrorPage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ErrorPage_Live`
--

DROP TABLE IF EXISTS `ErrorPage_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ErrorPage_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ErrorCode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ErrorPage_Live`
--

LOCK TABLES `ErrorPage_Live` WRITE;
/*!40000 ALTER TABLE `ErrorPage_Live` DISABLE KEYS */;
INSERT INTO `ErrorPage_Live` VALUES (4,404),(5,500);
/*!40000 ALTER TABLE `ErrorPage_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ErrorPage_versions`
--

DROP TABLE IF EXISTS `ErrorPage_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ErrorPage_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `ErrorCode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ErrorPage_versions`
--

LOCK TABLES `ErrorPage_versions` WRITE;
/*!40000 ALTER TABLE `ErrorPage_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ErrorPage_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File`
--

DROP TABLE IF EXISTS `File`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('File','Folder','Image','Image_Cached') DEFAULT 'File',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Filename` mediumtext,
  `Content` mediumtext,
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `OwnerID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `OwnerID` (`OwnerID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File`
--

LOCK TABLES `File` WRITE;
/*!40000 ALTER TABLE `File` DISABLE KEYS */;
INSERT INTO `File` VALUES (1,'Folder','2013-11-21 17:30:16','2013-11-21 17:30:16','Uploads','Uploads','assets/Uploads/',NULL,1,0,1),(2,'Image','2015-05-08 16:43:01','2015-05-08 16:43:01','ANDERSON-PROJECT-46edit7.jpg','ANDERSON PROJECT 46edit7','assets/Uploads/ANDERSON-PROJECT-46edit7.jpg',NULL,1,1,2);
/*!40000 ALTER TABLE `File` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group`
--

DROP TABLE IF EXISTS `Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('Group') DEFAULT 'Group',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Description` mediumtext,
  `Code` varchar(255) DEFAULT NULL,
  `Locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `HtmlEditorConfig` mediumtext,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group`
--

LOCK TABLES `Group` WRITE;
/*!40000 ALTER TABLE `Group` DISABLE KEYS */;
INSERT INTO `Group` VALUES (1,'Group','2013-11-21 09:30:33','2013-11-21 09:30:33','Content Authors',NULL,'content-authors',0,1,NULL,0),(2,'Group','2013-11-21 09:30:34','2013-11-21 09:30:34','Administrators',NULL,'administrators',0,0,NULL,0);
/*!40000 ALTER TABLE `Group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group_Members`
--

DROP TABLE IF EXISTS `Group_Members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group_Members` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupID` int(11) NOT NULL DEFAULT '0',
  `MemberID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `GroupID` (`GroupID`),
  KEY `MemberID` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group_Members`
--

LOCK TABLES `Group_Members` WRITE;
/*!40000 ALTER TABLE `Group_Members` DISABLE KEYS */;
INSERT INTO `Group_Members` VALUES (1,2,1),(2,2,2);
/*!40000 ALTER TABLE `Group_Members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group_Roles`
--

DROP TABLE IF EXISTS `Group_Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group_Roles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupID` int(11) NOT NULL DEFAULT '0',
  `PermissionRoleID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `GroupID` (`GroupID`),
  KEY `PermissionRoleID` (`PermissionRoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group_Roles`
--

LOCK TABLES `Group_Roles` WRITE;
/*!40000 ALTER TABLE `Group_Roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Group_Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LoginAttempt`
--

DROP TABLE IF EXISTS `LoginAttempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LoginAttempt` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('LoginAttempt') DEFAULT 'LoginAttempt',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Status` enum('Success','Failure') DEFAULT 'Success',
  `IP` varchar(255) DEFAULT NULL,
  `MemberID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `MemberID` (`MemberID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoginAttempt`
--

LOCK TABLES `LoginAttempt` WRITE;
/*!40000 ALTER TABLE `LoginAttempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `LoginAttempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Member`
--

DROP TABLE IF EXISTS `Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Member` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('Member') DEFAULT 'Member',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `Surname` varchar(50) DEFAULT NULL,
  `Email` varchar(254) DEFAULT NULL,
  `Password` varchar(160) DEFAULT NULL,
  `RememberLoginToken` varchar(160) DEFAULT NULL,
  `NumVisit` int(11) NOT NULL DEFAULT '0',
  `LastVisited` datetime DEFAULT NULL,
  `AutoLoginHash` varchar(160) DEFAULT NULL,
  `AutoLoginExpired` datetime DEFAULT NULL,
  `PasswordEncryption` varchar(50) DEFAULT NULL,
  `Salt` varchar(50) DEFAULT NULL,
  `PasswordExpiry` date DEFAULT NULL,
  `LockedOutUntil` datetime DEFAULT NULL,
  `Locale` varchar(6) DEFAULT NULL,
  `FailedLoginCount` int(11) NOT NULL DEFAULT '0',
  `DateFormat` varchar(30) DEFAULT NULL,
  `TimeFormat` varchar(30) DEFAULT NULL,
  `HasConfiguredDashboard` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `TempIDHash` varchar(160) DEFAULT NULL,
  `TempIDExpired` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Email` (`Email`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Member`
--

LOCK TABLES `Member` WRITE;
/*!40000 ALTER TABLE `Member` DISABLE KEYS */;
INSERT INTO `Member` VALUES (1,'Member','2013-11-21 09:30:34','2014-06-12 16:34:55','Default Admin',NULL,NULL,NULL,NULL,12,'2014-06-19 10:35:57',NULL,NULL,NULL,NULL,NULL,NULL,'en_US',0,NULL,NULL,0,NULL,NULL),(2,'Member','2015-04-02 15:55:46','2015-05-08 12:01:22','Default Admin',NULL,'defaultadmin',NULL,NULL,3,'2015-05-08 18:53:29',NULL,NULL,NULL,NULL,NULL,NULL,'en_US',0,NULL,NULL,0,'cd359c8e66b9670fb46c18211781b0013b491f09','2015-05-11 12:01:22');
/*!40000 ALTER TABLE `Member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MemberPassword`
--

DROP TABLE IF EXISTS `MemberPassword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MemberPassword` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('MemberPassword') DEFAULT 'MemberPassword',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Password` varchar(160) DEFAULT NULL,
  `Salt` varchar(50) DEFAULT NULL,
  `PasswordEncryption` varchar(50) DEFAULT NULL,
  `MemberID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `MemberID` (`MemberID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MemberPassword`
--

LOCK TABLES `MemberPassword` WRITE;
/*!40000 ALTER TABLE `MemberPassword` DISABLE KEYS */;
/*!40000 ALTER TABLE `MemberPassword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NewsArticle`
--

DROP TABLE IF EXISTS `NewsArticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NewsArticle` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date DEFAULT NULL,
  `AttachedImageID` int(11) NOT NULL DEFAULT '0',
  `IntroText` varchar(512) DEFAULT NULL,
  `TemplateShape` enum('Rectangle','Circle') DEFAULT 'Rectangle',
  PRIMARY KEY (`ID`),
  KEY `AttachedImageID` (`AttachedImageID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NewsArticle`
--

LOCK TABLES `NewsArticle` WRITE;
/*!40000 ALTER TABLE `NewsArticle` DISABLE KEYS */;
INSERT INTO `NewsArticle` VALUES (8,'2013-11-22',0,NULL,'Rectangle');
/*!40000 ALTER TABLE `NewsArticle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NewsArticle_Live`
--

DROP TABLE IF EXISTS `NewsArticle_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NewsArticle_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date DEFAULT NULL,
  `AttachedImageID` int(11) NOT NULL DEFAULT '0',
  `IntroText` varchar(512) DEFAULT NULL,
  `TemplateShape` enum('Rectangle','Circle') DEFAULT 'Rectangle',
  PRIMARY KEY (`ID`),
  KEY `AttachedImageID` (`AttachedImageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NewsArticle_Live`
--

LOCK TABLES `NewsArticle_Live` WRITE;
/*!40000 ALTER TABLE `NewsArticle_Live` DISABLE KEYS */;
/*!40000 ALTER TABLE `NewsArticle_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NewsArticle_versions`
--

DROP TABLE IF EXISTS `NewsArticle_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NewsArticle_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `Date` date DEFAULT NULL,
  `AttachedImageID` int(11) NOT NULL DEFAULT '0',
  `IntroText` varchar(512) DEFAULT NULL,
  `TemplateShape` enum('Rectangle','Circle') DEFAULT 'Rectangle',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `AttachedImageID` (`AttachedImageID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NewsArticle_versions`
--

LOCK TABLES `NewsArticle_versions` WRITE;
/*!40000 ALTER TABLE `NewsArticle_versions` DISABLE KEYS */;
INSERT INTO `NewsArticle_versions` VALUES (1,8,1,'2013-11-22',0,NULL,'Rectangle'),(2,8,2,'2013-11-22',0,NULL,'Rectangle'),(3,8,3,'2013-11-22',0,NULL,'Rectangle');
/*!40000 ALTER TABLE `NewsArticle_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OpenGraph`
--

DROP TABLE IF EXISTS `OpenGraph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OpenGraph` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('OpenGraph') DEFAULT 'OpenGraph',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `OGTitle` varchar(255) DEFAULT NULL,
  `OGDescription` varchar(255) DEFAULT NULL,
  `OGImageID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `OGImageID` (`OGImageID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OpenGraph`
--

LOCK TABLES `OpenGraph` WRITE;
/*!40000 ALTER TABLE `OpenGraph` DISABLE KEYS */;
/*!40000 ALTER TABLE `OpenGraph` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Page`
--

DROP TABLE IF EXISTS `Page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Page` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OGTitle` varchar(255) DEFAULT NULL,
  `OGDescription` varchar(255) DEFAULT NULL,
  `OGImageID` int(11) NOT NULL DEFAULT '0',
  `SEOPageSubject` varchar(256) DEFAULT NULL,
  `IMID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `OGImageID` (`OGImageID`),
  KEY `IMID` (`IMID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Page`
--

LOCK TABLES `Page` WRITE;
/*!40000 ALTER TABLE `Page` DISABLE KEYS */;
INSERT INTO `Page` VALUES (1,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,2),(3,'Technology','You can fill this page out with your own content, or delete it and create your own pages.',0,NULL,0),(8,NULL,NULL,0,NULL,0),(9,'Form','$UserDefinedForm',0,NULL,0),(10,'Blog',NULL,0,NULL,0),(11,'SilverStripe blog module successfully installed','.',0,NULL,0),(12,'Products','Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus',0,NULL,0),(13,'Our Panel',NULL,0,NULL,0),(14,'Results',NULL,0,NULL,0),(15,'About Us',NULL,0,NULL,0),(16,'Contact Us',NULL,0,NULL,0);
/*!40000 ALTER TABLE `Page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Page_Live`
--

DROP TABLE IF EXISTS `Page_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Page_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OGID` int(11) NOT NULL DEFAULT '0',
  `OGTitle` varchar(255) DEFAULT NULL,
  `OGDescription` varchar(255) DEFAULT NULL,
  `OGImageID` int(11) NOT NULL DEFAULT '0',
  `SEOPageSubject` varchar(256) DEFAULT NULL,
  `IMID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `OGID` (`OGID`),
  KEY `OGImageID` (`OGImageID`),
  KEY `IMID` (`IMID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Page_Live`
--

LOCK TABLES `Page_Live` WRITE;
/*!40000 ALTER TABLE `Page_Live` DISABLE KEYS */;
INSERT INTO `Page_Live` VALUES (1,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,2),(3,0,'Technology','You can fill this page out with your own content, or delete it and create your own pages.',0,NULL,0),(9,0,'Form','$UserDefinedForm',0,NULL,0),(10,0,'Blog',NULL,0,NULL,0),(11,0,'SilverStripe blog module successfully installed','.',0,NULL,0),(12,0,'Products','Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus',0,NULL,0),(13,0,'Our Panel',NULL,0,NULL,0),(14,0,'Results',NULL,0,NULL,0),(15,0,'About Us',NULL,0,NULL,0),(16,0,'Contact Us',NULL,0,NULL,0);
/*!40000 ALTER TABLE `Page_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Page_versions`
--

DROP TABLE IF EXISTS `Page_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Page_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `OGID` int(11) NOT NULL DEFAULT '0',
  `OGTitle` varchar(255) DEFAULT NULL,
  `OGDescription` varchar(255) DEFAULT NULL,
  `OGImageID` int(11) NOT NULL DEFAULT '0',
  `SEOPageSubject` varchar(256) DEFAULT NULL,
  `IMID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `OGID` (`OGID`),
  KEY `OGImageID` (`OGImageID`),
  KEY `IMID` (`IMID`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Page_versions`
--

LOCK TABLES `Page_versions` WRITE;
/*!40000 ALTER TABLE `Page_versions` DISABLE KEYS */;
INSERT INTO `Page_versions` VALUES (1,6,1,0,NULL,NULL,0,NULL,0),(2,6,2,0,NULL,NULL,0,NULL,0),(3,1,2,0,NULL,NULL,0,NULL,0),(4,1,3,0,NULL,NULL,0,NULL,0),(5,1,4,0,NULL,NULL,0,NULL,0),(6,1,5,3,NULL,NULL,0,NULL,0),(7,1,6,0,NULL,NULL,0,NULL,0),(8,1,7,0,'xxx',NULL,0,NULL,0),(9,1,8,0,'home social',NULL,0,NULL,0),(10,1,9,0,'home social','the description',2,NULL,0),(11,7,1,0,NULL,NULL,0,NULL,0),(12,7,2,0,NULL,NULL,0,NULL,0),(13,8,1,0,NULL,NULL,0,NULL,0),(14,8,2,0,NULL,NULL,0,NULL,0),(15,8,3,0,NULL,NULL,0,NULL,0),(16,1,10,0,NULL,NULL,0,NULL,0),(17,9,1,0,NULL,NULL,0,NULL,0),(18,9,2,0,NULL,NULL,0,NULL,0),(19,9,3,0,'Form','$UserDefinedForm',0,NULL,0),(20,9,4,0,'Form','$UserDefinedForm',0,NULL,0),(21,1,11,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,0),(22,1,12,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,0),(23,1,13,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,0),(24,10,1,0,NULL,NULL,0,NULL,0),(25,11,1,0,NULL,NULL,0,NULL,0),(26,11,2,0,'SilverStripe blog module successfully installed','.',0,NULL,0),(27,11,3,0,'SilverStripe blog module successfully installed','.',0,NULL,0),(28,10,2,0,'Blog',NULL,0,NULL,0),(29,10,3,0,'Blog',NULL,0,NULL,0),(30,11,4,0,'SilverStripe blog module successfully installed','.',0,NULL,0),(31,11,5,0,'SilverStripe blog module successfully installed','.',0,NULL,0),(32,1,14,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,0),(33,1,15,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,0),(34,2,2,0,'About Us',NULL,0,NULL,0),(35,2,3,0,'What is SAM','You can fill this page out with your own content, or delete it and create your own pages.',0,NULL,0),(36,3,2,0,'Contact Us',NULL,0,NULL,0),(37,3,3,0,'Technology','You can fill this page out with your own content, or delete it and create your own pages.',0,NULL,0),(38,3,4,0,'Technology','You can fill this page out with your own content, or delete it and create your own pages.',0,NULL,0),(39,12,1,0,NULL,NULL,0,NULL,0),(40,12,2,0,'New Page',NULL,0,NULL,0),(41,12,3,0,'Products',NULL,0,NULL,0),(42,12,4,0,'Products','Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus',0,NULL,0),(43,12,5,0,'Products','Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus',0,NULL,0),(44,13,1,0,NULL,NULL,0,NULL,0),(45,13,2,0,'New Page',NULL,0,NULL,0),(46,13,3,0,'Our Panel',NULL,0,NULL,0),(47,14,1,0,NULL,NULL,0,NULL,0),(48,14,2,0,'New Page',NULL,0,NULL,0),(49,14,3,0,'Results',NULL,0,NULL,0),(50,14,4,0,'Results',NULL,0,NULL,0),(51,13,4,0,'Our Panel',NULL,0,NULL,0),(52,9,5,0,'Form','$UserDefinedForm',0,NULL,0),(53,1,16,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,0),(54,1,17,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,0),(55,1,18,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,0),(56,3,5,0,'Technology','You can fill this page out with your own content, or delete it and create your own pages.',0,NULL,0),(57,12,6,0,'Products','Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus',0,NULL,0),(58,14,5,0,'Results',NULL,0,NULL,0),(59,15,1,0,NULL,NULL,0,NULL,0),(60,15,2,0,'New About Page',NULL,0,NULL,0),(61,15,3,0,'About Us',NULL,0,NULL,0),(62,15,4,0,'About Us',NULL,0,NULL,0),(63,13,5,0,'Our Panel',NULL,0,NULL,0),(64,16,1,0,NULL,NULL,0,NULL,0),(65,16,2,0,'New Contact Page',NULL,0,NULL,0),(66,16,3,0,'Contact Us',NULL,0,NULL,0),(67,16,4,0,'Contact Us',NULL,0,NULL,0),(68,10,4,0,'Blog',NULL,0,NULL,0),(69,15,6,0,'About Us',NULL,0,NULL,0),(70,3,7,0,'Technology','You can fill this page out with your own content, or delete it and create your own pages.',0,NULL,0),(71,1,20,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,0),(72,1,21,0,'Home','Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bib',0,NULL,2);
/*!40000 ALTER TABLE `Page_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Permission`
--

DROP TABLE IF EXISTS `Permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Permission` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('Permission') DEFAULT 'Permission',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Code` varchar(50) DEFAULT NULL,
  `Arg` int(11) NOT NULL DEFAULT '0',
  `Type` int(11) NOT NULL DEFAULT '1',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `GroupID` (`GroupID`),
  KEY `Code` (`Code`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permission`
--

LOCK TABLES `Permission` WRITE;
/*!40000 ALTER TABLE `Permission` DISABLE KEYS */;
INSERT INTO `Permission` VALUES (1,'Permission','2013-11-21 09:30:33','2013-11-21 09:30:33','CMS_ACCESS_CMSMain',0,1,1),(2,'Permission','2013-11-21 09:30:33','2013-11-21 09:30:33','CMS_ACCESS_AssetAdmin',0,1,1),(3,'Permission','2013-11-21 09:30:33','2013-11-21 09:30:33','CMS_ACCESS_ReportAdmin',0,1,1),(4,'Permission','2013-11-21 09:30:34','2013-11-21 09:30:34','SITETREE_REORGANISE',0,1,1),(5,'Permission','2013-11-21 09:30:34','2013-11-21 09:30:34','ADMIN',0,1,2);
/*!40000 ALTER TABLE `Permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PermissionRole`
--

DROP TABLE IF EXISTS `PermissionRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PermissionRole` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('PermissionRole') DEFAULT 'PermissionRole',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Title` varchar(50) DEFAULT NULL,
  `OnlyAdminCanApply` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PermissionRole`
--

LOCK TABLES `PermissionRole` WRITE;
/*!40000 ALTER TABLE `PermissionRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `PermissionRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PermissionRoleCode`
--

DROP TABLE IF EXISTS `PermissionRoleCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PermissionRoleCode` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('PermissionRoleCode') DEFAULT 'PermissionRoleCode',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Code` varchar(50) DEFAULT NULL,
  `RoleID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `RoleID` (`RoleID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PermissionRoleCode`
--

LOCK TABLES `PermissionRoleCode` WRITE;
/*!40000 ALTER TABLE `PermissionRoleCode` DISABLE KEYS */;
/*!40000 ALTER TABLE `PermissionRoleCode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RSSWidget`
--

DROP TABLE IF EXISTS `RSSWidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RSSWidget` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RSSTitle` mediumtext,
  `RssUrl` mediumtext,
  `NumberToShow` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RSSWidget`
--

LOCK TABLES `RSSWidget` WRITE;
/*!40000 ALTER TABLE `RSSWidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `RSSWidget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RedirectorPage`
--

DROP TABLE IF EXISTS `RedirectorPage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RedirectorPage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RedirectionType` enum('Internal','External') DEFAULT 'Internal',
  `ExternalURL` varchar(2083) DEFAULT NULL,
  `LinkToID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `LinkToID` (`LinkToID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RedirectorPage`
--

LOCK TABLES `RedirectorPage` WRITE;
/*!40000 ALTER TABLE `RedirectorPage` DISABLE KEYS */;
/*!40000 ALTER TABLE `RedirectorPage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RedirectorPage_Live`
--

DROP TABLE IF EXISTS `RedirectorPage_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RedirectorPage_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RedirectionType` enum('Internal','External') DEFAULT 'Internal',
  `ExternalURL` varchar(2083) DEFAULT NULL,
  `LinkToID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `LinkToID` (`LinkToID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RedirectorPage_Live`
--

LOCK TABLES `RedirectorPage_Live` WRITE;
/*!40000 ALTER TABLE `RedirectorPage_Live` DISABLE KEYS */;
/*!40000 ALTER TABLE `RedirectorPage_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RedirectorPage_versions`
--

DROP TABLE IF EXISTS `RedirectorPage_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RedirectorPage_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `RedirectionType` enum('Internal','External') DEFAULT 'Internal',
  `ExternalURL` varchar(2083) DEFAULT NULL,
  `LinkToID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `LinkToID` (`LinkToID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RedirectorPage_versions`
--

LOCK TABLES `RedirectorPage_versions` WRITE;
/*!40000 ALTER TABLE `RedirectorPage_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `RedirectorPage_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteConfig`
--

DROP TABLE IF EXISTS `SiteConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteConfig` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SiteConfig') DEFAULT 'SiteConfig',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Tagline` varchar(255) DEFAULT NULL,
  `Theme` varchar(255) DEFAULT NULL,
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers') DEFAULT 'Anyone',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers') DEFAULT 'LoggedInUsers',
  `CanCreateTopLevelType` enum('LoggedInUsers','OnlyTheseUsers') DEFAULT 'LoggedInUsers',
  `GoogleSiteVerificationCode` varchar(128) DEFAULT NULL,
  `GoogleAnalyticsCode` varchar(20) DEFAULT NULL,
  `OGID` int(11) NOT NULL DEFAULT '0',
  `SiteVersion` varchar(10) DEFAULT NULL,
  `GoogleCustomCode` mediumtext,
  `OGTitle` varchar(255) DEFAULT NULL,
  `OGDescription` varchar(512) DEFAULT NULL,
  `OGImageID` int(11) NOT NULL DEFAULT '0',
  `FacebookURL` varchar(255) DEFAULT NULL,
  `TwitterURL` varchar(255) DEFAULT NULL,
  `PinterestURL` varchar(255) DEFAULT NULL,
  `GoogleAnalyticsProfileId` varchar(255) DEFAULT NULL,
  `GoogleAnalyticsEmail` varchar(50) DEFAULT NULL,
  `GoogleAnalyticsPassword` varchar(50) DEFAULT NULL,
  `GMapsAPIKey` varchar(255) DEFAULT NULL,
  `GMapsEnableStreetView` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `TwitterName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`),
  KEY `OGID` (`OGID`),
  KEY `OGImageID` (`OGImageID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteConfig`
--

LOCK TABLES `SiteConfig` WRITE;
/*!40000 ALTER TABLE `SiteConfig` DISABLE KEYS */;
INSERT INTO `SiteConfig` VALUES (1,'SiteConfig','2013-11-21 09:30:34','2015-04-02 16:09:46','Your Site Name','your tagline here','default','Anyone','LoggedInUsers','LoggedInUsers',NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `SiteConfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteConfig_CreateTopLevelGroups`
--

DROP TABLE IF EXISTS `SiteConfig_CreateTopLevelGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteConfig_CreateTopLevelGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteConfigID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteConfigID` (`SiteConfigID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteConfig_CreateTopLevelGroups`
--

LOCK TABLES `SiteConfig_CreateTopLevelGroups` WRITE;
/*!40000 ALTER TABLE `SiteConfig_CreateTopLevelGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteConfig_CreateTopLevelGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteConfig_EditorGroups`
--

DROP TABLE IF EXISTS `SiteConfig_EditorGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteConfig_EditorGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteConfigID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteConfigID` (`SiteConfigID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteConfig_EditorGroups`
--

LOCK TABLES `SiteConfig_EditorGroups` WRITE;
/*!40000 ALTER TABLE `SiteConfig_EditorGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteConfig_EditorGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteConfig_ViewerGroups`
--

DROP TABLE IF EXISTS `SiteConfig_ViewerGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteConfig_ViewerGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteConfigID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteConfigID` (`SiteConfigID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteConfig_ViewerGroups`
--

LOCK TABLES `SiteConfig_ViewerGroups` WRITE;
/*!40000 ALTER TABLE `SiteConfig_ViewerGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteConfig_ViewerGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree`
--

DROP TABLE IF EXISTS `SiteTree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SiteTree','Page','NewsArticle','NewsHolder','ErrorPage','RedirectorPage','VirtualPage','UserDefinedForm','BlogEntry','BlogHolder','ProductsPage','ResultsPage','PanelPage','ContactPage') DEFAULT 'SiteTree',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `URLSegment` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `MenuTitle` varchar(100) DEFAULT NULL,
  `Content` mediumtext,
  `MetaDescription` mediumtext,
  `ExtraMeta` mediumtext,
  `ShowInMenus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `HasBrokenFile` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HasBrokenLink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ReportClass` varchar(50) DEFAULT NULL,
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `Priority` varchar(5) DEFAULT NULL,
  `Version` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `URLSegment` (`URLSegment`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree`
--

LOCK TABLES `SiteTree` WRITE;
/*!40000 ALTER TABLE `SiteTree` DISABLE KEYS */;
INSERT INTO `SiteTree` VALUES (1,'Page','2013-11-21 09:30:34','2015-05-08 16:43:04','home','Home','What is SAM','<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,21,0),(3,'Page','2013-11-21 09:30:34','2015-05-08 13:07:41','technology','Technology',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,3,0,0,NULL,'Inherit','Inherit',NULL,7,0),(4,'ErrorPage','2013-11-21 09:30:34','2013-11-21 09:30:34','page-not-found','Page not found',NULL,'<p>Sorry, it seems you were trying to access a page that doesn\'t exist.</p><p>Please check the spelling of the URL you were trying to access and try again.</p>',NULL,NULL,0,0,7,0,0,NULL,'Inherit','Inherit',NULL,1,0),(5,'ErrorPage','2013-11-21 09:30:35','2013-11-21 09:30:35','server-error','Server error',NULL,'<p>Sorry, there was a problem with handling your request.</p>',NULL,NULL,0,0,8,0,0,NULL,'Inherit','Inherit',NULL,1,0),(8,'NewsArticle','2013-11-22 11:04:13','2013-11-22 11:05:18','test','Test','2013-11-22: Test','<p>Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec sed odio dui. Nullam id dolor id nibh ultricies vehicula ut id elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Aenean lacinia bibendum nulla sed consectetur. Maecenas faucibus mollis interdum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Maecenas faucibus mollis interdum. Maecenas sed diam eget risus varius blandit sit amet non magna. Nullam quis risus eget urna mollis ornare vel eu leo. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,3,7),(9,'UserDefinedForm','2014-02-28 10:01:53','2014-06-12 13:00:51','form-2','Form',NULL,'<p>$UserDefinedForm</p>',NULL,NULL,0,1,9,0,0,NULL,'Inherit','Inherit',NULL,5,0),(10,'BlogHolder','2014-06-11 00:55:37','2014-06-19 10:18:59','blog','Blog',NULL,NULL,NULL,NULL,1,1,10,0,0,NULL,'Inherit','Inherit',NULL,4,0),(11,'BlogEntry','2014-06-11 00:55:37','2014-06-11 14:47:34','sample-blog-entry','SilverStripe blog module successfully installed',NULL,'<p>Congratulations, the SilverStripe blog module has been successfully installed. This blog entry can be safely deleted. You can configure aspects of your blog in <a href=\"admin\">the CMS</a>.</p>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,5,10),(12,'ProductsPage','2014-06-12 12:58:31','2014-06-16 09:50:48','products','Products',NULL,'<p>Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus ac facilisis in, egestas eget quam.</p>',NULL,NULL,1,1,4,0,0,NULL,'Inherit','Inherit',NULL,6,0),(13,'PanelPage','2014-06-12 12:59:54','2014-06-16 17:21:50','our-panel','Our Panel',NULL,NULL,NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,5,0),(14,'ResultsPage','2014-06-12 13:00:08','2014-06-16 12:00:17','results','Results',NULL,NULL,NULL,NULL,1,1,5,0,0,NULL,'Inherit','Inherit',NULL,5,0),(15,'Page','2014-06-16 15:31:09','2015-04-20 14:28:21','about-us','About Us',NULL,NULL,NULL,NULL,0,0,11,0,0,NULL,'Inherit','Inherit',NULL,6,0),(16,'ContactPage','2014-06-17 10:34:48','2014-06-17 10:35:05','contact-us','Contact Us',NULL,NULL,NULL,NULL,0,1,12,0,0,NULL,'Inherit','Inherit',NULL,4,0);
/*!40000 ALTER TABLE `SiteTree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_EditorGroups`
--

DROP TABLE IF EXISTS `SiteTree_EditorGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_EditorGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteTreeID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteTreeID` (`SiteTreeID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_EditorGroups`
--

LOCK TABLES `SiteTree_EditorGroups` WRITE;
/*!40000 ALTER TABLE `SiteTree_EditorGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteTree_EditorGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_ImageTracking`
--

DROP TABLE IF EXISTS `SiteTree_ImageTracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_ImageTracking` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteTreeID` int(11) NOT NULL DEFAULT '0',
  `FileID` int(11) NOT NULL DEFAULT '0',
  `FieldName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `SiteTreeID` (`SiteTreeID`),
  KEY `FileID` (`FileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_ImageTracking`
--

LOCK TABLES `SiteTree_ImageTracking` WRITE;
/*!40000 ALTER TABLE `SiteTree_ImageTracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteTree_ImageTracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_LinkTracking`
--

DROP TABLE IF EXISTS `SiteTree_LinkTracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_LinkTracking` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteTreeID` int(11) NOT NULL DEFAULT '0',
  `ChildID` int(11) NOT NULL DEFAULT '0',
  `FieldName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `SiteTreeID` (`SiteTreeID`),
  KEY `ChildID` (`ChildID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_LinkTracking`
--

LOCK TABLES `SiteTree_LinkTracking` WRITE;
/*!40000 ALTER TABLE `SiteTree_LinkTracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteTree_LinkTracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_Live`
--

DROP TABLE IF EXISTS `SiteTree_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SiteTree','Page','NewsArticle','NewsHolder','ErrorPage','RedirectorPage','VirtualPage','UserDefinedForm','BlogEntry','BlogHolder','ProductsPage','ResultsPage','PanelPage','ContactPage') DEFAULT 'SiteTree',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `URLSegment` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `MenuTitle` varchar(100) DEFAULT NULL,
  `Content` mediumtext,
  `MetaDescription` mediumtext,
  `ExtraMeta` mediumtext,
  `ShowInMenus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `HasBrokenFile` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HasBrokenLink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ReportClass` varchar(50) DEFAULT NULL,
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `Priority` varchar(5) DEFAULT NULL,
  `Version` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `URLSegment` (`URLSegment`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_Live`
--

LOCK TABLES `SiteTree_Live` WRITE;
/*!40000 ALTER TABLE `SiteTree_Live` DISABLE KEYS */;
INSERT INTO `SiteTree_Live` VALUES (1,'Page','2013-11-21 09:30:34','2015-05-08 16:43:04','home','Home','What is SAM','<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,21,0),(3,'Page','2013-11-21 09:30:34','2015-05-08 13:07:41','technology','Technology',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,3,0,0,NULL,'Inherit','Inherit',NULL,7,0),(4,'ErrorPage','2013-11-21 09:30:34','2013-11-21 09:30:34','page-not-found','Page not found',NULL,'<p>Sorry, it seems you were trying to access a page that doesn\'t exist.</p><p>Please check the spelling of the URL you were trying to access and try again.</p>',NULL,NULL,0,0,7,0,0,NULL,'Inherit','Inherit',NULL,1,0),(5,'ErrorPage','2013-11-21 09:30:35','2013-11-21 09:30:35','server-error','Server error',NULL,'<p>Sorry, there was a problem with handling your request.</p>',NULL,NULL,0,0,8,0,0,NULL,'Inherit','Inherit',NULL,1,0),(9,'UserDefinedForm','2014-02-28 10:01:53','2014-06-12 13:00:52','form-2','Form',NULL,'<p>$UserDefinedForm</p>',NULL,NULL,0,1,9,0,0,NULL,'Inherit','Inherit',NULL,5,0),(10,'BlogHolder','2014-06-11 00:55:37','2014-06-19 10:19:00','blog','Blog',NULL,NULL,NULL,NULL,1,1,10,0,0,NULL,'Inherit','Inherit',NULL,4,0),(11,'BlogEntry','2014-06-11 00:55:37','2014-06-11 14:47:34','sample-blog-entry','SilverStripe blog module successfully installed',NULL,'<p>Congratulations, the SilverStripe blog module has been successfully installed. This blog entry can be safely deleted. You can configure aspects of your blog in <a href=\"admin\">the CMS</a>.</p>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,5,10),(12,'ProductsPage','2014-06-12 12:58:31','2014-06-16 09:50:48','products','Products',NULL,'<p>Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus ac facilisis in, egestas eget quam.</p>',NULL,NULL,1,1,4,0,0,NULL,'Inherit','Inherit',NULL,6,0),(13,'PanelPage','2014-06-12 12:59:54','2014-06-16 17:21:50','our-panel','Our Panel',NULL,NULL,NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,5,0),(14,'ResultsPage','2014-06-12 13:00:08','2014-06-16 12:00:17','results','Results',NULL,NULL,NULL,NULL,1,1,5,0,0,NULL,'Inherit','Inherit',NULL,5,0),(15,'Page','2014-06-16 15:31:09','2015-04-20 14:28:21','about-us','About Us',NULL,NULL,NULL,NULL,0,0,11,0,0,NULL,'Inherit','Inherit',NULL,6,0),(16,'ContactPage','2014-06-17 10:34:48','2014-06-17 10:35:05','contact-us','Contact Us',NULL,NULL,NULL,NULL,0,1,12,0,0,NULL,'Inherit','Inherit',NULL,4,0);
/*!40000 ALTER TABLE `SiteTree_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_ViewerGroups`
--

DROP TABLE IF EXISTS `SiteTree_ViewerGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_ViewerGroups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteTreeID` int(11) NOT NULL DEFAULT '0',
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SiteTreeID` (`SiteTreeID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_ViewerGroups`
--

LOCK TABLES `SiteTree_ViewerGroups` WRITE;
/*!40000 ALTER TABLE `SiteTree_ViewerGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `SiteTree_ViewerGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteTree_versions`
--

DROP TABLE IF EXISTS `SiteTree_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteTree_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `WasPublished` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `AuthorID` int(11) NOT NULL DEFAULT '0',
  `PublisherID` int(11) NOT NULL DEFAULT '0',
  `ClassName` enum('SiteTree','Page','NewsArticle','NewsHolder','ErrorPage','RedirectorPage','VirtualPage','UserDefinedForm','BlogEntry','BlogHolder','ProductsPage','ResultsPage','PanelPage','ContactPage') DEFAULT 'SiteTree',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `URLSegment` varchar(255) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `MenuTitle` varchar(100) DEFAULT NULL,
  `Content` mediumtext,
  `MetaDescription` mediumtext,
  `ExtraMeta` mediumtext,
  `ShowInMenus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ShowInSearch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sort` int(11) NOT NULL DEFAULT '0',
  `HasBrokenFile` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HasBrokenLink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ReportClass` varchar(50) DEFAULT NULL,
  `CanViewType` enum('Anyone','LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `CanEditType` enum('LoggedInUsers','OnlyTheseUsers','Inherit') DEFAULT 'Inherit',
  `Priority` varchar(5) DEFAULT NULL,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `AuthorID` (`AuthorID`),
  KEY `PublisherID` (`PublisherID`),
  KEY `ParentID` (`ParentID`),
  KEY `URLSegment` (`URLSegment`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteTree_versions`
--

LOCK TABLES `SiteTree_versions` WRITE;
/*!40000 ALTER TABLE `SiteTree_versions` DISABLE KEYS */;
INSERT INTO `SiteTree_versions` VALUES (1,1,1,1,1,1,'Page','2013-11-21 09:30:34','2013-11-21 09:30:34','home','Home',NULL,'<p>Welcome to SilverStripe! This is the default homepage. You can edit this page by opening <a href=\"admin/\">the CMS</a>. You can now access the <a href=\"http://doc.silverstripe.org\">developer documentation</a>, or begin <a href=\"http://doc.silverstripe.org/doku.php?id=tutorials\">the tutorials.</a></p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(2,2,1,1,1,1,'Page','2013-11-21 09:30:34','2013-11-21 09:30:34','about-us','About Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.<br /></p>',NULL,NULL,1,1,2,0,0,NULL,'Inherit','Inherit',NULL,0),(3,3,1,1,1,1,'Page','2013-11-21 09:30:34','2013-11-21 09:30:34','contact-us','Contact Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.<br /></p>',NULL,NULL,1,1,3,0,0,NULL,'Inherit','Inherit',NULL,0),(4,4,1,1,1,1,'ErrorPage','2013-11-21 09:30:34','2013-11-21 09:30:34','page-not-found','Page not found',NULL,'<p>Sorry, it seems you were trying to access a page that doesn\'t exist.</p><p>Please check the spelling of the URL you were trying to access and try again.</p>',NULL,NULL,0,0,4,0,0,NULL,'Inherit','Inherit',NULL,0),(5,5,1,1,1,1,'ErrorPage','2013-11-21 09:30:35','2013-11-21 09:30:35','server-error','Server error',NULL,'<p>Sorry, there was a problem with handling your request.</p>',NULL,NULL,0,0,5,0,0,NULL,'Inherit','Inherit',NULL,0),(6,6,1,1,1,1,'Page','2013-11-21 11:59:31','2013-11-21 11:59:31','new-page','New Page',NULL,NULL,NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,3),(7,6,2,0,1,0,'Page','2013-11-21 11:59:31','2013-11-21 12:11:12','new-page','New Page',NULL,NULL,NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,3),(8,1,2,0,1,0,'Page','2013-11-21 09:30:34','2013-11-21 12:36:26','home','Home',NULL,'<p>Welcome to SilverStripe! This is the default homepage. You can edit this page by opening <a href=\"admin/\">the CMS</a>. You can now access the <a href=\"http://doc.silverstripe.org\">developer documentation</a>, or begin <a href=\"http://doc.silverstripe.org/doku.php?id=tutorials\">the tutorials.</a></p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(9,1,3,0,1,0,'Page','2013-11-21 09:30:34','2013-11-21 12:36:26','home','Home',NULL,'<p>Welcome to SilverStripe! This is the default homepage. You can edit this page by opening <a href=\"admin/\">the CMS</a>. You can now access the <a href=\"http://doc.silverstripe.org\">developer documentation</a>, or begin <a href=\"http://doc.silverstripe.org/doku.php?id=tutorials\">the tutorials.</a></p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(10,1,4,1,1,1,'Page','2013-11-21 09:30:34','2013-11-21 12:38:50','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(11,1,5,0,1,0,'Page','2013-11-21 09:30:34','2013-11-21 12:54:38','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(12,1,6,0,1,0,'Page','2013-11-21 09:30:34','2013-11-21 14:50:36','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(13,1,7,0,1,0,'Page','2013-11-21 09:30:34','2013-11-21 17:13:41','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(14,1,8,1,1,1,'Page','2013-11-21 09:30:34','2013-11-21 17:20:42','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(15,1,9,1,1,1,'Page','2013-11-21 09:30:34','2013-11-21 17:30:18','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(16,7,1,0,1,0,'NewsHolder','2013-11-22 11:03:36','2013-11-22 11:03:36','new-news-holder','New News Holder',NULL,NULL,NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,0),(17,7,2,1,1,1,'NewsHolder','2013-11-22 11:03:36','2013-11-22 11:03:58','news','News',NULL,'<p>Etiam porta sem malesuada magna mollis euismod. Maecenas sed diam eget risus varius blandit sit amet non magna. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Sed posuere consectetur est at lobortis.</p>',NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,0),(18,8,1,0,1,0,'NewsArticle','2013-11-22 11:04:13','2013-11-22 11:04:13','new-news-article','New News Article','2013-11-22: New News Article',NULL,NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,7),(19,8,2,1,1,1,'NewsArticle','2013-11-22 11:04:13','2013-11-22 11:04:48','test','Test','2013-11-22: Test',NULL,NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,7),(20,8,3,1,1,1,'NewsArticle','2013-11-22 11:04:13','2013-11-22 11:05:18','test','Test','2013-11-22: Test','<p>Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec sed odio dui. Nullam id dolor id nibh ultricies vehicula ut id elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Aenean lacinia bibendum nulla sed consectetur. Maecenas faucibus mollis interdum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Maecenas faucibus mollis interdum. Maecenas sed diam eget risus varius blandit sit amet non magna. Nullam quis risus eget urna mollis ornare vel eu leo. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,7),(21,1,10,1,1,1,'Page','2013-11-21 09:30:34','2014-02-24 10:10:50','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\n<p><img class=\"leftAlone\" title=\"\" src=\"assets/Uploads/_resampled/ResizedImage600316-birthday.jpg\" alt=\"birthday\" width=\"600\" height=\"316\"></p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(22,9,1,0,1,0,'UserDefinedForm','2014-02-28 10:01:53','2014-02-28 10:01:53','new-user-defined-form','New User Defined Form',NULL,'$UserDefinedForm',NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,0),(23,9,2,1,1,1,'UserDefinedForm','2014-02-28 10:01:53','2014-02-28 10:02:07','form-2','Form',NULL,'<p>$UserDefinedForm</p>',NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,0),(24,9,3,0,1,0,'UserDefinedForm','2014-02-28 10:01:53','2014-02-28 17:33:27','form-2','Form',NULL,'<p>$UserDefinedForm</p>',NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,0),(25,9,4,1,1,1,'UserDefinedForm','2014-02-28 10:01:53','2014-02-28 17:33:27','form-2','Form',NULL,'<p>$UserDefinedForm</p>',NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,0),(26,1,11,0,1,0,'Page','2013-11-21 09:30:34','2014-02-28 17:36:45','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\n<p><img class=\"leftAlone\" title=\"\" src=\"assets/Uploads/_resampled/ResizedImage600316-birthday.jpg\" alt=\"birthday\" width=\"600\" height=\"316\"></p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(27,1,12,1,1,1,'Page','2013-11-21 09:30:34','2014-02-28 17:36:45','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\n<p><img class=\"leftAlone\" title=\"\" src=\"assets/Uploads/_resampled/ResizedImage600316-birthday.jpg\" alt=\"birthday\" width=\"600\" height=\"316\"></p>\n<p><img class=\"leftAlone\" title=\"\" src=\"assets/Uploads/_resampled/ResizedImage600316-birthday.jpg\" alt=\"birthday\" width=\"600\" height=\"316\"></p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(28,1,13,1,1,1,'Page','2013-11-21 09:30:34','2014-03-06 16:01:45','home','Home',NULL,'<p>Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\n<p>Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Maecenas sed diam eget risus varius blandit sit amet non magna. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Etiam porta sem malesuada magna mollis euismod. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(29,10,1,1,0,0,'BlogHolder','2014-06-11 00:55:37','2014-06-11 00:55:37','blog','Blog',NULL,NULL,NULL,NULL,1,1,7,0,0,NULL,'Inherit','Inherit',NULL,0),(30,11,1,1,0,0,'BlogEntry','2014-06-11 00:55:37','2014-06-11 00:55:37','sample-blog-entry','SilverStripe blog module successfully installed',NULL,'<p>Congratulations, the SilverStripe blog module has been successfully installed. This blog entry can be safely deleted. You can configure aspects of your blog in <a href=\"admin\">the CMS</a>.</p>',NULL,NULL,0,1,0,0,0,NULL,'Inherit','Inherit',NULL,10),(31,11,2,0,1,0,'BlogEntry','2014-06-11 00:55:37','2014-06-11 13:23:23','sample-blog-entry','SilverStripe blog module successfully installed',NULL,'<p>Congratulations, the SilverStripe blog module has been successfully installed. This blog entry can be safely deleted. You can configure aspects of your blog in <a href=\"admin\">the CMS</a>.</p>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,10),(32,11,3,1,1,1,'BlogEntry','2014-06-11 00:55:37','2014-06-11 13:23:23','sample-blog-entry','SilverStripe blog module successfully installed',NULL,'<p>Congratulations, the SilverStripe blog module has been successfully installed. This blog entry can be safely deleted. You can configure aspects of your blog in <a href=\"admin\">the CMS</a>.</p>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,10),(33,10,2,0,1,0,'BlogHolder','2014-06-11 00:55:37','2014-06-11 14:47:13','blog','Blog',NULL,NULL,NULL,NULL,1,1,7,0,0,NULL,'Inherit','Inherit',NULL,0),(34,10,3,1,1,1,'BlogHolder','2014-06-11 00:55:37','2014-06-11 14:47:13','blog','Blog',NULL,NULL,NULL,NULL,1,1,7,0,0,NULL,'Inherit','Inherit',NULL,0),(35,11,4,1,1,1,'BlogEntry','2014-06-11 00:55:37','2014-06-11 14:47:27','sample-blog-entry','SilverStripe blog module successfully installed',NULL,'<p>Congratulations, the SilverStripe blog module has been successfully installed. This blog entry can be safely deleted. You can configure aspects of your blog in <a href=\"admin\">the CMS</a>.</p>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,10),(36,11,5,1,1,1,'BlogEntry','2014-06-11 00:55:37','2014-06-11 14:47:34','sample-blog-entry','SilverStripe blog module successfully installed',NULL,'<p>Congratulations, the SilverStripe blog module has been successfully installed. This blog entry can be safely deleted. You can configure aspects of your blog in <a href=\"admin\">the CMS</a>.</p>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,10),(37,1,14,1,1,1,'Page','2013-11-21 09:30:34','2014-06-12 12:04:59','home','Home',NULL,'<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(38,1,15,1,1,1,'Page','2013-11-21 09:30:34','2014-06-12 12:57:27','home','Home',NULL,'<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(39,2,2,0,1,0,'Page','2013-11-21 09:30:34','2014-06-12 12:57:56','about-us','About Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.<br /></p>',NULL,NULL,1,1,2,0,0,NULL,'Inherit','Inherit',NULL,0),(40,2,3,1,1,1,'Page','2013-11-21 09:30:34','2014-06-12 12:57:57','what-is-sam','What is SAM',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,2,0,0,NULL,'Inherit','Inherit',NULL,0),(41,3,2,0,1,0,'Page','2013-11-21 09:30:34','2014-06-12 12:58:10','contact-us','Contact Us',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.<br /></p>',NULL,NULL,1,1,3,0,0,NULL,'Inherit','Inherit',NULL,0),(42,3,3,1,1,1,'Page','2013-11-21 09:30:34','2014-06-12 12:58:10','contact-us','Technology',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,3,0,0,NULL,'Inherit','Inherit',NULL,0),(43,3,4,1,1,1,'Page','2013-11-21 09:30:34','2014-06-12 12:58:22','technology','Technology',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,3,0,0,NULL,'Inherit','Inherit',NULL,0),(44,12,1,0,1,0,'Page','2014-06-12 12:58:31','2014-06-12 12:58:31','new-page','New Page',NULL,NULL,NULL,NULL,1,1,8,0,0,NULL,'Inherit','Inherit',NULL,0),(45,12,2,0,1,0,'Page','2014-06-12 12:58:31','2014-06-12 12:58:49','new-page','New Page',NULL,NULL,NULL,NULL,1,1,8,0,0,NULL,'Inherit','Inherit',NULL,0),(46,12,3,1,1,1,'Page','2014-06-12 12:58:31','2014-06-12 12:58:49','products','Products',NULL,NULL,NULL,NULL,1,1,8,0,0,NULL,'Inherit','Inherit',NULL,0),(47,12,4,1,1,1,'Page','2014-06-12 12:58:31','2014-06-12 12:59:00','products','Products',NULL,'<p>Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus ac facilisis in, egestas eget quam.</p>',NULL,NULL,1,1,8,0,0,NULL,'Inherit','Inherit',NULL,0),(48,12,5,1,1,1,'Page','2014-06-12 12:58:31','2014-06-12 12:59:29','products','Products',NULL,'<p>Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus ac facilisis in, egestas eget quam.</p>',NULL,NULL,1,1,4,0,0,NULL,'Inherit','Inherit',NULL,0),(49,13,1,0,1,0,'Page','2014-06-12 12:59:54','2014-06-12 12:59:54','new-page','New Page',NULL,NULL,NULL,NULL,1,1,9,0,0,NULL,'Inherit','Inherit',NULL,0),(50,13,2,0,1,0,'Page','2014-06-12 12:59:54','2014-06-12 13:00:02','new-page','New Page',NULL,NULL,NULL,NULL,1,1,9,0,0,NULL,'Inherit','Inherit',NULL,0),(51,13,3,1,1,1,'Page','2014-06-12 12:59:54','2014-06-12 13:00:02','our-panel','Our Panel',NULL,NULL,NULL,NULL,1,1,9,0,0,NULL,'Inherit','Inherit',NULL,0),(52,14,1,0,1,0,'Page','2014-06-12 13:00:08','2014-06-12 13:00:08','new-page','New Page',NULL,NULL,NULL,NULL,1,1,10,0,0,NULL,'Inherit','Inherit',NULL,0),(53,14,2,0,1,0,'Page','2014-06-12 13:00:08','2014-06-12 13:00:15','new-page','New Page',NULL,NULL,NULL,NULL,1,1,10,0,0,NULL,'Inherit','Inherit',NULL,0),(54,14,3,1,1,1,'Page','2014-06-12 13:00:08','2014-06-12 13:00:15','results','Results',NULL,NULL,NULL,NULL,1,1,10,0,0,NULL,'Inherit','Inherit',NULL,0),(55,14,4,1,1,1,'Page','2014-06-12 13:00:08','2014-06-12 13:00:22','results','Results',NULL,NULL,NULL,NULL,1,1,5,0,0,NULL,'Inherit','Inherit',NULL,0),(56,13,4,0,1,0,'Page','2014-06-12 12:59:54','2014-06-12 13:00:29','our-panel','Our Panel',NULL,NULL,NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,0),(57,9,5,1,1,1,'UserDefinedForm','2014-02-28 10:01:53','2014-06-12 13:00:51','form-2','Form',NULL,'<p>$UserDefinedForm</p>',NULL,NULL,0,1,9,0,0,NULL,'Inherit','Inherit',NULL,0),(58,1,16,1,1,1,'','2013-11-21 09:30:34','2014-06-12 16:33:31','home','Home',NULL,'<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,0,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(59,1,17,0,1,0,'','2013-11-21 09:30:34','2014-06-13 16:34:38','home','Home',NULL,'<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(60,1,18,1,1,1,'','2013-11-21 09:30:34','2014-06-13 16:34:48','home','Home','What is SAM','<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(61,3,5,1,1,1,'','2013-11-21 09:30:34','2014-06-13 16:43:26','technology','Technology',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,3,0,0,NULL,'Inherit','Inherit',NULL,0),(62,12,6,1,1,1,'ProductsPage','2014-06-12 12:58:31','2014-06-16 09:50:48','products','Products',NULL,'<p>Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus ac facilisis in, egestas eget quam.</p>',NULL,NULL,1,1,4,0,0,NULL,'Inherit','Inherit',NULL,0),(63,14,5,1,1,1,'ResultsPage','2014-06-12 13:00:08','2014-06-16 12:00:17','results','Results',NULL,NULL,NULL,NULL,1,1,5,0,0,NULL,'Inherit','Inherit',NULL,0),(64,15,1,0,1,0,'','2014-06-16 15:31:09','2014-06-16 15:31:09','new-about-page','New About Page',NULL,NULL,NULL,NULL,1,1,11,0,0,NULL,'Inherit','Inherit',NULL,0),(65,15,2,0,1,0,'','2014-06-16 15:31:09','2014-06-16 15:31:22','new-about-page','New About Page',NULL,NULL,NULL,NULL,1,1,11,0,0,NULL,'Inherit','Inherit',NULL,0),(66,15,3,1,1,1,'','2014-06-16 15:31:09','2014-06-16 15:31:22','about-us','About Us',NULL,NULL,NULL,NULL,1,1,11,0,0,NULL,'Inherit','Inherit',NULL,0),(67,15,4,1,1,1,'','2014-06-16 15:31:09','2014-06-16 15:31:33','about-us','About Us',NULL,NULL,NULL,NULL,0,0,11,0,0,NULL,'Inherit','Inherit',NULL,0),(68,13,5,1,1,1,'PanelPage','2014-06-12 12:59:54','2014-06-16 17:21:50','our-panel','Our Panel',NULL,NULL,NULL,NULL,1,1,6,0,0,NULL,'Inherit','Inherit',NULL,0),(69,16,1,0,1,0,'ContactPage','2014-06-17 10:34:48','2014-06-17 10:34:48','new-contact-page','New Contact Page',NULL,NULL,NULL,NULL,1,1,12,0,0,NULL,'Inherit','Inherit',NULL,0),(70,16,2,0,1,0,'ContactPage','2014-06-17 10:34:48','2014-06-17 10:34:58','new-contact-page','New Contact Page',NULL,NULL,NULL,NULL,1,1,12,0,0,NULL,'Inherit','Inherit',NULL,0),(71,16,3,0,1,0,'ContactPage','2014-06-17 10:34:48','2014-06-17 10:34:58','contact-us','Contact Us',NULL,NULL,NULL,NULL,1,1,12,0,0,NULL,'Inherit','Inherit',NULL,0),(72,16,4,1,1,1,'ContactPage','2014-06-17 10:34:48','2014-06-17 10:35:05','contact-us','Contact Us',NULL,NULL,NULL,NULL,0,1,12,0,0,NULL,'Inherit','Inherit',NULL,0),(73,10,4,1,1,1,'BlogHolder','2014-06-11 00:55:37','2014-06-19 10:18:59','blog','Blog',NULL,NULL,NULL,NULL,1,1,10,0,0,NULL,'Inherit','Inherit',NULL,0),(74,1,19,1,2,2,'SiteTree','2013-11-21 09:30:34','2015-04-20 14:25:23','home','Home','What is SAM','<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(75,15,5,1,2,2,'SiteTree','2014-06-16 15:31:09','2015-04-20 14:28:08','about-us','About Us',NULL,NULL,NULL,NULL,0,0,11,0,0,NULL,'Inherit','Inherit',NULL,0),(76,15,6,1,2,2,'Page','2014-06-16 15:31:09','2015-04-20 14:28:21','about-us','About Us',NULL,NULL,NULL,NULL,0,0,11,0,0,NULL,'Inherit','Inherit',NULL,0),(77,3,6,1,2,2,'SiteTree','2013-11-21 09:30:34','2015-05-08 13:07:30','technology','Technology',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,3,0,0,NULL,'Inherit','Inherit',NULL,0),(78,3,7,1,2,2,'Page','2013-11-21 09:30:34','2015-05-08 13:07:41','technology','Technology',NULL,'<p>You can fill this page out with your own content, or delete it and create your own pages.</p>',NULL,NULL,1,1,3,0,0,NULL,'Inherit','Inherit',NULL,0),(79,1,20,1,2,2,'Page','2013-11-21 09:30:34','2015-05-08 14:12:41','home','Home','What is SAM','<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0),(80,1,21,1,2,2,'Page','2013-11-21 09:30:34','2015-05-08 16:43:04','home','Home','What is SAM','<h2>6</h2>\n<div class=\"row row1\">\n<div class=\"grid_1\">a</div>\n<div class=\"grid_1\">b</div>\n<div class=\"grid_1\">c</div>\n<div class=\"grid_1\">d</div>\n<div class=\"grid_1\">e</div>\n<div class=\"grid_1\">f</div>\n</div>\n<h2>3</h2>\n<div class=\"row\">\n<div class=\"grid_2\">a</div>\n<div class=\"grid_2\">b</div>\n<div class=\"grid_2\">c</div>\n</div>\n<h2>2</h2>\n<div class=\"row\">\n<div class=\"grid_3\">a</div>\n<div class=\"grid_3\">b</div>\n</div>',NULL,NULL,1,1,1,0,0,NULL,'Inherit','Inherit',NULL,0);
/*!40000 ALTER TABLE `SiteTree_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SubmittedFileField`
--

DROP TABLE IF EXISTS `SubmittedFileField`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubmittedFileField` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UploadedFileID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `UploadedFileID` (`UploadedFileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SubmittedFileField`
--

LOCK TABLES `SubmittedFileField` WRITE;
/*!40000 ALTER TABLE `SubmittedFileField` DISABLE KEYS */;
/*!40000 ALTER TABLE `SubmittedFileField` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SubmittedForm`
--

DROP TABLE IF EXISTS `SubmittedForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubmittedForm` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SubmittedForm') DEFAULT 'SubmittedForm',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `SubmittedByID` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SubmittedByID` (`SubmittedByID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SubmittedForm`
--

LOCK TABLES `SubmittedForm` WRITE;
/*!40000 ALTER TABLE `SubmittedForm` DISABLE KEYS */;
/*!40000 ALTER TABLE `SubmittedForm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SubmittedFormField`
--

DROP TABLE IF EXISTS `SubmittedFormField`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubmittedFormField` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('SubmittedFormField','SubmittedFileField') DEFAULT 'SubmittedFormField',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Value` mediumtext,
  `Title` varchar(255) DEFAULT NULL,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SubmittedFormField`
--

LOCK TABLES `SubmittedFormField` WRITE;
/*!40000 ALTER TABLE `SubmittedFormField` DISABLE KEYS */;
/*!40000 ALTER TABLE `SubmittedFormField` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TagCloudWidget`
--

DROP TABLE IF EXISTS `TagCloudWidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TagCloudWidget` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(50) DEFAULT NULL,
  `Limit` int(11) NOT NULL DEFAULT '0',
  `Sortby` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TagCloudWidget`
--

LOCK TABLES `TagCloudWidget` WRITE;
/*!40000 ALTER TABLE `TagCloudWidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `TagCloudWidget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaxonomyTerm`
--

DROP TABLE IF EXISTS `TaxonomyTerm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TaxonomyTerm` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('TaxonomyTerm') DEFAULT 'TaxonomyTerm',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TaxonomyTerm`
--

LOCK TABLES `TaxonomyTerm` WRITE;
/*!40000 ALTER TABLE `TaxonomyTerm` DISABLE KEYS */;
/*!40000 ALTER TABLE `TaxonomyTerm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserDefinedForm`
--

DROP TABLE IF EXISTS `UserDefinedForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserDefinedForm` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SubmitButtonText` varchar(50) DEFAULT NULL,
  `ClearButtonText` varchar(50) DEFAULT NULL,
  `OnCompleteMessage` mediumtext,
  `ShowClearButton` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `DisableSaveSubmissions` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `EnableLiveValidation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HideFieldLabels` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserDefinedForm`
--

LOCK TABLES `UserDefinedForm` WRITE;
/*!40000 ALTER TABLE `UserDefinedForm` DISABLE KEYS */;
INSERT INTO `UserDefinedForm` VALUES (9,NULL,NULL,'<p>Thanks, we\'ve received your submission.</p>',0,0,0,0);
/*!40000 ALTER TABLE `UserDefinedForm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserDefinedForm_EmailRecipient`
--

DROP TABLE IF EXISTS `UserDefinedForm_EmailRecipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserDefinedForm_EmailRecipient` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('UserDefinedForm_EmailRecipient') DEFAULT 'UserDefinedForm_EmailRecipient',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `EmailAddress` varchar(200) DEFAULT NULL,
  `EmailSubject` varchar(200) DEFAULT NULL,
  `EmailFrom` varchar(200) DEFAULT NULL,
  `EmailReplyTo` varchar(200) DEFAULT NULL,
  `EmailBody` mediumtext,
  `SendPlain` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HideFormData` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `FormID` int(11) NOT NULL DEFAULT '0',
  `SendEmailFromFieldID` int(11) NOT NULL DEFAULT '0',
  `SendEmailToFieldID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FormID` (`FormID`),
  KEY `SendEmailFromFieldID` (`SendEmailFromFieldID`),
  KEY `SendEmailToFieldID` (`SendEmailToFieldID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserDefinedForm_EmailRecipient`
--

LOCK TABLES `UserDefinedForm_EmailRecipient` WRITE;
/*!40000 ALTER TABLE `UserDefinedForm_EmailRecipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserDefinedForm_EmailRecipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserDefinedForm_Live`
--

DROP TABLE IF EXISTS `UserDefinedForm_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserDefinedForm_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SubmitButtonText` varchar(50) DEFAULT NULL,
  `ClearButtonText` varchar(50) DEFAULT NULL,
  `OnCompleteMessage` mediumtext,
  `ShowClearButton` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `DisableSaveSubmissions` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `EnableLiveValidation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HideFieldLabels` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserDefinedForm_Live`
--

LOCK TABLES `UserDefinedForm_Live` WRITE;
/*!40000 ALTER TABLE `UserDefinedForm_Live` DISABLE KEYS */;
INSERT INTO `UserDefinedForm_Live` VALUES (9,NULL,NULL,'<p>Thanks, we\'ve received your submission.</p>',0,0,0,0);
/*!40000 ALTER TABLE `UserDefinedForm_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserDefinedForm_versions`
--

DROP TABLE IF EXISTS `UserDefinedForm_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserDefinedForm_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `SubmitButtonText` varchar(50) DEFAULT NULL,
  `ClearButtonText` varchar(50) DEFAULT NULL,
  `OnCompleteMessage` mediumtext,
  `ShowClearButton` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `DisableSaveSubmissions` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `EnableLiveValidation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `HideFieldLabels` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserDefinedForm_versions`
--

LOCK TABLES `UserDefinedForm_versions` WRITE;
/*!40000 ALTER TABLE `UserDefinedForm_versions` DISABLE KEYS */;
INSERT INTO `UserDefinedForm_versions` VALUES (1,9,1,NULL,NULL,'<p>Thanks, we\'ve received your submission.</p>',0,0,0,0),(2,9,2,NULL,NULL,'<p>Thanks, we\'ve received your submission.</p>',0,0,0,0),(3,9,3,NULL,NULL,'<p>Thanks, we\'ve received your submission.</p>',0,0,0,0),(4,9,4,NULL,NULL,'<p>Thanks, we\'ve received your submission.</p>',0,0,0,0),(5,9,5,NULL,NULL,'<p>Thanks, we\'ve received your submission.</p>',0,0,0,0);
/*!40000 ALTER TABLE `UserDefinedForm_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VirtualPage`
--

DROP TABLE IF EXISTS `VirtualPage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VirtualPage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VersionID` int(11) NOT NULL DEFAULT '0',
  `CopyContentFromID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CopyContentFromID` (`CopyContentFromID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VirtualPage`
--

LOCK TABLES `VirtualPage` WRITE;
/*!40000 ALTER TABLE `VirtualPage` DISABLE KEYS */;
/*!40000 ALTER TABLE `VirtualPage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VirtualPage_Live`
--

DROP TABLE IF EXISTS `VirtualPage_Live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VirtualPage_Live` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VersionID` int(11) NOT NULL DEFAULT '0',
  `CopyContentFromID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CopyContentFromID` (`CopyContentFromID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VirtualPage_Live`
--

LOCK TABLES `VirtualPage_Live` WRITE;
/*!40000 ALTER TABLE `VirtualPage_Live` DISABLE KEYS */;
/*!40000 ALTER TABLE `VirtualPage_Live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VirtualPage_versions`
--

DROP TABLE IF EXISTS `VirtualPage_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VirtualPage_versions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RecordID` int(11) NOT NULL DEFAULT '0',
  `Version` int(11) NOT NULL DEFAULT '0',
  `VersionID` int(11) NOT NULL DEFAULT '0',
  `CopyContentFromID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RecordID_Version` (`RecordID`,`Version`),
  KEY `RecordID` (`RecordID`),
  KEY `Version` (`Version`),
  KEY `CopyContentFromID` (`CopyContentFromID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VirtualPage_versions`
--

LOCK TABLES `VirtualPage_versions` WRITE;
/*!40000 ALTER TABLE `VirtualPage_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `VirtualPage_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Widget`
--

DROP TABLE IF EXISTS `Widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Widget` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('Widget','ArchiveWidget','BlogManagementWidget','RSSWidget','SubscribeRSSWidget','TagCloudWidget','CategoryCloudWidget') DEFAULT 'Widget',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `Sort` int(11) NOT NULL DEFAULT '0',
  `Enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentID` (`ParentID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Widget`
--

LOCK TABLES `Widget` WRITE;
/*!40000 ALTER TABLE `Widget` DISABLE KEYS */;
/*!40000 ALTER TABLE `Widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WidgetArea`
--

DROP TABLE IF EXISTS `WidgetArea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WidgetArea` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` enum('WidgetArea') DEFAULT 'WidgetArea',
  `Created` datetime DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ClassName` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WidgetArea`
--

LOCK TABLES `WidgetArea` WRITE;
/*!40000 ALTER TABLE `WidgetArea` DISABLE KEYS */;
/*!40000 ALTER TABLE `WidgetArea` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-30 17:58:56
