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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (17,23,62,1,'2025-07-22 10:46:17'),(18,23,65,1,'2025-07-22 10:46:17'),(19,23,66,1,'2025-07-22 10:46:17'),(24,22,61,2,'2025-07-23 09:37:46');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_addresses`
--

DROP TABLE IF EXISTS `customer_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_addresses` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `address` text NOT NULL,
  `pin_code` varchar(10) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) DEFAULT 'India',
  `location_lat` decimal(10,8) DEFAULT NULL,
  `location_lng` decimal(11,8) DEFAULT NULL,
  `location` point NOT NULL,
  `address_type` enum('home','work','other') DEFAULT 'home',
  `address_label` varchar(50) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`),
  KEY `idx_customer_default` (`customer_id`,`is_default`),
  KEY `idx_customer_active` (`customer_id`,`is_active`),
  SPATIAL KEY `idx_coordinates` (`location`),
  CONSTRAINT `customer_addresses_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_addresses`
--

LOCK TABLES `customer_addresses` WRITE;
/*!40000 ALTER TABLE `customer_addresses` DISABLE KEYS */;
INSERT INTO `customer_addresses` VALUES (2,22,'My Address','500081','Hyderabad','Telangana','India',17.38500000,78.48670000,_binary '\Ê\0\0\0\0\0\√ı(\\èb1@•Ω¡&üS@','home',NULL,0,1,'2025-07-23 06:46:41','2025-07-23 06:46:41');
/*!40000 ALTER TABLE `customer_addresses` ENABLE KEYS */;
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
  `license_expiry_date` date DEFAULT NULL,
  `license_issuing_authority` varchar(100) DEFAULT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL,
  `driving_experience_years` int DEFAULT NULL,
  `years_of_commercial_driving_exp` int DEFAULT '0',
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
-- Table structure for table `provider_banking_details`
--

DROP TABLE IF EXISTS `provider_banking_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_banking_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL,
  `account_holder_name` varchar(100) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `ifsc_code` varchar(11) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `branch_name` varchar(100) DEFAULT NULL,
  `account_type` enum('savings','current') DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('unverified','verified','rejected','archived') NOT NULL DEFAULT 'unverified',
  `verification_remarks` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_provider_account` (`provider_id`,`account_number`),
  CONSTRAINT `provider_banking_details_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_banking_details`
--

