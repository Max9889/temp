-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 24, 2026 at 07:23 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `twin cities`
--

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `city_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `timezone_id` int(11) NOT NULL,
  `city_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `population` int(11) NOT NULL,
  `mayor_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `gdp` bigint(20) NOT NULL,
  `currency` varchar(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `area` decimal(10,2) NOT NULL COMMENT 'Area in km^2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `district`
--

CREATE TABLE `district` (
  `district_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `district_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `area` decimal(10,2) NOT NULL COMMENT 'Area in km^2',
  `population` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placeofinterest`
--

CREATE TABLE `placeofinterest` (
  `POI_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `POI_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `total_area` decimal(10,2) NOT NULL COMMENT 'Area in km^2',
  `date_established` date NOT NULL,
  `accessibility_rating` tinyint(3) UNSIGNED NOT NULL CHECK (`accessibility_rating` between 0 and 10),
  `entry_fee` decimal(6,2) DEFAULT NULL COMMENT 'Fee in local currency',
  `visitor_capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `poi_image`
--

CREATE TABLE `poi_image` (
  `image_id` int(11) NOT NULL,
  `POI_id` int(11) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `caption` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publicservice`
--

CREATE TABLE `publicservice` (
  `public_service_id` int(11) NOT NULL,
  `service_area_id` int(11) NOT NULL,
  `service_type_id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `servicearea`
--

CREATE TABLE `servicearea` (
  `service_area_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `servicetype`
--

CREATE TABLE `servicetype` (
  `service_type_id` int(11) NOT NULL,
  `service_type_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timezone`
--

CREATE TABLE `timezone` (
  `timezone_id` int(11) NOT NULL,
  `timezone_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transportstation`
--

CREATE TABLE `transportstation` (
  `station_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `station_type_id` int(11) NOT NULL,
  `station_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `toilets_available` tinyint(1) NOT NULL DEFAULT 0,
  `accessibility_rating` tinyint(3) UNSIGNED NOT NULL CHECK (`accessibility_rating` between 1 and 10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transportstationtype`
--

CREATE TABLE `transportstationtype` (
  `station_type_id` int(11) NOT NULL,
  `station_type_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `timezone_id` (`timezone_id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `district`
--
ALTER TABLE `district`
  ADD PRIMARY KEY (`district_id`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `placeofinterest`
--
ALTER TABLE `placeofinterest`
  ADD PRIMARY KEY (`POI_id`),
  ADD KEY `district_id` (`district_id`);

--
-- Indexes for table `poi_image`
--
ALTER TABLE `poi_image`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `POI_id` (`POI_id`);

--
-- Indexes for table `publicservice`
--
ALTER TABLE `publicservice`
  ADD PRIMARY KEY (`public_service_id`),
  ADD KEY `service_area_id` (`service_area_id`),
  ADD KEY `service_type_id` (`service_type_id`);

--
-- Indexes for table `servicearea`
--
ALTER TABLE `servicearea`
  ADD PRIMARY KEY (`service_area_id`),
  ADD KEY `district_id` (`district_id`);

--
-- Indexes for table `servicetype`
--
ALTER TABLE `servicetype`
  ADD PRIMARY KEY (`service_type_id`);

--
-- Indexes for table `timezone`
--
ALTER TABLE `timezone`
  ADD PRIMARY KEY (`timezone_id`);

--
-- Indexes for table `transportstation`
--
ALTER TABLE `transportstation`
  ADD PRIMARY KEY (`station_id`),
  ADD KEY `district_id` (`district_id`),
  ADD KEY `station_type_id` (`station_type_id`);

--
-- Indexes for table `transportstationtype`
--
ALTER TABLE `transportstationtype`
  ADD PRIMARY KEY (`station_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `district`
--
ALTER TABLE `district`
  MODIFY `district_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `placeofinterest`
--
ALTER TABLE `placeofinterest`
  MODIFY `POI_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `poi_image`
--
ALTER TABLE `poi_image`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publicservice`
--
ALTER TABLE `publicservice`
  MODIFY `public_service_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `servicearea`
--
ALTER TABLE `servicearea`
  MODIFY `service_area_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `servicetype`
--
ALTER TABLE `servicetype`
  MODIFY `service_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timezone`
--
ALTER TABLE `timezone`
  MODIFY `timezone_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transportstation`
--
ALTER TABLE `transportstation`
  MODIFY `station_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transportstationtype`
--
ALTER TABLE `transportstationtype`
  MODIFY `station_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `city_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`),
  ADD CONSTRAINT `city_ibfk_2` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`timezone_id`);

--
-- Constraints for table `district`
--
ALTER TABLE `district`
  ADD CONSTRAINT `district_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `placeofinterest`
--
ALTER TABLE `placeofinterest`
  ADD CONSTRAINT `placeofinterest_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`);

--
-- Constraints for table `poi_image`
--
ALTER TABLE `poi_image`
  ADD CONSTRAINT `poi_image_ibfk_1` FOREIGN KEY (`POI_id`) REFERENCES `placeofinterest` (`POI_id`);

--
-- Constraints for table `publicservice`
--
ALTER TABLE `publicservice`
  ADD CONSTRAINT `publicservice_ibfk_1` FOREIGN KEY (`service_area_id`) REFERENCES `servicearea` (`service_area_id`),
  ADD CONSTRAINT `publicservice_ibfk_2` FOREIGN KEY (`service_type_id`) REFERENCES `servicetype` (`service_type_id`);

--
-- Constraints for table `servicearea`
--
ALTER TABLE `servicearea`
  ADD CONSTRAINT `servicearea_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`);

--
-- Constraints for table `transportstation`
--
ALTER TABLE `transportstation`
  ADD CONSTRAINT `transportstation_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`),
  ADD CONSTRAINT `transportstation_ibfk_2` FOREIGN KEY (`station_type_id`) REFERENCES `transportstationtype` (`station_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
