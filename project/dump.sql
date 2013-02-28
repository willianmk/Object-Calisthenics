-- MySQL dump 10.13  Distrib 5.5.29, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: bob_tests
-- ------------------------------------------------------
-- Server version	5.5.29-0ubuntu0.12.10.1

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
-- Table structure for table `acl_role`
--

DROP TABLE IF EXISTS `acl_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_role` (
  `id_acl_role` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_acl_role`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=701 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_role`
--

LOCK TABLES `acl_role` WRITE;
/*!40000 ALTER TABLE `acl_role` DISABLE KEYS */;
INSERT INTO `acl_role` VALUES (1,'admin'),(4,'cli'),(2,'guest'),(3,'user'),(5,'webservice'),(700,'_dummy_role'),(6,'_jane_example_role');
/*!40000 ALTER TABLE `acl_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_role_has_privilege`
--

DROP TABLE IF EXISTS `acl_role_has_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_role_has_privilege` (
  `id_acl_role_has_privilege` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_acl_role` int(10) unsigned NOT NULL,
  `key_privilege` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_acl_role_has_privilege`),
  KEY `i_key_privilege` (`key_privilege`),
  KEY `fk_acl_role` (`fk_acl_role`),
  CONSTRAINT `acl_role_has_privilege_ibfk_1` FOREIGN KEY (`fk_acl_role`) REFERENCES `acl_role` (`id_acl_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_role_has_privilege`
--

LOCK TABLES `acl_role_has_privilege` WRITE;
/*!40000 ALTER TABLE `acl_role_has_privilege` DISABLE KEYS */;
INSERT INTO `acl_role_has_privilege` VALUES (1,1,'CanUsePet'),(2,6,'CanAdministerPetProductCreation'),(3,6,'CanAdministerPetEditedContent'),(4,6,'CanAdministerPetProductStatus'),(5,7,'CanChangePassword'),(6,9,'CanAdministerCatalogImport'),(7,10,'CanAdministerPetImages');
/*!40000 ALTER TABLE `acl_role_has_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_user`
--

DROP TABLE IF EXISTS `acl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_user` (
  `id_acl_user` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT '',
  `password` varchar(32) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fk_acl_role` int(10) unsigned NOT NULL,
  `fk_erp_operator` int(10) DEFAULT NULL,
  `logged_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `expires_password` tinyint(4) NOT NULL DEFAULT '1',
  `expires_email_sent_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_acl_user`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_acl_user_acl_role1` (`fk_acl_role`),
  CONSTRAINT `fk_acl_user_acl_role1` FOREIGN KEY (`fk_acl_role`) REFERENCES `acl_role` (`id_acl_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_user`
--

LOCK TABLES `acl_user` WRITE;
/*!40000 ALTER TABLE `acl_user` DISABLE KEYS */;
INSERT INTO `acl_user` VALUES (1,'admin','admin@example.com','a8b032edc715e42ab6fb38b129e43763','2013-02-28 13:32:10',1,NULL,'2013-02-28 00:00:00',NULL,0,NULL),(2,'guest','guest@example.com','a8b032edc715e42ab6fb38b129e43763','2013-02-28 13:32:10',2,NULL,NULL,NULL,1,NULL),(3,'user','user@example.com','a8b032edc715e42ab6fb38b129e43763','2013-02-28 13:32:10',3,NULL,'2012-12-12 00:00:00','2012-12-12 00:00:00',1,NULL),(4,'cli','cli@example.com','a8b032edc715e42ab6fb38b129e43763','2013-02-28 13:32:10',4,NULL,'2012-12-12 00:00:00','2012-12-13 00:00:00',1,NULL),(5,'webservice','webservice@example.com','a8b032edc715e42ab6fb38b129e43763','2013-02-28 13:32:10',5,NULL,'2012-12-12 00:00:00','2013-12-13 00:00:00',1,NULL),(6,'_john_example_doe','john.doe@example.com','99754106633f94d350db34d548d6091a','2013-02-28 13:32:10',6,NULL,'2013-02-28 00:00:00','2012-12-15 00:00:00',1,NULL),(7,'gamba','gamba@example.com','c73568538cc2fbb54e47f5bd42d43186','2013-02-28 13:32:10',1,NULL,'2012-12-12 00:00:00','2012-12-15 00:00:00',1,NULL);
/*!40000 ALTER TABLE `acl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alice_message`
--

DROP TABLE IF EXISTS `alice_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alice_message` (
  `id_alice_message` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) NOT NULL,
  `data` longtext NOT NULL,
  `command` varchar(255) NOT NULL,
  `caller` text NOT NULL,
  `comment` varchar(255) NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  `fk_store_store` int(11) NOT NULL,
  PRIMARY KEY (`id_alice_message`,`timestamp`),
  KEY `timestamp` (`timestamp`),
  KEY `fk_alice_message_store_store1` (`fk_store_store`),
  CONSTRAINT `fk_alice_message_store_store1` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alice_message`
--

LOCK TABLES `alice_message` WRITE;
/*!40000 ALTER TABLE `alice_message` DISABLE KEYS */;
INSERT INTO `alice_message` VALUES (1,136205846086053,'[\"cat-black-snarf\"]','delete','/var/www/dafiti/shop/bob/application/modules/messaging/models/Messaging.php(229)','Deleting products','product',1);
/*!40000 ALTER TABLE `alice_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bob_inline_documentation`
--

DROP TABLE IF EXISTS `bob_inline_documentation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bob_inline_documentation` (
  `id_bob_inline_documentation` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `acl_username` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `documentation` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_bob_inline_documentation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bob_inline_documentation`
--

LOCK TABLES `bob_inline_documentation` WRITE;
/*!40000 ALTER TABLE `bob_inline_documentation` DISABLE KEYS */;
/*!40000 ALTER TABLE `bob_inline_documentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boleto_reconciliation`
--

DROP TABLE IF EXISTS `boleto_reconciliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boleto_reconciliation` (
  `id_boleto_reconciliation` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bank_client` smallint(5) unsigned NOT NULL,
  `boleto_number` varchar(45) NOT NULL,
  `bank` int(10) unsigned NOT NULL,
  `boleto_status` varchar(10) NOT NULL,
  `paid_at` date NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `bank_taxes` decimal(10,2) NOT NULL,
  `amount_total` decimal(10,2) NOT NULL,
  `order_number` varchar(45) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'waiting',
  `obs` varchar(155) NOT NULL DEFAULT '',
  `others` varchar(255) DEFAULT '',
  PRIMARY KEY (`id_boleto_reconciliation`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boleto_reconciliation`
--

LOCK TABLES `boleto_reconciliation` WRITE;
/*!40000 ALTER TABLE `boleto_reconciliation` DISABLE KEYS */;
INSERT INTO `boleto_reconciliation` VALUES (1,1234,'11111111',1234,'L','2012-05-20',100.00,-0.75,99.25,'1111111','approve','','1'),(2,1234,'22222222',1234,'L','2012-05-19',90.00,-0.75,89.25,'2222222','cancel','','1'),(3,1234,'33333333',1234,'L','2012-05-20',90.00,-0.75,89.25,'3333333','waiting','','1'),(4,1234,'44444444',1234,'L','2012-05-20',85.00,-0.75,84.25,'4444444','cancel','','1'),(5,1234,'55555555',1234,'L','2012-05-20',0.00,0.00,0.00,'5555555','cancel','','1');
/*!40000 ALTER TABLE `boleto_reconciliation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand_discount_blacklist`
--

DROP TABLE IF EXISTS `brand_discount_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand_discount_blacklist` (
  `id_brand_discount_blacklist` int(11) NOT NULL AUTO_INCREMENT,
  `fk_brand_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_brand_discount_blacklist`),
  KEY `fk_brand_id1` (`fk_brand_id`),
  CONSTRAINT `fk_brand_id1` FOREIGN KEY (`fk_brand_id`) REFERENCES `catalog_brand` (`id_catalog_brand`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand_discount_blacklist`
--

LOCK TABLES `brand_discount_blacklist` WRITE;
/*!40000 ALTER TABLE `brand_discount_blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `brand_discount_blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule`
--

DROP TABLE IF EXISTS `cart_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_rule` (
  `id_cart_rule` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `from_date` datetime NOT NULL,
  `to_date` datetime NOT NULL,
  `action_serialized` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cart_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule`
--

LOCK TABLES `cart_rule` WRITE;
/*!40000 ALTER TABLE `cart_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_condition`
--

DROP TABLE IF EXISTS `cart_rule_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_rule_condition` (
  `id_cart_rule_condition` int(11) NOT NULL AUTO_INCREMENT,
  `fk_cart_rule` int(11) NOT NULL,
  `classname` varchar(255) NOT NULL,
  `operator` varchar(30) NOT NULL,
  `value` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cart_rule_condition`),
  KEY `fk_cart_rule1` (`fk_cart_rule`),
  CONSTRAINT `fk_cart_rule1` FOREIGN KEY (`fk_cart_rule`) REFERENCES `cart_rule` (`id_cart_rule`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_condition`
--

LOCK TABLES `cart_rule_condition` WRITE;
/*!40000 ALTER TABLE `cart_rule_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_attribute`
--

DROP TABLE IF EXISTS `catalog_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_attribute` (
  `id_catalog_attribute` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_attribute_set` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `product_type` enum('config','simple') NOT NULL,
  `attribute_type` enum('system','option','multi_option','value','custom') NOT NULL,
  `max_length` mediumint(8) unsigned DEFAULT NULL,
  `decimal_places` mediumint(8) unsigned DEFAULT NULL,
  `default_value` varchar(255) DEFAULT NULL,
  `unique_value` enum('global','config') DEFAULT NULL,
  `alice_export` enum('no','meta','attribute') NOT NULL,
  `dwh_field_name` varchar(255) DEFAULT NULL,
  `solr_searchable` tinyint(1) DEFAULT '0',
  `solr_filter` tinyint(1) DEFAULT '0',
  `solr_suggestions` tinyint(1) DEFAULT '0',
  `export_position` tinyint(1) DEFAULT NULL,
  `export_name` varchar(255) DEFAULT NULL,
  `import_name` varchar(255) DEFAULT NULL,
  `import_config_identifier` tinyint(1) DEFAULT '0',
  `label` varchar(255) NOT NULL,
  `label_en` varchar(255) NOT NULL,
  `description` text,
  `description_en` text,
  `pet_mode` enum('edit','display','invisible') NOT NULL,
  `pet_type` enum('textfield','textarea','numberfield','datefield','checkbox','dropdown','multiselect','combo','multicombo') NOT NULL,
  `pet_overview` tinyint(1) DEFAULT NULL,
  `pet_overview_filter` tinyint(1) DEFAULT NULL,
  `pet_qc` tinyint(1) DEFAULT NULL,
  `validation` enum('decimal','integer','percent','email','url','letters','lettersnumbers') DEFAULT NULL,
  `mandatory` tinyint(1) DEFAULT NULL,
  `mandatory_import` tinyint(1) DEFAULT NULL,
  `extra` text,
  PRIMARY KEY (`id_catalog_attribute`),
  UNIQUE KEY `fk_catalog_attribute_set` (`fk_catalog_attribute_set`,`name`,`product_type`),
  CONSTRAINT `catalog_attribute_ibfk_1` FOREIGN KEY (`fk_catalog_attribute_set`) REFERENCES `catalog_attribute_set` (`id_catalog_attribute_set`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_attribute`
--

LOCK TABLES `catalog_attribute` WRITE;
/*!40000 ALTER TABLE `catalog_attribute` DISABLE KEYS */;
INSERT INTO `catalog_attribute` VALUES (1,NULL,'sku','config','system',NULL,NULL,NULL,NULL,'attribute',NULL,1,NULL,NULL,NULL,NULL,NULL,0,'SKU','SKU',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,NULL,'name','config','system',NULL,NULL,NULL,NULL,'meta',NULL,1,NULL,1,NULL,NULL,NULL,0,'Nome','Name',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,NULL,'brand','config','system',NULL,NULL,NULL,NULL,'meta',NULL,1,1,1,NULL,NULL,NULL,0,'Nome do Fabricante','Name of the brand',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,NULL,'status','config','system',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Status','Status',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,NULL,'display_if_out_of_stock','config','system',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Não mostrar se não tem em estoque','Display if out of stock',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,NULL,'price','config','system',NULL,NULL,NULL,NULL,'meta',NULL,NULL,1,NULL,NULL,NULL,NULL,0,'Preço','Price',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,NULL,'special_price','config','system',NULL,NULL,NULL,NULL,'meta',NULL,NULL,1,NULL,NULL,NULL,NULL,0,'Special Price','Special Price',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,NULL,'special_from_date','config','system',NULL,NULL,NULL,NULL,'meta',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Special from','Special from',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,NULL,'special_to_date','config','system',NULL,NULL,NULL,NULL,'meta',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Special to','Special to',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,NULL,'tax_class','config','system',NULL,NULL,NULL,NULL,'meta',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Taxas','Tax class',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,NULL,'sku','simple','system',NULL,NULL,NULL,NULL,'meta',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'SKU','SKU',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,NULL,'status','simple','system',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Status','Status',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,NULL,'gender','config','option',NULL,NULL,NULL,NULL,'meta',NULL,1,1,1,NULL,NULL,NULL,0,'Genero','Gender',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,NULL,'activity','config','multi_option',NULL,NULL,NULL,NULL,'meta',NULL,1,1,1,NULL,NULL,NULL,0,'activity','activity',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,NULL,'is_outlet','config','value',NULL,NULL,NULL,NULL,'no',NULL,1,1,NULL,NULL,NULL,NULL,0,'Outlet','Outlet',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,NULL,'reason','config','value',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Razão','Reason',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,NULL,'release_date','config','value',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'Data de lançamento','Release date',NULL,NULL,'edit','textfield',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `catalog_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_attribute_link_global_activity`
--

DROP TABLE IF EXISTS `catalog_attribute_link_global_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_attribute_link_global_activity` (
  `id_catalog_attribute_link_global_activity` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  `fk_catalog_attribute_option_global_activity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_catalog_attribute_link_global_activity`),
  UNIQUE KEY `fk_catalog_config` (`fk_catalog_config`,`fk_catalog_attribute_option_global_activity`),
  KEY `fk_catalog_attribute_option_global_activity` (`fk_catalog_attribute_option_global_activity`),
  CONSTRAINT `fk_activity_link_catalog_config` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`) ON DELETE CASCADE,
  CONSTRAINT `fk_catalog_attribute_option_global_activity` FOREIGN KEY (`fk_catalog_attribute_option_global_activity`) REFERENCES `catalog_attribute_option_global_activity` (`id_catalog_attribute_option_global_activity`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_attribute_link_global_activity`
--

LOCK TABLES `catalog_attribute_link_global_activity` WRITE;
/*!40000 ALTER TABLE `catalog_attribute_link_global_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_attribute_link_global_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_attribute_link_global_pendency_workflow`
--

DROP TABLE IF EXISTS `catalog_attribute_link_global_pendency_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_attribute_link_global_pendency_workflow` (
  `id_catalog_attribute_link_global_pendency_workflow` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  `fk_catalog_attribute_option_global_pendency_workflow` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_catalog_attribute_link_global_pendency_workflow`),
  UNIQUE KEY `fk_catalog_config` (`fk_catalog_config`,`fk_catalog_attribute_option_global_pendency_workflow`),
  KEY `fk_catalog_attribute_option_global_pendency_workflow` (`fk_catalog_attribute_option_global_pendency_workflow`),
  CONSTRAINT `fk_pendency_workflow_link_catalog_config` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`) ON DELETE CASCADE,
  CONSTRAINT `fk_catalog_attribute_option_global_pendency_workflow` FOREIGN KEY (`fk_catalog_attribute_option_global_pendency_workflow`) REFERENCES `catalog_attribute_option_global_pendency_workflow` (`id_catalog_attribute_option_global_pendency_workflow`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_attribute_link_global_pendency_workflow`
--

LOCK TABLES `catalog_attribute_link_global_pendency_workflow` WRITE;
/*!40000 ALTER TABLE `catalog_attribute_link_global_pendency_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_attribute_link_global_pendency_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_attribute_metadata`
--

DROP TABLE IF EXISTS `catalog_attribute_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_attribute_metadata` (
  `id_catalog_attribute_metadata` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_attribute` int(10) unsigned DEFAULT NULL,
  `fk_catalog_attribute_set` int(10) unsigned DEFAULT NULL,
  `meta_pet_tab_main` varchar(50) DEFAULT NULL,
  `meta_pet_tab_sub` varchar(50) DEFAULT NULL,
  `meta_pet_tab_position` smallint(5) unsigned DEFAULT NULL,
  `meta_pet_group` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_catalog_attribute_metadata`),
  KEY `fk_catalog_attribute` (`fk_catalog_attribute`),
  KEY `fk_catalog_attribute_set` (`fk_catalog_attribute_set`),
  CONSTRAINT `catalog_attribute_metadata_ibfk_1` FOREIGN KEY (`fk_catalog_attribute`) REFERENCES `catalog_attribute` (`id_catalog_attribute`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `catalog_attribute_metadata_ibfk_2` FOREIGN KEY (`fk_catalog_attribute_set`) REFERENCES `catalog_attribute_set` (`id_catalog_attribute_set`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_attribute_metadata`
--

LOCK TABLES `catalog_attribute_metadata` WRITE;
/*!40000 ALTER TABLE `catalog_attribute_metadata` DISABLE KEYS */;
INSERT INTO `catalog_attribute_metadata` VALUES (1,1,NULL,'PC','Config',0,NULL),(2,2,NULL,'PC','Config',1,NULL),(3,3,NULL,'PC','Config',2,NULL),(4,4,NULL,'PC','Config',3,NULL),(5,5,NULL,'PC','Config',4,NULL),(6,6,NULL,'PC','Price & Tax',0,NULL),(7,7,NULL,'PC','Price & Tax',1,NULL),(8,8,NULL,'PC','Price & Tax',2,NULL),(9,9,NULL,'PC','Price & Tax',3,NULL),(10,10,NULL,'PC','Price & Tax',4,NULL),(11,11,NULL,'PC','Simples',0,NULL),(12,12,NULL,'PC','Simples',1,NULL),(13,13,NULL,'PC','Config',11,NULL),(14,15,NULL,'PC','Config',12,NULL),(15,15,NULL,'PC','Config',12,NULL),(16,15,NULL,'PC','Config',12,NULL),(17,15,NULL,'PC','Config',12,NULL),(18,16,NULL,'PC','Config',13,NULL),(19,16,NULL,'PC','Config',13,NULL),(20,16,NULL,'PC','Config',13,NULL),(21,16,NULL,'PC','Config',13,NULL),(22,17,NULL,'PC','Config',14,NULL),(23,17,NULL,'PC','Config',14,NULL),(24,17,NULL,'PC','Config',14,NULL),(25,17,NULL,'PC','Config',14,NULL);
/*!40000 ALTER TABLE `catalog_attribute_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_attribute_option_global_activity`
--

DROP TABLE IF EXISTS `catalog_attribute_option_global_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_attribute_option_global_activity` (
  `id_catalog_attribute_option_global_activity` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `position` smallint(5) unsigned DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_catalog_attribute_option_global_activity`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_en` (`name_en`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_attribute_option_global_activity`
--

LOCK TABLES `catalog_attribute_option_global_activity` WRITE;
/*!40000 ALTER TABLE `catalog_attribute_option_global_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_attribute_option_global_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_attribute_option_global_gender`
--

DROP TABLE IF EXISTS `catalog_attribute_option_global_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_attribute_option_global_gender` (
  `id_catalog_attribute_option_global_gender` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `position` mediumint(8) unsigned DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_catalog_attribute_option_global_gender`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_en` (`name_en`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_attribute_option_global_gender`
--

LOCK TABLES `catalog_attribute_option_global_gender` WRITE;
/*!40000 ALTER TABLE `catalog_attribute_option_global_gender` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_attribute_option_global_gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_attribute_option_global_pendency_workflow`
--

DROP TABLE IF EXISTS `catalog_attribute_option_global_pendency_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_attribute_option_global_pendency_workflow` (
  `id_catalog_attribute_option_global_pendency_workflow` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `position` smallint(5) unsigned DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_catalog_attribute_option_global_pendency_workflow`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_en` (`name_en`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_attribute_option_global_pendency_workflow`
--

LOCK TABLES `catalog_attribute_option_global_pendency_workflow` WRITE;
/*!40000 ALTER TABLE `catalog_attribute_option_global_pendency_workflow` DISABLE KEYS */;
INSERT INTO `catalog_attribute_option_global_pendency_workflow` VALUES (1,'Controle de Qualidade','Quality Control',2,0),(2,'Marketing','Marketing',1,0),(3,'Compras','Purchase',0,0);
/*!40000 ALTER TABLE `catalog_attribute_option_global_pendency_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_attribute_option_shoes_size`
--

DROP TABLE IF EXISTS `catalog_attribute_option_shoes_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_attribute_option_shoes_size` (
  `id_catalog_attribute_option_shoes_size` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `position` mediumint(8) unsigned DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_catalog_attribute_option_shoes_size`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_en` (`name_en`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_attribute_option_shoes_size`
--

LOCK TABLES `catalog_attribute_option_shoes_size` WRITE;
/*!40000 ALTER TABLE `catalog_attribute_option_shoes_size` DISABLE KEYS */;
INSERT INTO `catalog_attribute_option_shoes_size` VALUES (1,'Size-1',NULL,NULL,0);
/*!40000 ALTER TABLE `catalog_attribute_option_shoes_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_attribute_set`
--

DROP TABLE IF EXISTS `catalog_attribute_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_attribute_set` (
  `id_catalog_attribute_set` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `label_en` varchar(50) DEFAULT NULL,
  `identifier` varchar(2) NOT NULL,
  PRIMARY KEY (`id_catalog_attribute_set`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `label` (`label`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_attribute_set`
--

LOCK TABLES `catalog_attribute_set` WRITE;
/*!40000 ALTER TABLE `catalog_attribute_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_attribute_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_brand`
--

DROP TABLE IF EXISTS `catalog_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_brand` (
  `id_catalog_brand` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','deleted') NOT NULL,
  `name` varchar(255) NOT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `position` smallint(5) unsigned DEFAULT NULL,
  `url_key` varchar(255) NOT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_catalog_brand`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_en` (`name_en`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_brand`
--

LOCK TABLES `catalog_brand` WRITE;
/*!40000 ALTER TABLE `catalog_brand` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_category`
--

DROP TABLE IF EXISTS `catalog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category` (
  `id_catalog_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','inherited_inactive','deleted') NOT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `url_key` varchar(255) NOT NULL,
  PRIMARY KEY (`id_catalog_category`),
  UNIQUE KEY `lft` (`lft`),
  UNIQUE KEY `rgt` (`rgt`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_category`
--

LOCK TABLES `catalog_category` WRITE;
/*!40000 ALTER TABLE `catalog_category` DISABLE KEYS */;
INSERT INTO `catalog_category` VALUES (1,'active',1,6,'Root Category','Root Category','root-category'),(2,'active',2,3,'Main Category #1','Main Category #1','main-category-1'),(3,'active',4,5,'Main Category #2','Main Category #2','main-category-2');
/*!40000 ALTER TABLE `catalog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_category_has_catalog_segment`
--

DROP TABLE IF EXISTS `catalog_category_has_catalog_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_category_has_catalog_segment` (
  `id_catalog_category_has_catalog_segment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_category` int(10) unsigned NOT NULL,
  `fk_catalog_segment` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_catalog_category_has_catalog_segment`),
  UNIQUE KEY `uk_catalog_category_has_catalog_segment` (`fk_catalog_category`,`fk_catalog_segment`),
  KEY `fk_catalog_category` (`fk_catalog_category`),
  KEY `fk_catalog_segment` (`fk_catalog_segment`),
  CONSTRAINT `catalog_category_has_catalog_segment_ibfk_1` FOREIGN KEY (`fk_catalog_category`) REFERENCES `catalog_category` (`id_catalog_category`) ON DELETE CASCADE,
  CONSTRAINT `catalog_category_has_catalog_segment_ibfk_2` FOREIGN KEY (`fk_catalog_segment`) REFERENCES `catalog_segment` (`id_catalog_segment`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_category_has_catalog_segment`
--

LOCK TABLES `catalog_category_has_catalog_segment` WRITE;
/*!40000 ALTER TABLE `catalog_category_has_catalog_segment` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_category_has_catalog_segment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_config`
--

DROP TABLE IF EXISTS `catalog_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_config` (
  `id_catalog_config` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) NOT NULL,
  `status` enum('active','inactive','deleted') NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `special_price` decimal(10,2) DEFAULT NULL,
  `special_from_date` date DEFAULT NULL,
  `special_to_date` date DEFAULT NULL,
  `fk_catalog_brand` int(10) unsigned DEFAULT NULL,
  `fk_catalog_tax_class` int(10) unsigned NOT NULL,
  `fk_catalog_import` int(10) unsigned DEFAULT NULL,
  `display_if_out_of_stock` tinyint(1) DEFAULT '0',
  `fk_catalog_config_group` int(10) unsigned DEFAULT NULL,
  `fk_catalog_attribute_set` int(10) unsigned NOT NULL,
  `pet_status` set('creation','edited','images') DEFAULT NULL,
  `pet_approved` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `activated_at` datetime DEFAULT NULL,
  `first_activated` datetime DEFAULT NULL,
  `time_active` bigint(20) DEFAULT '0',
  `supplier` varchar(255) DEFAULT NULL,
  `cnpj_supplier` varchar(50) DEFAULT NULL,
  `sku_supplier_config` varchar(50) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `cnpj_brand` varchar(50) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `fk_catalog_attribute_option_global_gender` int(10) unsigned DEFAULT NULL,
  `is_outlet` tinyint(1) NOT NULL DEFAULT '0',
  `reason` varchar(250) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `is_no_product` tinyint(1) NOT NULL DEFAULT '0',
  `nameerp` varchar(45) DEFAULT NULL,
  `is_manual_grouping` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag used for define if product will be grouped manual',
  `is_outlet_shop_in_shop` tinyint(1) NOT NULL DEFAULT '0',
  `is_gift` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_catalog_config`),
  UNIQUE KEY `sku` (`sku`),
  KEY `fk_catalog_attribute_set` (`fk_catalog_attribute_set`),
  KEY `fk_catalog_brand` (`fk_catalog_brand`),
  KEY `fk_catalog_tax_class` (`fk_catalog_tax_class`),
  KEY `fk_catalog_config_group` (`fk_catalog_config_group`),
  KEY `fk_catalog_import` (`fk_catalog_import`),
  KEY `pet_approved` (`pet_approved`),
  KEY `fk_catalog_attribute_option_global_gender` (`fk_catalog_attribute_option_global_gender`),
  KEY `name` (`name`),
  KEY `created_at` (`created_at`),
  KEY `updated_at` (`updated_at`),
  KEY `activated_at` (`activated_at`),
  CONSTRAINT `catalog_config_ibfk_1` FOREIGN KEY (`fk_catalog_attribute_set`) REFERENCES `catalog_attribute_set` (`id_catalog_attribute_set`),
  CONSTRAINT `catalog_config_ibfk_2` FOREIGN KEY (`fk_catalog_brand`) REFERENCES `catalog_brand` (`id_catalog_brand`),
  CONSTRAINT `catalog_config_ibfk_3` FOREIGN KEY (`fk_catalog_tax_class`) REFERENCES `catalog_tax_class` (`id_catalog_tax_class`),
  CONSTRAINT `catalog_config_ibfk_4` FOREIGN KEY (`fk_catalog_config_group`) REFERENCES `catalog_config_group` (`id_catalog_config_group`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `catalog_config_ibfk_5` FOREIGN KEY (`fk_catalog_import`) REFERENCES `catalog_import` (`id_catalog_import`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_config`
--

LOCK TABLES `catalog_config` WRITE;
/*!40000 ALTER TABLE `catalog_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_config_group`
--

DROP TABLE IF EXISTS `catalog_config_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_config_group` (
  `id_catalog_config_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_catalog_config_group`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_config_group`
--

LOCK TABLES `catalog_config_group` WRITE;
/*!40000 ALTER TABLE `catalog_config_group` DISABLE KEYS */;
INSERT INTO `catalog_config_group` VALUES (1,'automated_group__cat-brown');
/*!40000 ALTER TABLE `catalog_config_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_config_has_catalog_category`
--

DROP TABLE IF EXISTS `catalog_config_has_catalog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_config_has_catalog_category` (
  `id_catalog_config_has_catalog_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  `fk_catalog_category` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_catalog_config_has_catalog_category`),
  UNIQUE KEY `uk_id_catalog_config_has_catalog_category` (`fk_catalog_config`,`fk_catalog_category`),
  UNIQUE KEY `fk_catalog_config` (`fk_catalog_config`,`fk_catalog_category`),
  KEY `fk_catalog_category` (`fk_catalog_category`),
  CONSTRAINT `catalog_config_has_catalog_category_ibfk_1` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`),
  CONSTRAINT `catalog_config_has_catalog_category_ibfk_2` FOREIGN KEY (`fk_catalog_category`) REFERENCES `catalog_category` (`id_catalog_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_config_has_catalog_category`
--

LOCK TABLES `catalog_config_has_catalog_category` WRITE;
/*!40000 ALTER TABLE `catalog_config_has_catalog_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_config_has_catalog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_config_log`
--

DROP TABLE IF EXISTS `catalog_config_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_config_log` (
  `id_catalog_config_log` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  `sku` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `change` text,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id_catalog_config_log`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_config_log`
--

LOCK TABLES `catalog_config_log` WRITE;
/*!40000 ALTER TABLE `catalog_config_log` DISABLE KEYS */;
INSERT INTO `catalog_config_log` VALUES (1,5,'cat-brown-miau','Admin','update','{\"special_price\":{\"old\":null,\"new\":\"99.9\"},\"special_from_date\":{\"old\":null,\"new\":\"12.07.2011\"},\"special_to_date\":{\"old\":null,\"new\":\"31.12.2015\"},\"color_name_brand\":{\"old\":\"Marron\",\"new\":\"Brown\"}}','2013-02-28 10:32:21'),(2,5,'cat-brown-miau','Admin','update','{\"special_from_date\":{\"old\":\"2012-07-20\",\"new\":\"12.07.2011\"},\"special_to_date\":{\"old\":\"2031-12-20\",\"new\":\"31.12.2015\"}}','2013-02-28 10:32:22');
/*!40000 ALTER TABLE `catalog_config_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_config_store`
--

DROP TABLE IF EXISTS `catalog_config_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_config_store` (
  `id_catalog_config_store` int(11) NOT NULL AUTO_INCREMENT,
  `fk_store_store` int(11) NOT NULL,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_catalog_config_store`),
  KEY `ccs_fk_store_store_1` (`fk_store_store`),
  KEY `ccs_fk_catalog_config_1` (`fk_catalog_config`),
  CONSTRAINT `ccs_fk_store_store` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ccs_fk_catalog_config` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_config_store`
--

LOCK TABLES `catalog_config_store` WRITE;
/*!40000 ALTER TABLE `catalog_config_store` DISABLE KEYS */;
INSERT INTO `catalog_config_store` VALUES (1,2,3),(2,2,3),(3,2,3),(4,2,3),(5,2,3),(6,2,3);
/*!40000 ALTER TABLE `catalog_config_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_import`
--

DROP TABLE IF EXISTS `catalog_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_import` (
  `id_catalog_import` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_attribute_set` int(10) unsigned NOT NULL,
  `type` enum('product') DEFAULT 'product',
  `adapter` enum('csv') DEFAULT 'csv',
  `mode` enum('create','update','simples') DEFAULT NULL,
  `uploaded_at` datetime DEFAULT NULL,
  `imported_at` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `label` varchar(50) NOT NULL,
  `fk_acl_user` int(10) unsigned DEFAULT NULL,
  `info` blob NOT NULL,
  `result` blob NOT NULL,
  `total` int(11) NOT NULL,
  PRIMARY KEY (`id_catalog_import`),
  KEY `fk_catalog_attribute_set` (`fk_catalog_attribute_set`),
  KEY `catalog_import_ibfk_2` (`fk_acl_user`),
  CONSTRAINT `catalog_import_ibfk_1` FOREIGN KEY (`fk_catalog_attribute_set`) REFERENCES `catalog_attribute_set` (`id_catalog_attribute_set`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `catalog_import_ibfk_2` FOREIGN KEY (`fk_acl_user`) REFERENCES `acl_user` (`id_acl_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_import`
--

LOCK TABLES `catalog_import` WRITE;
/*!40000 ALTER TABLE `catalog_import` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_import` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_import_config`
--

DROP TABLE IF EXISTS `catalog_import_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_import_config` (
  `id_catalog_import_config` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_import` int(10) unsigned NOT NULL,
  `simple_count` tinyint(3) unsigned NOT NULL,
  `data` mediumblob,
  `messages` blob NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_catalog_import_config`),
  KEY `fk_catalog_import_ibfk_1` (`fk_catalog_import`),
  CONSTRAINT `catalog_import_config_ibfk_1` FOREIGN KEY (`fk_catalog_import`) REFERENCES `catalog_import` (`id_catalog_import`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_import_config`
--

LOCK TABLES `catalog_import_config` WRITE;
/*!40000 ALTER TABLE `catalog_import_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_import_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_new_category`
--

DROP TABLE IF EXISTS `catalog_new_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_new_category` (
  `id_catalog_new_category` int(11) NOT NULL AUTO_INCREMENT,
  `fk_store_store` int(11) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `name` varchar(254) NOT NULL,
  `name_en` varchar(254) DEFAULT NULL,
  `url_key` varchar(254) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  `status` enum('active','inactive','inherited_inactive','deleted') NOT NULL,
  PRIMARY KEY (`id_catalog_new_category`),
  KEY `fk_store_store` (`fk_store_store`),
  KEY `parent` (`parent`),
  CONSTRAINT `cnc_fk_store_store` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cnc_parent` FOREIGN KEY (`parent`) REFERENCES `catalog_new_category` (`id_catalog_new_category`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_new_category`
--

LOCK TABLES `catalog_new_category` WRITE;
/*!40000 ALTER TABLE `catalog_new_category` DISABLE KEYS */;
INSERT INTO `catalog_new_category` VALUES (10,2,NULL,'Calçados','Shoes','calcados',0,'active'),(12,2,10,'Tênis','Tennis','tenis',1,'active'),(13,2,10,'Sapatênis','','sapatenis',2,'active'),(14,2,12,'Casual','','casual',0,'inactive'),(15,2,NULL,'Shoes','','shoes',0,'active'),(16,2,15,'Social','','social',1,'active'),(17,2,16,'Classico','','Classico',1,'active');
/*!40000 ALTER TABLE `catalog_new_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_new_category_catalog_config`
--

DROP TABLE IF EXISTS `catalog_new_category_catalog_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_new_category_catalog_config` (
  `id_catalog_new_category_catalog_config` int(11) NOT NULL AUTO_INCREMENT,
  `fk_catalog_new_category` int(11) NOT NULL,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_catalog_new_category_catalog_config`),
  UNIQUE KEY `fk_catalog_new_category_fk_catalog_config` (`fk_catalog_new_category`,`fk_catalog_config`),
  KEY `fk_catalog_new_category` (`fk_catalog_new_category`),
  KEY `fk_catalog_config` (`fk_catalog_config`),
  CONSTRAINT `cnccc_fk_catalog_new_category` FOREIGN KEY (`fk_catalog_new_category`) REFERENCES `catalog_new_category` (`id_catalog_new_category`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cnccc_fk_catalog_config` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_new_category_catalog_config`
--

LOCK TABLES `catalog_new_category_catalog_config` WRITE;
/*!40000 ALTER TABLE `catalog_new_category_catalog_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_new_category_catalog_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_new_category_catalog_segment`
--

DROP TABLE IF EXISTS `catalog_new_category_catalog_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_new_category_catalog_segment` (
  `id_catalog_new_category_catalog_segment` int(11) NOT NULL AUTO_INCREMENT,
  `fk_catalog_new_category` int(11) NOT NULL,
  `fk_catalog_segment` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_catalog_new_category_catalog_segment`),
  UNIQUE KEY `fk_catalog_new_category_fk_catalog_segment` (`fk_catalog_new_category`,`fk_catalog_segment`),
  KEY `fk_catalog_new_category` (`fk_catalog_new_category`),
  KEY `fk_catalog_segment` (`fk_catalog_segment`),
  CONSTRAINT `cnccs_fk_catalog_new_category_1` FOREIGN KEY (`fk_catalog_new_category`) REFERENCES `catalog_new_category` (`id_catalog_new_category`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cnccs_fk_catalog_segment` FOREIGN KEY (`fk_catalog_segment`) REFERENCES `catalog_segment` (`id_catalog_segment`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_new_category_catalog_segment`
--

LOCK TABLES `catalog_new_category_catalog_segment` WRITE;
/*!40000 ALTER TABLE `catalog_new_category_catalog_segment` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_new_category_catalog_segment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_product_boost`
--

DROP TABLE IF EXISTS `catalog_product_boost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_boost` (
  `id_catalog_product_boost` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  `boost` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_catalog_product_boost`),
  UNIQUE KEY `fk_catalog_config` (`fk_catalog_config`),
  CONSTRAINT `catalog_product_boost_ibfk_1` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_product_boost`
--

LOCK TABLES `catalog_product_boost` WRITE;
/*!40000 ALTER TABLE `catalog_product_boost` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_product_boost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_product_image`
--

DROP TABLE IF EXISTS `catalog_product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_image` (
  `id_catalog_product_image` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  `image` int(10) unsigned NOT NULL,
  `main` tinyint(1) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `original_filename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_catalog_product_image`),
  UNIQUE KEY `fk_catalog_config` (`fk_catalog_config`,`image`),
  CONSTRAINT `catalog_product_image_ibfk_1` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_product_image`
--

LOCK TABLES `catalog_product_image` WRITE;
/*!40000 ALTER TABLE `catalog_product_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_product_image_size`
--

DROP TABLE IF EXISTS `catalog_product_image_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_product_image_size` (
  `id_catalog_product_image_size` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `width` int(6) unsigned NOT NULL,
  `height` int(6) unsigned NOT NULL,
  `quality` int(3) unsigned NOT NULL,
  PRIMARY KEY (`id_catalog_product_image_size`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_product_image_size`
--

LOCK TABLES `catalog_product_image_size` WRITE;
/*!40000 ALTER TABLE `catalog_product_image_size` DISABLE KEYS */;
INSERT INTO `catalog_product_image_size` VALUES (1,'catalog',160,160,80),(2,'cart',75,75,80),(3,'product',355,355,80),(4,'gallery',37,54,80),(5,'zoom',728,728,80),(6,'related',53,53,80),(7,'list',79,79,80);
/*!40000 ALTER TABLE `catalog_product_image_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_segment`
--

DROP TABLE IF EXISTS `catalog_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_segment` (
  `id_catalog_segment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `url_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_catalog_segment`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_segment`
--

LOCK TABLES `catalog_segment` WRITE;
/*!40000 ALTER TABLE `catalog_segment` DISABLE KEYS */;
INSERT INTO `catalog_segment` VALUES (1,'Feminino','Women','feminin'),(2,'Masculino','Men','masculin'),(3,'Infantil','Kids','infant');
/*!40000 ALTER TABLE `catalog_segment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_simple`
--

DROP TABLE IF EXISTS `catalog_simple`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_simple` (
  `id_catalog_simple` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  `fk_catalog_import` int(10) unsigned DEFAULT NULL,
  `sku` varchar(255) NOT NULL,
  `status` enum('active','inactive','deleted') NOT NULL,
  `created_at_external` datetime DEFAULT NULL,
  `updated_at_external` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `erp_id` varchar(50) DEFAULT NULL COMMENT 'ID of item in ERP system',
  `sku_supplier_simple` varchar(50) DEFAULT NULL COMMENT 'SKU of product at supplier',
  `supplier_code_erp` varchar(100) DEFAULT NULL COMMENT 'Supplier code of item in ERP system',
  `barcode_ean` varchar(255) DEFAULT NULL COMMENT 'Barcode or EAN of product',
  `fiscal_check` tinyint(1) unsigned DEFAULT NULL COMMENT 'Indicates if the item has already been revised by th fiscal department',
  `weight` decimal(10,3) DEFAULT NULL COMMENT 'Weight of the product',
  `box_height` decimal(10,3) DEFAULT NULL COMMENT 'Height of the unity package, in meters',
  `box_width` decimal(10,3) DEFAULT NULL COMMENT 'Width of the unity package, in meters',
  `box_length` decimal(10,3) DEFAULT NULL COMMENT 'Length of the unity package, in meters',
  `fk_catalog_attribute_option_global_transport_type` int(10) unsigned DEFAULT NULL COMMENT 'Type of transportation (ERP)',
  `purchase_ean` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_catalog_simple`),
  UNIQUE KEY `sku` (`sku`),
  UNIQUE KEY `erp_id` (`erp_id`),
  UNIQUE KEY `barcode_ean` (`barcode_ean`),
  KEY `fk_catalog_config` (`fk_catalog_config`),
  KEY `fk_catalog_import` (`fk_catalog_import`),
  CONSTRAINT `catalog_simple_ibfk_1` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`),
  CONSTRAINT `catalog_simple_ibfk_2` FOREIGN KEY (`fk_catalog_import`) REFERENCES `catalog_import` (`id_catalog_import`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_simple`
--

LOCK TABLES `catalog_simple` WRITE;
/*!40000 ALTER TABLE `catalog_simple` DISABLE KEYS */;
INSERT INTO `catalog_simple` VALUES (1,1,NULL,'A-ABC-1','active',NULL,NULL,NULL,'2012-04-09 16:00:00','1',NULL,NULL,'barcode1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,NULL,'A-ABC-2','active',NULL,NULL,NULL,'2012-04-09 16:00:00','2',NULL,NULL,'barcode2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,3,NULL,'A-ABC-3','active',NULL,NULL,NULL,'2012-04-09 16:00:00','3',NULL,NULL,'barcode3',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,3,NULL,'A-ABC-4','active',NULL,NULL,NULL,'2012-04-09 16:00:00','4',NULL,NULL,'barcode4',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(100,2,NULL,'SKU-TEST-1','active',NULL,NULL,NULL,'2012-04-09 16:00:00','56500',NULL,NULL,'barcode500',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(200,2,NULL,'SKU-TEST-2','active',NULL,NULL,NULL,'2012-04-09 16:00:00','56600',NULL,NULL,'barcode600',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(300,3,NULL,'SKU-TEST-3','active',NULL,NULL,NULL,'2012-04-09 16:00:00','56900',NULL,NULL,'barcode300',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `catalog_simple` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_simple_shoes`
--

DROP TABLE IF EXISTS `catalog_simple_shoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_simple_shoes` (
  `id_catalog_simple_shoes` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_simple` int(10) unsigned NOT NULL,
  `fk_catalog_attribute_option_shoes_size` int(10) unsigned DEFAULT NULL COMMENT 'Size of the shoe that is displayed in the shop',
  `fk_catalog_attribute_option_shoes_size_system_brand` int(10) unsigned DEFAULT NULL COMMENT 'Size system used by brand',
  PRIMARY KEY (`id_catalog_simple_shoes`),
  UNIQUE KEY `fk_catalog_simple` (`fk_catalog_simple`),
  KEY `fk_catalog_attribute_option_shoes_size` (`fk_catalog_attribute_option_shoes_size`),
  KEY `fk_catalog_attribute_option_shoes_size_system_brand` (`fk_catalog_attribute_option_shoes_size_system_brand`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_simple_shoes`
--

LOCK TABLES `catalog_simple_shoes` WRITE;
/*!40000 ALTER TABLE `catalog_simple_shoes` DISABLE KEYS */;
INSERT INTO `catalog_simple_shoes` VALUES (1,1,1,NULL);
/*!40000 ALTER TABLE `catalog_simple_shoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_sorting`
--

DROP TABLE IF EXISTS `catalog_sorting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_sorting` (
  `id_catalog_sorting` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `formula` text NOT NULL,
  `fk_store_store` int(11) NOT NULL,
  PRIMARY KEY (`id_catalog_sorting`),
  KEY `catalog_sorting_ibfk_1` (`fk_store_store`),
  CONSTRAINT `catalog_sorting_ibfk_1` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_sorting`
--

LOCK TABLES `catalog_sorting` WRITE;
/*!40000 ALTER TABLE `catalog_sorting` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_sorting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_stock`
--

DROP TABLE IF EXISTS `catalog_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_stock` (
  `id_catalog_stock` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_simple` int(10) unsigned NOT NULL,
  `fk_warehouse` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `quantity` int(10) NOT NULL,
  PRIMARY KEY (`id_catalog_stock`),
  KEY `catalog_stock_ibfk_1` (`fk_catalog_simple`),
  CONSTRAINT `catalog_stock_ibfk_1` FOREIGN KEY (`fk_catalog_simple`) REFERENCES `catalog_simple` (`id_catalog_simple`)
) ENGINE=InnoDB AUTO_INCREMENT=689 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_stock`
--

LOCK TABLES `catalog_stock` WRITE;
/*!40000 ALTER TABLE `catalog_stock` DISABLE KEYS */;
INSERT INTO `catalog_stock` VALUES (678,2685,1,5),(679,2685,2,5),(685,2692,1,3),(686,2692,2,2),(687,2693,1,3),(688,2693,2,3);
/*!40000 ALTER TABLE `catalog_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_tax_class`
--

DROP TABLE IF EXISTS `catalog_tax_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_tax_class` (
  `id_catalog_tax_class` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `tax_percent` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id_catalog_tax_class`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_tax_class`
--

LOCK TABLES `catalog_tax_class` WRITE;
/*!40000 ALTER TABLE `catalog_tax_class` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_tax_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_folder`
--

DROP TABLE IF EXISTS `cms_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_folder` (
  `id_cms_folder` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_cms_folder_type` int(10) unsigned NOT NULL,
  `fk_acl_user` int(10) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL,
  `revision` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_confirmed` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `fk_cms_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `fk_store_store` int(11) NOT NULL,
  PRIMARY KEY (`id_cms_folder`),
  KEY `fk_cms_folder_type` (`fk_cms_folder_type`),
  KEY `fk_acl_user` (`fk_acl_user`),
  KEY `fk_cms_folder_store_store1` (`fk_store_store`),
  CONSTRAINT `cms_folder_ibfk_1` FOREIGN KEY (`fk_cms_folder_type`) REFERENCES `cms_folder_type` (`id_cms_folder_type`),
  CONSTRAINT `cms_folder_ibfk_2` FOREIGN KEY (`fk_acl_user`) REFERENCES `acl_user` (`id_acl_user`),
  CONSTRAINT `fk_cms_folder_store_store1` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_folder`
--

LOCK TABLES `cms_folder` WRITE;
/*!40000 ALTER TABLE `cms_folder` DISABLE KEYS */;
INSERT INTO `cms_folder` VALUES (1,1,1,'homepage','description',1,1,'2012-04-04 14:23:53',1,1,1),(2,1,1,'homepage','description',1,1,'2012-04-04 14:23:53',1,1,2);
/*!40000 ALTER TABLE `cms_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_folder_type`
--

DROP TABLE IF EXISTS `cms_folder_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_folder_type` (
  `id_cms_folder_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id_cms_folder_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_folder_type`
--

LOCK TABLES `cms_folder_type` WRITE;
/*!40000 ALTER TABLE `cms_folder_type` DISABLE KEYS */;
INSERT INTO `cms_folder_type` VALUES (1,'homepage','Homepage',''),(4,'staticblock','Static Block','');
/*!40000 ALTER TABLE `cms_folder_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_item`
--

DROP TABLE IF EXISTS `cms_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_item` (
  `id_cms_item` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_cms_folder` int(10) unsigned NOT NULL,
  `fk_cms_item_type` int(10) unsigned NOT NULL,
  `fk_acl_user` int(10) unsigned NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cms_item`),
  KEY `fk_cms_folder` (`fk_cms_folder`),
  KEY `fk_cms_item_type` (`fk_cms_item_type`),
  KEY `fk_acl_user` (`fk_acl_user`),
  CONSTRAINT `cms_item_ibfk_1` FOREIGN KEY (`fk_cms_folder`) REFERENCES `cms_folder` (`id_cms_folder`),
  CONSTRAINT `cms_item_ibfk_2` FOREIGN KEY (`fk_cms_item_type`) REFERENCES `cms_item_type` (`id_cms_item_type`),
  CONSTRAINT `cms_item_ibfk_3` FOREIGN KEY (`fk_acl_user`) REFERENCES `acl_user` (`id_acl_user`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_item`
--

LOCK TABLES `cms_item` WRITE;
/*!40000 ALTER TABLE `cms_item` DISABLE KEYS */;
INSERT INTO `cms_item` VALUES (1,1,1,1,'content','2012-04-04 14:23:53'),(2,8,8,1,'{google_analytics:1}','2012-07-07 21:18:18');
/*!40000 ALTER TABLE `cms_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_item_type`
--

DROP TABLE IF EXISTS `cms_item_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_item_type` (
  `id_cms_item_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `xtype` varchar(255) NOT NULL,
  PRIMARY KEY (`id_cms_item_type`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_item_type`
--

LOCK TABLES `cms_item_type` WRITE;
/*!40000 ALTER TABLE `cms_item_type` DISABLE KEYS */;
INSERT INTO `cms_item_type` VALUES (1,'page_title','Page Title','','text'),(2,'text','Text','','textarea'),(3,'meta_description','Meta Description','','textarea'),(4,'meta_keywords','Meta Keywords','','textarea'),(5,'meta_robots','Meta Robots','','text'),(6,'seo_text','SEO Text','','textarea'),(7,'banner','Banner','','banner'),(8,'body_start_block','Block at begin of body','','textarea'),(9,'body_end_block','Block at end of body','','textarea'),(10,'brandslist','Brands List','','list'),(11,'available_filter','Available filter','','textarea'),(12,'is_specialpage','Specialpage','','checkbox'),(13,'layout','Layout','','textarea'),(14,'tracking_code','Tracking Code','','trackingcode'),(15,'product_list','Product list','','text'),(16,'additional_layout','Additional Layout','An additional layout for a shop-in-shop','textarea'),(17,'seo_text_product','SEO Text Product','SEO Text for product detail page','textarea'),(19,'brandselector','Brands Dropdown','Select a single brand','brandselector'),(20,'categorieslist','Categories List','Selected categories are used as a whitelist of categories to be displayed in the categories filter','list');
/*!40000 ALTER TABLE `cms_item_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_shop`
--

DROP TABLE IF EXISTS `cms_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_shop` (
  `id_cms_shop` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `key_method` enum('subdomain','parameter','none') NOT NULL,
  `label` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id_cms_shop` (`id_cms_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_shop`
--

LOCK TABLES `cms_shop` WRITE;
/*!40000 ALTER TABLE `cms_shop` DISABLE KEYS */;
INSERT INTO `cms_shop` VALUES (2,'test','subdomain','test_label','2013-02-28 13:32:33'),(4,'test','subdomain','test_label','2013-02-28 13:32:33');
/*!40000 ALTER TABLE `cms_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_shop_config`
--

DROP TABLE IF EXISTS `cms_shop_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_shop_config` (
  `id_cms_shop_config` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_cms_shop` int(10) unsigned NOT NULL,
  `layout` text,
  `layout_reduced` text,
  `filter_method` enum('whitelist','blacklist') NOT NULL DEFAULT 'blacklist',
  `telephone_customer_care` varchar(40) DEFAULT NULL,
  `tracking` text,
  `layout_home` text,
  UNIQUE KEY `id_cms_shop_config` (`id_cms_shop_config`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_shop_config`
--

LOCK TABLES `cms_shop_config` WRITE;
/*!40000 ALTER TABLE `cms_shop_config` DISABLE KEYS */;
INSERT INTO `cms_shop_config` VALUES (2,2,'test_layout_full','test_layout_reduced','whitelist','(11)1111-1111','{\"cmspage\":\"Cms Page\\n\",\"catalogpage\":\"Catalog Page\\n\",\"productpage\":\"Product Page\\n\",\"quickviewpage\":\"Quickview Page\\n\",\"cartpage\":\"Cart Page\\n\",\"checkoutpage\":\"Checkout Page\\n\",\"successpage\":\"Success Page\\n\",\"landingpage\":\"Landing Page\\n\"}','test_layout_home'),(4,4,'test_layout_full','test_layout_reduced','whitelist',NULL,'{\"cmspage\":\"{coca_google_remarketing_cmspage:1}\"}',NULL);
/*!40000 ALTER TABLE `cms_shop_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_shop_filter`
--

DROP TABLE IF EXISTS `cms_shop_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_shop_filter` (
  `id_cms_shop_filter` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_cms_shop_config` int(10) unsigned NOT NULL,
  `filter_type` enum('brand','category') NOT NULL,
  `filter_value` int(10) NOT NULL,
  UNIQUE KEY `id_cms_shop_filter` (`id_cms_shop_filter`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_shop_filter`
--

LOCK TABLES `cms_shop_filter` WRITE;
/*!40000 ALTER TABLE `cms_shop_filter` DISABLE KEYS */;
INSERT INTO `cms_shop_filter` VALUES (1,2,'brand',4444);
/*!40000 ALTER TABLE `cms_shop_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuration` (
  `id_configuration` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_store_store` int(10) NOT NULL,
  `config_key` varchar(255) DEFAULT NULL,
  `config_value` text,
  `tstamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_configuration`),
  UNIQUE KEY `fk_store_store_2` (`fk_store_store`,`config_key`),
  KEY `fk_store_store` (`fk_store_store`),
  CONSTRAINT `configuration_ibfk_1` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration`
--

LOCK TABLES `configuration` WRITE;
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` VALUES (1,1,'payment_merchant_id','9A2D9FA6-6FF9-2BCE-C77A-6D8F11F79F7B','2013-02-28 13:34:34'),(2,1,'payment_payment_provider','redecard','2013-02-28 13:34:34'),(3,1,'pay_priority_braspag','50','2013-02-28 13:34:34'),(4,1,'pay_priority_adyen','50','2013-02-28 13:34:34'),(5,1,'pay_retry_limit','3','2013-02-28 13:34:34'),(6,1,'pluginerp_subsidiary_id','11200418000240','2013-02-28 13:34:34'),(7,1,'pluginerp_freight_carrier_selection_type','cheapest','2013-02-28 13:34:34'),(8,1,'pluginerp_freight_percentage_of_return_freight','20.00','2013-02-28 13:34:34'),(9,1,'pluginerp_freight_free_shipping_dafiti','1','2013-02-28 13:34:34'),(10,1,'pluginerp_order_detail_P_PZ_CD_EXPRESS','1','2013-02-28 13:34:34'),(11,1,'pluginerp_order_detail_P_PZ_CD_NORMAL','2','2013-02-28 13:34:34'),(12,1,'pluginerp_order_detail_P_PZ_CD_ECONOMIC','3','2013-02-28 13:34:34'),(13,1,'pluginerp_freight_cost_max_economic','10','2013-02-28 13:34:34'),(14,1,'pluginerp_freight_cost_max_normal','20','2013-02-28 13:34:34'),(15,1,'pluginerp_freight_cost_max_express','30','2013-02-28 13:34:34'),(16,1,'pluginerp_freight_cost_value_normal','120','2013-02-28 13:34:34'),(17,1,'pluginerp_freight_cost_value_economic','100','2013-02-28 13:34:34'),(18,1,'pluginerp_freight_cost_value_express','130','2013-02-28 13:34:34'),(19,1,'pluginerp_freight_no_carrier_type','fixed','2013-02-28 13:34:34'),(20,1,'pluginerp_freight_no_carrier_amount','15.00','2013-02-28 13:34:34'),(21,1,'pluginerp_freight_home_cep_range_start','00000000','2013-02-28 13:34:34'),(22,1,'pluginerp_freight_home_cep_range_end','99999999','2013-02-28 13:34:34'),(23,1,'pluginerp_freight_home_cep_transittime','35','2013-02-28 13:34:34'),(24,1,'pluginerp_freight_default_transittime','35','2013-02-28 13:34:34');
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id_country` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iso2_code` varchar(2) NOT NULL,
  `iso3_code` varchar(3) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_country`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (2,'AD','AND','Andorra'),(3,'AE','ARE','United Arab Emirates'),(4,'AF','AFG','Afghanistan'),(5,'AG','ATG','Antigua and Barbuda'),(6,'AI','AIA','Anguilla'),(7,'AL','ALB','Albania'),(8,'AM','ARM','Armenia'),(9,'AN','ANT','Netherlands Antilles'),(10,'AO','AGO','Angola'),(11,'AQ','ATA','Antarctica'),(12,'AR','ARG','Argentina'),(13,'AS','ASM','American Samoa'),(14,'AT','AUT','Austria'),(15,'AU','AUS','Australia'),(16,'AW','ABW','Aruba'),(17,'AX','ALA','Åland Islands'),(18,'AZ','AZE','Azerbaijan'),(19,'BA','BIH','Bosnia and Herzegovina'),(20,'BB','BRB','Barbados'),(21,'BD','BGD','Bangladesh'),(22,'BE','BEL','Belgium'),(23,'BF','BFA','Burkina Faso'),(24,'BG','BGR','Bulgaria'),(25,'BH','BHR','Bahrain'),(26,'BI','BDI','Burundi'),(27,'BJ','BEN','Benin'),(28,'BL','BLM','Saint Barthelemy'),(29,'BM','BMU','Bermuda'),(30,'BN','BRN','Brunei'),(31,'BO','BOL','Bolivia'),(32,'BR','BRA','Brazil'),(33,'BS','BHS','Bahamas'),(34,'BT','BTN','Bhutan'),(35,'BV','BVT','Bouvet Island'),(36,'BW','BWA','Botswana'),(37,'BY','BLR','Belarus'),(38,'BZ','BLZ','Belize'),(39,'CA','CAN','Canada'),(40,'CC','CCK','Cocos [Keeling] Islands'),(41,'CD','COD','Congo - Kinshasa'),(42,'CF','CAF','Central African Republic'),(43,'CG','COG','Congo - Brazzaville'),(44,'CH','CHE','Switzerland'),(45,'CI','CIV','Côte d’Ivoire'),(46,'CK','COK','Cook Islands'),(47,'CL','CHL','Chile'),(48,'CM','CMR','Cameroon'),(49,'CN','CHN','China'),(50,'CO','COL','Colombia'),(51,'CR','CRI','Costa Rica'),(52,'CU','CUB','Cuba'),(53,'CV','CPV','Cape Verde'),(54,'CX','CXR','Christmas Island'),(55,'CY','CYP','Cyprus'),(56,'CZ','CZE','Czech Republic'),(57,'DE','DEU','Germany'),(58,'DJ','DJI','Djibouti'),(59,'DK','DNK','Denmark'),(60,'DM','DMA','Dominica'),(61,'DO','DOM','Dominican Republic'),(62,'DZ','DZA','Algeria'),(63,'EC','ECU','Ecuador'),(64,'EE','EST','Estonia'),(65,'EG','EGY','Egypt'),(66,'EH','ESH','Western Sahara'),(67,'ER','ERI','Eritrea'),(68,'ES','ESP','Spain'),(69,'ET','ETH','Ethiopia'),(70,'FI','FIN','Finland'),(71,'FJ','FJI','Fiji'),(72,'FK','FLK','Falkland Islands'),(73,'FM','FSM','Micronesia'),(74,'FO','FRO','Faroe Islands'),(75,'FR','FRA','France'),(76,'GA','GAB','Gabon'),(77,'GB','GBR','United Kingdom'),(78,'GD','GRD','Grenada'),(79,'GE','GEO','Georgia'),(80,'GF','GUF','French Guiana'),(81,'GG','GGY','Guernsey'),(82,'GH','GHA','Ghana'),(83,'GI','GIB','Gibraltar'),(84,'GL','GRL','Greenland'),(85,'GM','GMB','Gambia'),(86,'GN','GIN','Guinea'),(87,'GP','GLP','Guadeloupe'),(88,'GQ','GNQ','Equatorial Guinea'),(89,'GR','GRC','Greece'),(90,'GS','SGS','South Georgia and the South Sandwich Islands'),(91,'GT','GTM','Guatemala'),(92,'GU','GUM','Guam'),(93,'GW','GNB','Guinea-Bissau'),(94,'GY','GUY','Guyana'),(95,'HK','HKG','Hong Kong SAR China'),(96,'HM','HMD','Heard Island and McDonald Islands'),(97,'HN','HND','Honduras'),(98,'HR','HRV','Croatia'),(99,'HT','HTI','Haiti'),(100,'HU','HUN','Hungary'),(101,'ID','IDN','Indonesia'),(102,'IE','IRL','Ireland'),(103,'IL','ISR','Israel'),(104,'IM','IMN','Isle of man'),(105,'IN','IND','India'),(106,'IO','IOT','British Indian Ocean Territory'),(107,'IQ','IRQ','Iraq'),(108,'IR','IRN','Iran'),(109,'IS','ISL','Iceland'),(110,'IT','ITA','Italy'),(111,'JE','JEY','Jersey'),(112,'JM','JAM','Jamaica'),(113,'JO','JOR','Jordan'),(114,'JP','JPN','Japan'),(115,'KE','KEN','Kenya'),(116,'KG','KGZ','Kyrgyzstan'),(117,'KH','KHM','Cambodia'),(118,'KI','KIR','Kiribati'),(119,'KM','COM','Comoros'),(120,'KN','KNA','Saint Kitts and Nevis'),(121,'KP','PRK','North Korea'),(122,'KR','KOR','South Korea'),(123,'KW','KWT','Kuwait'),(124,'KY','CYM','Cayman Islands'),(125,'KZ','KAZ','Kazakhstan'),(126,'LA','LAO','Laos'),(127,'LB','LBN','Lebanon'),(128,'LC','LCA','Saint Lucia'),(129,'LI','LIE','Liechtenstein'),(130,'LK','LKA','Sri Lanka'),(131,'LR','LBR','Liberia'),(132,'LS','LSO','Lesotho'),(133,'LT','LTU','Lithuania'),(134,'LU','LUX','Luxembourg'),(135,'LV','LVA','Latvia'),(136,'LY','LBY','Libya'),(137,'MA','MAR','Morocco'),(138,'MC','MCO','Monaco'),(139,'MD','MDA','Moldova'),(140,'ME','MNE','Montenegro'),(141,'MF','MAF','Saint Martin (French part)'),(142,'MG','MDG','Madagascar'),(143,'MH','MHL','Marshall Islands'),(144,'MK','MKD','Macedonia'),(145,'ML','MLI','Mali'),(146,'MM','MMR','Myanmar [Burma]'),(147,'MN','MNG','Mongolia'),(148,'MO','MAC','Macau SAR China'),(149,'MP','MNP','Northern Mariana Islands'),(150,'MQ','MTQ','Martinique'),(151,'MR','MRT','Mauritania'),(152,'MS','MSR','Montserrat'),(153,'MT','MLT','Malta'),(154,'MU','MUS','Mauritius'),(155,'MV','MDV','Maldives'),(156,'MW','MWI','Malawi'),(157,'MX','MEX','Mexico'),(158,'MY','MYS','Malaysia'),(159,'MZ','MOZ','Mozambique'),(160,'NA','NAM','Namibia'),(161,'NC','NCL','New Caledonia'),(162,'NE','NER','Niger'),(163,'NF','NFK','Norfolk Island'),(164,'NG','NGA','Nigeria'),(165,'NI','NIC','Nicaragua'),(166,'NL','NLD','Netherlands'),(167,'NO','NOR','Norway'),(168,'NP','NPL','Nepal'),(169,'NR','NRU','Nauru'),(170,'NU','NIU','Niue'),(171,'NZ','NZL','New Zealand'),(172,'OM','OMN','Oman'),(173,'PA','PAN','Panama'),(174,'PE','PER','Peru'),(175,'PF','PYF','French Polynesia'),(176,'PG','PNG','Papua New Guinea'),(177,'PH','PHL','Philippines'),(178,'PK','PAK','Pakistan'),(179,'PL','POL','Poland'),(180,'PM','SPM','Saint Pierre and Miquelon'),(181,'PN','PCN','Pitcairn Islands'),(182,'PR','PRI','Puerto Rico'),(183,'PS','PSE','Palestinian Territories'),(184,'PT','PRT','Portugal'),(185,'PW','PLW','Palau'),(186,'PY','PRY','Paraguay'),(187,'QA','QAT','Qatar'),(188,'RE','REU','Réunion'),(189,'RO','ROU','Romania'),(190,'RS','SRB','Serbia'),(191,'RU','RUS','Russia'),(192,'RW','RWA','Rwanda'),(193,'SA','SAU','Saudi Arabia'),(194,'SB','SLB','Solomon Islands'),(195,'SC','SYC','Seychelles'),(196,'SD','SDN','Sudan'),(197,'SE','SWE','Sweden'),(198,'SG','SGP','Singapore'),(199,'SH','SHN','Saint Helena'),(200,'SI','SVN','Slovenia'),(201,'SJ','SJM','Svalbard and Jan Mayen'),(202,'SK','SVK','Slovakia'),(203,'SL','SLE','Sierra Leone'),(204,'SM','SMR','San Marino'),(205,'SN','SEN','Senegal'),(206,'SO','SOM','Somalia'),(207,'SR','SUR','Suriname'),(208,'ST','STP','São Tomé and Príncipe'),(209,'SV','SLV','El Salvador'),(210,'SY','SYR','Syria'),(211,'SZ','SWZ','Swaziland'),(212,'TC','TCA','Turks and Caicos Islands'),(213,'TD','TCD','Chad'),(214,'TF','ATF','French Southern Territories'),(215,'TG','TGO','Togo'),(216,'TH','THA','Thailand'),(217,'TJ','TJK','Tajikistan'),(218,'TK','TKL','Tokelau'),(219,'TL','TLS','Timor-Leste'),(220,'TM','TKM','Turkmenistan'),(221,'TN','TUN','Tunisia'),(222,'TO','TON','Tonga'),(223,'TR','TUR','Turkey'),(224,'TT','TTO','Trinidad and Tobago'),(225,'TV','TUV','Tuvalu'),(226,'TW','TWN','Taiwan'),(227,'TZ','TZA','Tanzania'),(228,'UA','UKR','Ukraine'),(229,'UG','UGA','Uganda'),(230,'UM','UMI','U.S. Minor Outlying Islands'),(231,'US','USA','United States'),(232,'UY','URY','Uruguay'),(233,'UZ','UZB','Uzbekistan'),(234,'VA','VAT','Vatican City'),(235,'VC','VCT','Saint Vincent and the Grenadines'),(236,'VE','VEN','Venezuela'),(237,'VG','VGB','British Virgin Islands'),(238,'VI','VIR','U.S. Virgin Islands'),(239,'VN','VNM','Vietnam'),(240,'VU','VUT','Vanuatu'),(241,'WF','WLF','Wallis and Futuna'),(242,'WS','WSM','Samoa'),(243,'YE','YEM','Yemen'),(244,'YT','MYT','Mayotte'),(245,'ZA','ZAF','South Africa'),(246,'ZM','ZMB','Zambia'),(247,'ZW','ZWE','Zimbabwe');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id_customer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `increment_id` varchar(50) DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` enum('female','male') DEFAULT NULL,
  `password` varchar(35) NOT NULL,
  `restore_password_key` varchar(32) DEFAULT NULL,
  `is_confirmed` tinyint(1) unsigned DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `birthday` date DEFAULT NULL,
  `tax_identification` varchar(64) NOT NULL,
  `registro_geral` varchar(20) DEFAULT NULL,
  `state_registration` varchar(15) DEFAULT NULL,
  `customer_personality` tinyint(1) NOT NULL,
  `state_registration_exempt` tinyint(1) DEFAULT NULL,
  `prudsys_id` varchar(32) DEFAULT NULL,
  `id_hash` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_customer`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `increment_id_UNIQUE` (`increment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'dafiti_customer@dafiti.com.br',NULL,NULL,'dafiti',NULL,'customer',NULL,'xxxxxxxxxxxx',NULL,0,NULL,'2013-02-28 13:34:34',NULL,'tax',NULL,NULL,1,NULL,NULL,NULL),(2,'9b3b2ad1.default@mailinator.com',NULL,NULL,'DefaultFirstname','DefaultMiddlename','DefaultLastname','female','password',NULL,0,'2013-02-28 10:34:34','2013-02-28 13:34:34','1988-02-28','80984439307',NULL,NULL,2,NULL,NULL,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_address`
--

DROP TABLE IF EXISTS `customer_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_address` (
  `id_customer_address` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prefix` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `address1` varchar(500) NOT NULL,
  `company` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `postcode` varchar(15) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `phone_optional` varchar(255) DEFAULT NULL,
  `fk_customer` int(10) unsigned NOT NULL,
  `fk_country` int(10) unsigned NOT NULL,
  `fk_customer_address_region` int(10) unsigned DEFAULT NULL,
  `is_default_billing` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_default_shipping` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `address2` varchar(500) DEFAULT NULL,
  `additional_info` varchar(255) DEFAULT NULL,
  `neighborhood` varchar(255) NOT NULL,
  `cell_phone` varchar(255) DEFAULT NULL,
  `city_code` int(7) DEFAULT NULL,
  `street_number` int(6) NOT NULL,
  `reference_delivery` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_customer_address`),
  KEY `fk_customer_address_customer1` (`fk_customer`),
  KEY `fk_customer_address_country1` (`fk_country`),
  KEY `fk_customer_address_region1` (`fk_customer_address_region`),
  CONSTRAINT `fk_customer_address_country1` FOREIGN KEY (`fk_country`) REFERENCES `country` (`id_country`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_address_customer1` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`id_customer`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_address_region1` FOREIGN KEY (`fk_customer_address_region`) REFERENCES `customer_address_region` (`id_customer_address_region`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_address`
--

LOCK TABLES `customer_address` WRITE;
/*!40000 ALTER TABLE `customer_address` DISABLE KEYS */;
INSERT INTO `customer_address` VALUES (1,NULL,'DefaultFirstname','DefaultMiddlename','DefaultLastname','DefaultStreet 1','DefaultCompany','São Paulo','04642-000','0199123456','123456789',2,32,36,1,1,'2013-02-28 10:34:34','2013-02-28 13:34:34',NULL,'9abc','Default Neighborhood','0199123456',12345,99,'reference delivery');
/*!40000 ALTER TABLE `customer_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_address_region`
--

DROP TABLE IF EXISTS `customer_address_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_address_region` (
  `id_customer_address_region` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_country` int(10) unsigned NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sort` int(10) DEFAULT NULL,
  PRIMARY KEY (`id_customer_address_region`),
  KEY `fk_region_country1` (`fk_country`),
  CONSTRAINT `fk_region_country1` FOREIGN KEY (`fk_country`) REFERENCES `country` (`id_country`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_address_region`
--

LOCK TABLES `customer_address_region` WRITE;
/*!40000 ALTER TABLE `customer_address_region` DISABLE KEYS */;
INSERT INTO `customer_address_region` VALUES (17,32,'RO','Rondônia',NULL),(18,32,'AC','Acre',NULL),(19,32,'AM','Amazonas',NULL),(20,32,'RR','Roraima',NULL),(21,32,'PA','Pará',NULL),(22,32,'AP','Amapá',NULL),(23,32,'TO','Tocantins',NULL),(24,32,'MA','Maranhão',NULL),(25,32,'PI','Piauí',NULL),(26,32,'CE','Ceará',NULL),(27,32,'RN','Rio Grande do Norte',NULL),(28,32,'PB','Paraíba',NULL),(29,32,'PE','Pernambuco',NULL),(30,32,'AL','Alagoas',NULL),(31,32,'SE','Sergipe',NULL),(32,32,'BA','Bahia',NULL),(33,32,'MG','Minas Gerais',NULL),(34,32,'ES','Espírito Santo',NULL),(35,32,'RJ','Rio de Janeiro',NULL),(36,32,'SP','São Paulo',NULL),(37,32,'PR','Paraná',NULL),(38,32,'SC','Santa Catarina',NULL),(39,32,'RS','Rio Grande do Sul',NULL),(40,32,'MS','Mato Grosso do Sul',NULL),(41,32,'MT','Mato Grosso',NULL),(42,32,'GO','Goiás',NULL),(43,32,'DF','Distrito Federal',NULL);
/*!40000 ALTER TABLE `customer_address_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_shipment_status`
--

DROP TABLE IF EXISTS `customer_shipment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_shipment_status` (
  `id_customer_shipment_status` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `signal` tinyint(4) NOT NULL,
  `order` int(4) NOT NULL,
  PRIMARY KEY (`id_customer_shipment_status`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_shipment_status`
--

LOCK TABLES `customer_shipment_status` WRITE;
/*!40000 ALTER TABLE `customer_shipment_status` DISABLE KEYS */;
INSERT INTO `customer_shipment_status` VALUES (1,'Aguardando devolução','Registramos sua solicitação para troca, reenvio ou devolução da compra. Aguardamos devolução da mesma pelo nosso transportador para darmos continuidade ao seu atendimento.',1,16),(2,'Análise de dados','Para sua segurança, realizaremos uma análise das informações inseridas em seu cadastro. Por favor, aguarde que qualquer eventual problema entraremos em contato.',0,2),(3,'Compra registrada','Confirmamos a inclusão do seu pedido em nosso sistema.',0,1),(4,'Contate a Central de Relacionamento','Pedimos que entre em contato com nossa Central de Relacionamento, pois encontramos dificuldades para conclusão da entrega.',1,20),(5,'Dificuldades para entrega','Realizamos uma tentativa de entrega, porém não obtivemos sucesso porque não havia ninguém autorizado para receber sua compra. Realizaremos uma nova tentativa de entrega em até dois dias úteis contados a partir do recebimento desta mensagem.',1,13),(6,'Emissão de Nota Fiscal não autorizada','Pedimos que entre em contato com nossa Central de Relacionamento, pois encontramos dificuldades no processo de emissão de sua Nota Fiscal',2,10),(7,'Entrega cancelada','Sua entrega foi cancelada. Em caso de dúvidas entre em contato com nossa Central de Relacionamento',2,18),(8,'Entrega concluída','Concluímos a sua entrega.',0,15),(9,'Entrega em andamento','Seu pedido está com nosso transportador e será entregue conforme prazo previsto em http://www.dafiti.com.br/prazo-de-entrega.',0,12),(10,'Entregue na transportadora','Seu pedido está com nosso transportador e será entregue conforme prazo previsto em http://www.dafiti.com.br/prazo-de-entrega.',0,11),(11,'Nota Fiscal emitida','Seu produto já foi separado em nosso estoque e a Nota Fiscal emitida. Sua compra será entregue conforme prazo previsto em http://www.dafiti.com.br/prazo-de-entrega.',0,9),(12,'Pagamento aprovado','O pagamento foi aprovado.',0,5),(13,'Pagamento não aprovado','Não conseguimos efetivar sua compra devido algum dado inconsistente do seu cartão de crédito, tais como numeração, data de validade, código de segurança, nome do titular, limite ou outra inconsistência. Por favor, refaça sua compra. Será uma prazer receber você novamente em nosso site!',2,6),(14,'Pagamento pendente','Aguardamos confirmação do seu pagamento, sendo que a aprovação do pagamento poderá levar até dois dias úteis devido ao prazo de compensação bancária.',1,4),(15,'Pedido devolvido','Devido à impossibilidade de realizar sua entrega sua compra retornou ao Centro de Distribuição da Dafiti. Pedimos que entre em contato com nossa Central de Relacionamento.',1,17),(16,'Problemas fiscais','Pedimos que entre em contato com nossa Central de Relacionamento, pois encontramos dificuldades para conclusão da entega.',1,14),(17,'Reprovado na análise de dados','Seu pedido não foi aprovado na etapa de análise cadastral. Em caso de dúvidas entre em contato com nossa Central de Relacionamento.',2,3),(18,'Separação no estoque','Seu produto será separado em nosso estoque, embalado e em seguida entregue à transportadora. Sua compra será entregue conforme prazo previsto em http://www.dafiti.com.br/prazo-de-entrega.',0,8),(19,'Solicitação encerrada','Sua solicitação para troca, reenvio ou devolução da compra foi concluída. Aguarde nova comunicação de nossa Central de Relacionamento por e-mail.',0,19),(20,'Venda sem estoque','Aguardamos a disponibilidade do seu produto em nosso estoque.',1,7);
/*!40000 ALTER TABLE `customer_shipment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_shipment_status_history`
--

DROP TABLE IF EXISTS `customer_shipment_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_shipment_status_history` (
  `id_customer_shipment_status_history` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_customer_shipment_status` int(10) unsigned NOT NULL,
  `slip_number` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_customer_shipment_status_history`),
  KEY `fk_customer_shipment_status1` (`fk_customer_shipment_status`),
  KEY `i_slip` (`slip_number`),
  CONSTRAINT `fk_customer_shipment_status1` FOREIGN KEY (`fk_customer_shipment_status`) REFERENCES `customer_shipment_status` (`id_customer_shipment_status`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_shipment_status_history`
--

LOCK TABLES `customer_shipment_status_history` WRITE;
/*!40000 ALTER TABLE `customer_shipment_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_shipment_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_wishlist`
--

DROP TABLE IF EXISTS `customer_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_wishlist` (
  `id_customer_wishlist` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_customer` int(10) unsigned NOT NULL,
  `comment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `configurable_sku` varchar(255) NOT NULL,
  `simple_sku` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_customer_wishlist`),
  KEY `fk_customer` (`fk_customer`),
  CONSTRAINT `customer_wishlist_ibfk_1` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_wishlist`
--

LOCK TABLES `customer_wishlist` WRITE;
/*!40000 ALTER TABLE `customer_wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_call`
--

DROP TABLE IF EXISTS `erp_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_call` (
  `id_erp_call` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `call_type` varchar(255) NOT NULL,
  `responseXML` longtext NOT NULL,
  `was_successful` tinyint(1) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `error_message` varchar(500) DEFAULT NULL,
  `ref_table_name` varchar(255) DEFAULT NULL,
  `ref_table_id` int(10) unsigned DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_erp_call`),
  KEY `ref_table_name` (`ref_table_name`,`ref_table_id`),
  KEY `time_index` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_call`
--

LOCK TABLES `erp_call` WRITE;
/*!40000 ALTER TABLE `erp_call` DISABLE KEYS */;
/*!40000 ALTER TABLE `erp_call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_category_mapping`
--

DROP TABLE IF EXISTS `erp_category_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_category_mapping` (
  `id_erp_category_mapping` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_attribute_set` mediumint(8) unsigned DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `subcategory` varchar(255) DEFAULT NULL,
  `department_id_erp` mediumint(8) unsigned DEFAULT NULL,
  `sector_id_erp` mediumint(8) unsigned DEFAULT NULL,
  `product_family_id_erp` mediumint(8) unsigned DEFAULT NULL,
  `product_sub_family_id_erp` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_erp_category_mapping`),
  KEY `search` (`fk_catalog_attribute_set`,`category`,`subcategory`)
) ENGINE=InnoDB AUTO_INCREMENT=620 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_category_mapping`
--

LOCK TABLES `erp_category_mapping` WRITE;
/*!40000 ALTER TABLE `erp_category_mapping` DISABLE KEYS */;
INSERT INTO `erp_category_mapping` VALUES (1,1,'fashion_masculino','bota masc',1,1,1,201),(2,1,'fashion_masculino','chinelo/sandália',1,1,1,202),(3,1,'fashion_masculino','casual',1,1,1,204),(4,1,'fashion_masculino','sapatênis',1,1,1,205),(5,1,'fashion_masculino','social',1,1,1,206),(6,1,'fashion_masculino','tênis & esporte',1,1,1,205),(7,1,'fashion_masculino','moccasim',1,1,1,207),(8,1,'fashion_feminino','bota',1,1,2,101),(9,1,'fashion_feminino','mocassin',1,1,2,102),(10,1,'fashion_feminino','peep toe',1,1,2,103),(11,1,'fashion_feminino','rasteira',1,1,2,104),(12,1,'fashion_feminino','sandália',1,1,2,105),(13,1,'fashion_feminino','sapatilha',1,1,2,106),(14,1,'fashion_feminino','scarpin',1,1,2,107),(15,1,'fashion_feminino','tênis',1,1,2,108),(16,1,'fashion_feminino','oxford',1,1,2,109),(17,1,'fashion_feminino','chinelo',1,1,2,110),(18,1,'fashion_feminino','summer boot',1,1,2,111),(19,1,'fashion_feminino','ankle boot',1,1,2,112),(20,1,'fashion_masc_private_label','bota masc',1,1,3,201),(21,1,'fashion_masc_private_label','chinelo/sandália',1,1,3,202),(22,1,'fashion_masc_private_label','casual',1,1,3,204),(23,1,'fashion_masc_private_label','sapatênis/tênis',1,1,3,205),(24,1,'fashion_masc_private_label','social',1,1,3,206),(25,1,'fashion_masc_private_label','tênis & esporte',1,1,3,205),(26,1,'fashion_masc_private_label','moccasim',1,1,3,207),(27,1,'private_label_masculino','bota masc',1,1,3,201),(28,1,'private_label_masculino','chinelo/sandália',1,1,3,202),(29,1,'private_label_masculino','casual',1,1,3,204),(30,1,'private_label_masculino','sapatênis/tênis',1,1,3,205),(31,1,'private_label_masculino','social',1,1,3,206),(32,1,'private_label_masculino','tênis & esporte',1,1,3,205),(33,1,'private_label_masculino','moccasim',1,1,3,207),(34,1,'fashion_fem_private_label','bota',1,1,4,101),(35,1,'fashion_fem_private_label','mocassin',1,1,4,102),(36,1,'fashion_fem_private_label','peep toe',1,1,4,103),(37,1,'fashion_fem_private_label','rasteira',1,1,4,104),(38,1,'fashion_fem_private_label','sandália',1,1,4,105),(39,1,'fashion_fem_private_label','sapatilha',1,1,4,106),(40,1,'fashion_fem_private_label','scarpin',1,1,4,107),(41,1,'fashion_fem_private_label','tênis ',1,1,4,108),(42,1,'fashion_fem_private_label','oxford',1,1,4,109),(43,1,'fashion_fem_private_label','chinelo',1,1,4,110),(44,1,'fashion_fem_private_label','summer boot',1,1,4,111),(45,1,'fashion_fem_private_label','ankle boot',1,1,4,112),(46,1,'private_label_feminino','bota',1,1,4,101),(47,1,'private_label_feminino','mocassin',1,1,4,102),(48,1,'private_label_feminino','peep toe',1,1,4,103),(49,1,'private_label_feminino','rasteira',1,1,4,104),(50,1,'private_label_feminino','sandália',1,1,4,105),(51,1,'private_label_feminino','sapatilha',1,1,4,106),(52,1,'private_label_feminino','scarpin',1,1,4,107),(53,1,'private_label_feminino','tênis ',1,1,4,108),(54,1,'private_label_feminino','oxford',1,1,4,109),(55,1,'private_label_feminino','chinelo',1,1,4,110),(56,1,'private_label_feminino','summer boot',1,1,4,111),(57,1,'private_label_feminino','ankle boot',1,1,4,112),(58,1,'esporte_masculino','adventure',1,2,1,301),(59,1,'esporte_masculino','automobilismo',1,2,1,302),(60,1,'esporte_masculino','basquete',1,2,1,303),(61,1,'esporte_masculino','bike',1,2,1,304),(62,1,'esporte_masculino','fitness',1,2,1,305),(63,1,'esporte_masculino','futebol',1,2,1,306),(64,1,'esporte_masculino','lifestyle',1,2,1,307),(65,1,'esporte_masculino','life style',1,2,1,307),(66,1,'esporte_masculino','outros',1,2,1,308),(67,1,'esporte_masculino','performance',1,2,1,309),(68,1,'esporte_masculino','running',1,2,1,310),(69,1,'esporte_masculino','skate',1,2,1,311),(70,1,'esporte_masculino','tênis/squash',1,2,1,312),(71,1,'esporte_masculino','vôlei',1,2,1,313),(72,1,'esporte_feminino','adventure',1,2,2,401),(73,1,'esporte_feminino','automobilismo',1,2,2,402),(74,1,'esporte_feminino','basquete',1,2,2,403),(75,1,'esporte_feminino','bike',1,2,2,404),(76,1,'esporte_feminino','fitness',1,2,2,405),(77,1,'esporte_feminino','futebol',1,2,2,406),(78,1,'esporte_feminino','lifestyle',1,2,2,407),(79,1,'esporte_feminino','life style',1,2,2,407),(80,1,'esporte_feminino','outros',1,2,2,408),(81,1,'esporte_feminino','performance',1,2,2,409),(82,1,'esporte_feminino','running',1,2,2,410),(83,1,'esporte_feminino','skate',1,2,2,411),(84,1,'esporte_feminino','tênis/squash',1,2,2,412),(85,1,'esporte_feminino','vôlei',1,2,2,413),(86,1,'esporte_masc_private_label','adventure',1,2,3,301),(87,1,'esporte_masc_private_label','automobilismo',1,2,3,302),(88,1,'esporte_masc_private_label','basquete',1,2,3,303),(89,1,'esporte_masc_private_label','bike',1,2,3,304),(90,1,'esporte_masc_private_label','fitness',1,2,3,305),(91,1,'esporte_masc_private_label','futebol',1,2,3,306),(92,1,'esporte_masc_private_label','lifestyle',1,2,3,307),(93,1,'esporte_masc_private_label','life style',1,2,3,307),(94,1,'esporte_masc_private_label','outros',1,2,3,308),(95,1,'esporte_masc_private_label','performance',1,2,3,309),(96,1,'esporte_masc_private_label','running',1,2,3,310),(97,1,'esporte_masc_private_label','skate',1,2,3,311),(98,1,'esporte_masc_private_label','tênis/squash',1,2,3,312),(99,1,'esporte_masc_private_label','vôlei',1,2,3,313),(100,1,'esporte_private_label_masculino','adventure',1,2,3,301),(101,1,'esporte_private_label_masculino','automobilismo',1,2,3,302),(102,1,'esporte_private_label_masculino','basquete',1,2,3,303),(103,1,'esporte_private_label_masculino','bike',1,2,3,304),(104,1,'esporte_private_label_masculino','fitness',1,2,3,305),(105,1,'esporte_private_label_masculino','futebol',1,2,3,306),(106,1,'esporte_private_label_masculino','lifestyle',1,2,3,307),(107,1,'esporte_private_label_masculino','life style',1,2,3,307),(108,1,'esporte_private_label_masculino','outros',1,2,3,308),(109,1,'esporte_private_label_masculino','performance',1,2,3,309),(110,1,'esporte_private_label_masculino','running',1,2,3,310),(111,1,'esporte_private_label_masculino','skate',1,2,3,311),(112,1,'esporte_private_label_masculino','tênis/squash',1,2,3,312),(113,1,'esporte_private_label_masculino','vôlei',1,2,3,313),(114,1,'esporte_fem_private_label','adventure',1,2,4,401),(115,1,'esporte_fem_private_label','automobilismo',1,2,4,402),(116,1,'esporte_fem_private_label','basquete',1,2,4,403),(117,1,'esporte_fem_private_label','bike',1,2,4,404),(118,1,'esporte_fem_private_label','fitness',1,2,4,405),(119,1,'esporte_fem_private_label','futebol',1,2,4,406),(120,1,'esporte_fem_private_label','lifestyle',1,2,4,407),(121,1,'esporte_fem_private_label','life style',1,2,4,407),(122,1,'esporte_fem_private_label','outros',1,2,4,408),(123,1,'esporte_fem_private_label','performance',1,2,4,409),(124,1,'esporte_fem_private_label','running',1,2,4,410),(125,1,'esporte_fem_private_label','skate',1,2,4,411),(126,1,'esporte_fem_private_label','tênis/squash',1,2,4,412),(127,1,'esporte_fem_private_label','vôlei',1,2,4,413),(128,1,'esporte_private_label_feminino','adventure',1,2,4,401),(129,1,'esporte_private_label_feminino','automobilismo',1,2,4,402),(130,1,'esporte_private_label_feminino','basquete',1,2,4,403),(131,1,'esporte_private_label_feminino','bike',1,2,4,404),(132,1,'esporte_private_label_feminino','fitness',1,2,4,405),(133,1,'esporte_private_label_feminino','futebol',1,2,4,406),(134,1,'esporte_private_label_feminino','lifestyle',1,2,4,407),(135,1,'esporte_private_label_feminino','life style',1,2,4,407),(136,1,'esporte_private_label_feminino','outros',1,2,4,408),(137,1,'esporte_private_label_feminino','performance',1,2,4,409),(138,1,'esporte_private_label_feminino','running',1,2,4,410),(139,1,'esporte_private_label_feminino','skate',1,2,4,411),(140,1,'esporte_private_label_feminino','tênis/squash',1,2,4,412),(141,1,'esporte_private_label_feminino','vôlei',1,2,4,413),(142,1,'infantil_masculino','baby sapato',1,3,1,510),(143,1,'infantil_masculino','baby tênis',1,3,1,511),(144,1,'infantil_masculino','baby sandália ',1,3,1,512),(145,1,'infantil_masculino','baby chinelo',1,3,1,513),(146,1,'infantil_masculino','infantil sapato',1,3,1,502),(147,1,'infantil_masculino','infantil tênis',1,3,1,505),(148,1,'infantil_masculino','infantil sandália',1,3,1,507),(149,1,'infantil_masculino','infantil chinelo',1,3,1,509),(150,1,'fashion_masculino','baby sapato',1,3,1,510),(151,1,'fashion_masculino','baby tênis',1,3,1,511),(152,1,'fashion_masculino','baby sandália ',1,3,1,512),(153,1,'fashion_masculino','baby chinelo',1,3,1,513),(154,1,'fashion_masculino','infantil sapato',1,3,1,502),(155,1,'fashion_masculino','infantil tênis',1,3,1,505),(156,1,'fashion_masculino','infantil sandália',1,3,1,507),(157,1,'fashion_masculino','infantil chinelo',1,3,1,509),(158,1,'fashion_feminino','baby sapato',1,3,2,510),(159,1,'fashion_feminino','baby tênis',1,3,2,511),(160,1,'fashion_feminino','baby sandália ',1,3,2,512),(161,1,'fashion_feminino','baby chinelo',1,3,2,513),(162,1,'fashion_feminino','infantil sapato',1,3,2,503),(163,1,'fashion_feminino','infantil tênis',1,3,2,504),(164,1,'fashion_feminino','infantil sandália',1,3,2,506),(165,1,'fashion_feminino','infantil chinelo',1,3,2,508),(166,1,'infantil_feminino','baby sapato',1,3,2,510),(167,1,'infantil_feminino','baby tênis',1,3,2,511),(168,1,'infantil_feminino','baby sandália ',1,3,2,512),(169,1,'infantil_feminino','baby chinelo',1,3,2,513),(170,1,'infantil_feminino','infantil sapato',1,3,2,503),(171,1,'infantil_feminino','infantil tênis',1,3,2,504),(172,1,'infantil_feminino','infantil sandália',1,3,2,506),(173,1,'infantil_feminino','infantil chinelo',1,3,2,508),(174,1,'infantil_masc_private_label','baby sapato',1,3,3,510),(175,1,'infantil_masc_private_label','baby tênis',1,3,3,511),(176,1,'infantil_masc_private_label','baby sandália ',1,3,3,512),(177,1,'infantil_masc_private_label','baby chinelo',1,3,3,513),(178,1,'infantil_masc_private_label','infantil sapato',1,3,3,502),(179,1,'infantil_masc_private_label','infantil tênis',1,3,3,505),(180,1,'infantil_masc_private_label','infantil sandália',1,3,3,507),(181,1,'infantil_masc_private_label','infantil chinelo',1,3,3,509),(182,1,'private_label_masculino','baby sapato',1,3,3,510),(183,1,'private_label_masculino','baby tênis',1,3,3,511),(184,1,'private_label_masculino','baby sandália ',1,3,3,512),(185,1,'private_label_masculino','baby chinelo',1,3,3,513),(186,1,'private_label_masculino','infantil sapato',1,3,3,502),(187,1,'private_label_masculino','infantil tênis',1,3,3,505),(188,1,'private_label_masculino','infantil sandália',1,3,3,507),(189,1,'private_label_masculino','infantil chinelo',1,3,3,509),(190,1,'private_label_feminino','baby sapato',1,3,4,510),(191,1,'private_label_feminino','baby tênis',1,3,4,511),(192,1,'private_label_feminino','baby sandália ',1,3,4,512),(193,1,'private_label_feminino','baby chinelo',1,3,4,513),(194,1,'private_label_feminino','infantil sapato',1,3,4,503),(195,1,'private_label_feminino','infantil tênis',1,3,4,504),(196,1,'private_label_feminino','infantil sandália',1,3,4,506),(197,1,'private_label_feminino','infantil chinelo',1,3,4,508),(198,1,'infantil_fem_private_label','baby sapato',1,3,4,510),(199,1,'infantil_fem_private_label','baby tênis',1,3,4,511),(200,1,'infantil_fem_private_label','baby sandália ',1,3,4,512),(201,1,'infantil_fem_private_label','baby chinelo',1,3,4,513),(202,1,'infantil_fem_private_label','infantil sapato',1,3,4,503),(203,1,'infantil_fem_private_label','infantil tênis',1,3,4,504),(204,1,'infantil_fem_private_label','infantil sandália',1,3,4,506),(205,1,'infantil_fem_private_label','infantil chinelo',1,3,4,508),(206,2,'fashion_masculino','cinto',2,1,1,602),(207,2,'fashion_masculino','pasta',2,1,1,604),(208,2,'fashion_masculino','carteira',2,1,1,606),(209,2,'fashion_masculino','mochila/mala',2,1,1,607),(210,2,'fashion_masculino','necessaire',2,1,1,608),(211,2,'fashion_masculino','chapéu/boné',2,1,1,609),(212,2,'fashion_masculino','relógio',2,1,1,611),(213,2,'fashion_masculino','óculos',2,1,1,612),(214,2,'fashion_feminino','cinto',2,1,2,601),(215,2,'fashion_feminino','bolsa',2,1,2,603),(216,2,'fashion_feminino','carteira',2,1,2,605),(217,2,'fashion_feminino','mochila/mala',2,1,2,607),(218,2,'fashion_feminino','necessaire',2,1,2,608),(219,2,'fashion_feminino','chapéu/boné',2,1,2,609),(220,2,'fashion_feminino','bijuteria',2,1,2,610),(221,2,'fashion_feminino','relógio',2,1,2,611),(222,2,'fashion_feminino','óculos',2,1,2,612),(223,2,'fashion_masculino_private_label','cinto',2,1,3,602),(224,2,'fashion_masculino_private_label','pasta',2,1,3,604),(225,2,'fashion_masculino_private_label','carteira',2,1,3,606),(226,2,'fashion_masculino_private_label','mochila/mala',2,1,3,607),(227,2,'fashion_masculino_private_label','necessaire',2,1,3,608),(228,2,'fashion_masculino_private_label','chapéu/boné',2,1,3,609),(229,2,'fashion_masculino_private_label','relógio',2,1,3,611),(230,2,'fashion_masculino_private_label','óculos',2,1,3,612),(231,2,'fashion_feminino_private_label','cinto',2,1,4,601),(232,2,'fashion_feminino_private_label','bolsa',2,1,4,603),(233,2,'fashion_feminino_private_label','carteira',2,1,4,605),(234,2,'fashion_feminino_private_label','mochila/mala',2,1,4,607),(235,2,'fashion_feminino_private_label','necessaire',2,1,4,608),(236,2,'fashion_feminino_private_label','chapéu/boné',2,1,4,609),(237,2,'fashion_feminino_private_label','bijuteria',2,1,4,610),(238,2,'fashion_feminino_private_label','relógio',2,1,4,611),(239,2,'fashion_feminino_private_label','óculos',2,1,4,612),(240,2,'esportes_masculino','carteira',2,2,1,606),(241,2,'esportes_masculino','mochila/mala',2,2,1,607),(242,2,'esportes_masculino','necessaire',2,2,1,608),(243,2,'esportes_masculino','chapéu/boné',2,2,1,609),(244,2,'esportes_masculino','relógio',2,2,1,611),(245,2,'esportes_masculino','óculos',2,2,1,612),(246,2,'esportes_feminino','bolsa',2,2,2,603),(247,2,'esportes_feminino','carteira',2,2,2,605),(248,2,'esportes_feminino','mochila/mala',2,2,2,607),(249,2,'esportes_feminino','necessaire',2,2,2,608),(250,2,'esportes_feminino','chapéu/boné',2,2,2,609),(251,2,'esportes_feminino','bijuteria',2,2,2,610),(252,2,'esportes_feminino','relógio',2,2,2,611),(253,2,'esportes_feminino','óculos',2,2,2,612),(254,2,'esportes_masculino_private_label','carteira',2,2,3,606),(255,2,'esportes_masculino_private_label','mochila/mala',2,2,3,607),(256,2,'esportes_masculino_private_label','necessaire',2,2,3,608),(257,2,'esportes_masculino_private_label','chapéu/boné',2,2,3,609),(258,2,'esportes_masculino_private_label','relógio',2,2,3,611),(259,2,'esportes_masculino_private_label','óculos',2,2,3,612),(260,2,'esportes_feminino_private_label','bolsa',2,2,4,603),(261,2,'esportes_feminino_private_label','carteira',2,2,4,605),(262,2,'esportes_feminino_private_label','mochila/mala',2,2,4,607),(263,2,'esportes_feminino_private_label','necessaire',2,2,4,608),(264,2,'esportes_feminino_private_label','chapéu/boné',2,2,4,609),(265,2,'esportes_feminino_private_label','bijuteria',2,2,4,610),(266,2,'esportes_feminino_private_label','relógio',2,2,4,611),(267,2,'esportes_feminino_private_label','óculos',2,2,4,612),(268,2,'infantil_masculino','cinto',2,3,1,602),(269,2,'infantil_masculino','pasta',2,3,1,604),(270,2,'infantil_masculino','carteira',2,3,1,606),(271,2,'infantil_masculino','mochila/mala',2,3,1,607),(272,2,'infantil_masculino','necessaire',2,3,1,608),(273,2,'infantil_masculino','chapéu/boné',2,3,1,609),(274,2,'infantil_masculino','relógio',2,3,1,611),(275,2,'infantil_masculino','óculos',2,3,1,612),(276,2,'infantil_feminino','cinto',2,3,2,601),(277,2,'infantil_feminino','bolsa',2,3,2,603),(278,2,'infantil_feminino','carteira',2,3,2,605),(279,2,'infantil_feminino','mochila/mala',2,3,2,607),(280,2,'infantil_feminino','necessaire',2,3,2,608),(281,2,'infantil_feminino','chapéu/boné',2,3,2,609),(282,2,'infantil_feminino','bijuteria',2,3,2,610),(283,2,'infantil_feminino','relógio',2,3,2,611),(284,2,'infantil_feminino','óculos',2,3,2,612),(285,2,'infantil_masculino_private_label','cinto',2,3,3,602),(286,2,'infantil_masculino_private_label','pasta',2,3,3,604),(287,2,'infantil_masculino_private_label','carteira',2,3,3,606),(288,2,'infantil_masculino_private_label','mochila/mala',2,3,3,607),(289,2,'infantil_masculino_private_label','necessaire',2,3,3,608),(290,2,'infantil_masculino_private_label','chapéu/boné',2,3,3,609),(291,2,'infantil_masculino_private_label','relógio',2,3,3,611),(292,2,'infantil_masculino_private_label','óculos',2,3,3,612),(293,2,'infantil_feminino_private_label','cinto',2,3,4,601),(294,2,'infantil_feminino_private_label','bolsa',2,3,4,603),(295,2,'infantil_feminino_private_label','carteira',2,3,4,605),(296,2,'infantil_feminino_private_label','mochila/mala',2,3,4,607),(297,2,'infantil_feminino_private_label','necessaire',2,3,4,608),(298,2,'infantil_feminino_private_label','chapéu/boné',2,3,4,609),(299,2,'infantil_feminino_private_label','bijuteria',2,3,4,610),(300,2,'infantil_feminino_private_label','relógio',2,3,4,611),(301,2,'infantil_feminino_private_label','óculos',2,3,4,612),(302,3,'fashion_masculino','camiseta sem manga',3,1,1,1201),(303,3,'fashion_masculino','camiseta manga curta',3,1,1,1202),(304,3,'fashion_masculino','camiseta manga longa',3,1,1,1203),(305,3,'fashion_masculino','camisa polo',3,1,1,1204),(306,3,'fashion_masculino','camisa social',3,1,1,1205),(307,3,'fashion_masculino','camisa casual',3,1,1,1206),(308,3,'fashion_masculino','casaco/jaqueta',3,1,1,1207),(309,3,'fashion_masculino','malha/sueter',3,1,1,1208),(310,3,'fashion_masculino','calça jeans',3,1,1,1209),(311,3,'fashion_masculino','calça casual',3,1,1,1210),(312,3,'fashion_masculino','calça social',3,1,1,1211),(313,3,'fashion_masculino','bermuda/shorts',3,1,1,1212),(314,3,'fashion_feminino','blusa regata',3,1,2,1101),(315,3,'fashion_feminino','blusa manga curta',3,1,2,1102),(316,3,'fashion_feminino','blusa manga longa',3,1,2,1103),(317,3,'fashion_feminino','camisa polo',3,1,2,1104),(318,3,'fashion_feminino','camisa manga curta/longa',3,1,2,1105),(319,3,'fashion_feminino','casaco/jaqueta',3,1,2,1106),(320,3,'fashion_feminino','malha/sueter',3,1,2,1107),(321,3,'fashion_feminino','calça jeans',3,1,2,1108),(322,3,'fashion_feminino','calça casual',3,1,2,1109),(323,3,'fashion_feminino','calça social',3,1,2,1110),(324,3,'fashion_feminino','shorts',3,1,2,1111),(325,3,'fashion_feminino','bermuda',3,1,2,1112),(326,3,'fashion_feminino','saia (outra)',3,1,2,1113),(327,3,'fashion_feminino','mini saia',3,1,2,1114),(328,3,'fashion_feminino','vestido curto',3,1,2,1115),(329,3,'fashion_feminino','vestido longo',3,1,2,1116),(330,3,'fashion_feminino','macacão/macaquinho',3,1,2,1117),(331,3,'fashion_feminino','colete',3,1,2,1118),(332,3,'fashion_masculino_private_label','camiseta sem manga',3,1,3,1201),(333,3,'fashion_masculino_private_label','camiseta manga curta',3,1,3,1202),(334,3,'fashion_masculino_private_label','camiseta manga longa',3,1,3,1203),(335,3,'fashion_masculino_private_label','camisa polo',3,1,3,1204),(336,3,'fashion_masculino_private_label','camisa social',3,1,3,1205),(337,3,'fashion_masculino_private_label','camisa casual',3,1,3,1206),(338,3,'fashion_masculino_private_label','casaco/jaqueta',3,1,3,1207),(339,3,'fashion_masculino_private_label','malha/sueter',3,1,3,1208),(340,3,'fashion_masculino_private_label','calça jeans',3,1,3,1209),(341,3,'fashion_masculino_private_label','calça casual',3,1,3,1210),(342,3,'fashion_masculino_private_label','calça social',3,1,3,1211),(343,3,'fashion_masculino_private_label','bermuda/shorts',3,1,3,1212),(344,3,'fashion_feminino_private_label','blusa regata',3,1,4,1101),(345,3,'fashion_feminino_private_label','blusa manga curta',3,1,4,1102),(346,3,'fashion_feminino_private_label','blusa manga longa',3,1,4,1103),(347,3,'fashion_feminino_private_label','camisa polo',3,1,4,1104),(348,3,'fashion_feminino_private_label','camisa manga curta/longa',3,1,4,1105),(349,3,'fashion_feminino_private_label','casaco/jaqueta',3,1,4,1106),(350,3,'fashion_feminino_private_label','malha/sueter',3,1,4,1107),(351,3,'fashion_feminino_private_label','calça jeans',3,1,4,1108),(352,3,'fashion_feminino_private_label','calça casual',3,1,4,1109),(353,3,'fashion_feminino_private_label','calça social',3,1,4,1110),(354,3,'fashion_feminino_private_label','shorts',3,1,4,1111),(355,3,'fashion_feminino_private_label','bermuda',3,1,4,1112),(356,3,'fashion_feminino_private_label','saia (outra)',3,1,4,1113),(357,3,'fashion_feminino_private_label','mini saia',3,1,4,1114),(358,3,'fashion_feminino_private_label','vestido curto',3,1,4,1115),(359,3,'fashion_feminino_private_label','vestido longo',3,1,4,1116),(360,3,'fashion_feminino_private_label','macacão/macaquinho',3,1,4,1117),(361,3,'fashion_feminino_private_label','colete',3,1,4,1118),(362,3,'esportes_masculino','camiseta manga curta',3,2,1,1301),(363,3,'esportes_masculino','camiseta manga longa',3,2,1,1302),(364,3,'esportes_masculino','camiseta regata/sem manga',3,2,1,1303),(365,3,'esportes_masculino','camiseta polo',3,2,1,1304),(366,3,'esportes_masculino','camiseta time',3,2,1,1305),(367,3,'esportes_masculino','calça',3,2,1,1306),(368,3,'esportes_masculino','bermuda',3,2,1,1307),(369,3,'esportes_masculino','shorts',3,2,1,1308),(370,3,'esportes_masculino','blusão/jaqueta',3,2,1,1309),(371,3,'esportes_masculino','agasalho (conj.)',3,2,1,1310),(372,3,'esportes_feminino','blusa manga curta',3,2,2,1401),(373,3,'esportes_feminino','blusa manga longa',3,2,2,1402),(374,3,'esportes_feminino','blusa regata',3,2,2,1403),(375,3,'esportes_feminino','blusa polo',3,2,2,1404),(376,3,'esportes_feminino','calça',3,2,2,1405),(377,3,'esportes_feminino','calça legging',3,2,2,1406),(378,3,'esportes_feminino','calça corsário',3,2,2,1407),(379,3,'esportes_feminino','bermuda/shorts',3,2,2,1408),(380,3,'esportes_feminino','macacão/macaquinho',3,2,2,1409),(381,3,'esportes_feminino','jaqueta',3,2,2,1410),(382,3,'esportes_feminino','top',3,2,2,1411),(383,3,'esportes_feminino','maiô de natação',3,2,2,1412),(384,3,'esportes_feminino','saia',3,2,2,1413),(385,3,'esportes_feminino','agasalho (conj.)',3,2,2,1414),(386,3,'esportes_masculino_private_label','camiseta manga curta',3,2,3,1301),(387,3,'esportes_masculino_private_label','camiseta manga longa',3,2,3,1302),(388,3,'esportes_masculino_private_label','camiseta regata/sem manga',3,2,3,1303),(389,3,'esportes_masculino_private_label','camiseta polo',3,2,3,1304),(390,3,'esportes_masculino_private_label','camiseta time',3,2,3,1305),(391,3,'esportes_masculino_private_label','calça',3,2,3,1306),(392,3,'esportes_masculino_private_label','bermuda',3,2,3,1307),(393,3,'esportes_masculino_private_label','shorts',3,2,3,1308),(394,3,'esportes_masculino_private_label','blusão/jaqueta',3,2,3,1309),(395,3,'esportes_masculino_private_label','agasalho (conj.)',3,2,3,1310),(396,3,'esportes_feminino_private_label','blusa manga curta',3,2,4,1401),(397,3,'esportes_feminino_private_label','blusa manga longa',3,2,4,1402),(398,3,'esportes_feminino_private_label','blusa regata',3,2,4,1403),(399,3,'esportes_feminino_private_label','blusa polo',3,2,4,1404),(400,3,'esportes_feminino_private_label','calça',3,2,4,1405),(401,3,'esportes_feminino_private_label','calça legging',3,2,4,1406),(402,3,'esportes_feminino_private_label','calça corsário',3,2,4,1407),(403,3,'esportes_feminino_private_label','bermuda/shorts',3,2,4,1408),(404,3,'esportes_feminino_private_label','macacão/macaquinho',3,2,4,1409),(405,3,'esportes_feminino_private_label','jaqueta',3,2,4,1410),(406,3,'esportes_feminino_private_label','top',3,2,4,1411),(407,3,'esportes_feminino_private_label','maiô de natação',3,2,4,1412),(408,3,'esportes_feminino_private_label','saia',3,2,4,1413),(409,3,'esportes_feminino_private_label','agasalho (conj.)',3,2,4,1414),(410,3,'infantil_masculino','baby - body',3,3,1,1501),(411,3,'infantil_masculino','baby - blusa/camiseta',3,3,1,1502),(412,3,'infantil_masculino','baby - calça',3,3,1,1503),(413,3,'infantil_masculino','baby - short/bermuda/saia',3,3,1,1504),(414,3,'infantil_masculino','baby - casaco/jaqueta',3,3,1,1505),(415,3,'infantil_masculino','baby - malha/sueter',3,3,1,1506),(416,3,'infantil_masculino','baby - conjunto ',3,3,1,1507),(417,3,'infantil_masculino','baby - vestido',3,3,1,1508),(418,3,'infantil_masculino','baby - puericultura',3,3,1,1509),(419,3,'infantil_masculino','baby  - macaquinho',3,3,1,1510),(420,3,'infantil_masculino','baby  - macacão',3,3,1,1511),(421,3,'infantil_masculino','baby  - salopete/jardineira',3,3,1,1512),(422,3,'infantil_masculino','baby  - pijama',3,3,1,1513),(423,3,'infantil_masculino','infantil - camiseta regata/sem manga',3,3,1,1527),(424,3,'infantil_masculino','infantil - camiseta manga curta/longa',3,3,1,1528),(425,3,'infantil_masculino','infantil - camisa manga curta/longa',3,3,1,1529),(426,3,'infantil_masculino','infantil - camisa polo',3,3,1,1530),(427,3,'infantil_masculino','infantil - calça',3,3,1,1531),(428,3,'infantil_masculino','infantil - calça jeans',3,3,1,1532),(429,3,'infantil_masculino','infantil - short/bermuda',3,3,1,1533),(430,3,'infantil_masculino','infantil - casaco/jaqueta',3,3,1,1534),(431,3,'infantil_masculino','infantil - malha/sueter',3,3,1,1535),(432,3,'infantil_masculino','infantil - conjunto',3,3,1,1536),(433,3,'infantil_masculino','infantil - macaquinho/jardineira',3,3,1,1537),(434,3,'infantil_masculino','infantil - pijama',3,3,1,1538),(435,3,'infantil_masculino','baby - brinquedo',3,3,1,1539),(436,3,'infantil_masculino','baby sunga',3,3,1,1540),(437,3,'infantil_masculino','baby - sunga',3,3,1,1540),(438,3,'infantil_masculino','infantil - brinquedo',3,3,1,1550),(439,3,'infantil_masculino','infantil - sunga',3,3,1,1551),(440,3,'infantil_masculino','baby - toalha',3,3,1,1554),(441,3,'infantil_masculino','baby - escoval',3,3,1,1555),(442,3,'infantil_masculino','baby - touca',3,3,1,1556),(443,3,'infantil_masculino','baby - roupão',3,3,1,1557),(444,3,'infantil_masculino','infantil - roupão',3,3,1,1558),(445,3,'infantil_feminino','baby - body',3,3,2,1501),(446,3,'infantil_feminino','baby - blusa/camiseta',3,3,2,1502),(447,3,'infantil_feminino','baby - calça',3,3,2,1503),(448,3,'infantil_feminino','baby - short/bermuda/saia',3,3,2,1504),(449,3,'infantil_feminino','baby - casaco/jaqueta',3,3,2,1505),(450,3,'infantil_feminino','baby - malha/sueter',3,3,2,1506),(451,3,'infantil_feminino','baby - conjunto ',3,3,2,1507),(452,3,'infantil_feminino','baby - vestido',3,3,2,1508),(453,3,'infantil_feminino','baby - puericultura',3,3,2,1509),(454,3,'infantil_feminino','baby  - macaquinho',3,3,2,1510),(455,3,'infantil_feminino','baby  - macacão',3,3,2,1511),(456,3,'infantil_feminino','baby  - salopete/jardineira',3,3,2,1512),(457,3,'infantil_feminino','baby  - pijama',3,3,2,1513),(458,3,'infantil_feminino','infantil - blusa regata/sem manga',3,3,2,1514),(459,3,'infantil_feminino','infantil - blusa manga curta/longa',3,3,2,1515),(460,3,'infantil_feminino','infantil - camisa/camisa polo',3,3,2,1516),(461,3,'infantil_feminino','infantil - calça',3,3,2,1517),(462,3,'infantil_feminino','infantil - calça jeans',3,3,2,1518),(463,3,'infantil_feminino','infantil - short/bermuda',3,3,2,1519),(464,3,'infantil_feminino','infantil - casaco/jaqueta',3,3,2,1520),(465,3,'infantil_feminino','infantil - malha/sueter',3,3,2,1521),(466,3,'infantil_feminino','infantil - conjunto',3,3,2,1522),(467,3,'infantil_feminino','infantil - vestido',3,3,2,1523),(468,3,'infantil_feminino','infantil - saia',3,3,2,1524),(469,3,'infantil_feminino','infantil - macaquinho/jardineira/salopete',3,3,2,1525),(470,3,'infantil_feminino','infantil - pijama/camisola',3,3,2,1526),(471,3,'infantil_feminino','baby - brinquedo',3,3,2,1539),(472,3,'infantil_feminino','baby - sunga',3,3,2,1540),(473,3,'infantil_feminino','baby - biquíni',3,3,2,1541),(474,3,'infantil_feminino','baby - maîo',3,3,2,1542),(475,3,'infantil_feminino','infantil - brinquedo',3,3,2,1550),(476,3,'infantil_feminino','infantil - sunga',3,3,2,1551),(477,3,'infantil_feminino','infantil - biquíni',3,3,2,1552),(478,3,'infantil_feminino','infantil - maîo',3,3,2,1553),(479,3,'infantil_feminino','baby - toalha',3,3,2,1554),(480,3,'infantil_feminino','baby - escoval',3,3,2,1555),(481,3,'infantil_feminino','baby - touca',3,3,2,1556),(482,3,'infantil_feminino','baby - roupão',3,3,2,1557),(483,3,'infantil_feminino','infantil - roupão',3,3,2,1558),(484,3,'infantil_masculino_private_label','baby - body',3,3,3,1501),(485,3,'infantil_masculino_private_label','baby - blusa/camiseta',3,3,3,1502),(486,3,'infantil_masculino_private_label','baby - calça',3,3,3,1503),(487,3,'infantil_masculino_private_label','baby - short/bermuda/saia',3,3,3,1504),(488,3,'infantil_masculino_private_label','baby - casaco/jaqueta',3,3,3,1505),(489,3,'infantil_masculino_private_label','baby - malha/sueter',3,3,3,1506),(490,3,'infantil_masculino_private_label','baby - conjunto ',3,3,3,1507),(491,3,'infantil_masculino_private_label','baby - vestido',3,3,3,1508),(492,3,'infantil_masculino_private_label','baby - puericultura',3,3,3,1509),(493,3,'infantil_masculino_private_label','baby  - macaquinho',3,3,3,1510),(494,3,'infantil_masculino_private_label','baby  - macacão',3,3,3,1511),(495,3,'infantil_masculino_private_label','baby  - salopete/jardineira',3,3,3,1512),(496,3,'infantil_masculino_private_label','baby  - pijama',3,3,3,1513),(497,3,'infantil_masculino_private_label','infantil - camiseta regata/sem manga',3,3,3,1527),(498,3,'infantil_masculino_private_label','infantil - camiseta manga curta/longa',3,3,3,1528),(499,3,'infantil_masculino_private_label','infantil - camisa manga curta/longa',3,3,3,1529),(500,3,'infantil_masculino_private_label','infantil - camisa polo',3,3,3,1530),(501,3,'infantil_masculino_private_label','infantil - calça',3,3,3,1531),(502,3,'infantil_masculino_private_label','infantil - calça jeans',3,3,3,1532),(503,3,'infantil_masculino_private_label','infantil - short/bermuda',3,3,3,1533),(504,3,'infantil_masculino_private_label','infantil - casaco/jaqueta',3,3,3,1534),(505,3,'infantil_masculino_private_label','infantil - malha/sueter',3,3,3,1535),(506,3,'infantil_masculino_private_label','infantil - conjunto',3,3,3,1536),(507,3,'infantil_masculino_private_label','infantil - macaquinho/jardineira',3,3,3,1537),(508,3,'infantil_masculino_private_label','infantil - pijama',3,3,3,1538),(509,3,'infantil_masculino_private_label','baby - brinquedo',3,3,3,1539),(510,3,'infantil_masculino_private_label','baby sunga',3,3,3,1540),(511,3,'infantil_masculino_private_label','baby - sunga',3,3,3,1540),(512,3,'infantil_masculino_private_label','infantil - brinquedo',3,3,3,1550),(513,3,'infantil_masculino_private_label','infantil - sunga',3,3,3,1551),(514,3,'infantil_masculino_private_label','baby - toalha',3,3,3,1554),(515,3,'infantil_masculino_private_label','baby - escoval',3,3,3,1555),(516,3,'infantil_masculino_private_label','baby - touca',3,3,3,1556),(517,3,'infantil_masculino_private_label','baby - roupão',3,3,3,1557),(518,3,'infantil_masculino_private_label','infantil - roupão',3,3,3,1558),(519,3,'infantil_feminino_private_label','baby - body',3,3,4,1501),(520,3,'infantil_feminino_private_label','baby - blusa/camiseta',3,3,4,1502),(521,3,'infantil_feminino_private_label','baby - calça',3,3,4,1503),(522,3,'infantil_feminino_private_label','baby - short/bermuda/saia',3,3,4,1504),(523,3,'infantil_feminino_private_label','baby - casaco/jaqueta',3,3,4,1505),(524,3,'infantil_feminino_private_label','baby - malha/sueter',3,3,4,1506),(525,3,'infantil_feminino_private_label','baby - conjunto ',3,3,4,1507),(526,3,'infantil_feminino_private_label','baby - vestido',3,3,4,1508),(527,3,'infantil_feminino_private_label','baby - puericultura',3,3,4,1509),(528,3,'infantil_feminino_private_label','baby  - macaquinho',3,3,4,1510),(529,3,'infantil_feminino_private_label','baby  - macacão',3,3,4,1511),(530,3,'infantil_feminino_private_label','baby  - salopete/jardineira',3,3,4,1512),(531,3,'infantil_feminino_private_label','baby  - pijama',3,3,4,1513),(532,3,'infantil_feminino_private_label','infantil - blusa regata/sem manga',3,3,4,1514),(533,3,'infantil_feminino_private_label','infantil - blusa manga curta/longa',3,3,4,1515),(534,3,'infantil_feminino_private_label','infantil - camisa/camisa polo',3,3,4,1516),(535,3,'infantil_feminino_private_label','infantil - calça',3,3,4,1517),(536,3,'infantil_feminino_private_label','infantil - calça jeans',3,3,4,1518),(537,3,'infantil_feminino_private_label','infantil - short/bermuda',3,3,4,1519),(538,3,'infantil_feminino_private_label','infantil - casaco/jaqueta',3,3,4,1520),(539,3,'infantil_feminino_private_label','infantil - malha/sueter',3,3,4,1521),(540,3,'infantil_feminino_private_label','infantil - conjunto',3,3,4,1522),(541,3,'infantil_feminino_private_label','infantil - vestido',3,3,4,1523),(542,3,'infantil_feminino_private_label','infantil - saia',3,3,4,1524),(543,3,'infantil_feminino_private_label','infantil - macaquinho/jardineira/salopete',3,3,4,1525),(544,3,'infantil_feminino_private_label','infantil - pijama/camisola',3,3,4,1526),(545,3,'infantil_feminino_private_label','baby - brinquedo',3,3,4,1539),(546,3,'infantil_feminino_private_label','baby - sunga',3,3,4,1540),(547,3,'infantil_feminino_private_label','baby - biquíni',3,3,4,1541),(548,3,'infantil_feminino_private_label','baby - maîo',3,3,4,1542),(549,3,'infantil_feminino_private_label','infantil - brinquedo',3,3,4,1550),(550,3,'infantil_feminino_private_label','infantil - sunga',3,3,4,1551),(551,3,'infantil_feminino_private_label','infantil - biquíni',3,3,4,1552),(552,3,'infantil_feminino_private_label','infantil - maîo',3,3,4,1553),(553,3,'infantil_feminino_private_label','baby - toalha',3,3,4,1554),(554,3,'infantil_feminino_private_label','baby - escoval',3,3,4,1555),(555,3,'infantil_feminino_private_label','baby - touca',3,3,4,1556),(556,3,'infantil_feminino_private_label','baby - roupão',3,3,4,1557),(557,3,'infantil_feminino_private_label','infantil - roupão',3,3,4,1558),(558,3,'underwear_beachwear_masculino','pijama',3,4,1,1615),(559,3,'underwear_beachwear_masculino','roupão',3,4,1,1616),(560,3,'underwear_beachwear_masculino','cueca boxer/samba canção',3,4,1,1617),(561,3,'underwear_beachwear_masculino','cueca slip',3,4,1,1618),(562,3,'underwear_beachwear_masculino','cueca sunga',3,4,1,1619),(563,3,'underwear_beachwear_masculino','cueca kit',3,4,1,1620),(564,3,'underwear_beachwear_masculino','meia social',3,4,1,1621),(565,3,'underwear_beachwear_masculino','meia esportiva',3,4,1,1622),(566,3,'underwear_beachwear_masculino','meia casual',3,4,1,1623),(567,3,'underwear_beachwear_masculino','meia kit',3,4,1,1624),(568,3,'underwear_beachwear_masculino','praia sunga',3,4,1,1704),(569,3,'underwear_beachwear_masculino','praia bermuda de banho',3,4,1,1705),(570,3,'underwear_beachwear_masculino','praia infantil',3,4,1,1706),(571,3,'underwear_beachwear_feminino','lingerie sexy top',3,4,2,1601),(572,3,'underwear_beachwear_feminino','lingerie sexy botton',3,4,2,1602),(573,3,'underwear_beachwear_feminino','lingerie básico top',3,4,2,1603),(574,3,'underwear_beachwear_feminino','lingerie básico botton',3,4,2,1604),(575,3,'underwear_beachwear_feminino','lingerie dia-a-dia top',3,4,2,1605),(576,3,'underwear_beachwear_feminino','lingerie dia-a-dia botton',3,4,2,1606),(577,3,'underwear_beachwear_feminino','camisola',3,4,2,1607),(578,3,'underwear_beachwear_feminino','baby doll/short doll',3,4,2,1608),(579,3,'underwear_beachwear_feminino','pijama',3,4,2,1609),(580,3,'underwear_beachwear_feminino','roupão',3,4,2,1610),(581,3,'underwear_beachwear_feminino','meia calça',3,4,2,1611),(582,3,'underwear_beachwear_feminino','meia soquete',3,4,2,1612),(583,3,'underwear_beachwear_feminino','meia esportiva',3,4,2,1613),(584,3,'underwear_beachwear_feminino','meia kit',3,4,2,1614),(585,3,'underwear_beachwear_feminino','praia biquini',3,4,2,1701),(586,3,'underwear_beachwear_feminino','praia maiô',3,4,2,1702),(587,3,'underwear_beachwear_feminino','praia saída de praia',3,4,2,1702),(588,3,'underwear_beachwear_feminino','praia infantil',3,4,2,1706),(589,3,'underwear_beachwear_masculino_private_label','pijama',3,4,3,1615),(590,3,'underwear_beachwear_masculino_private_label','roupão',3,4,3,1616),(591,3,'underwear_beachwear_masculino_private_label','cueca boxer/samba canção',3,4,3,1617),(592,3,'underwear_beachwear_masculino_private_label','cueca slip',3,4,3,1618),(593,3,'underwear_beachwear_masculino_private_label','cueca sunga',3,4,3,1619),(594,3,'underwear_beachwear_masculino_private_label','cueca kit',3,4,3,1620),(595,3,'underwear_beachwear_masculino_private_label','meia social',3,4,3,1621),(596,3,'underwear_beachwear_masculino_private_label','meia esportiva',3,4,3,1622),(597,3,'underwear_beachwear_masculino_private_label','meia casual',3,4,3,1623),(598,3,'underwear_beachwear_masculino_private_label','meia kit',3,4,3,1624),(599,3,'underwear_beachwear_masculino_private_label','praia sunga',3,4,3,1704),(600,3,'underwear_beachwear_masculino_private_label','praia bermuda de banho',3,4,3,1705),(601,3,'underwear_beachwear_masculino_private_label','praia infantil',3,4,3,1706),(602,3,'underwear/beachwear_feminino_private_label','lingerie sexy top',3,4,4,1601),(603,3,'underwear/beachwear_feminino_private_label','lingerie sexy botton',3,4,4,1602),(604,3,'underwear/beachwear_feminino_private_label','lingerie básico top',3,4,4,1603),(605,3,'underwear/beachwear_feminino_private_label','lingerie básico botton',3,4,4,1604),(606,3,'underwear/beachwear_feminino_private_label','lingerie dia-a-dia top',3,4,4,1605),(607,3,'underwear/beachwear_feminino_private_label','lingerie dia-a-dia botton',3,4,4,1606),(608,3,'underwear/beachwear_feminino_private_label','camisola',3,4,4,1607),(609,3,'underwear/beachwear_feminino_private_label','baby doll/short doll',3,4,4,1608),(610,3,'underwear/beachwear_feminino_private_label','pijama',3,4,4,1609),(611,3,'underwear/beachwear_feminino_private_label','roupão',3,4,4,1610),(612,3,'underwear/beachwear_feminino_private_label','meia calça',3,4,4,1611),(613,3,'underwear/beachwear_feminino_private_label','meia soquete',3,4,4,1612),(614,3,'underwear/beachwear_feminino_private_label','meia esportiva',3,4,4,1613),(615,3,'underwear/beachwear_feminino_private_label','meia kit',3,4,4,1614),(616,3,'underwear/beachwear_feminino_private_label','praia biquini',3,4,4,1701),(617,3,'underwear/beachwear_feminino_private_label','praia maiô',3,4,4,1702),(618,3,'underwear/beachwear_feminino_private_label','praia saída de praia',3,4,4,1702),(619,3,'underwear/beachwear_feminino_private_label','praia infantil',3,4,4,1706);
/*!40000 ALTER TABLE `erp_category_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_freight_table`
--

DROP TABLE IF EXISTS `erp_freight_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_freight_table` (
  `id_erp_freight_table` int(11) NOT NULL AUTO_INCREMENT,
  `freight_table_id` int(11) NOT NULL,
  `subsidiary_cnpj` bigint(20) NOT NULL,
  `carrier_id` bigint(20) NOT NULL,
  `contract_id` varchar(100) NOT NULL,
  `carrier_name` varchar(100) NOT NULL,
  `region_id` int(11) NOT NULL,
  `zip_start` int(11) NOT NULL,
  `zip_end` int(11) NOT NULL,
  `weight_start` decimal(16,5) NOT NULL,
  `weight_end` decimal(16,5) NOT NULL,
  `volume_max` decimal(10,2) NOT NULL,
  `costs_min` decimal(10,2) NOT NULL,
  `costs_multiplicator` decimal(10,2) NOT NULL,
  `ad_valorem_dury` decimal(10,2) DEFAULT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `transit_time` int(3) NOT NULL,
  `dimensional_weight` decimal(10,5) NOT NULL,
  `delivery_type` tinyint(3) NOT NULL,
  `transportation_type` tinyint(4) NOT NULL,
  `cod_period` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_erp_freight_table`),
  KEY `ik_erp_freight_table` (`zip_start`,`zip_end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_freight_table`
--

LOCK TABLES `erp_freight_table` WRITE;
/*!40000 ALTER TABLE `erp_freight_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `erp_freight_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_status_map_customer`
--

DROP TABLE IF EXISTS `erp_status_map_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_status_map_customer` (
  `id_erp_status_map_customer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `erp_status` varchar(255) NOT NULL,
  `fk_customer_shipment_status` int(10) unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_erp_status_map_customer`),
  UNIQUE KEY `erp_status` (`erp_status`),
  KEY `fk_customer_shipment_status` (`fk_customer_shipment_status`),
  CONSTRAINT `fk_customer_shipment_status_for_erp_map` FOREIGN KEY (`fk_customer_shipment_status`) REFERENCES `customer_shipment_status` (`id_customer_shipment_status`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='Status map focused on customer';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_status_map_customer`
--

LOCK TABLES `erp_status_map_customer` WRITE;
/*!40000 ALTER TABLE `erp_status_map_customer` DISABLE KEYS */;
INSERT INTO `erp_status_map_customer` VALUES (1,'AAP',14,'2013-02-28 13:25:22'),(2,'ACR',2,'2013-02-28 13:25:22'),(3,'AES',20,'2013-02-28 13:25:22'),(4,'AGE',9,'2013-02-28 13:25:22'),(5,'AMC',2,'2013-02-28 13:25:22'),(6,'ART',1,'2013-02-28 13:25:22'),(7,'ATR',4,'2013-02-28 13:25:22'),(8,'AUS',5,'2013-02-28 13:25:22'),(9,'AVA',4,'2013-02-28 13:25:22'),(10,'CAN',7,'2013-02-28 13:25:22'),(11,'CRD',4,'2013-02-28 13:25:22'),(12,'CRF',5,'2013-02-28 13:25:22'),(13,'CRI',4,'2013-02-28 13:25:22'),(14,'DCN',4,'2013-02-28 13:25:22'),(15,'DCR',4,'2013-02-28 13:25:22'),(16,'DDE',5,'2013-02-28 13:25:22'),(17,'DES',4,'2013-02-28 13:25:22'),(18,'DEV',4,'2013-02-28 13:25:22'),(19,'DND',4,'2013-02-28 13:25:22'),(20,'DNF',5,'2013-02-28 13:25:22'),(21,'DNM',4,'2013-02-28 13:25:22'),(22,'EA1',5,'2013-02-28 13:25:22'),(23,'EA2',5,'2013-02-28 13:25:22'),(24,'EA3',4,'2013-02-28 13:25:22'),(25,'EAA',9,'2013-02-28 13:25:22'),(26,'EAT',8,'2013-02-28 13:25:22'),(27,'EEB',9,'2013-02-28 13:25:22'),(28,'EGA',9,'2013-02-28 13:25:22'),(29,'EGB',9,'2013-02-28 13:25:22'),(30,'EGN',4,'2013-02-28 13:25:22'),(31,'ENT',8,'2013-02-28 13:25:22'),(32,'ESU',4,'2013-02-28 13:25:22'),(33,'ETR',10,'2013-02-28 13:25:22'),(34,'FIS',16,'2013-02-28 13:25:22'),(35,'NFDEN',6,'2013-02-28 13:25:22'),(36,'NFDES',6,'2013-02-28 13:25:22'),(37,'NFE',11,'2013-02-28 13:25:22'),(38,'PAP',12,'2013-02-28 13:25:22'),(39,'PDV',4,'2013-02-28 13:25:22'),(40,'PEI',3,'2013-02-28 13:25:22'),(41,'PEN',4,'2013-02-28 13:25:22'),(42,'PEP',4,'2013-02-28 13:25:22'),(43,'PEV',4,'2013-02-28 13:25:22'),(44,'PNA',13,'2013-02-28 13:25:22'),(45,'REC',17,'2013-02-28 13:25:22'),(46,'REV',13,'2013-02-28 13:25:22'),(47,'RIE',15,'2013-02-28 13:25:22'),(48,'ROU',4,'2013-02-28 13:25:22'),(49,'SDE',19,'2013-02-28 13:25:22'),(50,'TDS',1,'2013-02-28 13:25:22'),(51,'VES',20,'2013-02-28 13:25:22'),(52,'WMS',18,'2013-02-28 13:25:22'),(53,'NFS',11,'2012-08-10 13:30:00');
/*!40000 ALTER TABLE `erp_status_map_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_status_map_order`
--

DROP TABLE IF EXISTS `erp_status_map_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_status_map_order` (
  `id_erp_status_map_order` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `erp_status` varchar(255) NOT NULL,
  `fk_sales_order_item_status` int(10) unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_erp_status_map_order`),
  UNIQUE KEY `erp_status` (`erp_status`),
  KEY `fk_order_item_order_status` (`fk_sales_order_item_status`),
  CONSTRAINT `fk_sales_order_item_status_for_erp_map` FOREIGN KEY (`fk_sales_order_item_status`) REFERENCES `sales_order_item_status` (`id_sales_order_item_status`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='Status map focused on customer';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_status_map_order`
--

LOCK TABLES `erp_status_map_order` WRITE;
/*!40000 ALTER TABLE `erp_status_map_order` DISABLE KEYS */;
INSERT INTO `erp_status_map_order` VALUES (1,'PRE',14,'2013-02-28 13:25:23'),(2,'ETA',6,'2013-02-28 13:25:23'),(3,'ASD',12,'2013-02-28 13:25:23'),(4,'PNA',9,'2013-02-28 13:25:23'),(5,'ALS',5,'2013-02-28 13:25:23'),(6,'REV',9,'2013-02-28 13:25:23'),(7,'AGE',5,'2013-02-28 13:25:23'),(8,'EGB',5,'2013-02-28 13:25:23'),(9,'CAN',9,'2013-02-28 13:25:23'),(10,'ATR',5,'2013-02-28 13:25:23'),(11,'AUS',5,'2013-02-28 13:25:23'),(12,'AUN',5,'2013-02-28 13:25:23'),(13,'CRD',5,'2013-02-28 13:25:23'),(14,'CRF',5,'2013-02-28 13:25:23'),(15,'CRI',5,'2013-02-28 13:25:23'),(16,'CRR',5,'2013-02-28 13:25:23'),(17,'DCN',5,'2013-02-28 13:25:23'),(18,'DCR',5,'2013-02-28 13:25:23'),(19,'DDE',5,'2013-02-28 13:25:23'),(20,'DES',5,'2013-02-28 13:25:23'),(21,'DND',5,'2013-02-28 13:25:23'),(22,'DNF',5,'2013-02-28 13:25:23'),(23,'DNM',5,'2013-02-28 13:25:23'),(24,'DSC',5,'2013-02-28 13:25:23'),(25,'DSR',5,'2013-02-28 13:25:23'),(26,'EA1',5,'2013-02-28 13:25:23'),(27,'EA2',5,'2013-02-28 13:25:23'),(28,'EA3',5,'2013-02-28 13:25:23'),(29,'EAA',5,'2013-02-28 13:25:23'),(30,'EEB',5,'2013-02-28 13:25:23'),(31,'EGA',5,'2013-02-28 13:25:23'),(32,'EGN',5,'2013-02-28 13:25:23'),(33,'EPT',5,'2013-02-28 13:25:23'),(34,'ESU',5,'2013-02-28 13:25:23'),(35,'EXT',5,'2013-02-28 13:25:23'),(36,'FIS',5,'2013-02-28 13:25:23'),(37,'PDV',5,'2013-02-28 13:25:23'),(38,'PEN',5,'2013-02-28 13:25:23'),(39,'PEV',5,'2013-02-28 13:25:23'),(40,'RDC',5,'2013-02-28 13:25:23'),(41,'AVA',7,'2013-02-28 13:25:23'),(42,'PEP',7,'2013-02-28 13:25:23'),(43,'ROU',7,'2013-02-28 13:25:23'),(44,'RDV',8,'2013-02-28 13:25:23'),(45,'RIE',8,'2013-02-28 13:25:23'),(46,'DEV',8,'2013-02-28 13:25:23'),(47,'ETR',5,'2013-02-28 13:25:23'),(48,'ENT',6,'2013-02-28 13:25:23');
/*!40000 ALTER TABLE `erp_status_map_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_webservice_token`
--

DROP TABLE IF EXISTS `erp_webservice_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `erp_webservice_token` (
  `id_erp_webservice_token` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_erp_webservice_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_webservice_token`
--

LOCK TABLES `erp_webservice_token` WRITE;
/*!40000 ALTER TABLE `erp_webservice_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `erp_webservice_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_campaign`
--

DROP TABLE IF EXISTS `gift_campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_campaign` (
  `id_gift_campaign` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `conditions_url` varchar(255) DEFAULT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `obs` varchar(255) DEFAULT NULL,
  `stock_alert` int(11) DEFAULT NULL,
  `email_alert` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_gift_campaign`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gift_campaign`
--

LOCK TABLES `gift_campaign` WRITE;
/*!40000 ALTER TABLE `gift_campaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `gift_campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_campaign_order`
--

DROP TABLE IF EXISTS `gift_campaign_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_campaign_order` (
  `id_gift_campaign_order` int(11) NOT NULL AUTO_INCREMENT,
  `fk_gift_campaign` int(11) NOT NULL,
  `fk_sales_order` int(10) unsigned NOT NULL,
  `fk_sales_order_item` int(10) unsigned NOT NULL,
  `sku_simple` text,
  PRIMARY KEY (`id_gift_campaign_order`),
  KEY `fk_gift_campaign_idx` (`fk_gift_campaign`),
  KEY `fk_sales_order_idx` (`fk_sales_order`),
  KEY `fk_sales_order_item_idx` (`fk_sales_order_item`),
  CONSTRAINT `gift_campaign_order_ibfk_3` FOREIGN KEY (`fk_sales_order_item`) REFERENCES `sales_order_item` (`id_sales_order_item`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `gift_campaign_order_ibfk_1` FOREIGN KEY (`fk_gift_campaign`) REFERENCES `gift_campaign` (`id_gift_campaign`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `gift_campaign_order_ibfk_2` FOREIGN KEY (`fk_sales_order`) REFERENCES `sales_order` (`id_sales_order`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gift_campaign_order`
--

LOCK TABLES `gift_campaign_order` WRITE;
/*!40000 ALTER TABLE `gift_campaign_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `gift_campaign_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_campaign_reward`
--

DROP TABLE IF EXISTS `gift_campaign_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_campaign_reward` (
  `id_gift_campaign_reward` int(11) NOT NULL AUTO_INCREMENT,
  `fk_gift_campaign_selector` int(11) NOT NULL,
  `sku` text NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id_gift_campaign_reward`),
  KEY `fk_gift_campaign_gift_gift_campaign_selector1_idx` (`fk_gift_campaign_selector`),
  CONSTRAINT `fk_gift_campaign_gift_gift_campaign_selector1` FOREIGN KEY (`fk_gift_campaign_selector`) REFERENCES `gift_campaign_selector` (`id_gift_campaign_selector`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gift_campaign_reward`
--

LOCK TABLES `gift_campaign_reward` WRITE;
/*!40000 ALTER TABLE `gift_campaign_reward` DISABLE KEYS */;
/*!40000 ALTER TABLE `gift_campaign_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_campaign_selector`
--

DROP TABLE IF EXISTS `gift_campaign_selector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_campaign_selector` (
  `id_gift_campaign_selector` int(11) NOT NULL AUTO_INCREMENT,
  `fk_gift_campaign` int(11) NOT NULL,
  `start_amount` decimal(8,2) DEFAULT NULL,
  `end_amount` decimal(8,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `sku` text,
  `brand` text,
  `attribute_set` text,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_gift_campaign_selector`),
  KEY `fk_gift_campaign_selector_gift_campaign_idx` (`fk_gift_campaign`),
  CONSTRAINT `fk_gift_campaign_selector_gift_campaign` FOREIGN KEY (`fk_gift_campaign`) REFERENCES `gift_campaign` (`id_gift_campaign`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gift_campaign_selector`
--

LOCK TABLES `gift_campaign_selector` WRITE;
/*!40000 ALTER TABLE `gift_campaign_selector` DISABLE KEYS */;
/*!40000 ALTER TABLE `gift_campaign_selector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupon_brand_blacklist`
--

DROP TABLE IF EXISTS `groupon_brand_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupon_brand_blacklist` (
  `id_groupon_brand_blacklist` int(10) NOT NULL AUTO_INCREMENT,
  `fk_brand_id` int(10) unsigned DEFAULT NULL,
  `fk_groupon_campaing_id` int(10) NOT NULL,
  PRIMARY KEY (`id_groupon_brand_blacklist`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupon_brand_blacklist`
--

LOCK TABLES `groupon_brand_blacklist` WRITE;
/*!40000 ALTER TABLE `groupon_brand_blacklist` DISABLE KEYS */;
INSERT INTO `groupon_brand_blacklist` VALUES (1,5,2),(2,7,2),(3,10,3);
/*!40000 ALTER TABLE `groupon_brand_blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupon_campaing`
--

DROP TABLE IF EXISTS `groupon_campaing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupon_campaing` (
  `id_groupon_campaing` int(10) NOT NULL AUTO_INCREMENT,
  `ref_campaing` varchar(254) DEFAULT NULL,
  `name` varchar(254) NOT NULL,
  `description` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `usage_limit` int(10) unsigned NOT NULL,
  `value_amount` decimal(10,2) NOT NULL,
  `value_discount` decimal(10,2) NOT NULL,
  `value_dafiti` decimal(10,2) NOT NULL,
  `minimum_amount` varchar(254) NOT NULL,
  PRIMARY KEY (`id_groupon_campaing`),
  UNIQUE KEY `ref_campaing` (`ref_campaing`),
  KEY `id_groupon_campaing` (`id_groupon_campaing`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupon_campaing`
--

LOCK TABLES `groupon_campaing` WRITE;
/*!40000 ALTER TABLE `groupon_campaing` DISABLE KEYS */;
INSERT INTO `groupon_campaing` VALUES (1,'999038','campaing_name','campaing_description',1,'0000-00-00','0000-00-00',50,29.90,49.90,39.90,'60');
/*!40000 ALTER TABLE `groupon_campaing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupon_category_blacklist`
--

DROP TABLE IF EXISTS `groupon_category_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupon_category_blacklist` (
  `id_groupon_category_blacklist` int(10) NOT NULL AUTO_INCREMENT,
  `fk_category_id` int(10) unsigned DEFAULT NULL,
  `fk_groupon_campaing_id` int(10) NOT NULL,
  PRIMARY KEY (`id_groupon_category_blacklist`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupon_category_blacklist`
--

LOCK TABLES `groupon_category_blacklist` WRITE;
/*!40000 ALTER TABLE `groupon_category_blacklist` DISABLE KEYS */;
INSERT INTO `groupon_category_blacklist` VALUES (1,201,1),(2,231,1),(3,207,2);
/*!40000 ALTER TABLE `groupon_category_blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupon_code`
--

DROP TABLE IF EXISTS `groupon_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupon_code` (
  `id_groupon_code` int(10) NOT NULL AUTO_INCREMENT,
  `fk_groupon_campaing` int(10) NOT NULL,
  `code` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `times_used` tinyint(2) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime NOT NULL,
  PRIMARY KEY (`id_groupon_code`),
  KEY `code` (`code`),
  KEY `fk_groupon_campaing` (`fk_groupon_campaing`),
  KEY `id_groupon_code` (`id_groupon_code`),
  CONSTRAINT `groupon_code_ibfk_1` FOREIGN KEY (`fk_groupon_campaing`) REFERENCES `groupon_campaing` (`id_groupon_campaing`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupon_code`
--

LOCK TABLES `groupon_code` WRITE;
/*!40000 ALTER TABLE `groupon_code` DISABLE KEYS */;
INSERT INTO `groupon_code` VALUES (1,1,'999038;259/6678;D9AD6DBC90',0,0,'0000-00-00','0000-00-00','0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,1,'999038;259/4469;F3GH1CDT51',1,0,'0000-00-00','0000-00-00','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `groupon_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_boleto_sales_notification`
--

DROP TABLE IF EXISTS `mail_boleto_sales_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_boleto_sales_notification` (
  `id_mail_boleto_sales_notification` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order_item` int(10) NOT NULL,
  `fk_customer` int(10) unsigned NOT NULL,
  `fk_catalog_simple` int(10) NOT NULL,
  `lowest_price` decimal(10,2) NOT NULL,
  `former_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_mail_boleto_sales_notification`),
  UNIQUE KEY `uk_customer_catalog_simple` (`fk_customer`,`fk_catalog_simple`),
  KEY `fk_customer_idx` (`fk_customer`),
  KEY `fk_catalog_simple_idx` (`fk_catalog_simple`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_boleto_sales_notification`
--

LOCK TABLES `mail_boleto_sales_notification` WRITE;
/*!40000 ALTER TABLE `mail_boleto_sales_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_boleto_sales_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_reminder_boleto`
--

DROP TABLE IF EXISTS `mail_reminder_boleto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_reminder_boleto` (
  `id_mail_reminder_boleto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order` int(10) unsigned NOT NULL,
  `number` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_mail_reminder_boleto`),
  KEY `fk_sales_order_idx` (`fk_sales_order`),
  CONSTRAINT `mail_reminder_boleto_ibfk_1` FOREIGN KEY (`fk_sales_order`) REFERENCES `sales_order` (`id_sales_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_reminder_boleto`
--

LOCK TABLES `mail_reminder_boleto` WRITE;
/*!40000 ALTER TABLE `mail_reminder_boleto` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_reminder_boleto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_reminder_canceledboletos`
--

DROP TABLE IF EXISTS `mail_reminder_canceledboletos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_reminder_canceledboletos` (
  `id_mail_reminder_canceledboletos` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order` int(10) unsigned NOT NULL,
  `number` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_mail_reminder_canceledboletos`),
  KEY `fk_sales_order_idx` (`fk_sales_order`),
  CONSTRAINT `mail_reminder_canceledboletos_ibfk_1` FOREIGN KEY (`fk_sales_order`) REFERENCES `sales_order` (`id_sales_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_reminder_canceledboletos`
--

LOCK TABLES `mail_reminder_canceledboletos` WRITE;
/*!40000 ALTER TABLE `mail_reminder_canceledboletos` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_reminder_canceledboletos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_reminder_cartdropout`
--

DROP TABLE IF EXISTS `mail_reminder_cartdropout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_reminder_cartdropout` (
  `id_mail_reminder_cartdropout` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_customer` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT '1',
  `sku` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `price` double DEFAULT '0',
  PRIMARY KEY (`id_mail_reminder_cartdropout`),
  KEY `fk_customer_idx` (`fk_customer`),
  CONSTRAINT `mail_reminder_cartdropout_ibfk_1` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_reminder_cartdropout`
--

LOCK TABLES `mail_reminder_cartdropout` WRITE;
/*!40000 ALTER TABLE `mail_reminder_cartdropout` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_reminder_cartdropout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_reminder_restock`
--

DROP TABLE IF EXISTS `mail_reminder_restock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_reminder_restock` (
  `id_mail_reminder_restock` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_customer` int(10) unsigned NOT NULL,
  `fk_catalog_simple` int(10) unsigned NOT NULL,
  `number` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_mail_reminder_restock`),
  KEY `fk_customer_idx` (`fk_customer`),
  KEY `fk_catalog_simple_idx` (`fk_catalog_simple`),
  CONSTRAINT `mail_reminder_restock_ibfk_1` FOREIGN KEY (`fk_catalog_simple`) REFERENCES `catalog_simple` (`id_catalog_simple`),
  CONSTRAINT `mail_reminder_restock_ibfk_2` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_reminder_restock`
--

LOCK TABLES `mail_reminder_restock` WRITE;
/*!40000 ALTER TABLE `mail_reminder_restock` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_reminder_restock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_reminder_review`
--

DROP TABLE IF EXISTS `mail_reminder_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_reminder_review` (
  `id_mail_reminder_review` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order_item` int(10) NOT NULL,
  `fk_customer` int(10) unsigned NOT NULL,
  `fk_catalog_simple` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_mail_reminder_review`),
  KEY `fk_customer_idx` (`fk_customer`),
  KEY `fk_catalog_simple_idx` (`fk_catalog_simple`),
  KEY `fk_sales_order_item` (`fk_sales_order_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_reminder_review`
--

LOCK TABLES `mail_reminder_review` WRITE;
/*!40000 ALTER TABLE `mail_reminder_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_reminder_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_reminder_wishlist`
--

DROP TABLE IF EXISTS `mail_reminder_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_reminder_wishlist` (
  `id_mail_reminder_wishlist` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_customer_wishlist` int(10) unsigned NOT NULL,
  `number` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_mail_reminder_wishlist`),
  KEY `fk_customer_wishlist_idx` (`fk_customer_wishlist`),
  CONSTRAINT `mail_reminder_wishlist_ibfk_1` FOREIGN KEY (`fk_customer_wishlist`) REFERENCES `customer_wishlist` (`id_customer_wishlist`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_reminder_wishlist`
--

LOCK TABLES `mail_reminder_wishlist` WRITE;
/*!40000 ALTER TABLE `mail_reminder_wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_reminder_wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter_subscription`
--

DROP TABLE IF EXISTS `newsletter_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_subscription` (
  `id_newsletter_subscription` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_customer` int(10) unsigned DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `unsubscribe_key` varchar(32) NOT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` enum('subscribed','unsubscribed') NOT NULL DEFAULT 'subscribed',
  `gender` enum('female','male') NOT NULL DEFAULT 'female',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `prudsys_id` varchar(32) DEFAULT NULL,
  `id_store` tinyint(3) unsigned DEFAULT '1',
  PRIMARY KEY (`id_newsletter_subscription`),
  UNIQUE KEY `uniqueUnsubscribed` (`unsubscribe_key`),
  UNIQUE KEY `uniqueEmailStore` (`email`,`id_store`),
  KEY `index_email` (`email`),
  KEY `fk_customer` (`fk_customer`),
  CONSTRAINT `newsletter_subscription_ibfk_1` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`id_customer`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter_subscription`
--

LOCK TABLES `newsletter_subscription` WRITE;
/*!40000 ALTER TABLE `newsletter_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `newsletter_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter_subscription_cms_shop`
--

DROP TABLE IF EXISTS `newsletter_subscription_cms_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_subscription_cms_shop` (
  `id_newsletter_subscription_cms_shop` int(11) NOT NULL AUTO_INCREMENT,
  `fk_newsletter_subscription` int(10) unsigned NOT NULL,
  `fk_cms_shop` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id_newsletter_subscription_cms_shop`),
  UNIQUE KEY `fk_newsletter_subscription_fk_cms_shop` (`fk_newsletter_subscription`,`fk_cms_shop`),
  KEY `fk_newsletter_subscription` (`fk_newsletter_subscription`),
  KEY `fk_cms_shop` (`fk_cms_shop`),
  CONSTRAINT `newsletter_subscription_cms_shop_ibfk_1` FOREIGN KEY (`fk_newsletter_subscription`) REFERENCES `newsletter_subscription` (`id_newsletter_subscription`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `newsletter_subscription_cms_shop_ibfk_2` FOREIGN KEY (`fk_cms_shop`) REFERENCES `cms_shop` (`id_cms_shop`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter_subscription_cms_shop`
--

LOCK TABLES `newsletter_subscription_cms_shop` WRITE;
/*!40000 ALTER TABLE `newsletter_subscription_cms_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `newsletter_subscription_cms_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `id_notification` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `message` varchar(2048) DEFAULT NULL,
  `tag` varchar(127) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_notification`),
  KEY `i_title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `old_cart`
--

DROP TABLE IF EXISTS `old_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_cart` (
  `id_old_cart` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fk_customer` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `fk_store_store` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_old_cart`),
  KEY `fk_customer` (`fk_customer`),
  KEY `fk_store_store` (`fk_store_store`),
  CONSTRAINT `old_cart_ibfk_2` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `old_cart_ibfk_1` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`id_customer`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `old_cart`
--

LOCK TABLES `old_cart` WRITE;
/*!40000 ALTER TABLE `old_cart` DISABLE KEYS */;
INSERT INTO `old_cart` VALUES (1,1111,'2012-08-01 20:00:01','a65s4d6ae15ff8ae43a',1,1),(2,1111,'2017-01-01 10:00:01','45as64d64f8e1a36',1,1),(3,2222,'2016-08-01 20:00:01','45as64d64fsfasf8e1a36',2,1),(4,2222,'2011-08-01 20:00:01','45as64d64f6s54s8e1a36',1,1),(5,3333,'2012-08-01 20:00:01','45as646fas4fsa5asd64f8e1a36',1,0);
/*!40000 ALTER TABLE `old_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `old_cart_item`
--

DROP TABLE IF EXISTS `old_cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_cart_item` (
  `id_old_cart_item` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sku_simple` varchar(255) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `fk_old_cart` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_old_cart_item`),
  KEY `fk_old_cart` (`fk_old_cart`),
  CONSTRAINT `old_cart_item_ibfk_1` FOREIGN KEY (`fk_old_cart`) REFERENCES `old_cart` (`id_old_cart`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `old_cart_item`
--

LOCK TABLES `old_cart_item` WRITE;
/*!40000 ALTER TABLE `old_cart_item` DISABLE KEYS */;
INSERT INTO `old_cart_item` VALUES (1,'VI282SHF81SOC-52',1,1),(2,'VHHHHSHF81SOC-52',2,1),(3,'KFGHFLDJH9857-65',2,3),(4,'KKHFLDJH9857-65',1,3),(5,'KKHFLDJH9857-65',1,5),(6,'VI282SHF81SOC-52',1,5);
/*!40000 ALTER TABLE `old_cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parcel_tracking`
--

DROP TABLE IF EXISTS `parcel_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parcel_tracking` (
  `id_parcel_tracking` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `carrier_name` varchar(255) DEFAULT NULL,
  `tracking_base_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_parcel_tracking`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='This is a meta-table, representing all shipping providers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parcel_tracking`
--

LOCK TABLES `parcel_tracking` WRITE;
/*!40000 ALTER TABLE `parcel_tracking` DISABLE KEYS */;
INSERT INTO `parcel_tracking` VALUES (1,NULL,NULL);
/*!40000 ALTER TABLE `parcel_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner`
--

DROP TABLE IF EXISTS `partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner` (
  `id_partner` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(100) NOT NULL,
  `name` varchar(150) NOT NULL,
  `hash` text NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_partner`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner`
--

LOCK TABLES `partner` WRITE;
/*!40000 ALTER TABLE `partner` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postcode_correios`
--

DROP TABLE IF EXISTS `postcode_correios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcode_correios` (
  `id_postcode_correios` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cep` varchar(16) NOT NULL,
  `street` varchar(200) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `region` varchar(4) DEFAULT NULL,
  `neighborhood` varchar(144) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_postcode_correios`),
  UNIQUE KEY `cep` (`cep`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postcode_correios`
--

LOCK TABLES `postcode_correios` WRITE;
/*!40000 ALTER TABLE `postcode_correios` DISABLE KEYS */;
INSERT INTO `postcode_correios` VALUES (1,'04642000','Alameda Sarutaiá','São Paulo','SP','Jardim Paulista','2011-12-14 12:00:57'),(2,'08452010','Alameda Jururu','São Paulo','SP','Vila Beto Barbosa','2011-12-15 12:00:57');
/*!40000 ALTER TABLE `postcode_correios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating_aggregated`
--

DROP TABLE IF EXISTS `rating_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_aggregated` (
  `id_rating_aggregated` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  `total` float NOT NULL,
  `single` varchar(255) NOT NULL,
  PRIMARY KEY (`id_rating_aggregated`),
  UNIQUE KEY `uk_rating_type` (`fk_catalog_config`),
  CONSTRAINT `fk_catalog_config1` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating_aggregated`
--

LOCK TABLES `rating_aggregated` WRITE;
/*!40000 ALTER TABLE `rating_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating_option`
--

DROP TABLE IF EXISTS `rating_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_option` (
  `id_rating_option` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_rating_type` int(10) unsigned NOT NULL,
  `code` varchar(25) NOT NULL,
  `value` tinyint(4) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rating_option`),
  UNIQUE KEY `uk_rating_option` (`fk_rating_type`,`position`),
  KEY `fk_rating_option_rating1` (`fk_rating_type`),
  CONSTRAINT `fk_rating_option_rating1` FOREIGN KEY (`fk_rating_type`) REFERENCES `rating_type` (`id_rating_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating_option`
--

LOCK TABLES `rating_option` WRITE;
/*!40000 ALTER TABLE `rating_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating_review`
--

DROP TABLE IF EXISTS `rating_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_review` (
  `id_rating_review` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_catalog_config` int(10) unsigned NOT NULL,
  `fk_customer` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `detail` text NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `status` enum('APPROVED','PENDING','REJECTED') NOT NULL DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rating_review`),
  KEY `fk_review_customer` (`fk_customer`),
  KEY `fk_rating_review_catalog_config1` (`fk_catalog_config`),
  CONSTRAINT `fk_rating_review_catalog_config1` FOREIGN KEY (`fk_catalog_config`) REFERENCES `catalog_config` (`id_catalog_config`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_customer` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`id_customer`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating_review`
--

LOCK TABLES `rating_review` WRITE;
/*!40000 ALTER TABLE `rating_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating_review_has_option`
--

DROP TABLE IF EXISTS `rating_review_has_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_review_has_option` (
  `id_rating_review_has_option` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_rating_review` int(10) unsigned NOT NULL,
  `fk_rating_option` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_rating_review_has_option`),
  UNIQUE KEY `uk_rating_option_vote` (`fk_rating_review`,`fk_rating_option`),
  KEY `fk_rating_option_vote_review` (`fk_rating_review`),
  KEY `fk_rating_option_vote_rating_option1` (`fk_rating_option`),
  CONSTRAINT `fk_rating_option_vote_review1` FOREIGN KEY (`fk_rating_review`) REFERENCES `rating_review` (`id_rating_review`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_option_vote_rating_option1` FOREIGN KEY (`fk_rating_option`) REFERENCES `rating_option` (`id_rating_option`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating_review_has_option`
--

LOCK TABLES `rating_review_has_option` WRITE;
/*!40000 ALTER TABLE `rating_review_has_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating_review_has_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating_type`
--

DROP TABLE IF EXISTS `rating_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_type` (
  `id_rating_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `title` varchar(50) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rating_type`),
  UNIQUE KEY `uk_rating_type` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating_type`
--

LOCK TABLES `rating_type` WRITE;
/*!40000 ALTER TABLE `rating_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `real_freight_cost_file`
--

DROP TABLE IF EXISTS `real_freight_cost_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `real_freight_cost_file` (
  `id_real_freight_cost_file` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL,
  PRIMARY KEY (`id_real_freight_cost_file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `real_freight_cost_file`
--

LOCK TABLES `real_freight_cost_file` WRITE;
/*!40000 ALTER TABLE `real_freight_cost_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `real_freight_cost_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `real_freight_cost_list`
--

DROP TABLE IF EXISTS `real_freight_cost_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `real_freight_cost_list` (
  `id_real_freight_cost_list` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fk_real_freight_cost_file` int(11) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `delivery_number` int(11) NOT NULL,
  `real_weight` decimal(5,2) NOT NULL,
  `weight_considered` decimal(5,2) NOT NULL,
  `gris` decimal(5,2) NOT NULL,
  `advalorem` decimal(5,2) NOT NULL,
  `freight` decimal(5,2) NOT NULL,
  `icms` decimal(5,2) NOT NULL,
  `pis_cofins` decimal(5,2) NOT NULL,
  `gross_shipping` decimal(5,2) NOT NULL,
  `liquid_shipping` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id_real_freight_cost_list`),
  KEY `fk_real_freight_cost_file` (`fk_real_freight_cost_file`),
  CONSTRAINT `real_freight_cost_list_ibfk_1` FOREIGN KEY (`fk_real_freight_cost_file`) REFERENCES `real_freight_cost_file` (`id_real_freight_cost_file`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `real_freight_cost_list`
--

LOCK TABLES `real_freight_cost_list` WRITE;
/*!40000 ALTER TABLE `real_freight_cost_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `real_freight_cost_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation_last_update_timestamp`
--

DROP TABLE IF EXISTS `recommendation_last_update_timestamp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recommendation_last_update_timestamp` (
  `id_recommendation_last_update_timestamp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_recommendation_last_update_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation_last_update_timestamp`
--

LOCK TABLES `recommendation_last_update_timestamp` WRITE;
/*!40000 ALTER TABLE `recommendation_last_update_timestamp` DISABLE KEYS */;
/*!40000 ALTER TABLE `recommendation_last_update_timestamp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminder_mail`
--

DROP TABLE IF EXISTS `reminder_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminder_mail` (
  `id_reminder` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_id_reminder_type` tinyint(3) unsigned NOT NULL,
  `context_id` int(11) NOT NULL,
  `last_sent_datetime` datetime NOT NULL,
  PRIMARY KEY (`id_reminder`),
  KEY `sheduled` (`context_id`,`last_sent_datetime`),
  KEY `fk_reminder_mail_reminder_type` (`fk_id_reminder_type`),
  CONSTRAINT `fk_reminder_mail_reminder_type` FOREIGN KEY (`fk_id_reminder_type`) REFERENCES `reminder_type` (`id_reminder_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminder_mail`
--

LOCK TABLES `reminder_mail` WRITE;
/*!40000 ALTER TABLE `reminder_mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminder_mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminder_size_product`
--

DROP TABLE IF EXISTS `reminder_size_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminder_size_product` (
  `id_reminder_size_product` int(10) NOT NULL AUTO_INCREMENT,
  `fk_reminder_size_user` int(10) DEFAULT NULL,
  `skus` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'active',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_reminder_size_product`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminder_size_product`
--

LOCK TABLES `reminder_size_product` WRITE;
/*!40000 ALTER TABLE `reminder_size_product` DISABLE KEYS */;
INSERT INTO `reminder_size_product` VALUES (1,1,'SKU-1-01','sended','2013-02-28 10:33:32'),(2,1,'SKU-1-02','active','2013-02-28 10:33:32'),(3,2,'SKU-1-03','active','2013-02-28 10:33:32'),(4,3,'SKU-1-01','removed','2001-01-01 00:00:00');
/*!40000 ALTER TABLE `reminder_size_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminder_size_user`
--

DROP TABLE IF EXISTS `reminder_size_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminder_size_user` (
  `id_reminder_size_user` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_reminder_size_user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminder_size_user`
--

LOCK TABLES `reminder_size_user` WRITE;
/*!40000 ALTER TABLE `reminder_size_user` DISABLE KEYS */;
INSERT INTO `reminder_size_user` VALUES (1,'UserTest','test@dafiti.com.br','2013-02-28 10:33:32'),(2,'UserTest2','test2@dafiti.com.br','2013-02-28 10:33:32'),(3,'OldUser','old@dafiti.com.br','2013-02-28 10:33:32');
/*!40000 ALTER TABLE `reminder_size_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminder_type`
--

DROP TABLE IF EXISTS `reminder_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminder_type` (
  `id_reminder_type` tinyint(3) unsigned NOT NULL,
  `type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_reminder_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminder_type`
--

LOCK TABLES `reminder_type` WRITE;
/*!40000 ALTER TABLE `reminder_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminder_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order`
--

DROP TABLE IF EXISTS `sales_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order` (
  `id_sales_order` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order_address_billing` int(10) unsigned NOT NULL,
  `fk_sales_order_address_shipping` int(10) unsigned NOT NULL,
  `fk_customer` int(10) unsigned NOT NULL,
  `mage_customer_entity_id` int(10) unsigned DEFAULT NULL,
  `mage_order_entity_id` int(10) unsigned DEFAULT NULL,
  `customer_first_name` varchar(255) DEFAULT NULL,
  `customer_last_name` varchar(255) DEFAULT NULL,
  `customer_email` varchar(255) NOT NULL,
  `order_nr` varchar(45) DEFAULT NULL,
  `customer_session_id` varchar(255) DEFAULT NULL,
  `store_id` smallint(6) DEFAULT NULL,
  `original_grand_total` decimal(10,2) NOT NULL,
  `original_tax_amount` decimal(10,2) NOT NULL,
  `original_base_shipping_amount` decimal(10,2) DEFAULT '0.00',
  `shipping_method` varchar(255) DEFAULT NULL,
  `coupon_code` varchar(50) DEFAULT NULL,
  `payment_method` varchar(20) NOT NULL,
  `gift_option` enum('t','f') DEFAULT 'f',
  `gift_message` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cc_paid` tinyint(4) DEFAULT NULL,
  `fk_shipping_carrier` int(11) DEFAULT NULL,
  `tracking_url` mediumtext,
  `otrs_ticket` varchar(255) DEFAULT NULL,
  `fk_sales_order_process` int(10) unsigned NOT NULL DEFAULT '1',
  `shipping_discount_amount` decimal(10,0) DEFAULT NULL,
  `refund_voucher_code` varchar(100) DEFAULT NULL,
  `refund_voucher_amount` decimal(10,2) DEFAULT NULL,
  `ip` varchar(64) NOT NULL,
  `is_paid` tinyint(4) DEFAULT NULL,
  `channel` varchar(4) DEFAULT NULL,
  `id_telesales_user` int(6) DEFAULT NULL,
  `groupon_code` varchar(100) DEFAULT NULL,
  `groupon_amount` decimal(10,2) DEFAULT NULL,
  `host_domain` varchar(100) DEFAULT NULL,
  `nfe_key` varchar(255) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `delivery_maximum_approval_date_time` date DEFAULT NULL,
  `delivery_type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_sales_order`),
  UNIQUE KEY `UNIQUE_ORDER_NR` (`order_nr`),
  KEY `fk_order_address` (`fk_sales_order_address_billing`),
  KEY `fk_order_address1` (`fk_sales_order_address_shipping`),
  KEY `fk_sales_order_process` (`fk_sales_order_process`),
  KEY `fk_customer` (`fk_customer`),
  CONSTRAINT `fk_order_address` FOREIGN KEY (`fk_sales_order_address_billing`) REFERENCES `sales_order_address` (`id_sales_order_address`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_address1` FOREIGN KEY (`fk_sales_order_address_shipping`) REFERENCES `sales_order_address` (`id_sales_order_address`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sales_order_ibfk_1` FOREIGN KEY (`fk_sales_order_process`) REFERENCES `sales_order_process` (`id_sales_order_process`),
  CONSTRAINT `sales_order_ibfk_2` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`id_customer`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order`
--

LOCK TABLES `sales_order` WRITE;
/*!40000 ALTER TABLE `sales_order` DISABLE KEYS */;
INSERT INTO `sales_order` VALUES (5,1,1,10,NULL,NULL,NULL,'Hotzenplotz','some@email.com','4400005',NULL,NULL,10.00,2.00,NULL,NULL,NULL,'braspag_boleto',NULL,NULL,'2011-10-01 22:00:00','2013-02-28 13:34:34',NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,'127.0.0.1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,1,1,10,NULL,NULL,NULL,'Souza','some@email.com','4400007',NULL,NULL,12.00,2.00,NULL,NULL,NULL,'braspag_boleto',NULL,NULL,'2011-10-02 22:00:00','2013-02-28 13:34:34',NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,'255.255.255.255',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,1,1,1,NULL,NULL,NULL,'dafiti','dafiti_customer@dafiti.com.br','4400008',NULL,NULL,12.00,2.00,NULL,NULL,NULL,'braspag_boleto',NULL,NULL,'2011-10-02 22:00:00','2013-02-28 13:34:34',NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,'8.8.8.8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,1,1,1,NULL,NULL,NULL,'dafiti','dafiti_customer@dafiti.com.br','4400009',NULL,NULL,12.00,2.00,NULL,NULL,NULL,'braspag_boleto',NULL,NULL,'2011-10-02 22:00:00','2013-02-28 13:34:34',NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,'8.8.4.4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sales_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_address`
--

DROP TABLE IF EXISTS `sales_order_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_address` (
  `id_sales_order_address` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mage_customer_address_id` int(10) unsigned DEFAULT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `city_code` int(11) DEFAULT NULL,
  `postcode` varchar(10) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `phone_optional` varchar(255) DEFAULT NULL,
  `fk_country` int(10) unsigned NOT NULL,
  `is_billing` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_customer_address_region` int(10) unsigned DEFAULT NULL,
  `additional_info` varchar(255) DEFAULT NULL,
  `cell_phone` varchar(255) DEFAULT NULL,
  `neighborhood` varchar(255) NOT NULL,
  `region_code` varchar(2) DEFAULT NULL,
  `street_number` int(6) NOT NULL,
  `reference_delivery` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_sales_order_address`),
  KEY `fk_sales_order_address_country1` (`fk_country`),
  KEY `fk_sales_order_address_customer_address_region1` (`fk_customer_address_region`),
  CONSTRAINT `fk_sales_order_address_country1` FOREIGN KEY (`fk_country`) REFERENCES `country` (`id_country`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_order_address_customer_address_region1` FOREIGN KEY (`fk_customer_address_region`) REFERENCES `customer_address_region` (`id_customer_address_region`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_address`
--

LOCK TABLES `sales_order_address` WRITE;
/*!40000 ALTER TABLE `sales_order_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_gateway`
--

DROP TABLE IF EXISTS `sales_order_gateway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_gateway` (
  `id_sales_order_gateway` int(11) NOT NULL AUTO_INCREMENT,
  `fk_sales_order` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL COMMENT 'When the authorization was sent.',
  `updated_at` datetime DEFAULT NULL COMMENT 'When the capture was received.',
  `gateway_name` varchar(255) NOT NULL COMMENT 'Name of the gateway used.',
  `authorize_trasaction_id` text COMMENT 'Identification of the gateway.',
  `capture_transaction_id` text COMMENT 'Identification of the gateway.',
  `authorize_apiCall_time` int(11) DEFAULT NULL COMMENT 'How many seconds *authorization* api call took.',
  `capture_apiCall_time` int(11) DEFAULT NULL COMMENT 'How many seconds *capture* api call took.',
  PRIMARY KEY (`id_sales_order_gateway`),
  KEY `fk_orderGateway_salesOrder` (`fk_sales_order`),
  KEY `idx_orderGatewayCreation` (`created_at`),
  CONSTRAINT `fk_sales_order_gateway_sales_order1` FOREIGN KEY (`fk_sales_order`) REFERENCES `sales_order` (`id_sales_order`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_gateway`
--

LOCK TABLES `sales_order_gateway` WRITE;
/*!40000 ALTER TABLE `sales_order_gateway` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_gateway` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_invoice`
--

DROP TABLE IF EXISTS `sales_order_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_invoice` (
  `id_sales_order_invoice` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slip_number` varchar(255) NOT NULL,
  `erp_id` varchar(255) DEFAULT NULL,
  `erp_serial_number` varchar(255) DEFAULT NULL,
  `generated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_sales_order_invoice`),
  UNIQUE KEY `slip_number` (`slip_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Invoices generated by slip number';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_invoice`
--

LOCK TABLES `sales_order_invoice` WRITE;
/*!40000 ALTER TABLE `sales_order_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_item`
--

DROP TABLE IF EXISTS `sales_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_item` (
  `id_sales_order_item` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order` int(10) unsigned NOT NULL,
  `fk_sales_order_item_status` int(10) unsigned NOT NULL DEFAULT '1',
  `fk_sales_order_item_shipment` int(10) unsigned DEFAULT NULL,
  `fk_stock_warehouse` tinyint(1) unsigned DEFAULT NULL,
  `fk_out_warehouse` tinyint(1) unsigned DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL COMMENT 'Net Merchandise Value (Netto-Warenwert)',
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `paid_price` decimal(10,2) NOT NULL,
  `coupon_money_value` decimal(10,2) DEFAULT NULL COMMENT 'Exists always, if coupon exists',
  `coupon_percent` int(11) DEFAULT NULL COMMENT 'Exists only if coupon is a percent coupon\n',
  `coupon_refundable` tinyint(1) unsigned DEFAULT NULL,
  `coupon_category` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `weight` decimal(12,4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `brand` varchar(255) NOT NULL,
  `last_status_change` datetime NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL DEFAULT '0.00',
  `refunded_money` decimal(10,2) DEFAULT '0.00',
  `refunded_voucher` decimal(10,2) DEFAULT '0.00',
  `tax_percent` decimal(10,2) DEFAULT '0.00',
  `original_unit_price` decimal(10,2) DEFAULT NULL,
  `cart_rule_discount` decimal(10,2) DEFAULT NULL,
  `cart_rule_display_names` text,
  `freight_costs` decimal(10,2) DEFAULT NULL,
  `freight_costs_charged_to_customer` decimal(10,2) DEFAULT NULL,
  `carrier_contract_id` varchar(100) DEFAULT NULL,
  `carrier_id` bigint(20) DEFAULT NULL,
  `carrier_transit_time_in_days` tinyint(3) DEFAULT NULL,
  `carrier_delivery_type` tinyint(3) DEFAULT NULL,
  `carrier_cod_period` tinyint(3) DEFAULT NULL,
  `erp_id` int(50) NOT NULL,
  `exchanged_at` datetime DEFAULT NULL,
  `gift_wrap_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_sales_order_item`),
  KEY `fk_order_item_order1` (`fk_sales_order`),
  KEY `fk_order_item_order_status1` (`fk_sales_order_item_status`),
  KEY `sku` (`sku`),
  KEY `fk_sales_order_item_shipment` (`fk_sales_order_item_shipment`),
  KEY `fk_stock_warehouse` (`fk_stock_warehouse`),
  KEY `fk_out_warehouse` (`fk_out_warehouse`),
  CONSTRAINT `fk_order_item_order1` FOREIGN KEY (`fk_sales_order`) REFERENCES `sales_order` (`id_sales_order`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_item_order_status1` FOREIGN KEY (`fk_sales_order_item_status`) REFERENCES `sales_order_item_status` (`id_sales_order_item_status`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sales_order_item_ibfk_1` FOREIGN KEY (`fk_sales_order_item_shipment`) REFERENCES `sales_order_item_shipment` (`id_sales_order_item_shipment`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_item`
--

LOCK TABLES `sales_order_item` WRITE;
/*!40000 ALTER TABLE `sales_order_item` DISABLE KEYS */;
INSERT INTO `sales_order_item` VALUES (17,5,2,901,1,1,10.00,NULL,10.00,NULL,NULL,NULL,NULL,'Some Product','SKU_1',NULL,NULL,'2011-09-03 01:00:00','Some Brand','2011-09-02 22:00:01',10.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9993,NULL,NULL),(18,6,2,NULL,3,1,12.00,NULL,12.00,NULL,NULL,NULL,NULL,'Some Product','SKU_2',NULL,NULL,'2011-09-03 01:00:02','Some Brand','2011-09-02 22:00:03',12.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9994,NULL,NULL),(19,6,2,NULL,4,1,12.00,NULL,12.00,NULL,NULL,NULL,NULL,'Some Product','SKU_3',NULL,NULL,'2011-09-03 01:00:02','Some Brand','2011-09-02 22:00:03',12.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9994,NULL,NULL),(20,7,6,NULL,4,1,12.00,NULL,12.00,NULL,NULL,NULL,NULL,'Some Product','SKU_4',NULL,NULL,'2011-09-03 01:00:02','Some Brand','2011-09-02 22:00:03',12.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9994,NULL,NULL),(21,7,6,NULL,4,1,12.00,NULL,12.00,NULL,NULL,NULL,NULL,'Some Product','1111',NULL,NULL,'2011-09-03 01:00:02','Some Brand','2011-09-02 22:00:03',12.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9994,NULL,NULL),(22,8,6,NULL,4,1,12.00,NULL,12.00,NULL,NULL,NULL,NULL,'Some Product','1111',NULL,NULL,'2011-09-03 01:00:02','Some Brand','2011-09-02 22:00:03',12.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9994,NULL,NULL),(23,8,6,NULL,4,1,12.00,NULL,12.00,NULL,NULL,NULL,NULL,'Some Product','1111',NULL,NULL,'2011-09-03 01:00:02','Some Brand','2011-09-02 22:00:03',12.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9994,NULL,NULL);
/*!40000 ALTER TABLE `sales_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_item_shipment`
--

DROP TABLE IF EXISTS `sales_order_item_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_item_shipment` (
  `id_sales_order_item_shipment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(50) DEFAULT NULL,
  `shipment_date` date DEFAULT NULL COMMENT 'YYYMMDD',
  `slip_number` varchar(255) DEFAULT NULL COMMENT 'shipment slip, Lieferschein Nr. ',
  `created_at` datetime DEFAULT NULL,
  `carrier` int(2) unsigned NOT NULL DEFAULT '1',
  `created_by_webstore` tinyint(1) DEFAULT NULL,
  `tracking_url` text,
  PRIMARY KEY (`id_sales_order_item_shipment`),
  KEY `carrier` (`carrier`),
  KEY `slip_number` (`slip_number`),
  CONSTRAINT `sales_order_item_shipment_ibfk_1` FOREIGN KEY (`carrier`) REFERENCES `parcel_tracking` (`id_parcel_tracking`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=903 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_item_shipment`
--

LOCK TABLES `sales_order_item_shipment` WRITE;
/*!40000 ALTER TABLE `sales_order_item_shipment` DISABLE KEYS */;
INSERT INTO `sales_order_item_shipment` VALUES (901,NULL,NULL,'111111',NULL,1,NULL,'http://www.correios.com.br/BR111111'),(902,NULL,NULL,'22222222',NULL,1,NULL,NULL);
/*!40000 ALTER TABLE `sales_order_item_shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_item_status`
--

DROP TABLE IF EXISTS `sales_order_item_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_item_status` (
  `id_sales_order_item_status` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `expiration_duration` int(10) DEFAULT NULL,
  PRIMARY KEY (`id_sales_order_item_status`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1039 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_item_status`
--

LOCK TABLES `sales_order_item_status` WRITE;
/*!40000 ALTER TABLE `sales_order_item_status` DISABLE KEYS */;
INSERT INTO `sales_order_item_status` VALUES (1,'new','new order',0),(2,'payment_pending','we wait for money after authorization',0),(3,'exportable','will be exported in the next run of the export cron job',0),(4,'exported','Item was succesfully exported to the ERP',0),(5,'shipped','the item was sent to the customer',0),(6,'closed','the item was successfully processed ',0),(7,'clarify_not_shipped','the fulfillment provider did not ship the order',0),(8,'returned','the item was returned by the customer',0),(9,'canceled','the item was canceled by the costumer support or cronjob (before we received money)',0),(10,'invalid','order is not valid (can be removed from database)',0),(12,'return_denied','the return of an item was denied',0),(14,'retransfer','the item was canceled and the money needs to be retransfered',0),(22,'export_in_progress','order export failed and has to be checked',1),(23,'clarify_failed_export','',0),(37,'clarify_return_denied','',0),(1023,'clarify_refund_failed_after_retransfer','The failed retransfer needs to be clarified',0),(1024,'refund_failed_after_retransfer','The refund failed',0),(1025,'refunded_after_retransfer','The refund after retransfer was successful',0),(1026,'clarify_refund_failed_after_return','The failed return needs to clarified',0),(1027,'refund_failed_after_return','The return failed',0),(1028,'refunded_after_return','The refund after the item came back was successful',0),(1032,'paid','The order is paid',168),(1033,'exchanged','The order item is exchanged and closed',0),(1034,'clarify_new','something went wrong while creating boleto or authorizing credit card',0),(1036,'payment_information_received','payment confirmation information received from the gateway',0),(1037,'clarify_payment_proxy','',0),(1038,'refunded','Money refunded to the customer (generic refund)',0);
/*!40000 ALTER TABLE `sales_order_item_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_item_status_history`
--

DROP TABLE IF EXISTS `sales_order_item_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_item_status_history` (
  `id_sales_order_item_status_history` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order_item` int(10) unsigned NOT NULL,
  `fk_sales_order_item_status` int(10) unsigned NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `request_type` enum('GUI','CLI','Webservice') DEFAULT NULL,
  `request_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_sales_order_item_status_history`),
  KEY `fk_order_status_history_order_item1` (`fk_sales_order_item`),
  KEY `fk_order_status_history_order_status1` (`fk_sales_order_item_status`),
  CONSTRAINT `fk_order_status_history_order_item1` FOREIGN KEY (`fk_sales_order_item`) REFERENCES `sales_order_item` (`id_sales_order_item`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_status_history_order_status1` FOREIGN KEY (`fk_sales_order_item_status`) REFERENCES `sales_order_item_status` (`id_sales_order_item_status`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_item_status_history`
--

LOCK TABLES `sales_order_item_status_history` WRITE;
/*!40000 ALTER TABLE `sales_order_item_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_item_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_message`
--

DROP TABLE IF EXISTS `sales_order_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_message` (
  `id_sales_order_message` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order` int(10) unsigned NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `probable_guilty` varchar(100) DEFAULT NULL,
  `payment_return_code` int(4) DEFAULT NULL,
  PRIMARY KEY (`id_sales_order_message`),
  KEY `fk_sales_order` (`fk_sales_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Error and informational order-specific messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_message`
--

LOCK TABLES `sales_order_message` WRITE;
/*!40000 ALTER TABLE `sales_order_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_payment`
--

DROP TABLE IF EXISTS `sales_order_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_payment` (
  `id_sales_order_payment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order` int(10) unsigned NOT NULL,
  `boleto_number` varchar(255) DEFAULT NULL,
  `boleto_barcode` varchar(47) DEFAULT NULL,
  `boleto_barcode_fetched` tinyint(2) DEFAULT NULL,
  `boleto_expiration_date` datetime DEFAULT NULL,
  `boleto_url` varchar(255) DEFAULT NULL,
  `cc_installment_count` int(11) DEFAULT NULL,
  `cc_acquirer_transaction_id` varchar(64) DEFAULT NULL,
  `cc_braspag_transaction_id` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `provider` varchar(64) DEFAULT NULL,
  `last_boleto_status_request` datetime DEFAULT NULL,
  `cc_masked_number` varchar(50) DEFAULT NULL,
  `cc_holder` varchar(255) DEFAULT NULL,
  `cc_type` tinyint(4) DEFAULT NULL,
  `cc_authorization_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_sales_order_payment`),
  KEY `fk_payment_order1` (`fk_sales_order`),
  CONSTRAINT `fk_payment_order1` FOREIGN KEY (`fk_sales_order`) REFERENCES `sales_order` (`id_sales_order`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_payment`
--

LOCK TABLES `sales_order_payment` WRITE;
/*!40000 ALTER TABLE `sales_order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_payment_chargeback`
--

DROP TABLE IF EXISTS `sales_order_payment_chargeback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_payment_chargeback` (
  `id_sales_order_payment_chargeback` int(11) NOT NULL AUTO_INCREMENT,
  `fk_sales_order` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `transferred_at` date NOT NULL,
  `closed_at` date NOT NULL,
  `rv_number` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  `canceled_value` float NOT NULL,
  `transferred_value` float NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_sales_order_payment_chargeback`,`fk_sales_order`),
  UNIQUE KEY `fk_sales_order_UNIQUE` (`fk_sales_order`),
  KEY `fk_sales_order_payment_chargeback_sales_order_idx` (`fk_sales_order`),
  CONSTRAINT `fk_sales_order_payment_chargeback_sales_order` FOREIGN KEY (`fk_sales_order`) REFERENCES `sales_order` (`id_sales_order`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_payment_chargeback`
--

LOCK TABLES `sales_order_payment_chargeback` WRITE;
/*!40000 ALTER TABLE `sales_order_payment_chargeback` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_payment_chargeback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_payment_status`
--

DROP TABLE IF EXISTS `sales_order_payment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_payment_status` (
  `id_sales_order_payment_status` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order` int(10) unsigned NOT NULL,
  `authorization_code` varchar(255) DEFAULT NULL,
  `error_code` varchar(255) DEFAULT NULL,
  `error_message` varchar(255) DEFAULT NULL,
  `payment_code` varchar(255) NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `installments` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `cancel_date` datetime DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `order_date` datetime NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `braspag_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id_sales_order_payment_status`),
  KEY `fk_payment_status_order1` (`fk_sales_order`),
  CONSTRAINT `fk_payment_status_order1` FOREIGN KEY (`fk_sales_order`) REFERENCES `sales_order` (`id_sales_order`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_payment_status`
--

LOCK TABLES `sales_order_payment_status` WRITE;
/*!40000 ALTER TABLE `sales_order_payment_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_payment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_process`
--

DROP TABLE IF EXISTS `sales_order_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_process` (
  `id_sales_order_process` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_sales_order_process`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_process`
--

LOCK TABLES `sales_order_process` WRITE;
/*!40000 ALTER TABLE `sales_order_process` DISABLE KEYS */;
INSERT INTO `sales_order_process` VALUES (3,'Boleto'),(4,'CreditCard'),(5,'NoPayment');
/*!40000 ALTER TABLE `sales_order_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_status_partition`
--

DROP TABLE IF EXISTS `sales_order_status_partition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_status_partition` (
  `id_sales_order_status_partition` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_sales_order_status_partition`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_status_partition`
--

LOCK TABLES `sales_order_status_partition` WRITE;
/*!40000 ALTER TABLE `sales_order_status_partition` DISABLE KEYS */;
INSERT INTO `sales_order_status_partition` VALUES (1,'dwh_shipment_state'),(2,'dwh_payment_state');
/*!40000 ALTER TABLE `sales_order_status_partition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_status_partition_map`
--

DROP TABLE IF EXISTS `sales_order_status_partition_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_status_partition_map` (
  `id_sales_order_status_partition_map` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order_process` int(10) unsigned NOT NULL,
  `fk_sales_order_item_status` int(10) unsigned NOT NULL,
  `fk_sales_order_status_partition` int(10) unsigned NOT NULL,
  `fk_sales_order_status_partition_member` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_sales_order_status_partition_map`),
  UNIQUE KEY `uk_sales_order_status_partition_map` (`fk_sales_order_item_status`,`fk_sales_order_process`,`fk_sales_order_status_partition`),
  KEY `fk_sales_order_process` (`fk_sales_order_process`),
  KEY `fk_sales_order_item_status` (`fk_sales_order_item_status`),
  KEY `fk_sales_order_status_partition` (`fk_sales_order_status_partition`),
  KEY `fk_sales_order_status_partition_member` (`fk_sales_order_status_partition_member`),
  CONSTRAINT `sales_order_status_partition_map_ibfk_1` FOREIGN KEY (`fk_sales_order_process`) REFERENCES `sales_order_process` (`id_sales_order_process`),
  CONSTRAINT `sales_order_status_partition_map_ibfk_2` FOREIGN KEY (`fk_sales_order_item_status`) REFERENCES `sales_order_item_status` (`id_sales_order_item_status`),
  CONSTRAINT `sales_order_status_partition_map_ibfk_3` FOREIGN KEY (`fk_sales_order_status_partition`) REFERENCES `sales_order_status_partition` (`id_sales_order_status_partition`),
  CONSTRAINT `sales_order_status_partition_map_ibfk_4` FOREIGN KEY (`fk_sales_order_status_partition_member`) REFERENCES `sales_order_status_partition_member` (`id_sales_order_status_partition_member`)
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_status_partition_map`
--

LOCK TABLES `sales_order_status_partition_map` WRITE;
/*!40000 ALTER TABLE `sales_order_status_partition_map` DISABLE KEYS */;
INSERT INTO `sales_order_status_partition_map` VALUES (69,3,1,1,1),(70,3,1,2,7),(71,3,1034,1,1),(73,3,10,1,13),(74,3,10,2,8),(75,3,3,1,1),(76,3,3,2,7),(77,3,22,1,1),(78,3,22,2,7),(79,3,23,1,1),(80,3,23,2,7),(81,3,4,1,1),(82,3,4,2,7),(83,3,2,1,1),(84,3,2,2,7),(85,3,1037,1,1),(86,3,1037,2,7),(87,3,9,1,2),(88,3,9,2,8),(89,3,1036,1,1),(90,3,1036,2,7),(91,3,1032,1,11),(92,3,1032,2,9),(93,3,7,1,11),(94,3,7,2,9),(95,3,5,1,3),(96,3,5,2,9),(97,4,1,1,1),(98,4,1,2,7),(99,4,10,1,13),(100,4,10,2,8),(101,4,3,1,1),(102,4,3,2,7),(103,4,22,1,1),(104,4,22,2,7),(105,4,23,1,1),(106,4,23,2,7),(107,4,4,1,1),(108,4,4,2,7),(109,4,2,1,1),(110,4,2,2,7),(111,4,1037,1,1),(112,4,1037,2,7),(113,4,9,1,2),(114,4,9,2,8),(115,4,1036,1,1),(116,4,1036,2,7),(117,4,1032,1,11),(118,4,1032,2,9),(119,4,7,1,11),(120,4,7,2,9),(121,4,5,1,3),(122,4,5,2,9),(123,5,1,1,1),(124,5,1,2,7),(125,5,10,1,13),(126,5,10,2,8),(127,5,3,1,1),(128,5,3,2,7),(129,5,22,1,1),(130,5,22,2,7),(131,5,23,1,1),(132,5,23,2,7),(133,5,4,1,1),(134,5,4,2,7),(135,5,9,1,2),(136,5,9,2,8),(137,5,1032,1,11),(138,5,1032,2,9),(139,5,7,1,11),(140,5,7,2,9),(141,5,5,1,3),(142,5,5,2,9),(146,3,1034,2,8),(171,3,6,1,5),(172,3,6,2,9),(173,3,8,1,4),(174,3,8,2,9),(175,3,1033,1,12),(176,3,1033,2,9),(177,3,1026,1,4),(178,3,1026,2,9),(179,3,1027,1,4),(180,3,1027,2,9),(181,3,1028,1,4),(182,3,1028,2,10),(183,3,37,1,4),(184,3,37,2,9),(185,3,12,1,2),(186,3,12,2,9),(187,3,1023,1,2),(188,3,1023,2,9),(189,3,1024,1,2),(190,3,1024,2,9),(191,3,1025,1,2),(192,3,1025,2,10),(219,4,6,1,5),(220,4,6,2,9),(221,4,8,1,4),(222,4,8,2,9),(223,4,1033,1,12),(224,4,1033,2,9),(225,4,1026,1,4),(226,4,1026,2,9),(227,4,1027,1,4),(228,4,1027,2,9),(229,4,1028,1,4),(230,4,1028,2,10),(231,4,37,1,4),(232,4,37,2,9),(233,4,12,1,2),(234,4,12,2,9),(235,4,1023,1,2),(236,4,1023,2,9),(237,4,1024,1,2),(238,4,1024,2,9),(239,4,1025,1,2),(240,4,1025,2,10),(261,5,6,1,5),(262,5,6,2,9),(263,5,8,1,4),(264,5,8,2,9),(265,5,1033,1,12),(266,5,1033,2,9),(267,5,1026,1,4),(268,5,1026,2,9),(269,5,1027,1,4),(270,5,1027,2,9),(271,5,1028,1,4),(272,5,1028,2,10),(273,5,37,1,4),(274,5,37,2,9),(275,5,12,1,2),(276,5,12,2,9),(277,5,1023,1,2),(278,5,1023,2,9),(279,5,1024,1,2),(280,5,1024,2,9),(281,5,1025,1,2),(282,5,1025,2,10),(429,3,14,2,9),(430,3,14,1,2),(431,4,14,2,9),(432,4,14,1,2),(433,5,14,2,9),(434,5,14,1,2),(435,3,1038,1,2),(436,3,1038,2,10),(437,4,1038,1,2),(438,4,1038,2,10),(439,5,1038,1,2),(440,5,1038,2,10);
/*!40000 ALTER TABLE `sales_order_status_partition_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_status_partition_member`
--

DROP TABLE IF EXISTS `sales_order_status_partition_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_order_status_partition_member` (
  `id_sales_order_status_partition_member` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_order_status_partition` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_sales_order_status_partition_member`),
  UNIQUE KEY `uk_sales_order_status_partition_member` (`name`),
  KEY `fk_sales_order_status_partition` (`fk_sales_order_status_partition`),
  CONSTRAINT `sales_order_status_partition_member_ibfk_1` FOREIGN KEY (`fk_sales_order_status_partition`) REFERENCES `sales_order_status_partition` (`id_sales_order_status_partition`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_status_partition_member`
--

LOCK TABLES `sales_order_status_partition_member` WRITE;
/*!40000 ALTER TABLE `sales_order_status_partition_member` DISABLE KEYS */;
INSERT INTO `sales_order_status_partition_member` VALUES (1,1,'item_reserved'),(2,1,'item_canceled'),(3,1,'item_shipped'),(4,1,'item_returned'),(5,1,'item_closed'),(6,1,'item_unknown'),(7,2,'payment_pending'),(8,2,'payment_canceled'),(9,2,'payment_paid'),(10,2,'payment_refunded'),(11,1,'item_exportable'),(12,1,'item_exchanged'),(13,1,'item_invalid');
/*!40000 ALTER TABLE `sales_order_status_partition_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_rule`
--

DROP TABLE IF EXISTS `sales_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_rule` (
  `id_sales_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sales_rule_set` int(10) unsigned NOT NULL,
  `code` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0',
  `from_date` datetime NOT NULL,
  `to_date` datetime DEFAULT NULL,
  `used_discount_amount` decimal(10,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fk_customer` int(10) unsigned DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `customer_tax_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_sales_rule`,`fk_sales_rule_set`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `fk_sales_rule_sales_rule_set` (`fk_sales_rule_set`),
  KEY `fk_customer` (`fk_customer`),
  CONSTRAINT `fk_sales_rule_sales_rule_set` FOREIGN KEY (`fk_sales_rule_set`) REFERENCES `sales_rule_set` (`id_sales_rule_set`),
  CONSTRAINT `sales_rule_ibfk_1` FOREIGN KEY (`fk_customer`) REFERENCES `customer` (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_rule`
--

LOCK TABLES `sales_rule` WRITE;
/*!40000 ALTER TABLE `sales_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_rule_by_user`
--

DROP TABLE IF EXISTS `sales_rule_by_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_rule_by_user` (
  `id_sales_rule_by_user` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_id_sales_rule_set` int(10) unsigned NOT NULL,
  `fk_id_customer` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_sales_rule_by_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_rule_by_user`
--

LOCK TABLES `sales_rule_by_user` WRITE;
/*!40000 ALTER TABLE `sales_rule_by_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_rule_by_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_rule_set`
--

DROP TABLE IF EXISTS `sales_rule_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_rule_set` (
  `id_sales_rule_set` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `code_prefix` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `discount_amount_default` decimal(10,2) DEFAULT '0.00',
  `fk_sales_rule_set_refund` int(10) unsigned DEFAULT NULL,
  `duration_in_days` int(11) DEFAULT NULL,
  `usage_limit` int(10) unsigned NOT NULL DEFAULT '1',
  `type` enum('coupon','credit','refund') NOT NULL,
  `is_refundable` tinyint(1) NOT NULL DEFAULT '0',
  `discount_type` enum('fixed','percent') NOT NULL,
  `discount_percentage` decimal(10,2) DEFAULT '0.00',
  `apply_to_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `conditions_ruleset` mediumtext,
  `code_length` int(11) NOT NULL DEFAULT '6',
  PRIMARY KEY (`id_sales_rule_set`),
  KEY `fk_sales_rule_set_sales_rule_set` (`fk_sales_rule_set_refund`),
  CONSTRAINT `fk_sales_rule_set_sales_rule_set` FOREIGN KEY (`fk_sales_rule_set_refund`) REFERENCES `sales_rule_set` (`id_sales_rule_set`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_rule_set`
--

LOCK TABLES `sales_rule_set` WRITE;
/*!40000 ALTER TABLE `sales_rule_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_rule_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sare_call`
--

DROP TABLE IF EXISTS `sare_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sare_call` (
  `id_sare_call` int(11) NOT NULL AUTO_INCREMENT,
  `fk_sare_lead` int(11) NOT NULL,
  `fk_sare_user` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `closed_at` datetime DEFAULT NULL,
  `observation` text,
  PRIMARY KEY (`id_sare_call`),
  KEY `fk_sare_call_lead` (`fk_sare_lead`),
  CONSTRAINT `fk_sare_call_lead` FOREIGN KEY (`fk_sare_lead`) REFERENCES `sare_lead` (`id_sare_lead`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sare_call`
--

LOCK TABLES `sare_call` WRITE;
/*!40000 ALTER TABLE `sare_call` DISABLE KEYS */;
/*!40000 ALTER TABLE `sare_call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sare_data_source`
--

DROP TABLE IF EXISTS `sare_data_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sare_data_source` (
  `id_sare_data_source` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `target` varchar(45) DEFAULT NULL COMMENT 'for sales order as sample the target is bob.sales_sorder',
  `create_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_sare_data_source`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sare_data_source`
--

LOCK TABLES `sare_data_source` WRITE;
/*!40000 ALTER TABLE `sare_data_source` DISABLE KEYS */;
INSERT INTO `sare_data_source` VALUES (1,'Sales Order','Sare_Model_SalesOrderDataSource','2013-02-28 10:25:21');
/*!40000 ALTER TABLE `sare_data_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sare_filter`
--

DROP TABLE IF EXISTS `sare_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sare_filter` (
  `id_sare_filter` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created_at` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `creator_id` int(11) NOT NULL,
  `fk_sare_data_source` int(11) NOT NULL,
  PRIMARY KEY (`id_sare_filter`),
  KEY `fk_sare_filter_datasource` (`fk_sare_data_source`),
  CONSTRAINT `fk_sare_filter_datasource` FOREIGN KEY (`fk_sare_data_source`) REFERENCES `sare_data_source` (`id_sare_data_source`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sare_filter`
--

LOCK TABLES `sare_filter` WRITE;
/*!40000 ALTER TABLE `sare_filter` DISABLE KEYS */;
INSERT INTO `sare_filter` VALUES (1,'Sales Order Default','2013-02-28',1,0,1);
/*!40000 ALTER TABLE `sare_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sare_filteroption`
--

DROP TABLE IF EXISTS `sare_filteroption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sare_filteroption` (
  `id_sare_filteroption` int(11) NOT NULL AUTO_INCREMENT,
  `fk_sare_filter` int(11) NOT NULL,
  `created_at` date NOT NULL,
  `operator` varchar(45) NOT NULL,
  `value` varchar(45) NOT NULL,
  `fk_sare_option` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `option_type` int(11) NOT NULL,
  `utility` tinyint(4) DEFAULT '2',
  PRIMARY KEY (`id_sare_filteroption`),
  KEY `fk_sare_filteroption_filter` (`fk_sare_filter`),
  KEY `fk_sare_filteroption_option` (`fk_sare_option`),
  CONSTRAINT `fk_sare_filteroption_filter` FOREIGN KEY (`fk_sare_filter`) REFERENCES `sare_filter` (`id_sare_filter`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sare_filteroption_option` FOREIGN KEY (`fk_sare_option`) REFERENCES `sare_option` (`id_sare_option`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sare_filteroption`
--

LOCK TABLES `sare_filteroption` WRITE;
/*!40000 ALTER TABLE `sare_filteroption` DISABLE KEYS */;
INSERT INTO `sare_filteroption` VALUES (4,1,'2013-02-28','In','10,1034,23',5,0,0,2),(5,1,'2013-02-28','LessThanOrEqual','2',6,0,0,2),(6,1,'2013-02-28','GreaterThanOrEqual','0',7,0,1,1);
/*!40000 ALTER TABLE `sare_filteroption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sare_lead`
--

DROP TABLE IF EXISTS `sare_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sare_lead` (
  `id_sare_lead` int(11) NOT NULL AUTO_INCREMENT,
  `fk_sare_filter` int(11) NOT NULL,
  `fk_customer` int(11) NOT NULL,
  `score` decimal(7,2) DEFAULT NULL,
  `new_sales_order_id` int(11) NOT NULL COMMENT 'to store the new sale id\n',
  `status` int(11) DEFAULT NULL COMMENT 'this value como from static data in software\n',
  `referral` int(11) NOT NULL,
  `order_nr` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `name_customer` varchar(254) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `numitens` int(10) DEFAULT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  `installment` int(11) DEFAULT NULL,
  `revenues` decimal(10,2) DEFAULT NULL,
  `username` varchar(254) DEFAULT NULL,
  `bobstatus` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id_sare_lead`),
  KEY `fk_sare_lead_filter` (`fk_sare_filter`),
  KEY `fk_sare_lead_customer` (`fk_customer`),
  CONSTRAINT `fk_sare_lead_filter` FOREIGN KEY (`fk_sare_filter`) REFERENCES `sare_filter` (`id_sare_filter`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sare_lead`
--

LOCK TABLES `sare_lead` WRITE;
/*!40000 ALTER TABLE `sare_lead` DISABLE KEYS */;
/*!40000 ALTER TABLE `sare_lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sare_log`
--

DROP TABLE IF EXISTS `sare_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sare_log` (
  `id_sare_log` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT NULL COMMENT 'come from static data into software\n',
  `fk_sare_user` int(11) DEFAULT NULL COMMENT 'the user(dafiti user) id',
  `fk_sare_lead` varchar(45) DEFAULT NULL,
  `message` varchar(150) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id_sare_log`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sare_log`
--

LOCK TABLES `sare_log` WRITE;
/*!40000 ALTER TABLE `sare_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sare_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sare_option`
--

DROP TABLE IF EXISTS `sare_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sare_option` (
  `id_sare_option` int(11) NOT NULL AUTO_INCREMENT,
  `fk_sare_data_source` int(11) NOT NULL,
  `target` varchar(45) DEFAULT NULL COMMENT 'for column value from sales_order table, the target is ''value''',
  `name` varchar(45) DEFAULT NULL,
  `type` enum('Number','String','Date','Calculated') DEFAULT NULL,
  PRIMARY KEY (`id_sare_option`),
  KEY `fk_sare_option_data_source` (`fk_sare_data_source`),
  CONSTRAINT `fk_sare_option_data_source` FOREIGN KEY (`fk_sare_data_source`) REFERENCES `sare_data_source` (`id_sare_data_source`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sare_option`
--

LOCK TABLES `sare_option` WRITE;
/*!40000 ALTER TABLE `sare_option` DISABLE KEYS */;
INSERT INTO `sare_option` VALUES (4,1,'hasstock','hasstock','Number'),(5,1,'i.fk_sales_order_item_status','sale status','Number'),(6,1,'(timestampdiff(hour, o.created_at, now()))','timelapsed','Number'),(7,1,'CM2','cm2','Calculated'),(8,1,'Order','order has successful','Calculated');
/*!40000 ALTER TABLE `sare_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sare_schedule`
--

DROP TABLE IF EXISTS `sare_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sare_schedule` (
  `id_sare_schedule` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `indate` date DEFAULT NULL,
  `intime` time DEFAULT NULL,
  `fk_sare_lead` int(11) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_sare_schedule`),
  KEY `fk_sare_schedule_lead` (`fk_sare_lead`),
  CONSTRAINT `fk_sare_schedule_lead` FOREIGN KEY (`fk_sare_lead`) REFERENCES `sare_lead` (`id_sare_lead`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sare_schedule`
--

LOCK TABLES `sare_schedule` WRITE;
/*!40000 ALTER TABLE `sare_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `sare_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_update`
--

DROP TABLE IF EXISTS `schema_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_update` (
  `id_schema_update` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(25) NOT NULL,
  `file` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_schema_update`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_update`
--

LOCK TABLES `schema_update` WRITE;
/*!40000 ALTER TABLE `schema_update` DISABLE KEYS */;
INSERT INTO `schema_update` VALUES (1,'maintenance','start.sql','2013-02-28 13:24:42'),(2,'maintenance','init.sql','2013-02-28 13:25:01'),(3,'mail','alter-ums.sql','2013-02-28 13:25:01'),(4,'mail','reminder.sql','2013-02-28 13:25:01'),(5,'plugincore','BRA-1162.sql','2013-02-28 13:25:02'),(6,'plugincore','BRAERP-449.sql','2013-02-28 13:25:03'),(7,'newsletter','BRAERP-450.sql','2013-02-28 13:25:03'),(8,'catalog','indexes.sql','2013-02-28 13:25:03'),(9,'plugincore','BRAERP-451.sql','2013-02-28 13:25:03'),(10,'customer','BRAERP-437.sql','2013-02-28 13:25:04'),(11,'cart','BUGS-280.sql','2013-02-28 13:25:05'),(12,'plugincore','BUGS-287.sql','2013-02-28 13:25:05'),(13,'plugincore','BRAERP-451b.sql','2013-02-28 13:25:05'),(14,'plugincore','BRAERP-451c.sql','2013-02-28 13:25:05'),(15,'customer','BRAERP-437b.sql','2013-02-28 13:25:06'),(16,'mail','BRAERP-419.sql','2013-02-28 13:25:06'),(17,'customer','BUGS-307.sql','2013-02-28 13:25:06'),(18,'payment','BRAERP-322.sql','2013-02-28 13:25:06'),(19,'catalog','PROD-687.sql','2013-02-28 13:25:07'),(20,'catalog','PROD-738.sql','2013-02-28 13:25:07'),(21,'urlmanager','BRAERP-455.sql','2013-02-28 13:25:07'),(22,'plugincore','BRAERP-451d.sql','2013-02-28 13:25:07'),(23,'cms','product_list.sql','2013-02-28 13:25:07'),(24,'customer','BUGS-307b.sql','2013-02-28 13:25:07'),(25,'auth','PROD-670.sql','2013-02-28 13:25:07'),(26,'mail','BRAERP-417.sql','2013-02-28 13:25:08'),(27,'cart','BUGS-347.sql','2013-02-28 13:25:08'),(28,'mail','BRAERP-421.sql','2013-02-28 13:25:08'),(29,'mail','BRAERP-417a.sql','2013-02-28 13:25:08'),(30,'mail','BRAERP-419a.sql','2013-02-28 13:25:09'),(31,'messaging','alice_message_and_solr_message.sql','2013-02-28 13:25:09'),(32,'mail','BRA-804.sql','2013-02-28 13:25:10'),(33,'plugincore','SalesOrderStatusItem_CleanUp.sql','2013-02-28 13:25:10'),(34,'payment','nullable_cc_authorization_code.sql','2013-02-28 13:25:10'),(35,'customer','BRAERP-437c.sql','2013-02-28 13:25:10'),(36,'pluginerp','index_on_erp_freight_table.sql','2013-02-28 13:25:10'),(37,'pluginerp','info_fields_in_erp_call.sql','2013-02-28 13:25:10'),(38,'pluginerp','index_on_erp_freight_table2.sql','2013-02-28 13:25:11'),(39,'customer','BRAERP-437d.sql','2013-02-28 13:25:11'),(40,'recommendation','create_update_table.sql','2013-02-28 13:25:11'),(41,'solr','BUGS-428-solr-score-stat-table.sql','2013-02-28 13:25:11'),(42,'messaging','indexes-for-messaging.sql','2013-02-28 13:25:11'),(43,'cms','DFT-30.sql','2013-02-28 13:25:11'),(44,'maintenance','schema_update-increase-file-column-size.sql','2013-02-28 13:25:11'),(45,'alice','DFT-178_Remove_Tables_forAlice_Node_Information_Bob.sql','2013-02-28 13:25:12'),(46,'cms','DFT-30b.sql','2013-02-28 13:25:12'),(47,'plugincore','DFT-292.sql','2013-02-28 13:25:12'),(48,'salesrule','DFT-18-sales-rule-by-user-table.sql','2013-02-28 13:25:12'),(49,'auth','PJT-18-erp-operator-id.sql','2013-02-28 13:25:12'),(50,'orderprocessing','add_column_id_telesales_user.sql','2013-02-28 13:25:13'),(51,'cms','DFT-62.sql','2013-02-28 13:25:13'),(52,'cms','DFT-504-product_boost.sql','2013-02-28 13:25:14'),(53,'cms','DFT-536.sql','2013-02-28 13:25:14'),(54,'cms','DFT-518.sql','2013-02-28 13:25:14'),(55,'catalogsorting','DFT-560_custom_catalog_sorting.sql','2013-02-28 13:25:14'),(56,'alice','PJT-117_Alter_table_for_exchanged_products.sql','2013-02-28 13:25:14'),(57,'orderprocessing','add_sales_order_message_table.sql','2013-02-28 13:25:14'),(58,'inline-documentation','inline_documentation.sql','2013-02-28 13:25:15'),(59,'maintenance','change_pluginpayment_to_payment.sql','2013-02-28 13:25:15'),(60,'cms','DFT-673.sql','2013-02-28 13:25:15'),(61,'orderprocessing','add_refunded_status_and_relatives.sql','2013-02-28 13:25:15'),(62,'catalog','DFT-614.sql','2013-02-28 13:25:16'),(63,'postcode','create_postcode_correios_table.sql','2013-02-28 13:25:16'),(64,'postcode','remove_non_brazil_region_data.sql','2013-02-28 13:25:16'),(65,'mail','DFT-750_boleto_sales_notification.sql','2013-02-28 13:25:16'),(66,'pluginerp','time_index_in_erp_call.sql','2013-02-28 13:25:16'),(67,'telesales','PJT-18-create-log-telesales-actions-table.sql','2013-02-28 13:25:16'),(68,'telesales','drop_fk_customer_from_log-telesales-actions-table.sql','2013-02-28 13:25:16'),(69,'telesales','drop_action_column_at_log-telesales-actions-table.sql','2013-02-28 13:25:17'),(70,'telesales','add_message_column_to_log-telesales-actions-table.sql','2013-02-28 13:25:17'),(71,'telesales','rename_table_log-telesales-action_to_telesales_logging.sql','2013-02-28 13:25:17'),(72,'telesales','create_table_telesales_actions.sql','2013-02-28 13:25:17'),(73,'telesales','seed_table_telesales_actions.sql','2013-02-28 13:25:17'),(74,'telesales','add_fk_customer_to_telesales_logging_table.sql','2013-02-28 13:25:17'),(75,'telesales','alter_fk_telesales_logging.sql','2013-02-28 13:25:18'),(76,'salesrule','DFT-795-brand-discount-blacklist.sql','2013-02-28 13:25:18'),(77,'groupon','PJT-groupon.sql','2013-02-28 13:25:18'),(78,'orderprocessing','PJT-groupon.sql','2013-02-28 13:25:18'),(79,'cms','DFT-752.sql','2013-02-28 13:25:19'),(80,'customer','history_status_index.sql','2013-02-28 13:25:19'),(81,'recommendation','fix_engine.sql','2013-02-28 13:25:19'),(82,'urlmanager','fix_engine.sql','2013-02-28 13:25:20'),(83,'groupon','PJT-210-groupon-brand-blacklist.sql','2013-02-28 13:25:20'),(84,'sare','PJT-278-Arquitetura-base-RECV.sql','2013-02-28 13:25:21'),(85,'sare','PJT-278-Load-inicial-RECV.sql','2013-02-28 13:25:21'),(86,'groupon','PJT-216-groupon-category-blacklist.sql','2013-02-28 13:25:21'),(87,'sare','PJT-287-Update-Leads-job.sql','2013-02-28 13:25:21'),(88,'salesrule','PJT-205_Gift_Wrap_Calculator.sql','2013-02-28 13:25:21'),(89,'groupon','PJT-235-drop_groupon_status_code_table.sql','2013-02-28 13:25:21'),(90,'sare','PJT-287-Load-filteroption.sql','2013-02-28 13:25:21'),(91,'catalog','DFT-604.sql','2013-02-28 13:25:22'),(92,'orderprocessing','add_invoice_table.sql','2013-02-28 13:25:22'),(93,'pluginerp','erp_status_map_customer.sql','2013-02-28 13:25:22'),(94,'pluginerp','erp_status_map_order.sql','2013-02-28 13:25:23'),(95,'pluginerp','fix_status_maps.sql','2013-02-28 13:25:23'),(96,'catalog','PJT-480_add_outlet_column_to_catalog_config.sql','2013-02-28 13:25:23'),(97,'mail','review-reminder.sql','2013-02-28 13:25:23'),(98,'pluginerp','remove_statuses_from_configuration_table.sql','2013-02-28 13:25:23'),(99,'sare','PJT-474-Call_Entry.sql','2013-02-28 13:25:23'),(100,'sare','PJT-539-Save-Installments-Sare.sql','2013-02-28 13:25:24'),(101,'pluginerp','create_host_domain_in_sales_order.sql','2013-02-28 13:25:24'),(102,'sare','PJT-601-Add-Utility-Field.sql','2013-02-28 13:25:24'),(103,'cms','DFT-1519-Shop_in_Shop_Tracking.sql','2013-02-28 13:25:25'),(104,'customer','DFT-954.sql','2013-02-28 13:25:25'),(105,'customer','DFT-1675.sql','2013-02-28 13:25:26'),(106,'catalog','DFT-1132_DFT-1617.sql','2013-02-28 13:25:27'),(107,'orderprocessing','add_slip_number_index.sql','2013-02-28 13:25:27'),(108,'newsletter','DFT-1787_Change_Newsletter_unsubscribe_key_generation_strategy.sql','2013-02-28 13:25:27'),(109,'store','PJT-829_Multistore_CMS.sql','2013-02-28 13:25:28'),(110,'store','PJT-829-Setup_DafitiSports_and_copy_CMS.sql','2013-02-28 13:25:28'),(111,'customer','add_legal_personality_fields.sql','2013-02-28 13:25:29'),(112,'store','PJT-807_Multistore_Messaging.sql','2013-02-28 13:25:29'),(113,'store','PJT-807_Update_store_secure_domains.sql','2013-02-28 13:25:29'),(114,'customer','add_php_session_id.sql','2013-02-28 13:25:30'),(115,'newsletter','add_php_session_id.sql','2013-02-28 13:25:30'),(116,'customer','add_prudsys_id.sql','2013-02-28 13:25:31'),(117,'newsletter','add_prudsys_id.sql','2013-02-28 13:25:31'),(118,'configuration','DFT-1547.sql','2013-02-28 13:25:31'),(119,'catalog','PJT-903_Add_is_no_product_column.sql','2013-02-28 13:25:31'),(120,'store','PJT-939_Add_cookie_domain_field.sql','2013-02-28 13:25:32'),(121,'stock','PJT-869_Add_Warehouse_Stock.sql','2013-02-28 13:25:33'),(122,'orderprocessing','remove_returns.sql','2013-02-28 13:25:33'),(123,'orderprocessing','remove_refunds.sql','2013-02-28 13:25:33'),(124,'maintenance','remove_citycode.sql','2013-02-28 13:25:33'),(125,'pluginerp','remove_erp_call_bindvalue.sql','2013-02-28 13:25:33'),(126,'orderprocessing','PJT-898_Send_Warehouses_to_ERP.sql','2013-02-28 13:25:34'),(127,'store','PJT-1012_CMS_meta_robots_to_store.sql','2013-02-28 13:25:34'),(128,'catalog','PJT-1012_Multistore_category_tree.sql','2013-02-28 13:25:34'),(129,'salesrule','DFT-2057_Change_table_Sales_Rule_Set_solve_problem_conditions_coupons.sql','2013-02-28 13:25:35'),(130,'orderprocessing','add_message_extra_fields.sql','2013-02-28 13:25:35'),(131,'mail','add_index_mail_reminder.sql','2013-02-28 13:25:35'),(132,'orderprocessing','add_shipment_created_by_webstore.sql','2013-02-28 13:25:36'),(133,'boletoreconciliation','create_boleto_reconciliation.sql','2013-02-28 13:25:36'),(134,'telesales','DFT-1267.sql','2013-02-28 13:25:36'),(135,'catalog','DFT-1609.sql','2013-02-28 13:25:36'),(136,'catalog','DFT-1865.sql','2013-02-28 13:25:36'),(137,'newsletter','DFT-2143_create_newsletter_identification_for_shop_in_shops.sql','2013-02-28 13:25:36'),(138,'catalog','DFT-967.sql','2013-02-28 13:25:36'),(139,'mail','DFT-290.sql','2013-02-28 13:25:37'),(140,'catalog','DFT-2004-pendencies_in_workflow.sql','2013-02-28 13:25:37'),(141,'catalog','PJT-1547_Add_store_relationship_to_config.sql','2013-02-28 13:25:38'),(142,'catalog','DFT-2150.sql','2013-02-28 13:25:38'),(143,'pluginerp','DFT-902.sql','2013-02-28 13:25:38'),(144,'store','PJT-1544_Blacklist_brand.sql','2013-02-28 13:25:38'),(145,'configuration','PJT-1538_configuration_multistore.sql','2013-02-28 13:25:39'),(146,'configuration','PJT-1645_configuration_for_recommendation.sql','2013-02-28 13:25:39'),(147,'stock','PJT-1421-Change_Priority_Warehouses.sql','2013-02-28 13:25:39'),(148,'store','PJT-1572_Store_Installments.sql','2013-02-28 13:25:39'),(149,'customer','DFT-2285_management_cart_products.sql','2013-02-28 13:25:40'),(150,'orderprocessing','DFT-631_add_tracking_url.sql','2013-02-28 13:25:41'),(151,'configuration','DFT-2394_change-config_value-to-text.sql','2013-02-28 13:25:41'),(152,'store','PM-37-Freight_Improvements_For_Multi_Store.sql','2013-02-28 13:25:41'),(153,'catalog','DFT-2468.sql','2013-02-28 13:25:41'),(154,'catalog','Remove_Duplicated_Product_Boost_Index.sql','2013-02-28 13:25:42'),(155,'velocitycheck','PJT-1754_Implement_Velocity_Check.sql','2013-02-28 13:25:42'),(156,'velocitycheck','PVC-1_Implement_charge_back_on_velocity_check.sql','2013-02-28 13:25:42'),(157,'cms','DFT-2063-Shop_in_Shop_Home_Layout.sql','2013-02-28 13:25:42'),(158,'realfreightcost','DFT-2134_Include_Bob_Real_Freight.sql','2013-02-28 13:25:42'),(159,'sare','RDV-3-Add_More_Columns_To_Lead_To_FIX_Performace_Issue.sql','2013-02-28 13:25:45'),(160,'sare','DRV-Sprint_01_clean_ununsed_leads.sql','2013-02-28 13:25:45'),(161,'stock','PBB-5_Add_order_break_by_warehouse.sql','2013-02-28 13:25:45'),(162,'pet','DFT-2442_flag_product_for_grouped_automatic.sql','2013-02-28 13:25:46'),(163,'pay','PJT-1778-create_table_OrderGateway.sql','2013-02-28 13:25:46'),(164,'pay','PGDP-44-Record_time_for_gateway_calls.sql','2013-02-28 13:25:46'),(165,'pay','PGDP-43-Payment_configuration.sql','2013-02-28 13:25:46'),(166,'orderprocessing','add_column_nfe_key.sql','2013-02-28 13:25:46'),(167,'sale','PJT-1589-Import_Gifts_From_MDS.sql','2013-02-28 13:25:46'),(168,'sale','PJT-1592_Add_Gift_Campaign.sql','2013-02-28 13:25:47'),(169,'sale','PJT-1592_Add_Gift_Campaign_stock.sql','2013-02-28 13:25:47'),(170,'sale','PJT-1596-Gift_Campaign_Order.sql','2013-02-28 13:25:48'),(171,'sare','RDV-7-Change-Lead-List-To-Show-Different-Data.sql','2013-02-28 13:25:48'),(172,'sare','DRV-2_performance_improvement.sql','2013-02-28 13:25:48'),(173,'auth','PMB-1-Bob-enhancements.sql','2013-02-28 13:25:50'),(174,'catalog','DFT-2686.sql','2013-02-28 13:25:50'),(175,'urlmanager','OSS-3_url-mapping-multistore.sql','2013-02-28 13:25:51'),(176,'urlmanager','Fix_url_manager.sql','2013-02-28 13:25:51'),(177,'freight','PEG-4_Guaranteed_Delivery_Fields.sql','2013-02-28 13:25:51'),(178,'catalog','DFT-2787_Remove_Manual_Group_from_Filter.sql','2013-02-28 13:25:51'),(179,'partner','DFT-2710.sql','2013-02-28 13:25:51'),(180,'store','DFT-2499_infinite_scroll_by_store.sql','2013-02-28 13:25:52'),(181,'catalog','DFT-2062_add_outlet_shop_in_shop_column_to_catalog_config.sql','2013-02-28 13:25:52'),(182,'catalog','NPS-155_catalog_import_changes.sql','2013-02-28 13:25:53'),(183,'customer','DFT-2711.sql','2013-02-28 13:25:53'),(184,'catalog','NPS-181_New_import_architecture.sql','2013-02-28 13:25:54'),(185,'pay','DFT-2225_send_cardholder_to_order_interface.sql','2013-02-28 13:25:54'),(186,'catalogsorting','DFT-2591_Catalog_Sorting_By_Store.sql','2013-02-28 13:25:55'),(187,'orderprocessing','DFT-2102_DFT-2325_add_in_bob_barcode.sql','2013-02-28 13:25:55'),(188,'orderprocessing','DFT-2102_DFT-2325_change_column_boleto_barcode_fetched.sql','2013-02-28 13:25:55'),(189,'auth','PMB-47_HOTFIX_send_one_email_per_day.sql','2013-02-28 13:25:56'),(190,'auth','PMB-47_Update_users.sql','2013-02-28 13:25:56'),(191,'cms','OSS-69_create_blacklist_for_search.sql','2013-02-28 13:25:56'),(192,'newsletter','DFT-2885_Opt_in_separated_by_shop.sql','2013-02-28 13:25:56');
/*!40000 ALTER TABLE `schema_update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_blacklist`
--

DROP TABLE IF EXISTS `search_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_blacklist` (
  `id_search_blacklist` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(254) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_search_blacklist`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_blacklist`
--

LOCK TABLES `search_blacklist` WRITE;
/*!40000 ALTER TABLE `search_blacklist` DISABLE KEYS */;
INSERT INTO `search_blacklist` VALUES (1,'blah2','2013-02-26 00:00:00'),(2,'ate','2013-02-26 00:00:00'),(3,'em','2013-02-26 00:00:00');
/*!40000 ALTER TABLE `search_blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solr_last_update_timestamp`
--

DROP TABLE IF EXISTS `solr_last_update_timestamp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solr_last_update_timestamp` (
  `id_solr_last_update_timestamp` int(10) unsigned NOT NULL,
  `timestamp` bigint(20) NOT NULL,
  PRIMARY KEY (`id_solr_last_update_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solr_last_update_timestamp`
--

LOCK TABLES `solr_last_update_timestamp` WRITE;
/*!40000 ALTER TABLE `solr_last_update_timestamp` DISABLE KEYS */;
INSERT INTO `solr_last_update_timestamp` VALUES (1,0);
/*!40000 ALTER TABLE `solr_last_update_timestamp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solr_message`
--

DROP TABLE IF EXISTS `solr_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solr_message` (
  `id_solr_message` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) NOT NULL,
  `products` longtext NOT NULL,
  `command` enum('update','delete') NOT NULL,
  `caller` text NOT NULL,
  `comment` varchar(255) NOT NULL,
  PRIMARY KEY (`id_solr_message`,`timestamp`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solr_message`
--

LOCK TABLES `solr_message` WRITE;
/*!40000 ALTER TABLE `solr_message` DISABLE KEYS */;
INSERT INTO `solr_message` VALUES (1,136205846086330,'[\"cat-black-snarf\"]','delete','/var/www/dafiti/shop/bob/application/modules/messaging/models/Messaging.php(229)','Deleting products');
/*!40000 ALTER TABLE `solr_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solr_score_stat`
--

DROP TABLE IF EXISTS `solr_score_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solr_score_stat` (
  `id_solr_score_stat` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_solr_score_stat`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solr_score_stat`
--

LOCK TABLES `solr_score_stat` WRITE;
/*!40000 ALTER TABLE `solr_score_stat` DISABLE KEYS */;
INSERT INTO `solr_score_stat` VALUES (1,'last-update-timestamp',NULL),(2,'stddev-top-seller',NULL),(3,'avg-top-seller',NULL),(4,'stddev-availability',NULL),(5,'avg-availability',NULL);
/*!40000 ALTER TABLE `solr_score_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_blacklist_brand`
--

DROP TABLE IF EXISTS `store_blacklist_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_blacklist_brand` (
  `id_store_blacklist_brand` int(11) NOT NULL AUTO_INCREMENT,
  `fk_store_store` int(11) NOT NULL,
  `fk_catalog_brand` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_store_blacklist_brand`),
  KEY `fk_store_store_index` (`fk_store_store`),
  KEY `fk_catalog_brand_index` (`fk_catalog_brand`),
  CONSTRAINT `ss_fk_store_store` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cb_fk_catalog_brand` FOREIGN KEY (`fk_catalog_brand`) REFERENCES `catalog_brand` (`id_catalog_brand`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_blacklist_brand`
--

LOCK TABLES `store_blacklist_brand` WRITE;
/*!40000 ALTER TABLE `store_blacklist_brand` DISABLE KEYS */;
INSERT INTO `store_blacklist_brand` VALUES (1,1,101),(2,1,101),(3,1,101),(4,1,101),(5,1,101);
/*!40000 ALTER TABLE `store_blacklist_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_freight_price`
--

DROP TABLE IF EXISTS `store_freight_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_freight_price` (
  `id_store_freight_price` int(11) NOT NULL AUTO_INCREMENT,
  `fk_store_store` int(11) DEFAULT NULL,
  `free_shipping` tinyint(4) DEFAULT NULL,
  `min_costs` double DEFAULT NULL,
  PRIMARY KEY (`id_store_freight_price`),
  KEY `fk_store_freight_price_1` (`fk_store_store`),
  CONSTRAINT `fk_store_freight_price_1` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_freight_price`
--

LOCK TABLES `store_freight_price` WRITE;
/*!40000 ALTER TABLE `store_freight_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_freight_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_installment`
--

DROP TABLE IF EXISTS `store_installment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_installment` (
  `id_store_installment` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL DEFAULT '12',
  `fk_catalog_brand` int(10) unsigned NOT NULL,
  `fk_store_store` int(11) NOT NULL,
  PRIMARY KEY (`id_store_installment`),
  UNIQUE KEY `unique_brand_store` (`fk_catalog_brand`,`fk_store_store`),
  KEY `fk_store_installment_catalog_brand` (`fk_catalog_brand`),
  KEY `fk_store_installment_store_store` (`fk_store_store`),
  CONSTRAINT `fk_store_installment_catalog_brand` FOREIGN KEY (`fk_catalog_brand`) REFERENCES `catalog_brand` (`id_catalog_brand`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_store_installment_store_store` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_installment`
--

LOCK TABLES `store_installment` WRITE;
/*!40000 ALTER TABLE `store_installment` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_installment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_paging`
--

DROP TABLE IF EXISTS `store_paging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_paging` (
  `id_store_paging` int(11) NOT NULL AUTO_INCREMENT,
  `fk_store_store` int(11) NOT NULL,
  `is_infinite_scroll` tinyint(1) NOT NULL,
  `items_by_page` int(11) NOT NULL,
  PRIMARY KEY (`id_store_paging`),
  KEY `store_paging_ibfk_1` (`fk_store_store`),
  CONSTRAINT `store_paging_ibfk_1` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_paging`
--

LOCK TABLES `store_paging` WRITE;
/*!40000 ALTER TABLE `store_paging` DISABLE KEYS */;
INSERT INTO `store_paging` VALUES (1,1,1,20),(2,2,0,100);
/*!40000 ALTER TABLE `store_paging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_store`
--

DROP TABLE IF EXISTS `store_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_store` (
  `id_store_store` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `domain` varchar(254) NOT NULL,
  `cookie_domain` varchar(254) NOT NULL,
  `id_business_unit` int(11) NOT NULL,
  `solr_core` varchar(254) DEFAULT NULL,
  `secure_domain` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id_store_store`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_store`
--

LOCK TABLES `store_store` WRITE;
/*!40000 ALTER TABLE `store_store` DISABLE KEYS */;
INSERT INTO `store_store` VALUES (1,'dafiti','www.dafiti.com.br','',1,NULL,NULL),(2,'sports','www.dafitisports.com.br','',2,NULL,NULL);
/*!40000 ALTER TABLE `store_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telesales_actions`
--

DROP TABLE IF EXISTS `telesales_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telesales_actions` (
  `id_telesales_actions` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_telesales_actions`),
  UNIQUE KEY `action` (`action`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telesales_actions`
--

LOCK TABLES `telesales_actions` WRITE;
/*!40000 ALTER TABLE `telesales_actions` DISABLE KEYS */;
INSERT INTO `telesales_actions` VALUES (1,'LOGIN','TELESALES OPERATOR LOGIN'),(2,'LOGOUT','TELESALES OPERATOR LOGOUT'),(3,'LOGIN_AS_CUSTOMER','SELECT CUSTOMER TO CREATE NEW ORDER'),(4,'ADD_NEW_CUSTOMER','REGISTER NEW CUSTOMER'),(5,'CHANGE_CUSTOMER_INFO','CHANGE ANY CUSTOMER INFO AND REGISTER OLD AND NEW VALUE'),(6,'NEW_ORDER','CREATES NEW ORDER TO CUSTOMER'),(7,'SEE_CUSTOMER_ACCOUNT',''),(8,'SEE_CUSTOMER_ADDRESSES',''),(9,'EDIT_CUSTOMER_ADDRESS','CHANGE CUSTOMER ADDRESS AND REGISTER OLD AND NEW VALUE'),(10,'ADD_CUSTOMER_ADDRESS',''),(11,'SEE_CUSTOMER_ORDERS',''),(12,'EDIT_CUSTOMER_NEWSLETTER_SUBSCRIPTION',''),(13,'DELETE_CUSTOMER_ADDRESS','DELETE A CUSTOMER ADDRESS');
/*!40000 ALTER TABLE `telesales_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telesales_logging`
--

DROP TABLE IF EXISTS `telesales_logging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telesales_logging` (
  `id_telesales_logging` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_acl_user` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message` text NOT NULL,
  `fk_telesales_actions` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_telesales_logging`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telesales_logging`
--

LOCK TABLES `telesales_logging` WRITE;
/*!40000 ALTER TABLE `telesales_logging` DISABLE KEYS */;
/*!40000 ALTER TABLE `telesales_logging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ums`
--

DROP TABLE IF EXISTS `ums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ums` (
  `id_ums` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `url` mediumtext NOT NULL,
  `state` enum('error','executed','initial','loaded') NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status_code` varchar(19) DEFAULT NULL,
  `last_response` tinytext,
  `is_top_priority` enum('t','f') NOT NULL,
  `calls` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id_ums`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ums`
--

LOCK TABLES `ums` WRITE;
/*!40000 ALTER TABLE `ums` DISABLE KEYS */;
INSERT INTO `ums` VALUES (1,'2013-02-28 13:33:33','http://sysmail.fagms.net/cgi-bin/systemmail-utf8?ACTION=SYSTEM&email=example%40gmail.com&AID=30902&mailpriority=f&mailtype=newsletter_unsubscription','initial','2013-02-28 13:33:33',NULL,NULL,'f',0);
/*!40000 ALTER TABLE `ums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_mapping`
--

DROP TABLE IF EXISTS `url_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_mapping` (
  `id_url_mapping` int(11) NOT NULL AUTO_INCREMENT,
  `fk_store_store` int(11) NOT NULL,
  `request_path` varchar(255) NOT NULL,
  `target_path` varchar(255) NOT NULL,
  `http_code` int(3) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_url_mapping`),
  UNIQUE KEY `fk_store_request_unique` (`fk_store_store`,`request_path`),
  KEY `fk_store_store` (`fk_store_store`),
  CONSTRAINT `url_mapping_ibfk_1` FOREIGN KEY (`fk_store_store`) REFERENCES `store_store` (`id_store_store`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_mapping`
--

LOCK TABLES `url_mapping` WRITE;
/*!40000 ALTER TABLE `url_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `url_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `velocitycheck`
--

DROP TABLE IF EXISTS `velocitycheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `velocitycheck` (
  `id_velocitycheck` int(11) NOT NULL AUTO_INCREMENT,
  `fk_sales_order_payment` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `approved` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_velocitycheck`,`fk_sales_order_payment`),
  KEY `fk_velocitycheck_sales_order_payment1_idx` (`fk_sales_order_payment`),
  CONSTRAINT `fk_velocitycheck_sales_order_payment` FOREIGN KEY (`fk_sales_order_payment`) REFERENCES `sales_order_payment` (`id_sales_order_payment`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `velocitycheck`
--

LOCK TABLES `velocitycheck` WRITE;
/*!40000 ALTER TABLE `velocitycheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `velocitycheck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `velocitycheck_history`
--

DROP TABLE IF EXISTS `velocitycheck_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `velocitycheck_history` (
  `id_velocitycheck_history` int(11) NOT NULL AUTO_INCREMENT,
  `fk_velocitycheck` int(11) NOT NULL,
  `fk_sales_order_payment` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rule` varchar(45) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_velocitycheck_history`),
  KEY `fk_velocitycheck_history_velocitycheck_idx` (`fk_velocitycheck`,`fk_sales_order_payment`),
  CONSTRAINT `fk_velocitycheck_history_velocitycheck` FOREIGN KEY (`fk_velocitycheck`, `fk_sales_order_payment`) REFERENCES `velocitycheck` (`id_velocitycheck`, `fk_sales_order_payment`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `velocitycheck_history`
--

LOCK TABLES `velocitycheck_history` WRITE;
/*!40000 ALTER TABLE `velocitycheck_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `velocitycheck_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouse` (
  `id_warehouse` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `cnpj` varchar(64) NOT NULL,
  `active` enum('true','false') NOT NULL DEFAULT 'true',
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id_warehouse`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,'CD 02 - GR','12345678000199','true',1),(3,'CD 03 - Itupeva','12345678000399','true',3),(4,'CD 04 - CCP BigBox','12345678000499','true',2);
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse_configuration`
--

DROP TABLE IF EXISTS `warehouse_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouse_configuration` (
  `id_warehouse_configuration` int(11) NOT NULL,
  `order_break` enum('true','false') NOT NULL DEFAULT 'false',
  PRIMARY KEY (`id_warehouse_configuration`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse_configuration`
--

LOCK TABLES `warehouse_configuration` WRITE;
/*!40000 ALTER TABLE `warehouse_configuration` DISABLE KEYS */;
INSERT INTO `warehouse_configuration` VALUES (1,'false');
/*!40000 ALTER TABLE `warehouse_configuration` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-02-28 10:34:35
