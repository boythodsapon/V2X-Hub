-- MariaDB dump 10.17  Distrib 10.4.12-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: IVP
-- ------------------------------------------------------
-- Server version	10.4.12-MariaDB-1:10.4.12+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `IVP`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `IVP` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `IVP`;

--
-- Table structure for table `eventLog`
--

DROP TABLE IF EXISTS `eventLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventLog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `description` text NOT NULL COMMENT 'The log message content',
  `source` text NOT NULL COMMENT 'The name of the plugin or other agent that logged the event',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'The date and time of the event in UTC',
  `logLevel` enum('Debug','Info','Warning','Error','Fatal') NOT NULL COMMENT 'The type of event being logged, one of   	- Debug 	- Info 	- Warn 	- Error',
  `uploaded` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1189 DEFAULT CHARSET=latin1 COMMENT='This table records events generated by every IVP core component and plugin in the IVP platform.  ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventLog`
--

LOCK TABLES `eventLog` WRITE;
/*!40000 ALTER TABLE `eventLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `installedPlugin`
--

DROP TABLE IF EXISTS `installedPlugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `installedPlugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pluginId` int(10) unsigned NOT NULL,
  `path` text NOT NULL,
  `exeName` text NOT NULL,
  `manifestName` text NOT NULL,
  `commandLineParameters` text NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `maxMessageInterval` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pluginId` (`pluginId`),
  CONSTRAINT `installedPlugin_ibfk_2` FOREIGN KEY (`pluginId`) REFERENCES `plugin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `installedPlugin`
--

LOCK TABLES `installedPlugin` WRITE;
/*!40000 ALTER TABLE `installedPlugin` DISABLE KEYS */;
INSERT INTO `installedPlugin` VALUES (3,435,'/var/www/plugins/CommandPlugin','/bin/CommandPlugin','manifest.json','',0,500000),(4,436,'/var/www/plugins/CswPlugin','/bin/CswPlugin','manifest.json','',0,500000),(5,437,'/var/www/plugins/DmsPlugin','/bin/DmsPlugin','manifest.json','',0,500000),(6,438,'/var/www/plugins/DsrcImmediateForwardPlugin','/bin/DsrcImmediateForwardPlugin','manifest.json','',0,500000),(7,439,'/var/www/plugins/LocationPlugin','/bin/LocationPlugin','manifest.json','',0,500000),(8,440,'/var/www/plugins/MapPlugin','/bin/MapPlugin','manifest.json','',0,500000),(9,441,'/var/www/plugins/MessageReceiverPlugin','/bin/MessageReceiverPlugin','manifest.json','',0,500000),(10,442,'/var/www/plugins/ODEPlugin','/bin/ODEPlugin','manifest.json','',0,500000),(11,443,'/var/www/plugins/RtcmPlugin','/bin/RtcmPlugin','manifest.json','',0,500000),(12,444,'/var/www/plugins/SpatPlugin','/bin/SpatPlugin','manifest.json','',0,500000),(13,445,'/var/www/plugins/PreemptionPlugin','/bin/PreemptionPlugin','manifest.json','',0,500000),(14,446,'/var/www/plugins/SPaTLoggerPlugin','/bin/SPaTLoggerPlugin','manifest.json','',0,500000),(15,447,'/var/www/plugins/BsmLoggerPlugin','/bin/BsmLoggerPlugin','manifest.json','',0,500000),(16,448,'/var/www/plugins/PedestrianPlugin','/bin/PedestrianPlugin','manifest.json','',0,500000),(17,449,'/var/www/plugins/TimPlugin','/bin/TimPlugin','manifest.json','',0,500000);
/*!40000 ALTER TABLE `installedPlugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messageActivity`
--

DROP TABLE IF EXISTS `messageActivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messageActivity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `messageTypeId` int(10) unsigned NOT NULL COMMENT 'Foreign key into the messageType table',
  `pluginId` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL,
  `lastReceivedTimestamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'The date and time of the most recent message of a type in UTC.',
  `averageInterval` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `messageTypeId_pluginId` (`messageTypeId`,`pluginId`),
  KEY `messageTypeId` (`messageTypeId`),
  KEY `pluginId` (`pluginId`),
  CONSTRAINT `messageActivity_ibfk_1` FOREIGN KEY (`messageTypeId`) REFERENCES `messageType` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messageActivity_ibfk_2` FOREIGN KEY (`pluginId`) REFERENCES `plugin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31397 DEFAULT CHARSET=latin1 COMMENT='This table records the most recent message activity of each active plugin in the IVP system. The data in this table is updated by the IVP plugin monitor core component for every message the plugin monitor receives.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messageActivity`
--

LOCK TABLES `messageActivity` WRITE;
/*!40000 ALTER TABLE `messageActivity` DISABLE KEYS */;
/*!40000 ALTER TABLE `messageActivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messageType`
--

DROP TABLE IF EXISTS `messageType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messageType` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `type` varchar(50) NOT NULL COMMENT 'A unique message type name',
  `subtype` varchar(50) NOT NULL,
  `description` text DEFAULT NULL COMMENT 'A description of the message type',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`subtype`)
) ENGINE=InnoDB AUTO_INCREMENT=695 DEFAULT CHARSET=latin1 COMMENT='This table lists the valid message types of every plugin loaded on the IVP platform.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messageType`
--

LOCK TABLES `messageType` WRITE;
/*!40000 ALTER TABLE `messageType` DISABLE KEYS */;
/*!40000 ALTER TABLE `messageType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `name` varchar(100) NOT NULL COMMENT 'A unique plugin name',
  `description` text DEFAULT NULL,
  `version` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=450 DEFAULT CHARSET=latin1 COMMENT='This table lists the plugins loaded and available to run on the IVP platform.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
INSERT INTO `plugin` VALUES (435,'CommandPlugin','Listens for websocket connections from the TMX admin portal and processes commands','5.0'),(436,'CSW','Provides Curve Speed Warning (CSW).','5.0'),(437,'DynamicMessageSign','Provides communication to a dynamic message sign.','5.0'),(438,'DSRCMessageManager','Plugin that listens for TMX messages and forwards them to the DSRC Radio (i.e. the RSU).','5.0'),(439,'Location','Plugin used to send out Location Messages using data from GPSD','5.0'),(440,'MAP','Plugin that reads intersection geometry from a configuration file and publishes a J2735 MAP message.','5.0'),(441,'MessageReceiver','Plugin to receive messages from an external DSRC radio or other source','5.0'),(442,'ODEPlugin','Plugin to forward messages to the Florida ODEPlugin network','5.0'),(443,'RTCM','Plugin to listen for RTCM messages from an NTRIP caster and route those messages over DSRC','5.0'),(444,'SPAT','Plugin that reads PTLM data from a configuration file, receives live data from the signal controller, and publishes a J2735 SPAT message.','5.0'),(445,'Preemption','Preemption plugin for the IVP system.','5.0'),(446,'SPaTLoggerPlugin','Listens for SPaT messages and logs them in a file in CSV format.','5.0'),(447,'BsmLoggerPlugin','Listens for BSM messages and logs them in a file in CSV format.','5.0'),(448,'Pedestrian','Pedestrian plugin for the IVP system.','5.0'),(449,'TIM','Provides Traveller Information Message (TIM).','5.0');
/*!40000 ALTER TABLE `plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pluginActivity`
--

DROP TABLE IF EXISTS `pluginActivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pluginActivity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `msgReceivedTimestamp` bigint(20) unsigned NOT NULL COMMENT 'Timestamp in microseconds since Epoch of when message was received by destination Plugin',
  `rPluginName` varchar(100) NOT NULL COMMENT 'Name of receiving plugin',
  `sPluginName` varchar(100) NOT NULL COMMENT 'Name of source plugin',
  `msgType` varchar(100) NOT NULL COMMENT 'Type of message',
  `msgSubtype` varchar(100) NOT NULL COMMENT 'Subtype of message',
  `msgCreatedTimestamp` bigint(20) NOT NULL COMMENT 'Timestamp in milliseconds since Epoch of when message was created.',
  `msgHandledTimestamp` bigint(20) NOT NULL COMMENT 'Timestamp in milliseconds since Epoch of when receiving plugin finished handling message.',
  `origMsgTimestamp` bigint(20) NOT NULL COMMENT 'Timestamp in milliseconds since Epoch of the original message that triggered this message sequence.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `msgReceivedTimestamp_rPluginName` (`msgReceivedTimestamp`,`rPluginName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table records all message activity of each active plugin in the IVP system. The data in this table is updated by each Plugin as part of PluginClient base class implementation.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pluginActivity`
--

LOCK TABLES `pluginActivity` WRITE;
/*!40000 ALTER TABLE `pluginActivity` DISABLE KEYS */;
/*!40000 ALTER TABLE `pluginActivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pluginConfigurationParameter`
--

DROP TABLE IF EXISTS `pluginConfigurationParameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pluginConfigurationParameter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `pluginId` int(10) unsigned NOT NULL,
  `key` varchar(255) NOT NULL COMMENT 'The name of a configuration parameter.',
  `value` text NOT NULL COMMENT 'The value of a configuration parameter',
  `defaultValue` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pluginId_key` (`pluginId`,`key`),
  KEY `pluginId` (`pluginId`),
  CONSTRAINT `pluginConfigurationParameter_ibfk_1` FOREIGN KEY (`pluginId`) REFERENCES `plugin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1622 DEFAULT CHARSET=latin1 COMMENT='This table lists the IVP system configuration parameters used by both core components and plugins to control the behavior of the system.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pluginConfigurationParameter`
--

LOCK TABLES `pluginConfigurationParameter` WRITE;
/*!40000 ALTER TABLE `pluginConfigurationParameter` DISABLE KEYS */;
INSERT INTO `pluginConfigurationParameter` VALUES (1540,435,'SleepMS','100','100','The length of milliseconds to sleep between processing all messages.'),(1541,435,'SSLEnabled','true','true','Enable secure connection using SSL.'),(1542,435,'SSLPath','/var/www/plugins/.ssl','/var/www/plugins/.ssl','The path to the directory containing the SSL key and certificate files.'),(1543,435,'EventRowLimit','50','50','The maximum number of rows returned for the initial Event Log query.'),(1544,435,'DownloadPath','/var/www/download','/var/www/download','The path to the directory where downloaded files will be saved.'),(1545,435,'LogLevel','ERROR','ERROR','The log level for this plugin'),(1546,436,'Frequency','1000','1000','The frequency to send the TIM in milliseconds.'),(1547,436,'MapFile','IVP_GF_CSW.xml','IVP_GF_CSW.xml',''),(1548,436,'Snap Interval','300','300','The interval in milliseconds to keep a vehicle within a zone before allowing it to transition out of all zones.'),(1549,436,'Vehicle Timeout','2000','2000','Timeout in milliseconds when a vehicle is removed from all zones if a BSM has not been received.'),(1550,437,'DMS IP Address','192.168.25.30','192.168.25.30','The IP address of the NTCIP Dynamic Message Sign.'),(1551,437,'DMS Port','9090','9090','The port of the NTCIP Dynamic Message Sign.'),(1552,437,'Enable DMS','True','True','If true all messages are sent to the Dynamic Message Sign using NTCIP 1203.'),(1553,437,'Enable Sign Simulator','True','True','If true all messages are sent to the Sign Simulator using UDP.'),(1554,437,'Force Message ID','-1','-1','Immediately activates the message ID specified, then resets back to -1.'),(1555,437,'Message 01','','','The text to display on the sign for ID 01 with any formatting (see NTCIP 1203).'),(1556,437,'Message 02','[jl3][pt15o0]25[np]MPH','[jl3][pt15o0]25[np]MPH','The text to display on the sign for ID 02 with any formatting (see NTCIP 1203).'),(1557,437,'Message 03','[jl3][pt15o0]SLOW[np]DOWN','[jl3][pt15o0]SLOW[np]DOWN','The text to display on the sign for ID 03 with any formatting (see NTCIP 1203).'),(1558,437,'Message 04','[jl3][pt15o0]CRVE[np]AHED','[jl3][pt15o0]CRVE[np]AHED','The text to display on the sign for ID 04 with any formatting (see NTCIP 1203).'),(1559,437,'Sign Sim IP Address','192.168.25.31','192.168.25.31','The IP address of the Sign Simulator that is the receipient of UDP messages.'),(1560,437,'Sign Sim Port','9090','9090','The UDP port of the Sign Simulator that is the receipient of UDP messages.'),(1561,438,'Messages_Destination_1','{ \"Messages\": [ { \"TmxType\": \"SPAT-P\", \"SendType\": \"SPAT\", \"PSID\": \"0x8002\" }, { \"TmxType\": \"MAP-P\", \"SendType\": \"MAP\", \"PSID\": \"0x8002\" }, { \"TmxType\": \"PSM\", \"SendType\": \"PSM\", \"PSID\": \"0x8002\" } ] }','{ \"Messages\": [ { \"TmxType\": \"SPAT-P\", \"SendType\": \"SPAT\", \"PSID\": \"0x8002\" }, { \"TmxType\": \"MAP-P\", \"SendType\": \"MAP\", \"PSID\": \"0x8002\" }, { \"TmxType\": \"PSM\", \"SendType\": \"PSM\", \"PSID\": \"0x8002\" } ] }','JSON data defining the message types and PSIDs for messages forwarded to the DSRC radio at destination 1.'),(1562,438,'Messages_Destination_2','{ \"Messages\": [ ] }','{ \"Messages\": [ ] }','JSON data defining the message types and PSIDs for messages forwarded to the DSRC radio at destination 2.'),(1563,438,'Messages_Destination_3','{ \"Messages\": [ ] }','{ \"Messages\": [ ] }','JSON data defining the message types and PSIDs for messages forwarded to the DSRC radio at destination 3.'),(1564,438,'Messages_Destination_4','{ \"Messages\": [ ] }','{ \"Messages\": [ ] }','JSON data defining the message types and PSIDs for messages forwarded to the DSRC radio at destination 4.'),(1565,438,'Destination_1','192.168.55.77:1516','192.168.55.77:1516','The destination UDP server(s) and port number(s) on the DSRC radio for all messages specified by Messages_Destination_1.'),(1566,438,'Destination_2','0','0','The destination UDP server(s) and port number(s) on the DSRC radio for all messages specified by Messages_Destination_2.'),(1567,438,'Destination_3','0','0','The destination UDP server(s) and port number(s) on the DSRC radio for all messages specified by Messages_Destination_3.'),(1568,438,'Destination_4','0','0','The destination UDP server(s) and port number(s) on the DSRC radio for all messages specified by Messages_Destination_4.'),(1569,438,'Signature','False','False','True or False value indicating whether to sign the messages.'),(1570,439,'Frequency','500','500','Rate to send Location Message in milliseconds'),(1571,439,'LatchHeadingSpeed','2.5','2.5','Speed at which the heading parameter should be latched, in mph.  Set to 0 to disable latching.'),(1572,439,'GPSSource','localhost','localhost','Host where the GPSd is running'),(1573,439,'SendRawNMEA','true','true','Route the raw NMEA strings from GPSd through TMX'),(1574,440,'Frequency','1000','1000','The frequency to send the MAP message in milliseconds.'),(1575,440,'MAP_Files','{ \"MapFiles\": [\n  {\"Action\":0, \"FilePath\":\"GID_Telegraph-Twelve_Mile_withEgress.xml\"}\n] }','{ \"MapFiles\": [\n  {\"Action\":0, \"FilePath\":\"GID_Telegraph-Twelve_Mile_withEgress.xml\"}\n] }','JSON data defining a list of map files.  One map file for each action set specified by the TSC.'),(1576,441,'IP','127.0.0.1','127.0.0.1','IP address for the incoming message network connection.'),(1577,441,'Port','26789','26789','Port for the incoming message network connection.'),(1578,441,'RouteDSRC','false','false','Set the flag to route a received J2735 message over DSRC.'),(1579,441,'EnableSimulatedBSM','true','true','Accept and route incoming BSM messages from a V2I Hub simulator.'),(1580,441,'EnableSimulatedSRM','true','true','Accept and route incoming SRM messages from a V2I Hub simulator.'),(1581,441,'EnableSimulatedLocation','true','true','Accept and route incoming GPS location messages from a V2I Hub simulator.'),(1582,442,'ODEIP','127.0.0.1','127.0.0.1','IP address for the ODE network connection.'),(1583,442,'ODEPort','26789','26789','Port for the ODE network connection.'),(1584,443,'Endpoint IP','156.63.133.118','156.63.133.118','NTRIP caster endpoint IP address'),(1585,443,'Endpoint Port','2101','2101','NTRIP caster endpoint port'),(1586,443,'Username','username','username','NTRIP caster authentication username'),(1587,443,'Password','password','password','NTRIP caster authentication password'),(1588,443,'Mountpoint','ODOT_RTCM23','ODOT_RTCM23','NTRIP caster mountpoint'),(1589,443,'RTCM Version','Unknown','Unknown','Specify the expected RTCM message version (2.3 or 3.3) coming from the caster.  Use Unknown to auto detect the version, which is done using trial and error, thus may be slow.'),(1590,443,'Route RTCM','false','false','Route the RTCM messages created from NTRIP internally for use by other plugins.'),(1591,444,'Intersection_Id','1','1','The intersection id for SPAT generated by this plugin.'),(1592,444,'Intersection_Name','Intersection','Intersection','The intersection name for SPAT generated by this plugin.'),(1593,444,'SignalGroupMapping','{\"SignalGroups\":[{\"SignalGroupId\":1,\"Phase\":1,\"Type\":\"vehicle\"},{\"SignalGroupId\":2,\"Phase\":2,\"Type\":\"vehicle\"},{\"SignalGroupId\":3,\"Phase\":3,\"Type\":\"vehicle\"},{\"SignalGroupId\":4,\"Phase\":4,\"Type\":\"vehicle\"},{\"SignalGroupId\":5,\"Phase\":5,\"Type\":\"vehicle\"},{\"SignalGroupId\":6,\"Phase\":6,\"Type\":\"vehicle\"},{\"SignalGroupId\":7,\"Phase\":7,\"Type\":\"vehicle\"},{\"SignalGroupId\":8,\"Phase\":8,\"Type\":\"vehicle\"},{\"SignalGroupId\":22,\"Phase\":2,\"Type\":\"pedestrian\"},{\"SignalGroupId\":24,\"Phase\":4,\"Type\":\"pedestrian\"},{\"SignalGroupId\":26,\"Phase\":6,\"Type\":\"pedestrian\"},{\"SignalGroupId\":28,\"Phase\":8,\"Type\":\"pedestrian\"}]}','{\"SignalGroups\":[{\"SignalGroupId\":1,\"Phase\":1,\"Type\":\"vehicle\"},{\"SignalGroupId\":2,\"Phase\":2,\"Type\":\"vehicle\"},{\"SignalGroupId\":3,\"Phase\":3,\"Type\":\"vehicle\"},{\"SignalGroupId\":4,\"Phase\":4,\"Type\":\"vehicle\"},{\"SignalGroupId\":5,\"Phase\":5,\"Type\":\"vehicle\"},{\"SignalGroupId\":6,\"Phase\":6,\"Type\":\"vehicle\"},{\"SignalGroupId\":7,\"Phase\":7,\"Type\":\"vehicle\"},{\"SignalGroupId\":8,\"Phase\":8,\"Type\":\"vehicle\"},{\"SignalGroupId\":22,\"Phase\":2,\"Type\":\"pedestrian\"},{\"SignalGroupId\":24,\"Phase\":4,\"Type\":\"pedestrian\"},{\"SignalGroupId\":26,\"Phase\":6,\"Type\":\"pedestrian\"},{\"SignalGroupId\":28,\"Phase\":8,\"Type\":\"pedestrian\"}]}','JSON data defining a list of SignalGroups and phases.'),(1594,444,'Local_IP','192.168.25.20','192.168.25.20','The IPv4 address of the local computer for receiving Traffic Signal Controller Broadcast Messages.'),(1595,444,'Local_UDP_Port','6053','6053','The local UDP port for reception of Traffic Signal Controller Broadcast Messages from the TSC.'),(1596,444,'TSC_IP','192.168.25.50','192.168.25.50','The IPv4 address of the destination Traffic Signal Controller (TSC).'),(1597,444,'TSC_Remote_SNMP_Port','501','501','The destination port on the Traffic Signal Controller (TSC) for SNMP NTCIP communication.'),(1598,445,'Instance','0','0','The instance of Preemption plugin.'),(1599,445,'BasePreemptionOid','.1.3.6.1.4.1.1206.4.2.1.6.3.1.2.','.1.3.6.1.4.1.1206.4.2.1.6.3.1.2.','The BasePreemptionOid of Preemption plugin.'),(1600,445,'ipwithport','192.168.55.49:6053','192.168.55.49:6053','The ipwithport of Preemption plugin.'),(1601,445,'snmp_community','public','public','The snmp_community of Preemption plugin.'),(1602,445,'map_path','/geo.json','/geo.json','The map_path for Preemption plugin.'),(1603,445,'allowedList','{\"validVehicles\":[\"292710445\",\"123456789\",\"2345678\"]}','{\"validVehicles\":[\"292710445\",\"123456789\",\"2345678\"]}','List of vehicles BSM id that are allowed'),(1604,446,'File Size In MB','100','100','Maximum size of the SPaT log file in mb.'),(1605,446,'File Location','/var/log/tmx','/var/log/tmx','The location where the log files are stored.'),(1606,446,'Filename','SPaTLog','SPaTLog','Default name of the SPaT log file.'),(1607,447,'File Size In MB','100','100','Maximum size of the BSM log file in mb.'),(1608,447,'File Location','/var/log/tmx','/var/log/tmx','The location where the log files are stored.'),(1609,447,'Filename','BSMLog','BSMLog','Default name of the BSM log file.'),(1610,448,'Frequency','1000','1000','The frequency to send the PSM in milliseconds.'),(1611,448,'Instance','0','0','The instance of Pedestrian plugin.'),(1612,448,'WebServiceIP','192.168.55.46','192.168.55.46','IP address at which the web service exists'),(1613,448,'WebServicePort','9000','9000','Port at which Web service exists'),(1614,449,'Frequency','1000','1000','The frequency to send the TIM in milliseconds.'),(1615,449,'MapFile','IVP_GF_TIM.xml','IVP_GF_TIM.xml',''),(1616,449,'Start_Broadcast_Date','01-01-2019','01-01-2019','The Start Broadcast Date for the TIM message in the (mm-dd-YYYY) format.'),(1617,449,'Stop_Broadcast_Date','12-31-2020','12-31-2020','The Stop Broadcast Date for the TIM message in the (mm-dd-YYYY) format.'),(1618,449,'Start_Broadcast_Time','06:00:00','06:00:00','The Start Broadcast Time for the TIM message in the (HH:MM:SS) format.'),(1619,449,'Stop_Broadcast_Time','21:00:00','21:00:00','The Start Broadcast Time for the TIM message in the (HH:MM:SS) format.'),(1620,449,'WebServiceIP','127.0.0.1','127.0.0.1','IP address at which the web service exists'),(1621,449,'WebServicePort','9999','9999','Port at which Web service exists');
/*!40000 ALTER TABLE `pluginConfigurationParameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pluginMessageMap`
--

DROP TABLE IF EXISTS `pluginMessageMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pluginMessageMap` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `pluginId` int(10) unsigned NOT NULL COMMENT 'Foreign key into the plugin table',
  `messageTypeId` int(10) unsigned NOT NULL COMMENT 'Foreign key into the messageType table.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pluginId` (`pluginId`,`messageTypeId`),
  KEY `pluginId_2` (`pluginId`),
  KEY `messageTypeId` (`messageTypeId`),
  CONSTRAINT `pluginMessageMap_ibfk_1` FOREIGN KEY (`pluginId`) REFERENCES `plugin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pluginMessageMap_ibfk_2` FOREIGN KEY (`messageTypeId`) REFERENCES `messageType` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18172 DEFAULT CHARSET=latin1 COMMENT='This table identifies the types of messages generated by each plugin.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pluginMessageMap`
--

LOCK TABLES `pluginMessageMap` WRITE;
/*!40000 ALTER TABLE `pluginMessageMap` DISABLE KEYS */;
/*!40000 ALTER TABLE `pluginMessageMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pluginStatus`
--

DROP TABLE IF EXISTS `pluginStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pluginStatus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pluginId` int(10) unsigned NOT NULL,
  `key` varchar(100) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_pluginId_key` (`pluginId`,`key`),
  KEY `pluginId` (`pluginId`),
  CONSTRAINT `pluginStatus_ibfk_2` FOREIGN KEY (`pluginId`) REFERENCES `plugin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27521 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pluginStatus`
--

LOCK TABLES `pluginStatus` WRITE;
/*!40000 ALTER TABLE `pluginStatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `pluginStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemConfigurationParameter`
--

DROP TABLE IF EXISTS `systemConfigurationParameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemConfigurationParameter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `key` varchar(255) NOT NULL COMMENT 'The name of a configuration parameter.',
  `value` text NOT NULL COMMENT 'The value of a configuration parameter',
  `defaultValue` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=latin1 COMMENT='This table lists the IVP system configuration parameters used by both core components and plugins to control the behavior of the system.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemConfigurationParameter`
--

LOCK TABLES `systemConfigurationParameter` WRITE;
/*!40000 ALTER TABLE `systemConfigurationParameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemConfigurationParameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `username` varchar(50) NOT NULL COMMENT 'The account name for the user, typically an email address',
  `password` varchar(50) NOT NULL COMMENT 'An encrypted password',
  `accessLevel` int(11) NOT NULL DEFAULT 1 COMMENT 'The access level permitted for this user, one of: \n  	1. read-only access to portal 	2. application administrator access 	3. system administrator, all access',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_user_id` (`id`),
  UNIQUE KEY `UQ_user_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='The list of accounts that can access the IVP platform via the administrative portal is held in the users table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-19 19:30:37