LOCK TABLES `provider_banking_details` WRITE;
/*!40000 ALTER TABLE `provider_banking_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_banking_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_data`
--

DROP TABLE IF EXISTS `provider_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_data` (
  `provider_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'FK to the original users table id',
  `full_name` varchar(100) NOT NULL COMMENT 'From users.name',
  `email` varchar(100) NOT NULL COMMENT 'From users.email',
  `phone_number` varchar(15) NOT NULL COMMENT 'From users.phone_number',
  `bio` text,
  `profile_picture_url` varchar(255) DEFAULT NULL,
  `permanent_address` varchar(255) DEFAULT NULL,
  `alternate_email` varchar(100) DEFAULT NULL,
  `alternate_phone_number` varchar(15) DEFAULT NULL,
  `emergency_contact_name` varchar(100) DEFAULT NULL,
  `emergency_contact_relationship` varchar(50) DEFAULT NULL,
  `emergency_contact_phone` varchar(15) DEFAULT NULL,
  `experience_years` int DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0' COMMENT 'Admin verified provider',
  `is_active` tinyint(1) DEFAULT '1' COMMENT 'Provider is active on the platform',
  `last_active_at` timestamp NULL DEFAULT NULL,
  `service_radius_km` int DEFAULT NULL,
  `current_location_lat` decimal(10,8) DEFAULT NULL,
  `current_location_lng` decimal(11,8) DEFAULT NULL,
  `driver_license_number` varchar(50) DEFAULT NULL,
  `driver_license_expiry_date` date DEFAULT NULL,
  `vehicles` json DEFAULT NULL COMMENT 'Array of vehicle objects, e.g., [{"make": "Toyota", "model": "Innova", "reg_no": "MH12AB1234"}, ...]',
  `qualifications` json DEFAULT NULL COMMENT 'Array of qualification objects, e.g., [{"name": "ITI Diploma", "institution": "Govt. Polytechnic"}, ...]',
  `documents` json DEFAULT NULL COMMENT 'Array of document objects, e.g., [{"type": "identity_proof", "url": "...", "status": "approved"}, ...]',
  `primary_bank_account_holder_name` varchar(100) DEFAULT NULL,
  `primary_bank_account_number` varchar(50) DEFAULT NULL,
  `primary_bank_ifsc_code` varchar(11) DEFAULT NULL,
  `primary_bank_name` varchar(100) DEFAULT NULL,
  `primary_bank_account_type` enum('savings','current') DEFAULT NULL,
  `primary_bank_status` enum('unverified','verified','rejected','archived') DEFAULT 'unverified',
  `notify_on_job_alerts` tinyint(1) DEFAULT '1',
  `notify_on_messages` tinyint(1) DEFAULT '1',
  `auto_accept_jobs` tinyint(1) DEFAULT '0',
  `max_jobs_per_day` int DEFAULT NULL,
  `profile_visibility` enum('public','platform_only') DEFAULT 'platform_only',
  `location_sharing_mode` enum('on_job','always_on','off') DEFAULT 'on_job',
  `preferred_language` varchar(10) DEFAULT 'en-US',
  `preferred_currency` varchar(3) DEFAULT 'INR',
  `distance_unit` enum('km','miles') DEFAULT 'km',
  `acquisition_source` varchar(100) DEFAULT NULL,
  `referrer_provider_id` int DEFAULT NULL,
  `business_type` enum('individual','small_business','company') DEFAULT 'individual',
  `can_be_featured` tinyint(1) DEFAULT '0',
  `willing_to_offer_promos` tinyint(1) DEFAULT '0',
  `provider_tier` enum('Bronze','Silver','Gold','Platinum') DEFAULT NULL,
  `services_offered` json DEFAULT NULL COMMENT 'Array of service objects with pricing, e.g., [{"subcategory_id": 5, "name": "AC Repair", "pricing_model": "per_hour", "rate": 500}, ...]',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`),
  KEY `email_2` (`email`),
  KEY `phone_number_2` (`phone_number`),
  KEY `is_active` (`is_active`,`is_verified`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_data`
--

LOCK TABLES `provider_data` WRITE;
/*!40000 ALTER TABLE `provider_data` DISABLE KEYS */;
INSERT INTO `provider_data` VALUES (1,101,'Ramesh Kumar','ramesh.k@example.com','9876543210','15+ years of experience in residential and commercial electrical work. CET-certified.','https://example.com/images/ramesh.jpg','123, Koramangala, Bangalore','ramesh.k.alt@example.com','9000000001','Sunita Kumar','Spouse','9012345671',15,4.80,1,1,'2025-07-28 05:00:00',25,12.93450000,77.62440000,NULL,NULL,NULL,'[{\"name\": \"Certified Electrical Technician\", \"institution\": \"ITI Bangalore\"}, {\"name\": \"Advanced Safety Training\", \"institution\": \"Safety First Institute\"}]','[{\"url\": \"...\", \"type\": \"identity_proof\", \"status\": \"approved\"}, {\"url\": \"...\", \"type\": \"trade_certificate\", \"status\": \"approved\"}]','Ramesh Kumar','11223344556','HDFC0000123','HDFC Bank','savings','verified',1,1,0,5,'public','on_job','en-US','INR','km','Google Search',NULL,'individual',1,1,'Platinum','[{\"name\": \"Fan Installation\", \"rate\": 800, \"pricing_model\": \"fixed\", \"subcategory_id\": 10}, {\"name\": \"Wiring Inspection\", \"rate\": 600, \"pricing_model\": \"per_hour\", \"subcategory_id\": 11}]','2025-07-28 05:52:26','2025-07-28 05:52:26'),(2,102,'Priya Singh','priya.s@example.com','9876543211','Professional driver with a clean record and 5 years experience in city and highway driving. Customer-focused and punctual.','https://example.com/images/priya.jpg','45, Indiranagar, Bangalore','priya.s.alt@example.com','9000000002','Amit Singh','Sibling','9012345672',5,4.90,1,1,'2025-07-28 05:25:00',30,12.97160000,77.64110000,'DL1420200012345','2030-05-20','[{\"make\": \"Toyota\", \"year\": 2022, \"model\": \"Innova Crysta\", \"vehicle_type\": \"suv\", \"registration_number\": \"KA01MF1234\"}]','[]','[{\"url\": \"...\", \"type\": \"drivers_license\", \"status\": \"approved\"}, {\"url\": \"...\", \"type\": \"vehicle_registration\", \"status\": \"approved\"}]','Priya Singh','22334455667','ICIC0000102','ICICI Bank','savings','verified',1,1,1,10,'public','always_on','en-US','INR','km','Friend Referral',105,'individual',1,0,'Gold','[{\"name\": \"City Ride\", \"rate\": 450, \"pricing_model\": \"per_hour\", \"subcategory_id\": 1}, {\"name\": \"Airport Drop\", \"rate\": 1200, \"pricing_model\": \"fixed\", \"subcategory_id\": 2}]','2025-07-28 05:52:26','2025-07-28 05:52:26'),(3,103,'Glow Home Cleaning','contact@glowhome.com','9876543212','We are a team of trained professionals providing top-notch home cleaning services. We use eco-friendly products.','https://example.com/images/glowhome.jpg','78, Jayanagar, Bangalore','admin@glowhome.com','9000000003','Vikram Desai','Business Partner','9012345673',4,4.70,1,1,'2025-07-28 03:30:00',15,12.92620000,77.58230000,NULL,NULL,NULL,'[]','[{\"url\": \"...\", \"type\": \"address_proof\", \"status\": \"approved\"}]','Glow Home Cleaning Pvt Ltd','33445566778','AXIS0000143','Axis Bank','current','verified',1,1,0,99,'public','on_job','en-US','INR','km','Facebook Ad',NULL,'small_business',1,1,'Gold','[{\"name\": \"Deep Home Cleaning\", \"rate\": 4500, \"pricing_model\": \"fixed\", \"subcategory_id\": 20}, {\"name\": \"Kitchen Cleaning\", \"rate\": 1500, \"pricing_model\": \"fixed\", \"subcategory_id\": 21}]','2025-07-28 05:52:26','2025-07-28 05:52:26'),(4,104,'Arun Patel','arun.p@example.com','9876543213','Certified plumber specializing in leak detection and fixture installation. Available for emergency services.','https://example.com/images/arun.jpg','99, HSR Layout, Bangalore',NULL,NULL,'Kavita Patel','Parent','9012345674',2,4.50,1,1,'2025-07-28 04:45:00',10,12.91210000,77.64460000,NULL,NULL,NULL,'[{\"name\": \"Plumbing Certification\", \"institution\": \"Skill India\"}]','[{\"url\": \"...\", \"type\": \"identity_proof\", \"status\": \"approved\"}]','Arun Patel','44556677889','SBIN0000876','State Bank of India','savings','verified',1,1,0,8,'public','on_job','en-US','INR','km','Offline Event',NULL,'individual',0,1,'Silver','[{\"name\": \"Leaky Pipe Repair\", \"rate\": 400, \"pricing_model\": \"per_hour\", \"subcategory_id\": 15}, {\"name\": \"Tap Installation\", \"rate\": 500, \"pricing_model\": \"fixed\", \"subcategory_id\": 16}]','2025-07-28 05:52:26','2025-07-28 05:52:26'),(5,105,'Sanjay Yadav','sanjay.y@example.com','9876543214','Experienced and reliable personal driver for hire. Familiar with all city routes and fluent in English and Hindi.','https://example.com/images/sanjay.jpg','56, Marathahalli, Bangalore','sanjay.y.alt@example.com',NULL,'Geeta Yadav','Spouse','9012345675',8,4.90,1,1,'2025-07-28 05:10:00',20,12.95690000,77.70110000,'DL1820150054321','2028-11-01',NULL,'[]','[{\"url\": \"...\", \"type\": \"drivers_license\", \"status\": \"approved\"}]','Sanjay Yadav','55667788990','HDFC0000123','HDFC Bank','savings','verified',1,1,0,3,'public','off','en-US','INR','km','Friend Referral',102,'individual',0,1,'Silver','[{\"name\": \"Driver for Hire (Per Day)\", \"rate\": 1500, \"pricing_model\": \"per_day\", \"subcategory_id\": 3}]','2025-07-28 05:52:26','2025-07-28 05:52:26'),(6,106,'Rajesh Gupta','rajesh.g@example.com','9876543215','Licensed pest control operator with expertise in handling termites, rodents, and cockroaches. Safe and effective solutions.','https://example.com/images/rajesh.jpg','21, Whitefield, Bangalore',NULL,NULL,'Meena Gupta','Spouse','9012345676',7,4.80,1,1,'2025-07-28 05:30:00',25,12.96980000,77.74990000,NULL,NULL,NULL,'[{\"name\": \"Pest Control License\", \"institution\": \"State Health Dept.\"}]','[{\"url\": \"...\", \"type\": \"trade_certificate\", \"status\": \"approved\"}]','Rajesh Gupta','66778899001','ICIC0000102','ICICI Bank','savings','verified',1,1,0,4,'public','on_job','en-US','INR','km','Google Search',NULL,'individual',1,1,'Gold','[{\"name\": \"Cockroach Control\", \"rate\": 1800, \"pricing_model\": \"fixed\", \"subcategory_id\": 30}]','2025-07-28 05:52:26','2025-07-28 05:52:26'),(7,107,'Anita Devi','anita.d@example.com','9876543216','Reliable and thorough housekeeper available for daily or weekly cleaning, dusting, and mopping.','https://example.com/images/anita.jpg','33, Electronic City, Bangalore',NULL,'9000000007','Ravi Shankar','Brother','9012345677',3,4.60,1,0,'2025-07-27 12:30:00',8,12.84520000,77.66020000,NULL,NULL,NULL,'[]','[{\"url\": \"...\", \"type\": \"identity_proof\", \"status\": \"approved\"}]','Anita Devi','77889900112','SBIN0000876','State Bank of India','savings','verified',1,0,0,2,'platform_only','on_job','hi-IN','INR','km','Word of Mouth',NULL,'individual',0,1,'Silver','[{\"name\": \"General Housekeeping\", \"rate\": 250, \"pricing_model\": \"per_hour\", \"subcategory_id\": 22}]','2025-07-28 05:52:26','2025-07-28 05:52:26'),(8,108,'CoolTech Services','support@cooltech.com','9876543217','Your one-stop shop for AC installation, repair, and regular maintenance. Authorised dealers for major brands.','https://example.com/images/cooltech.jpg','88, Malleswaram, Bangalore','accounts@cooltech.com','9000000008','Suresh Reddy','Manager','9012345678',10,4.90,1,1,'2025-07-28 04:00:00',30,13.00190000,77.56380000,NULL,NULL,NULL,'[{\"name\": \"HVAC Certification\", \"institution\": \"Tech Skills Academy\"}]','[{\"url\": \"...\", \"type\": \"address_proof\", \"status\": \"approved\"}]','CoolTech Services LLP','88990011223','AXIS0000143','Axis Bank','current','verified',1,1,0,99,'public','on_job','en-US','INR','km','Facebook Ad',NULL,'small_business',1,1,'Platinum','[{\"name\": \"AC Gas Refill\", \"rate\": 2500, \"pricing_model\": \"fixed\", \"subcategory_id\": 40}, {\"name\": \"AC Installation\", \"rate\": 1500, \"pricing_model\": \"fixed\", \"subcategory_id\": 41}]','2025-07-28 05:52:26','2025-07-28 05:52:26'),(9,109,'Irfan Khan','irfan.k@example.com','9876543218','Skilled carpenter for furniture repair, assembly, and custom woodwork. Precision and quality guaranteed.','https://example.com/images/irfan.jpg','12, RT Nagar, Bangalore',NULL,NULL,'Fatima Khan','Spouse','9012345679',12,4.70,1,1,'2025-07-28 04:35:00',15,13.02880000,77.59270000,NULL,NULL,NULL,'[{\"name\": \"Advanced Carpentry\", \"institution\": \"Urban Skills Center\"}]','[{\"url\": \"...\", \"type\": \"identity_proof\", \"status\": \"approved\"}]','Irfan Khan','99001122334','HDFC0000123','HDFC Bank','savings','verified',1,1,0,3,'public','on_job','en-US','INR','km','Google Search',NULL,'individual',0,1,'Gold','[{\"name\": \"Furniture Assembly\", \"rate\": 700, \"pricing_model\": \"per_item\", \"subcategory_id\": 50}]','2025-07-28 05:52:26','2025-07-28 05:52:26'),(10,110,'Kiran More','kiran.m@example.com','9876543219','Quick and safe bike taxi rides to beat the city traffic. Available for short-distance commutes.','https://example.com/images/kiran.jpg','7, BTM Layout, Bangalore','kiran.m.alt@example.com',NULL,'Sunil More','Brother','9012345680',3,4.60,1,0,'2025-06-15 11:30:00',10,12.91660000,77.61010000,'DL2020220065432','2032-01-10','[{\"make\": \"Bajaj\", \"year\": 2023, \"model\": \"Pulsar 150\", \"vehicle_type\": \"bike\", \"registration_number\": \"KA05XY5678\"}]','[]','[{\"url\": \"...\", \"type\": \"drivers_license\", \"status\": \"approved\"}]','Kiran More','10203040506','ICIC0000102','ICICI Bank','savings','verified',0,1,1,15,'public','always_on','mr-IN','INR','km','Friend Referral',102,'individual',0,0,'Silver','[{\"name\": \"Bike Ride\", \"rate\": 150, \"pricing_model\": \"per_hour\", \"subcategory_id\": 4}]','2025-07-28 05:52:26','2025-07-28 05:52:26');
/*!40000 ALTER TABLE `provider_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_documents`
--

DROP TABLE IF EXISTS `provider_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL,
  `document_type` enum('identity_proof','address_proof','drivers_license','trade_certificate','background_check','vehicle_registration') NOT NULL,
  `document_url` varchar(255) NOT NULL COMMENT 'URL to the stored file (e.g., on S3)',
  `status` enum('pending_review','approved','rejected') NOT NULL DEFAULT 'pending_review',
  `remarks` text COMMENT 'Reason for rejection by admin',
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `verified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `provider_id` (`provider_id`),
  CONSTRAINT `provider_documents_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_documents`
--

LOCK TABLES `provider_documents` WRITE;
/*!40000 ALTER TABLE `provider_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_documents` ENABLE KEYS */;
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
-- Table structure for table `provider_qualifications`
--

