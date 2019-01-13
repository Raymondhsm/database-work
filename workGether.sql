-- MySQL dump 10.13  Distrib 5.7.21, for Win64 (x86_64)
--
-- Host: localhost    Database: workGether
-- ------------------------------------------------------
-- Server version	5.7.21-log

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
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `deptID` int(11) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(50) NOT NULL,
  `deptNumberOfStaff` int(11) DEFAULT NULL,
  `deptIntroduction` varchar(200) NOT NULL,
  `workdayID` int(11) NOT NULL,
  `managerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`deptID`),
  KEY `fk_Department_Workday1_idx` (`workdayID`),
  CONSTRAINT `fk_Department_Workday1` FOREIGN KEY (`workdayID`) REFERENCES `workday` (`workdayID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'公共关系部',20,'人长得很漂亮',2,NULL);
INSERT INTO `department` VALUES (2,'开发研究部',50,'人天天打代码',1,NULL);
INSERT INTO `department` VALUES (3,'董事委员会',10,'人长得很呵呵',0,NULL);
INSERT INTO `department` VALUES (4,'维修部',NULL,'就专门修东西',2,3);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logged`
--

DROP TABLE IF EXISTS `logged`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logged` (
  `loggedID` int(11) NOT NULL AUTO_INCREMENT,
  `workload` varchar(200) NOT NULL,
  `rateOfProcess` int(11) NOT NULL,
  `staffID` int(11) NOT NULL,
  `loggedRemark` varchar(200) DEFAULT '暂无备注',
  `taskID` int(11) NOT NULL,
  `needTime` date NOT NULL,
  `writeTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(200) DEFAULT '暂无评语',
  `result` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`loggedID`),
  KEY `fk_Logged_Task1_idx` (`taskID`),
  KEY `loggedTime_index` (`writeTime`),
  CONSTRAINT `fk_Logged_Task1` FOREIGN KEY (`taskID`) REFERENCES `task` (`taskID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logged`
--

LOCK TABLES `logged` WRITE;
/*!40000 ALTER TABLE `logged` DISABLE KEYS */;
INSERT INTO `logged` VALUES (1,'one',75,1,'hdsjfh',1,'2018-08-29','2018-08-23 17:16:42','onetoone',1);
INSERT INTO `logged` VALUES (3,'three',75,3,'hdsjfh',3,'2018-08-29','2018-08-23 16:44:28','onetoone',1);
INSERT INTO `logged` VALUES (7,'一般',89,2,'暂无备注',1,'2018-08-26','2018-08-26 14:51:26',NULL,1);
INSERT INTO `logged` VALUES (8,'123',12,1,'暂无备注',1,'2018-08-27','2018-08-27 09:00:12',NULL,2);
INSERT INTO `logged` VALUES (14,'不多',45,4,'暂无备注',22,'2018-08-31','2018-08-30 16:28:38','暂无评语',1);
/*!40000 ALTER TABLE `logged` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logininfo`
--

DROP TABLE IF EXISTS `logininfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logininfo` (
  `account` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `skey` varchar(40) DEFAULT NULL,
  `skeyTime` datetime DEFAULT NULL,
  `staffID` int(11) NOT NULL,
  PRIMARY KEY (`account`),
  KEY `fk_LoginInfo_Staff_idx` (`staffID`),
  CONSTRAINT `fk_LoginInfo_Staff` FOREIGN KEY (`staffID`) REFERENCES `staff` (`staffID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logininfo`
--

LOCK TABLES `logininfo` WRITE;
/*!40000 ALTER TABLE `logininfo` DISABLE KEYS */;
INSERT INTO `logininfo` VALUES ('guanliyuan','guanliyuan','fdb219ed52b249e8be95b9b0cdbbb81b','2018-08-29 16:35:11',1);
INSERT INTO `logininfo` VALUES ('jingli','jingli','c2fedefba98c42d5aa0ec5581ee56c62','2018-08-29 16:35:52',3);
INSERT INTO `logininfo` VALUES ('laoban','laoban','8ee0f08b0de14c98a447fb62ddbd6371','2018-08-31 18:45:29',2);
INSERT INTO `logininfo` VALUES ('yuangong','yuangong','6c5f8b63071741649d4a3600d8440387','2018-08-31 00:27:50',4);
/*!40000 ALTER TABLE `logininfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `needlogged`
--

DROP TABLE IF EXISTS `needlogged`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `needlogged` (
  `needLoggedID` int(11) NOT NULL AUTO_INCREMENT,
  `taskID` int(11) NOT NULL,
  `pushTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pushRemark` varchar(200) DEFAULT NULL,
  `staffWhoPushID` int(11) NOT NULL,
  `deptWhoseAcceptID` int(11) NOT NULL,
  PRIMARY KEY (`needLoggedID`),
  KEY `fk_NeedLogged_Staff1_idx` (`staffWhoPushID`),
  KEY `fk_NeedLogged_Department1_idx` (`deptWhoseAcceptID`),
  CONSTRAINT `fk_NeedLogged_Department1` FOREIGN KEY (`deptWhoseAcceptID`) REFERENCES `department` (`deptID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_NeedLogged_Staff1` FOREIGN KEY (`staffWhoPushID`) REFERENCES `staff` (`staffID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `needlogged`
--

LOCK TABLES `needlogged` WRITE;
/*!40000 ALTER TABLE `needlogged` DISABLE KEYS */;
INSERT INTO `needlogged` VALUES (3,2,'2018-08-26 09:51:42',NULL,2,1);
INSERT INTO `needlogged` VALUES (4,2,'2018-08-26 09:55:16',NULL,2,3);
INSERT INTO `needlogged` VALUES (5,3,'2018-08-26 10:00:12',NULL,2,1);
INSERT INTO `needlogged` VALUES (6,3,'2018-08-26 10:00:56',NULL,2,2);
INSERT INTO `needlogged` VALUES (7,18,'2018-08-26 14:58:29',NULL,2,1);
INSERT INTO `needlogged` VALUES (8,3,'2018-08-29 08:52:05',NULL,2,2);
INSERT INTO `needlogged` VALUES (9,22,'2018-08-29 08:52:10',NULL,2,4);
INSERT INTO `needlogged` VALUES (10,1,'2018-08-29 09:03:46',NULL,2,2);
INSERT INTO `needlogged` VALUES (11,1,'2018-08-29 09:03:47',NULL,2,3);
INSERT INTO `needlogged` VALUES (12,22,'2018-08-29 09:03:49',NULL,2,1);
INSERT INTO `needlogged` VALUES (13,22,'2018-08-29 09:03:49',NULL,2,2);
INSERT INTO `needlogged` VALUES (22,22,'2018-08-30 16:06:27',NULL,2,1);
INSERT INTO `needlogged` VALUES (23,26,'2018-08-30 16:20:52',NULL,2,1);
INSERT INTO `needlogged` VALUES (24,1,'2018-08-30 16:29:37',NULL,2,2);
INSERT INTO `needlogged` VALUES (25,1,'2018-08-30 16:29:37',NULL,2,3);
INSERT INTO `needlogged` VALUES (26,22,'2018-08-30 16:29:38',NULL,2,2);
INSERT INTO `needlogged` VALUES (27,22,'2018-08-30 16:29:38',NULL,2,4);
INSERT INTO `needlogged` VALUES (28,26,'2018-08-30 16:29:39',NULL,2,4);
/*!40000 ALTER TABLE `needlogged` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `staffID` int(11) NOT NULL AUTO_INCREMENT,
  `staffName` varchar(20) NOT NULL,
  `staffSex` tinyint(4) NOT NULL,
  `staffBorn` date DEFAULT NULL,
  `staffPost` varchar(20) NOT NULL,
  `staffDateHired` date DEFAULT NULL,
  `staffPhoneNumber` varchar(20) DEFAULT NULL,
  `staffEmail` varchar(50) DEFAULT NULL,
  `staffAddress` varchar(50) DEFAULT NULL,
  `staffRemark` varchar(200) DEFAULT NULL,
  `deptID` int(11) NOT NULL,
  `userLevelID` int(11) NOT NULL,
  PRIMARY KEY (`staffID`),
  KEY `fk_Staff_Department1_idx` (`deptID`),
  KEY `fk_Staff_UserLevel1_idx` (`userLevelID`),
  CONSTRAINT `fk_Staff_Department1` FOREIGN KEY (`deptID`) REFERENCES `department` (`deptID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Staff_UserLevel1` FOREIGN KEY (`userLevelID`) REFERENCES `userlevel` (`userLevelID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'黄一',1,'1998-06-07','系统管理员','2018-08-08',NULL,NULL,NULL,NULL,4,1);
INSERT INTO `staff` VALUES (2,'梁二',1,'1995-07-06','老板','2018-08-08',NULL,NULL,NULL,NULL,3,2);
INSERT INTO `staff` VALUES (3,'张三',0,'1997-09-05','经理','2018-08-08',NULL,NULL,NULL,NULL,2,3);
INSERT INTO `staff` VALUES (4,'李四',0,'1998-09-07','员工','2018-08-08',NULL,NULL,NULL,NULL,1,4);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskID` int(11) NOT NULL AUTO_INCREMENT,
  `taskName` varchar(45) NOT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endTime` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `taskRemark` varchar(200) DEFAULT NULL,
  `taskLevelID` int(11) NOT NULL,
  `taskTypeID` int(11) NOT NULL,
  `taskSourceID` int(11) NOT NULL,
  `createStaffID` int(11) DEFAULT NULL,
  PRIMARY KEY (`taskID`),
  KEY `fk_Task_TaskLevel1_idx` (`taskLevelID`),
  KEY `fk_Task_TaskType1_idx` (`taskTypeID`),
  KEY `fk_Task_TaskSource1_idx` (`taskSourceID`),
  CONSTRAINT `fk_Task_TaskLevel1` FOREIGN KEY (`taskLevelID`) REFERENCES `tasklevel` (`taskLevelID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_TaskSource1` FOREIGN KEY (`taskSourceID`) REFERENCES `tasksource` (`taskSourceID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_TaskType1` FOREIGN KEY (`taskTypeID`) REFERENCES `tasktype` (`taskTypeID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'系统UI设计','2018-08-18 11:32:29','2018-09-01 00:00:00',1,'wu',1,1,1,1);
INSERT INTO `task` VALUES (3,'系统测试','2018-08-18 11:32:48','2018-08-30 00:00:00',1,'wu',3,3,3,3);
INSERT INTO `task` VALUES (22,'系统数据库测试','2018-08-29 06:10:36','2019-02-28 00:00:00',1,'',1,1,1,2);
INSERT INTO `task` VALUES (26,'系统实现','2018-08-30 16:08:03','2018-10-26 00:00:00',1,'无',1,1,1,2);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskassign`
--

DROP TABLE IF EXISTS `taskassign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taskassign` (
  `taskID` int(11) NOT NULL,
  `deptID` int(11) NOT NULL,
  PRIMARY KEY (`taskID`,`deptID`),
  KEY `fk_Task_has_Department_Department1_idx` (`deptID`),
  KEY `fk_Task_has_Department_Task1_idx` (`taskID`),
  CONSTRAINT `fk_Task_has_Department_Department1` FOREIGN KEY (`deptID`) REFERENCES `department` (`deptID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_has_Department_Task1` FOREIGN KEY (`taskID`) REFERENCES `task` (`taskID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskassign`
--

LOCK TABLES `taskassign` WRITE;
/*!40000 ALTER TABLE `taskassign` DISABLE KEYS */;
INSERT INTO `taskassign` VALUES (3,1);
INSERT INTO `taskassign` VALUES (22,1);
INSERT INTO `taskassign` VALUES (26,1);
INSERT INTO `taskassign` VALUES (1,2);
INSERT INTO `taskassign` VALUES (3,2);
INSERT INTO `taskassign` VALUES (22,2);
INSERT INTO `taskassign` VALUES (1,3);
INSERT INTO `taskassign` VALUES (22,4);
INSERT INTO `taskassign` VALUES (26,4);
/*!40000 ALTER TABLE `taskassign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskfollow`
--

DROP TABLE IF EXISTS `taskfollow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taskfollow` (
  `staffID` int(11) NOT NULL,
  `taskID` int(11) NOT NULL,
  PRIMARY KEY (`staffID`,`taskID`),
  KEY `fk_Staff_has_Task_Staff1_idx` (`staffID`),
  KEY `fk_Staff_has_Task_Task1` (`taskID`),
  CONSTRAINT `fk_Staff_has_Task_Staff1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`staffID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Staff_has_Task_Task1` FOREIGN KEY (`taskID`) REFERENCES `task` (`taskID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskfollow`
--

LOCK TABLES `taskfollow` WRITE;
/*!40000 ALTER TABLE `taskfollow` DISABLE KEYS */;
INSERT INTO `taskfollow` VALUES (1,1);
INSERT INTO `taskfollow` VALUES (2,1);
INSERT INTO `taskfollow` VALUES (2,22);
INSERT INTO `taskfollow` VALUES (3,3);
INSERT INTO `taskfollow` VALUES (4,3);
INSERT INTO `taskfollow` VALUES (4,22);
/*!40000 ALTER TABLE `taskfollow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasklevel`
--

DROP TABLE IF EXISTS `tasklevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasklevel` (
  `taskLevelID` int(11) NOT NULL AUTO_INCREMENT,
  `taskLevelName` varchar(45) NOT NULL,
  `taskLevel` int(11) NOT NULL,
  PRIMARY KEY (`taskLevelID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasklevel`
--

LOCK TABLES `tasklevel` WRITE;
/*!40000 ALTER TABLE `tasklevel` DISABLE KEYS */;
INSERT INTO `tasklevel` VALUES (1,'绝密',1);
INSERT INTO `tasklevel` VALUES (2,'机密',2);
INSERT INTO `tasklevel` VALUES (3,'保密',3);
/*!40000 ALTER TABLE `tasklevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasksource`
--

DROP TABLE IF EXISTS `tasksource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasksource` (
  `taskSourceID` int(11) NOT NULL AUTO_INCREMENT,
  `TaskSourceName` varchar(45) NOT NULL,
  PRIMARY KEY (`taskSourceID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasksource`
--

LOCK TABLES `tasksource` WRITE;
/*!40000 ALTER TABLE `tasksource` DISABLE KEYS */;
INSERT INTO `tasksource` VALUES (1,'董事');
INSERT INTO `tasksource` VALUES (2,'总裁');
INSERT INTO `tasksource` VALUES (3,'经理');
/*!40000 ALTER TABLE `tasksource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasktype`
--

DROP TABLE IF EXISTS `tasktype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasktype` (
  `taskTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `taskTypeName` varchar(45) NOT NULL,
  PRIMARY KEY (`taskTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasktype`
--

LOCK TABLES `tasktype` WRITE;
/*!40000 ALTER TABLE `tasktype` DISABLE KEYS */;
INSERT INTO `tasktype` VALUES (1,'设计');
INSERT INTO `tasktype` VALUES (2,'开发');
INSERT INTO `tasktype` VALUES (3,'外出');
/*!40000 ALTER TABLE `tasktype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userlevel`
--

DROP TABLE IF EXISTS `userlevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userlevel` (
  `userLevelID` int(11) NOT NULL AUTO_INCREMENT,
  `userLevelName` varchar(45) NOT NULL,
  `jichushezhi` tinyint(4) NOT NULL,
  `shixiangguanli` tinyint(4) NOT NULL,
  `renwuchuangjian` tinyint(4) NOT NULL,
  `renwugengzong` tinyint(4) NOT NULL,
  `rizhitianxie` tinyint(4) NOT NULL,
  `rizhishenhe` tinyint(4) NOT NULL,
  PRIMARY KEY (`userLevelID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlevel`
--

LOCK TABLES `userlevel` WRITE;
/*!40000 ALTER TABLE `userlevel` DISABLE KEYS */;
INSERT INTO `userlevel` VALUES (1,'系统管理员',1,0,0,0,0,0);
INSERT INTO `userlevel` VALUES (2,'老板',1,1,1,1,1,1);
INSERT INTO `userlevel` VALUES (3,'经理',0,0,1,1,1,1);
INSERT INTO `userlevel` VALUES (4,'员工',0,0,0,1,1,0);
/*!40000 ALTER TABLE `userlevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workday`
--

DROP TABLE IF EXISTS `workday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workday` (
  `workdayID` int(11) NOT NULL AUTO_INCREMENT,
  `workdayName` varchar(45) NOT NULL,
  `mondayMorning` tinyint(4) DEFAULT NULL,
  `mondayAfternoon` tinyint(4) DEFAULT NULL,
  `mondayEvening` tinyint(4) DEFAULT NULL,
  `tuesdayMorning` tinyint(4) DEFAULT NULL,
  `tuesdayAfternoon` tinyint(4) DEFAULT NULL,
  `tuesdayEvening` tinyint(4) DEFAULT NULL,
  `wendesdayMorning` tinyint(4) DEFAULT NULL,
  `wendesdayAfternoon` tinyint(4) DEFAULT NULL,
  `wendesdayEvening` tinyint(4) DEFAULT NULL,
  `thursdayMorning` tinyint(4) DEFAULT NULL,
  `thursdayAfternoon` tinyint(4) DEFAULT NULL,
  `thursdayEvening` tinyint(4) DEFAULT NULL,
  `fridayMorning` tinyint(4) DEFAULT NULL,
  `fridayAfternoon` tinyint(4) DEFAULT NULL,
  `fridayEvening` tinyint(4) DEFAULT NULL,
  `saturdayMorning` tinyint(4) DEFAULT NULL,
  `saturdayAftrnoon` tinyint(4) DEFAULT NULL,
  `saturdayEvening` tinyint(4) DEFAULT NULL,
  `sundayMorning` tinyint(4) DEFAULT NULL,
  `sundayAfternoon` tinyint(4) DEFAULT NULL,
  `sundayEvening` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`workdayID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workday`
--

LOCK TABLES `workday` WRITE;
/*!40000 ALTER TABLE `workday` DISABLE KEYS */;
INSERT INTO `workday` VALUES (0,'周一到周五',1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,0,0,0,0,0,0);
INSERT INTO `workday` VALUES (1,'整天都要',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
INSERT INTO `workday` VALUES (2,'晚上不用',1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0);
/*!40000 ALTER TABLE `workday` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-31 20:03:57
