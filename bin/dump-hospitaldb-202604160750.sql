-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: hospitaldb
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `billID` int unsigned NOT NULL AUTO_INCREMENT,
  `patientSSN` char(11) NOT NULL,
  `stayID` int unsigned NOT NULL,
  `insuranceID` varchar(20) DEFAULT NULL,
  `roomCost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `treatmentCost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `insCoverageAmount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `taxAmount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `totalDue` decimal(12,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`billID`),
  KEY `fk_Bill_Patient` (`patientSSN`),
  KEY `fk_Bill_Stay` (`stayID`),
  KEY `fk_Bill_Insurance` (`insuranceID`),
  CONSTRAINT `fk_Bill_Insurance` FOREIGN KEY (`insuranceID`) REFERENCES `insurancepolicy` (`insuranceID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_Bill_Patient` FOREIGN KEY (`patientSSN`) REFERENCES `patient` (`ssn`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_Bill_Stay` FOREIGN KEY (`stayID`) REFERENCES `stay` (`stayID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brandname_`
--

DROP TABLE IF EXISTS `brandname_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brandname_` (
  `brandName` varchar(150) NOT NULL,
  `treatmentID` int unsigned NOT NULL,
  PRIMARY KEY (`treatmentID`),
  CONSTRAINT `brandname__prescription_FK` FOREIGN KEY (`treatmentID`) REFERENCES `prescription` (`treatmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brandname_`
--

LOCK TABLES `brandname_` WRITE;
/*!40000 ALTER TABLE `brandname_` DISABLE KEYS */;
/*!40000 ALTER TABLE `brandname_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condition_`
--

DROP TABLE IF EXISTS `condition_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `condition_` (
  `stayID` int unsigned NOT NULL,
  `condition_` varchar(150) NOT NULL,
  PRIMARY KEY (`stayID`,`condition_`),
  CONSTRAINT `condition__stay_FK` FOREIGN KEY (`stayID`) REFERENCES `stay` (`stayID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condition_`
--

LOCK TABLES `condition_` WRITE;
/*!40000 ALTER TABLE `condition_` DISABLE KEYS */;
/*!40000 ALTER TABLE `condition_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `deptID` int unsigned NOT NULL AUTO_INCREMENT,
  `deptName` varchar(100) NOT NULL,
  `building` varchar(100) NOT NULL,
  PRIMARY KEY (`deptID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floorno_`
--

DROP TABLE IF EXISTS `floorno_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `floorno_` (
  `deptID` int unsigned NOT NULL,
  `floorNo` smallint NOT NULL,
  PRIMARY KEY (`deptID`,`floorNo`),
  CONSTRAINT `fk_Floor_Dept` FOREIGN KEY (`deptID`) REFERENCES `department` (`deptID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floorno_`
--

LOCK TABLES `floorno_` WRITE;
/*!40000 ALTER TABLE `floorno_` DISABLE KEYS */;
/*!40000 ALTER TABLE `floorno_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurancepolicy`
--

DROP TABLE IF EXISTS `insurancepolicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurancepolicy` (
  `insuranceID` varchar(20) NOT NULL,
  `providerName` varchar(100) NOT NULL,
  `coveragePercent` decimal(5,2) NOT NULL,
  `planName` varchar(100) NOT NULL,
  PRIMARY KEY (`insuranceID`),
  CONSTRAINT `insurancepolicy_chk_1` CHECK ((`coveragePercent` between 0.00 and 1.00))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurancepolicy`
--

LOCK TABLES `insurancepolicy` WRITE;
/*!40000 ALTER TABLE `insurancepolicy` DISABLE KEYS */;
INSERT INTO `insurancepolicy` VALUES ('JJO1298D723D','Aetna',0.13,'Bronze Plan');
/*!40000 ALTER TABLE `insurancepolicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `ssn` char(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `age` tinyint unsigned NOT NULL,
  `bioSex` enum('M','F','I') NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `insuranceID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `fk_Patient_Ins` (`insuranceID`),
  CONSTRAINT `fk_Patient_Ins` FOREIGN KEY (`insuranceID`) REFERENCES `insurancepolicy` (`insuranceID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES ('123-09-1929','Jimmy Doe','1948-02-02',78,'M','jimdoe@example.org','123-555-8911','JJO1298D723D');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription` (
  `treatmentID` int unsigned NOT NULL,
  `genericName` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dosage` decimal(8,3) NOT NULL,
  `unit` varchar(30) NOT NULL,
  `frequency` varchar(100) NOT NULL,
  PRIMARY KEY (`treatmentID`),
  KEY `fk_Rx_Medication` (`genericName`),
  CONSTRAINT `prescription_treatment_FK` FOREIGN KEY (`treatmentID`) REFERENCES `treatment` (`treatmentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prescription_chk_1` CHECK ((`dosage` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription`
--

LOCK TABLES `prescription` WRITE;
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `roomID` int unsigned NOT NULL AUTO_INCREMENT,
  `building` varchar(100) NOT NULL,
  `floorNo` smallint NOT NULL,
  `roomNo` varchar(20) NOT NULL,
  `status` enum('Available','Occupied','Maintenance') NOT NULL DEFAULT 'Available',
  `dailyRate` decimal(10,2) NOT NULL,
  `deptID` int unsigned NOT NULL,
  PRIMARY KEY (`roomID`),
  KEY `fk_Room_Dept` (`deptID`),
  CONSTRAINT `fk_Room_Dept` FOREIGN KEY (`deptID`) REFERENCES `department` (`deptID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `room_chk_1` CHECK ((`dailyRate` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `empID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `deptID` int unsigned NOT NULL,
  PRIMARY KEY (`empID`),
  KEY `fk_Staff_Dept` (`deptID`),
  CONSTRAINT `fk_Staff_Dept` FOREIGN KEY (`deptID`) REFERENCES `department` (`deptID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stay`
--

DROP TABLE IF EXISTS `stay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stay` (
  `stayID` int unsigned NOT NULL AUTO_INCREMENT,
  `patientSSN` char(11) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `length` smallint unsigned DEFAULT NULL,
  `roomUsed` int unsigned NOT NULL,
  `careProvider` int unsigned NOT NULL,
  PRIMARY KEY (`stayID`),
  KEY `fk_Stay_Patient` (`patientSSN`),
  KEY `fk_Stay_Room` (`roomUsed`),
  KEY `fk_Stay_Staff` (`careProvider`),
  CONSTRAINT `fk_Stay_Patient` FOREIGN KEY (`patientSSN`) REFERENCES `patient` (`ssn`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_Stay_Room` FOREIGN KEY (`roomUsed`) REFERENCES `room` (`roomID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_Stay_Staff` FOREIGN KEY (`careProvider`) REFERENCES `staff` (`empID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `stay_chk_1` CHECK ((`length` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stay`
--

LOCK TABLES `stay` WRITE;
/*!40000 ALTER TABLE `stay` DISABLE KEYS */;
/*!40000 ALTER TABLE `stay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staytreatment`
--

DROP TABLE IF EXISTS `staytreatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staytreatment` (
  `stayID` int unsigned NOT NULL,
  `treatmentID` int unsigned NOT NULL,
  PRIMARY KEY (`stayID`,`treatmentID`),
  KEY `fk_StayTx_Treatment` (`treatmentID`),
  CONSTRAINT `fk_StayTx_Stay` FOREIGN KEY (`stayID`) REFERENCES `stay` (`stayID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_StayTx_Treatment` FOREIGN KEY (`treatmentID`) REFERENCES `treatment` (`treatmentID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staytreatment`
--

LOCK TABLES `staytreatment` WRITE;
/*!40000 ALTER TABLE `staytreatment` DISABLE KEYS */;
/*!40000 ALTER TABLE `staytreatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surgery`
--

DROP TABLE IF EXISTS `surgery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surgery` (
  `treatmentID` int unsigned NOT NULL,
  `bodyLocation` varchar(150) NOT NULL,
  `surgeon` int unsigned NOT NULL,
  PRIMARY KEY (`treatmentID`),
  KEY `surgery_staff_FK` (`surgeon`),
  CONSTRAINT `fk_Surgery_Treat` FOREIGN KEY (`treatmentID`) REFERENCES `treatment` (`treatmentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `surgery_staff_FK` FOREIGN KEY (`surgeon`) REFERENCES `staff` (`empID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surgery`
--

LOCK TABLES `surgery` WRITE;
/*!40000 ALTER TABLE `surgery` DISABLE KEYS */;
/*!40000 ALTER TABLE `surgery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `treatmentID` int unsigned NOT NULL,
  `type` varchar(100) NOT NULL,
  `analyte` varchar(150) DEFAULT NULL,
  `testName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`treatmentID`),
  CONSTRAINT `fk_Test_Treat` FOREIGN KEY (`treatmentID`) REFERENCES `treatment` (`treatmentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testresult`
--

DROP TABLE IF EXISTS `testresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testresult` (
  `patientSSN` char(11) NOT NULL,
  `date_` date NOT NULL,
  `treatmentID` int unsigned NOT NULL,
  `result` text NOT NULL,
  `orderedByDoctor` int unsigned NOT NULL,
  PRIMARY KEY (`patientSSN`,`date_`),
  KEY `fk_TR_Treatment` (`treatmentID`),
  KEY `testresult_staff_FK` (`orderedByDoctor`),
  CONSTRAINT `fk_TR_Patient` FOREIGN KEY (`patientSSN`) REFERENCES `patient` (`ssn`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_TR_Treatment` FOREIGN KEY (`treatmentID`) REFERENCES `treatment` (`treatmentID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `testresult_staff_FK` FOREIGN KEY (`orderedByDoctor`) REFERENCES `staff` (`empID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testresult`
--

LOCK TABLES `testresult` WRITE;
/*!40000 ALTER TABLE `testresult` DISABLE KEYS */;
/*!40000 ALTER TABLE `testresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treatment` (
  `treatmentID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text,
  `baseCost` decimal(10,2) NOT NULL,
  PRIMARY KEY (`treatmentID`),
  CONSTRAINT `treatment_chk_1` CHECK ((`baseCost` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment`
--

LOCK TABLES `treatment` WRITE;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hospitaldb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-16  7:50:34