DROP TABLE IF EXISTS `provider_qualifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_qualifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL,
  `qualification_name` varchar(150) NOT NULL COMMENT 'e.g., ITI Diploma in Electrical, Certified Pest Control Operator',
  `issuing_institution` varchar(150) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `certificate_number` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `provider_id` (`provider_id`),
  CONSTRAINT `provider_qualifications_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_qualifications`
--

LOCK TABLES `provider_qualifications` WRITE;
/*!40000 ALTER TABLE `provider_qualifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_qualifications` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_services`
--

LOCK TABLES `provider_services` WRITE;
/*!40000 ALTER TABLE `provider_services` DISABLE KEYS */;
INSERT INTO `provider_services` VALUES (1,7,31),(2,7,65),(5,8,62),(4,8,65),(3,8,67),(7,8,73),(8,8,74),(6,8,75),(10,9,62),(9,9,65),(12,9,73),(11,9,75);
/*!40000 ALTER TABLE `provider_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_settings`
--

DROP TABLE IF EXISTS `provider_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL,
  `notify_on_job_alerts` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Toggle for new job opportunities',
  `notify_on_messages` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Toggle for messages from users/admins',
  `notify_on_payments` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Toggle for payment confirmations',
  `notify_by_sms` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Opt-in for SMS notifications',
  `notify_by_push` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Opt-in for mobile push notifications',
  `auto_accept_jobs` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Automatically accept jobs that match criteria',
  `max_jobs_per_day` int DEFAULT NULL COMMENT 'Limit on number of jobs per day',
  `allow_weekend_work` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Willing to work on weekends',
  `allow_holiday_work` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Willing to work on public holidays',
  `profile_visibility` enum('public','platform_only') NOT NULL DEFAULT 'platform_only' COMMENT 'Who can see the profile',
  `display_rating` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Allow public display of their rating',
  `allow_direct_contact` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Allow users to contact before booking',
  `location_sharing_mode` enum('on_job','always_on','off') NOT NULL DEFAULT 'on_job' COMMENT 'Controls when location is shared',
  `preferred_language` varchar(10) NOT NULL DEFAULT 'en-US' COMMENT 'e.g., en-US, es-MX',
  `preferred_currency` varchar(3) NOT NULL DEFAULT 'INR' COMMENT 'e.g., INR, USD, CAD',
  `distance_unit` enum('km','miles') NOT NULL DEFAULT 'km',
  `time_format` enum('12h','24h') NOT NULL DEFAULT '24h',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `provider_id` (`provider_id`),
  CONSTRAINT `provider_settings_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_settings`
--

LOCK TABLES `provider_settings` WRITE;
/*!40000 ALTER TABLE `provider_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_settings` ENABLE KEYS */;
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
  `alternate_email` varchar(100) DEFAULT NULL COMMENT 'Secondary email for account recovery',
  `alternate_phone_number` varchar(15) DEFAULT NULL COMMENT 'Secondary phone for account recovery',
  `emergency_contact_name` varchar(100) DEFAULT NULL COMMENT 'Full name of the emergency contact',
  `emergency_contact_relationship` varchar(50) DEFAULT NULL COMMENT 'Relationship of the emergency contact (e.g., Spouse, Parent)',
  `emergency_contact_phone` varchar(15) DEFAULT NULL COMMENT 'Phone number of the emergency contact',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `providers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
INSERT INTO `providers` VALUES (1,101,5,4.75,'Experienced electrician with 5+ years in residential wiring and repairs.',1,1,'2025-07-25 08:52:10',15,19.07609000,72.87742600,'2022-03-01 04:45:00','2025-07-25 08:52:10','402, Gopal Apartments, Dadar West, Mumbai, MH',NULL,NULL,NULL,NULL,NULL),(2,102,2,4.20,'Freelance makeup artist specializing in weddings and parties.',1,1,'2025-07-26 03:00:55',10,28.61393900,77.20902300,'2023-01-18 04:00:00','2025-07-26 03:00:55','A-45, Green Park, New Delhi, DL',NULL,NULL,NULL,NULL,NULL),(3,103,10,4.95,'Plumber with over a decade of experience in pipe fitting and leak repairs.',1,0,'2025-06-30 11:15:20',25,13.08268000,80.27071800,'2021-08-22 09:40:00','2025-06-30 11:15:20','17B, Anna Nagar, Chennai, TN',NULL,NULL,NULL,NULL,NULL),(4,104,3,3.85,'Young and energetic personal trainer with focus on strength and mobility.',0,1,'2025-07-26 03:40:00',8,12.97159900,77.59456600,'2024-02-12 05:30:00','2025-07-26 03:40:00','201, Koramangala 4th Block, Bangalore, KA',NULL,NULL,NULL,NULL,NULL),(5,105,7,4.60,'Gardener offering organic landscaping and plant care services.',1,1,'2025-07-25 14:15:45',20,22.57264600,88.36389500,'2020-11-10 02:55:00','2025-07-25 14:15:45','55A, Salt Lake Sector 3, Kolkata, WB',NULL,NULL,NULL,NULL,NULL),(6,106,1,0.00,'dsf',1,1,NULL,10,17.75042560,83.29625600,'2025-07-30 04:46:47','2025-07-30 05:18:37',NULL,NULL,NULL,NULL,NULL,NULL),(7,107,1,0.00,'4562',0,1,'2025-07-30 05:26:28',10,17.75042560,83.29625600,'2025-07-30 04:56:59','2025-07-30 05:26:28',NULL,NULL,NULL,NULL,NULL,NULL),(8,110,2,0.00,'87451',0,1,NULL,10,17.75042560,83.29625600,'2025-07-30 05:37:40','2025-07-30 05:37:40','miami, usa ','','','Messi','friend','7894561230'),(9,111,2,0.00,'gshfjdkl',0,0,'2025-07-30 05:45:29',20,17.74152190,83.22585450,'2025-07-30 05:41:38','2025-07-30 07:18:09','portugal ','ronaldo@gmail.com','7418529305','ronaldo','friend','7418529630');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (2,7,1),(3,8,4),(5,11,3),(6,12,3),(7,13,3),(9,18,3),(10,19,3),(11,20,2),(12,21,2),(13,22,1),(14,23,1),(15,106,2),(16,107,2),(19,110,2),(20,111,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (7,'tulasi ram','tulasi12115045@gmail.com','$2b$10$/mMUziTGSwGY8uERTzwa7eMR5iddTALTmohTjsSdzrjw78qOgQrZm',1,'2025-07-18 11:45:04','9874561230'),(8,'supra admin','superadmin@urbango.ca','$2b$10$K/hwKUBqWBw4iSTO8Uq/Mui8hzCwQlp5BJNlUyblC2KsegS87dmxS',1,'2025-07-18 13:07:10','7854963210'),(11,'Ronaldo','ronaldo7@otw.com','Superadmin@123',1,'2025-07-21 05:17:31','1236547890'),(12,'Ronaldo','ronaldoCR7@otw.com','Superadmin@123',1,'2025-07-21 05:20:31','7777777777'),(13,'Hello','Hello@gmail.com','User@123',0,'2025-07-21 05:30:16','7894564512'),(18,'neymar','neymar@gmail.com','User@123',1,'2025-07-21 05:35:47','7894561230'),(19,'messi','messi@gmail.com','$2b$10$3bY3s4A8.NxPpiCM9d.k.uRBUED2CR/CKojn3JeIBNMV3J/v7sT/G',1,'2025-07-21 05:54:59','1010101010'),(20,'messi leo','messi123@gmail.com','$2b$10$H4CyFs3EPJG0FU1IwAWrZewvBYead9ar9QD.SqsMLCthv2atzcB16',1,'2025-07-21 10:24:24','7894562310'),(21,'ronaldo 7','ronaldo12@gmail.com','$2b$10$7GpP3x0amZNJEmxwtGCstOJJLicp09dtOnzQ4OuWSj4KiJITdYdeK',1,'2025-07-22 08:46:28','4587466545'),(22,'Neymar da silva santos','neymarDa@gmail.com','$2b$10$CWS2xiW0XhHW/lm.RNW28ugO3VNXpGhhBfsBQ97T0ECb3YX4D13au',1,'2025-07-22 09:54:05','7894565223'),(23,'Ronda Alado','ronaldo123@gmail.com','$2b$10$y3jTMhdkZAzG.8W08aW9EeR6myuV09PHHZBYzoTyvtF2Kw3pGql/2',1,'2025-07-22 10:46:17','5452215221'),(101,'Rajesh Kumar','rajesh.kumar@example.com','$2y$10$abcxyz1234567890encrypted1',1,'2021-02-10 03:45:00','9876543210'),(102,'Priya Mehta','priya.mehta@example.com','$2y$10$abcxyz1234567890encrypted2',1,'2022-06-18 05:15:00','9812345678'),(103,'Suresh Nair','suresh.nair@example.com','$2y$10$abcxyz1234567890encrypted3',0,'2020-12-05 03:00:00','9765432109'),(104,'Anjali Verma','anjali.verma@example.com','$2y$10$abcxyz1234567890encrypted4',1,'2023-03-22 08:30:00','9888777666'),(105,'Arvind Sen','arvind.sen@example.com','$2y$10$abcxyz1234567890encrypted5',1,'2019-09-30 02:20:00','9900112233'),(106,'Messi lionel','messiWorker2@gmail.com','$2b$10$.B4t3YiF3O7KWGbDhsGtIeECzGxUiazshjYTJejmUWVPyiW83N3NG',1,'2025-07-30 04:46:47','7894561230'),(107,'Messi  lionel','messiWorker3@gmail.com','$2b$10$c7W4FIsMwReaC0up1O.tjepgi7GkLwtGLJPP3rJdvqGPd8.dnzSNW',1,'2025-07-30 04:56:59','7418529630'),(110,'worker 1','worker1@gmail.com','$2b$10$6i.jIvgKDtcR994XU07o8OS1sXubVWgl2WyIfbnJzzEXtVUo7lqD6',1,'2025-07-30 05:37:40','7418529630'),(111,'Tulasi ram','worker2@gmail.com','$2b$10$zwy/L.QvztUq6FmLvvyVvOSFYmfTYwFPA3CDKEaiFU.ZboUnrxf/O',1,'2025-07-30 05:41:38','7410852963');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL COMMENT 'The provider who owns/operates this vehicle',
  `make` varchar(50) NOT NULL COMMENT 'e.g., Toyota, Maruti Suzuki, Ford',
  `model` varchar(50) NOT NULL COMMENT 'e.g., Innova Crysta, Swift, Ecosport',
  `year` int NOT NULL,
  `color` varchar(30) DEFAULT NULL,
  `registration_number` varchar(20) NOT NULL,
  `vehicle_type` enum('sedan','suv','hatchback','bike','van') NOT NULL,
  `insurance_policy_number` varchar(50) DEFAULT NULL,
  `insurance_expiry_date` date DEFAULT NULL,
  `fitness_certificate_expiry_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is this vehicle currently in use on the platform?',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `registration_number` (`registration_number`),
  KEY `provider_id` (`provider_id`),
  CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-30 12:51:58
