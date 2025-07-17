-- Create database if not already created
CREATE DATABASE IF NOT EXISTS urban_db; 
USE urban_db;

-- Users table
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255),
  is_active TINYINT(1),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Customers (1-to-1 with users)
CREATE TABLE customers (
  id INT PRIMARY KEY,
  full_name VARCHAR(100),
  phone VARCHAR(15),
  address TEXT,
  pin_code VARCHAR(10),
  city VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100),
  location_lat DECIMAL(10, 8),
  location_lng DECIMAL(11, 8),
  FOREIGN KEY (id) REFERENCES users(id)
);

-- Roles
CREATE TABLE roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50)
);

-- User roles (many-to-many between users and roles)
CREATE TABLE user_roles (
  user_role_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Service categories (e.g., Home Services)
CREATE TABLE service_categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

-- Subcategories (e.g., Electrician, Plumber)
CREATE TABLE subcategories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category_id INT,
  description TEXT,
  base_price INT, 
  UNIQUE (category_id, name),
  FOREIGN KEY (category_id) REFERENCES service_categories(id) ON DELETE CASCADE
);

-- Providers
CREATE TABLE providers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  experience_years INT DEFAULT 0,
  rating DECIMAL(3,2) DEFAULT 0.00,
  bio TEXT,
  verified BOOLEAN DEFAULT FALSE,
  active BOOLEAN DEFAULT TRUE,
  last_active_at TIMESTAMP NULL DEFAULT NULL,
  service_radius_km INT DEFAULT 10,
  location_lat DECIMAL(10, 8),
  location_lng DECIMAL(11, 8),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Service areas
CREATE TABLE service_area (
  id INT AUTO_INCREMENT PRIMARY KEY,
  provider_id INT,
  city VARCHAR(50),
  pincode VARCHAR(10),
  UNIQUE (provider_id, pincode),
  FOREIGN KEY (provider_id) REFERENCES providers(id)
);

-- Many-to-many: providers offer multiple services
CREATE TABLE provider_services (
prov_serv_id INT AUTO_INCREMENT PRIMARY KEY,
  provider_id INT NOT NULL,
  subcategory_id INT NOT NULL,
  unique (provider_id, subcategory_id),
  FOREIGN KEY (provider_id) REFERENCES providers(id) ON DELETE CASCADE,
  FOREIGN KEY (subcategory_id) REFERENCES subcategories(id) ON DELETE CASCADE
);

CREATE TABLE provider_location_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  provider_id INT NOT NULL,
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (provider_id) REFERENCES providers(id) ON DELETE CASCADE
);

-- Bookings
CREATE TABLE bookings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  provider_id INT,
  subcategory_id INT,
  scheduled_time DATETIME,
  address TEXT,
  gst INT,           -- stored in paise
  price INT,       
  service_status VARCHAR(20), 
  payment_status VARCHAR(20) DEFAULT 'unpaid',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (provider_id) REFERENCES providers(id),
  FOREIGN KEY (subcategory_id) REFERENCES subcategories(id)
);

-- Payments (via Razorpay)
CREATE TABLE payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  booking_id INT NOT NULL,
  user_id INT NOT NULL,
  razorpay_payment_id VARCHAR(50) UNIQUE,
  razorpay_order_id VARCHAR(50),
  method VARCHAR(20),
  status ENUM('created', 'authorized', 'captured', 'failed', 'refunded') DEFAULT 'created',
  amount_paid INT,    -- stored in paise
  currency VARCHAR(10) DEFAULT 'INR',
  email VARCHAR(100),
  contact VARCHAR(15),
  captured_at TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Refunds
CREATE TABLE payment_refunds (
  id INT AUTO_INCREMENT PRIMARY KEY,
  payment_id INT NOT NULL,
  refund_id VARCHAR(50) UNIQUE,
  amount INT,  -- in paise
  reason TEXT,
  status ENUM('pending', 'processed', 'failed') DEFAULT 'pending',
  refunded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (payment_id) REFERENCES payments(id) ON DELETE CASCADE
);
