-- MySQL dump 10.13  Distrib 5.7.17, for solaris11 (x86_64)
--
-- Host: localhost    Database: dumplings
-- ------------------------------------------------------
-- Server version	5.7.17

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
-- Table structure for table `account_user`
--

DROP TABLE IF EXISTS `account_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_user` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(70) NOT NULL,
  `password` varchar(70) NOT NULL,
  `verified` tinyint(7) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_user`
--

LOCK TABLES `account_user` WRITE;
/*!40000 ALTER TABLE `account_user` DISABLE KEYS */;
INSERT INTO `account_user` VALUES (1,'752048018@qq.com','202cb962ac59075b964b07152d234b70',1,'2019-07-04 00:00:00'),(4,'email@braewebb.com','482c811da5d5b4bc6d497ffa98491e38',0,'2019-07-05 02:31:48'),(5,'test@braewebb.com','bdc87b9c894da5168059e00ebffb9077',0,'2019-07-08 07:49:34'),(6,'anothertest@braewebb.com','bdc87b9c894da5168059e00ebffb9077',0,'2019-07-08 07:51:26'),(7,'anothertest@braewebb.com','bdc87b9c894da5168059e00ebffb9077',0,'2019-07-08 07:51:26'),(8,'anothertest2@braewebb.com','bdc87b9c894da5168059e00ebffb9077',0,'2019-07-08 07:52:08'),(9,'help@braewebb.com','81dc9bdb52d04dc20036dbd8313ed055',0,'2019-07-08 07:55:29'),(10,'help2@braewebb.com','81dc9bdb52d04dc20036dbd8313ed055',0,'2019-07-08 07:56:06'),(11,'help3@braewebb.com','81dc9bdb52d04dc20036dbd8313ed055',0,'2019-07-08 07:56:51'),(12,'help@email.com','531e70a6745d07a8befbd79e5cc7e4c1',0,'2019-07-08 08:06:53'),(13,'help2@email.com','531e70a6745d07a8befbd79e5cc7e4c1',0,'2019-07-08 08:07:48'),(14,'help3@email.com','531e70a6745d07a8befbd79e5cc7e4c1',0,'2019-07-08 08:08:28'),(15,'email@doitwork.com','657f8b8da628ef83cf69101b6817150a',0,'2019-07-08 08:09:38'),(16,'','d41d8cd98f00b204e9800998ecf8427e',0,'2019-07-10 01:16:07'),(17,'email@kodi.com','fc5e038d38a57032085441e7fe7010b0',0,'2019-07-10 03:20:24');
/*!40000 ALTER TABLE `account_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(70) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `picture_id` int(11) NOT NULL,
  PRIMARY KEY (`activity_id`),
  KEY `activities_ibfk_1` (`picture_id`),
  CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`picture_id`) REFERENCES `pictures` (`picture_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` VALUES (2,'basketball','2019-07-04 00:00:00',1);
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) NOT NULL,
  `initiator_id` int(11) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `activity_name` varchar(70) NOT NULL,
  `name` varchar(70) NOT NULL,
  `location` varchar(70) NOT NULL,
  `description` varchar(70) NOT NULL,
  `start_time` datetime NOT NULL,
  `finish_time` datetime NOT NULL,
  `rsvp_time` datetime NOT NULL,
  `picture_id` int(11) NOT NULL,
  `price` int(70) NOT NULL,
  `minimum_participants_number` int(70) NOT NULL,
  `maximum_participants_number` int(70) NOT NULL,
  `minimum_age` int(70) NOT NULL,
  `maximum_age` int(70) NOT NULL,
  `verified` tinyint(7) NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `activity_id` (`activity_id`),
  KEY `events_ibfk_1` (`initiator_id`),
  KEY `picture_id` (`picture_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`initiator_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`picture_id`) REFERENCES `pictures` (`picture_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` (`event_id`, `activity_id`, `initiator_id`, `creation_time`, `activity_name`, `name`, `location`, `description`, `start_time`, `finish_time`, `rsvp_time`, `picture_id`, `price`, `minimum_participants_number`, `maximum_participants_number`, `minimum_age`, `maximum_age`, `verified`) VALUES
(1, 2, 1, '2019-07-05 00:00:00', 'Play sport', 'Basketball with ELIZA', 'square near DNUI', 'Everybody should go to play basketball. I love you all, guys!','2019-07-05 00:00:00', '2019-07-12 00:00:00', '2019-07-11 00:00:00', 1, 123, 10, 20, 14, 18, 1);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logins`
--

DROP TABLE IF EXISTS `logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logins` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`login_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `logins_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logins`
--

LOCK TABLES `logins` WRITE;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` VALUES (1,1,'2019-07-05 00:00:00');
/*!40000 ALTER TABLE `logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participations`
--

DROP TABLE IF EXISTS `participations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participations` (
  `participation_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `role` varchar(70) NOT NULL,
  `account_id` int(11) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`participation_id`),
  KEY `account_id` (`account_id`),
  KEY `activity_id` (`activity_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `participations_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `participations_ibfk_2` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`activity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `participations_ibfk_3` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participations`
--

LOCK TABLES `participations` WRITE;
/*!40000 ALTER TABLE `participations` DISABLE KEYS */;
INSERT INTO `participations` VALUES (1,1,2,'organized',1,'2019-07-05 00:00:00'),(2,1,2,'approved',4,'2019-07-05 00:00:00'),(3,1,2,'pending',5,'2019-07-05 00:00:00');
/*!40000 ALTER TABLE `participations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pictures`
--

DROP TABLE IF EXISTS `pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pictures` (
  `picture_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(200) NOT NULL,
  PRIMARY KEY (`picture_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pictures`
--

LOCK TABLES `pictures` WRITE;
/*!40000 ALTER TABLE `pictures` DISABLE KEYS */;
INSERT INTO `pictures` VALUES (1,'1.jpg'),(4,'4.jpg'),(5,'5.jpg');
/*!40000 ALTER TABLE `pictures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_user`
--

DROP TABLE IF EXISTS `profile_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `given_name` varchar(70) NOT NULL,
  `family_name` varchar(70) NOT NULL,
  `country` varchar(70) NOT NULL,
  `city` varchar(70) NOT NULL,
  `birthday` datetime NOT NULL,
  `sex` varchar(10) NOT NULL,
  `picture_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `profile_user_ibfk_1` (`account_id`),
  KEY `picture_id` (`picture_id`),
  CONSTRAINT `profile_user_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `profile_user_ibfk_2` FOREIGN KEY (`picture_id`) REFERENCES `pictures` (`picture_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_user`
--

LOCK TABLES `profile_user` WRITE;
/*!40000 ALTER TABLE `profile_user` DISABLE KEYS */;
INSERT INTO `profile_user` VALUES (1,1,'Mike','Brown','China','Dalian','2019-07-02 00:00:00','man',1),(4,4,'Brae','Webb','Australia','Brisbane','1998-05-24 00:00:00','M',4),(5,5,'Leon','Karstens','Australia','Brown Snake','1998-05-24 00:00:00','M',5);
/*!40000 ALTER TABLE `profile_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quality_user`
--

DROP TABLE IF EXISTS `quality_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quality_user` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `rating` int(70) NOT NULL,
  `count_visited_events` int(70) NOT NULL,
  `last_modified` datetime NOT NULL,
  PRIMARY KEY (`rating_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `quality_user_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quality_user`
--

LOCK TABLES `quality_user` WRITE;
/*!40000 ALTER TABLE `quality_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `quality_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating_events`
--

DROP TABLE IF EXISTS `rating_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_events` (
  `rating_event_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `rate` int(70) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `event_id` int(11) NOT NULL,
  PRIMARY KEY (`rating_event_id`),
  KEY `account_id` (`account_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `rating_events_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `rating_events_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating_events`
--

LOCK TABLES `rating_events` WRITE;
/*!40000 ALTER TABLE `rating_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating_user`
--

DROP TABLE IF EXISTS `rating_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_user` (
  `rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `rater_account_id` int(11) NOT NULL,
  `ratee_account_id` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  PRIMARY KEY (`rate_id`),
  KEY `rater_account_id` (`rater_account_id`),
  KEY `rating_user_ibfk_2` (`ratee_account_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `rating_user_ibfk_1` FOREIGN KEY (`rater_account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `rating_user_ibfk_2` FOREIGN KEY (`ratee_account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `rating_user_ibfk_3` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating_user`
--

LOCK TABLES `rating_user` WRITE;
/*!40000 ALTER TABLE `rating_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-11  1:12:21
