-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: urban_db
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `provider_id` int DEFAULT NULL,
  `subcategory_id` int DEFAULT NULL,
  `scheduled_time` datetime DEFAULT NULL,
  `address` text,
  `gst` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `service_status` varchar(20) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT 'unpaid',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `provider_id` (`provider_id`),
  KEY `subcategory_id` (`subcategory_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`),
  CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `subcategory_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_cart_item` (`customer_id`,`subcategory_id`),
  KEY `subcategory_id` (`subcategory_id`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (17,23,62,1,'2025-07-22 10:46:17'),(18,23,65,1,'2025-07-22 10:46:17'),(19,23,66,1,'2025-07-22 10:46:17'),(20,22,79,1,'2025-07-23 04:18:37'),(21,22,59,1,'2025-07-23 04:19:36'),(22,22,60,1,'2025-07-23 04:19:39');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL,
  `address` text,
  `pin_code` varchar(10) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `location_lat` decimal(10,8) DEFAULT NULL,
  `location_lng` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (22,'washington ton dc , usa, America Continent','584332','Washington, DC','Florida','USA',NULL,NULL),(23,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drivers`
--

DROP TABLE IF EXISTS `drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drivers` (
  `provider_id` int NOT NULL,
  `license_number` varchar(50) DEFAULT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL,
  `driving_experience_years` int DEFAULT NULL,
  `vehicle_registration_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`provider_id`),
  CONSTRAINT `fk_driver_provider` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drivers`
--

LOCK TABLES `drivers` WRITE;
/*!40000 ALTER TABLE `drivers` DISABLE KEYS */;
/*!40000 ALTER TABLE `drivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_refunds`
--

DROP TABLE IF EXISTS `payment_refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_refunds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_id` int NOT NULL,
  `refund_id` varchar(50) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `reason` text,
  `status` enum('pending','processed','failed') DEFAULT 'pending',
  `refunded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `refund_id` (`refund_id`),
  KEY `payment_id` (`payment_id`),
  CONSTRAINT `payment_refunds_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_refunds`
--

LOCK TABLES `payment_refunds` WRITE;
/*!40000 ALTER TABLE `payment_refunds` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_refunds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `user_id` int NOT NULL,
  `razorpay_payment_id` varchar(50) DEFAULT NULL,
  `razorpay_order_id` varchar(50) DEFAULT NULL,
  `method` varchar(20) DEFAULT NULL,
  `status` enum('created','authorized','captured','failed','refunded') DEFAULT 'created',
  `amount_paid` int DEFAULT NULL,
  `currency` varchar(10) DEFAULT 'INR',
  `email` varchar(100) DEFAULT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `captured_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `razorpay_payment_id` (`razorpay_payment_id`),
  KEY `booking_id` (`booking_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_location_logs`
--

DROP TABLE IF EXISTS `provider_location_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_location_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `recorded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `provider_id` (`provider_id`),
  CONSTRAINT `provider_location_logs_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_location_logs`
--

LOCK TABLES `provider_location_logs` WRITE;
/*!40000 ALTER TABLE `provider_location_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_location_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_services`
--

DROP TABLE IF EXISTS `provider_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_services` (
  `prov_serv_id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL,
  `subcategory_id` int NOT NULL,
  PRIMARY KEY (`prov_serv_id`),
  UNIQUE KEY `provider_id` (`provider_id`,`subcategory_id`),
  KEY `subcategory_id` (`subcategory_id`),
  CONSTRAINT `provider_services_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `provider_services_ibfk_2` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_services`
--

LOCK TABLES `provider_services` WRITE;
/*!40000 ALTER TABLE `provider_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `providers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `experience_years` int DEFAULT '0',
  `rating` decimal(3,2) DEFAULT '0.00',
  `bio` text,
  `verified` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `last_active_at` timestamp NULL DEFAULT NULL,
  `service_radius_km` int DEFAULT '10',
  `location_lat` decimal(10,8) DEFAULT NULL,
  `location_lng` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `permanent_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `providers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
INSERT INTO `providers` VALUES (1,20,1,0.00,'cameraa wowoo',0,1,NULL,10,17.74714880,83.24710400,'2025-07-21 10:24:24','2025-07-21 10:24:24',NULL),(2,21,2,0.00,'fooyballl',0,1,NULL,10,17.74387200,83.22744320,'2025-07-22 08:46:28','2025-07-22 08:46:28',NULL);
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'customer'),(2,'worker'),(3,'admin'),(4,'super admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_area`
--

DROP TABLE IF EXISTS `service_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_area` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `provider_id` (`provider_id`,`pincode`),
  CONSTRAINT `service_area_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_area`
--

LOCK TABLES `service_area` WRITE;
/*!40000 ALTER TABLE `service_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_categories`
--

DROP TABLE IF EXISTS `service_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `category_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_categories`
--

LOCK TABLES `service_categories` WRITE;
/*!40000 ALTER TABLE `service_categories` DISABLE KEYS */;
INSERT INTO `service_categories` VALUES (17,'Carpenter',1,'maintenance'),(18,'AC Services',1,'maintenance'),(19,'Plumber',1,'maintenance'),(20,'Electrician',1,'maintenance'),(21,'Pest Control',1,'maintenance'),(22,'Cleaner',1,'maid'),(23,'Cook',1,'maid'),(24,'General Help',1,'maid'),(25,'Innova Crysta',1,'driver');
/*!40000 ALTER TABLE `service_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `category_id` int DEFAULT NULL,
  `description` text,
  `base_price` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_id` (`category_id`,`name`),
  CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `service_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
INSERT INTO `subcategories` VALUES (21,'Airport Transfer',25,'Airport pickup and drop service',1500),(22,'City Tours',25,'Local city sightseeing tours',2000),(23,'Outstation Trips',25,'Long-distance travel service',5000),(24,'Wedding Transportation',25,'Wedding party transportation',4000),(25,'Corporate Travel',25,'Business travel services',3000),(26,'Emergency Transport',25,'24/7 emergency transport',2500),(27,'Hourly Rental',25,'Vehicle rental by the hour',1800),(28,'Kitchen Cabinets',17,'Custom kitchen cabinet installation and repair',5000),(29,'Furniture Repair',17,'Repair and restoration of wooden furniture',2000),(30,'Door Installation',17,'Door fitting and frame installation',3000),(31,'Window Frames',17,'Window frame repair and replacement',3500),(32,'Custom Shelving',17,'Custom built-in shelves and storage solutions',4000),(33,'Flooring Installation',17,'Wooden flooring installation and repair',6000),(34,'Deck Building',17,'Outdoor deck construction and maintenance',8000),(56,'Installation',18,'New AC unit installation',3000),(57,'Repair & Maintenance',18,'AC troubleshooting and regular maintenance',1500),(58,'Gas Refilling',18,'Refrigerant gas refilling service',2500),(59,'Cleaning & Servicing',18,'Deep cleaning and servicing of AC units',1200),(60,'Duct Cleaning',18,'AC duct cleaning and maintenance',2000),(61,'Thermostat Installation',18,'Smart thermostat installation and setup',1800),(62,'Pipe Repair',19,'Leaky pipe repair and replacement',1000),(63,'Drain Cleaning',19,'Clogged drain cleaning and unblocking',800),(64,'Toilet Installation',19,'Toilet fitting and installation',2500),(65,'Faucet Repair',19,'Faucet repair and replacement',500),(66,'Water Heater Service',19,'Water heater installation and repair',3500),(67,'Bathroom Renovation',19,'Complete bathroom plumbing renovation',10000),(68,'Emergency Plumbing',19,'24/7 emergency plumbing services',2000),(69,'Wiring Installation',20,'Complete house wiring installation',5000),(70,'Light Fixture Setup',20,'Light fixture installation and repair',800),(71,'Outlet Installation',20,'Electrical outlet and switch installation',600),(72,'Circuit Breaker Repair',20,'Circuit breaker troubleshooting and repair',1500),(73,'Fan Installation',20,'Ceiling and exhaust fan installation',1000),(74,'Electrical Inspection',20,'Complete electrical safety inspection',2000),(75,'Emergency Electrical',20,'24/7 emergency electrical services',2500),(76,'Termite Treatment',21,'Termite inspection and treatment',3000),(77,'Rodent Control',21,'Rat and mouse extermination',2500),(78,'Cockroach Treatment',21,'Cockroach elimination service',2000),(79,'Ant Control',21,'Ant colony removal and prevention',1800),(80,'Bed Bug Treatment',21,'Bed bug extermination service',3500),(81,'Mosquito Control',21,'Mosquito fogging and prevention',2200),(82,'General Fumigation',21,'Complete home fumigation service',4000),(83,'House Cleaning',22,'Standard home cleaning service',1500),(84,'Deep Cleaning',22,'Thorough deep cleaning service',3000),(85,'Carpet Cleaning',22,'Professional carpet cleaning and nice work',2000),(86,'Window Cleaning',22,'Interior/exterior window cleaning',1200),(87,'Post-Construction Cleanup',22,'Post-construction debris removal',3500),(88,'Office Cleaning',22,'Commercial office cleaning',2500),(89,'Move-in/Move-out Cleaning',22,'Complete home cleaning for moving',4000),(90,'Daily Meal Prep',23,'Daily home-cooked meal preparation',5000),(91,'Party Catering',23,'Event and party catering service',8000),(92,'Special Occasion Cooking',23,'Custom meals for special events',6000),(93,'Meal Planning',23,'Personalized meal planning service',3000),(94,'Cooking Classes',23,'In-home cooking lessons',2000),(95,'Diet-specific Meals',23,'Special diet meal preparation',5500),(96,'Bulk Cooking',23,'Large quantity meal preparation',7000),(97,'Moving Assistance',24,'Help with moving and packing',2500),(98,'Furniture Assembly',24,'Furniture assembly and setup',1500),(99,'Yard Work',24,'Gardening and yard maintenance',2000),(100,'Painting',24,'Interior/exterior painting service',4000),(101,'Minor Repairs',24,'Various home repair services',1800),(102,'Organizing Services',24,'Home organization and decluttering',3000),(103,'Handyman Tasks',24,'Various handyman services',2200);
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_role_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_role_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (2,7,1),(3,8,4),(5,11,3),(6,12,3),(7,13,3),(9,18,3),(10,19,3),(11,20,2),(12,21,2),(13,22,1),(14,23,1);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `phone_number` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (7,'tulasi ram','tulasi12115045@gmail.com','$2b$10$/mMUziTGSwGY8uERTzwa7eMR5iddTALTmohTjsSdzrjw78qOgQrZm',1,'2025-07-18 11:45:04',NULL),(8,'supra admin','superadmin@urbango.ca','$2b$10$K/hwKUBqWBw4iSTO8Uq/Mui8hzCwQlp5BJNlUyblC2KsegS87dmxS',1,'2025-07-18 13:07:10',NULL),(11,'Ronaldo','ronaldo7@otw.com','Superadmin@123',1,'2025-07-21 05:17:31',NULL),(12,'Ronaldo','ronaldoCR7@otw.com','Superadmin@123',1,'2025-07-21 05:20:31','7777777777'),(13,'Hello','Hello@gmail.com','User@123',0,'2025-07-21 05:30:16','7894564512'),(18,'neymar','neymar@gmail.com','User@123',1,'2025-07-21 05:35:47','7894561230'),(19,'messi','messi@gmail.com','$2b$10$3bY3s4A8.NxPpiCM9d.k.uRBUED2CR/CKojn3JeIBNMV3J/v7sT/G',1,'2025-07-21 05:54:59','1010101010'),(20,'messi leo','messi123@gmail.com','$2b$10$H4CyFs3EPJG0FU1IwAWrZewvBYead9ar9QD.SqsMLCthv2atzcB16',1,'2025-07-21 10:24:24',''),(21,'ronaldo 7','ronaldo12@gmail.com','$2b$10$7GpP3x0amZNJEmxwtGCstOJJLicp09dtOnzQ4OuWSj4KiJITdYdeK',1,'2025-07-22 08:46:28',''),(22,'Neymar da silva santos','neymarDa@gmail.com','$2b$10$CWS2xiW0XhHW/lm.RNW28ugO3VNXpGhhBfsBQ97T0ECb3YX4D13au',1,'2025-07-22 09:54:05',NULL),(23,'Ronda Alado','ronaldo123@gmail.com','$2b$10$y3jTMhdkZAzG.8W08aW9EeR6myuV09PHHZBYzoTyvtF2Kw3pGql/2',1,'2025-07-22 10:46:17',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-23 12:07:17
