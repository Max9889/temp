-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2026 at 03:38 PM
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
  `lng` decimal(9,6) NOT NULL,
  `population` int(11) NOT NULL,
  `mayor_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `GDP` bigint(20) NOT NULL,
  `currency` varchar(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `area` decimal(10,2) NOT NULL COMMENT 'Area in km^2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`city_id`, `country_id`, `timezone_id`, `city_name`, `lat`, `lng`, `population`, `mayor_name`, `GDP`, `currency`, `area`) VALUES
(1, 1, 1, 'Liverpool', 53.400002, -2.983333, 508961, 'Steve Rotheram', 20000000000, 'GBP', 134.00),
(2, 2, 2, 'Shanghai', 31.224361, 121.469170, 29558908, 'Gong Zheng', 610085763000, 'CNY', 6340.00);

-- --------------------------------------------------------

--
-- Table structure for table `relevant_news`
--

CREATE TABLE `relevant_news` (
  `relevant_news_id` int(11) NOT NULL,
  `news_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `relevant_news`
--

INSERT INTO `relevant_news` (`relevant_news_id`, `news_id`, `city_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
    `news_id` int(11) NOT NULL,
    `author_id` int(11) NOT NULL,
    `source_id` int(11) NOT NULL,
    `title` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
    `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
    `news_url` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
    `image_url` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
    `date_published` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`news_id`, `author_id`, `source_id`, `title`, `description`, `news_url`, `image_url`, `date_published`) VALUES
(1, 1, 1, "Almost 150 injured at LFC parade before Doyle incident", "Almost 150 people were injured during Liverpool FC's parade last May in circumstances not related to the Water Street incident, a new report has revealed.", "https://www.bbc.co.uk/news/articles/cewz7yrxw2jo", "https://ichef.bbci.co.uk/ace/standard/976/cpsprodpb/b7b9/live/baf5e460-1949-11f1-8e5e-abb58cd0aded.jpg.webp", "2026-03-06"),
(2, 2, 2, "Hong Kong, Shanghai sign pact on digital trade finance, cross-border data link", "Hong Kong and Shanghai have signed an accord deepening their collaboration in promoting digitised cargo trade finance and strengthening mainland China’s connection to the global data ecosystem.", "https://www.scmp.com/business/banking-finance/article/3345160/hong-kong-shanghai-sign-pact-digital-trade-finance-cross-border-data-link", "https://cdn.i-scmp.com/sites/default/files/styles/1200x800/public/d8/images/canvas/2026/03/02/af69a8ad-6145-424c-99ff-e83e2e1d18f7_31554b0d.jpg?itok=bi9Ck41B&v=1772448928", "2026-03-02"),
(3, 3, 1, "Liverpool to host Chinese art exhibition", "Liverpool has been announced as the host of Chinese art collection loaned by its twin city of Shanghai.", "https://www.bbc.co.uk/news/articles/cn425ypd7p1o", "https://ichef.bbci.co.uk/ace/standard/976/cpsprodpb/7e9a/live/3573ddd0-ff39-11f0-bcaf-15a49ee177e5.png.webp", "2026-02-02");

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `author_id` int(11) NOT NULL,
  `author_name` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`author_id`, `author_name`) VALUES
(1, "BBC News Team"),
(2, "Enoch Yiu"),
(3, "Stewart Whittingham");

-- --------------------------------------------------------

--
-- Table structure for table `source`
--

CREATE TABLE `source` (
  `source_id` int(11) NOT NULL,
  `source_name` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `source`
--

INSERT INTO `source` (`source_id`, `source_name`) VALUES
(1, "BBC News"),
(2, "South China Morning Post");

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_name`) VALUES
(1, 'England'),
(2, 'China');

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
  `lng` decimal(9,6) NOT NULL,
  `area` decimal(10,2) NOT NULL COMMENT 'Area in km^2',
  `population` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `district`
--

INSERT INTO `district` (`district_id`, `city_id`, `district_name`, `description`, `lat`, `lng`, `area`, `population`) VALUES
(1, 1, 'City Centre North', 'Covers part of the Vauxhall area and the northern portion of the city centre. This includes St George\'s Hall and Liverpool Town Hall.', 53.404000, -2.991000, 1.20, 10476),
(2, 1, 'City Centre South', 'The southern half of the commercial centre. Home to Liverpool ONE shopping complex, Bold Street, and the Ropewalks area. A hub for retail, nightlife, and student life given its proximity to university buildings.', 53.393100, -2.981800, 1.00, 10540),
(3, 1, 'Waterfront South', 'Covers the iconic riverside stretch including Pier Head, the Three Graces, Albert Dock, and the museums quarter. Seen as a primary tourist and cultural destination. ', 53.401800, -2.986300, 1.50, 3590),
(4, 1, 'Canning', 'Located on the southern edge of the city centre, canning encompasses the Georgian Quarter, Hope Street corridor, and Chinatown. It is also rich in Victorian and Georgian architecture.', 53.400200, -2.922400, 0.90, 10449),
(5, 1, 'Brownlow Hill', 'Centred around the university district, covering the campuses of the University of Liverpool and Liverpool John Moores University. It is a dense, student-heavy area with hospitals and research institutions.', 53.405700, -2.971000, 1.10, 10213),
(6, 2, 'Huangpu', 'Located on the west bank of the Huangpu River, it is the core of downtown Shanghai. Home to the Bund, Nanjing Road, People\'s Square, the Shanghai Museum, and Xintiandi.', 31.230000, 121.480000, 20.52, 656200),
(7, 2, 'Jing\'an', 'Located in downtown Shanghai. Jing\'an is  Considered the thriving centre of the city, densely populated with food, drink, restaurants, cafes, entertainment, and shopping, usually all within walking distance of each other.', 31.223500, 121.455900, 37.00, 975707),
(8, 2, 'Xuhui', 'Xuhui is a, prosperous, and culturally rich district in the heart of Shanghai, China, known for blending historical charm with modern, upscale development.', 31.188300, 121.436900, 54.93, 1113078),
(9, 2, 'Hongkou', 'Located in the northeast of downtown it is a core functional zone of Shanghai\'s central business district. A traditional district known for its historic Jewish heritage, local food culture, and Art Deco architecture.', 31.264500, 121.505100, 23.48, 757498),
(10, 2, 'Yangpu', 'Located in the northeast of downtown Shanghai, Yangpu is home to two of China\'s biggest universities: Fudan University and Tongji University, as well as the lively Wujiaochang commercial and student area', 31.259600, 121.526100, 60.61, 1242548),
(11, 2, 'Putuo', 'Putuo is characterized by urban development, the Suzhou Creek, and major transport hubs like Shanghai West Railway Station. It is known for attractions such as the Jade Buddha Temple and the Yuexing Global Harbor.', 31.249400, 121.397000, 55.53, 1288881);

-- --------------------------------------------------------

--
-- Table structure for table `POI`
--

CREATE TABLE `POI` (
  `POI_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `POI_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `lng` decimal(9,6) NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `area` decimal(10,2) NOT NULL COMMENT 'Area in km^2',
  `date_established` date NOT NULL,
  `accessibility_rating` tinyint(3) UNSIGNED NOT NULL CHECK (`accessibility_rating` between 0 and 10),
  `entry_fee` decimal(6,2) DEFAULT NULL COMMENT 'Fee in local currency',
  `visitor_capacity` int(11) NOT NULL,
  `image_filename` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `image_caption` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `POI`
--

INSERT INTO `POI` (`POI_id`, `district_id`, `POI_name`, `lat`, `lng`, `description`, `area`, `date_established`, `accessibility_rating`, `entry_fee`, `visitor_capacity`, `image_filename`, `image_caption`) VALUES
(1, 1, 'St George\'s Hall', 53.407300, -2.981400, 'A magnificent Grade I listed neoclassical building completed in 1854, housing concert rooms and a law court. One of the finest examples of neoclassical architecture in the world, now used as an events and cultural venue.', 0.02, '1854-09-18', 8, 0.00, 1500, 'st_georges_hall.jpg', 'The neoclassical facade of St George\'s Hall, Liverpool'),
(2, 1, 'Walker Art Gallery', 53.407600, -2.980700, 'One of the finest art galleries in the UK, opened in 1877. Houses an outstanding collection of paintings, sculpture and decorative art from the 13th century to the present day, including works by Rubens, Rembrandt and Hockney.', 0.03, '1877-09-06', 9, 0.00, 2000, 'walker_art_gallery.jpg', 'The Walker Art Gallery on William Brown Street'),
(3, 2, 'Liverpool ONE', 53.401400, -2.987600, 'A 42-acre open-air shopping and leisure complex in the heart of the city centre, opened in 2008. One of the largest city centre retail developments in Europe, home to over 170 stores, restaurants, and Chavasse Park.', 0.17, '2008-05-29', 9, 0.00, 30000, 'liverpool_one.jpg', 'Liverpool ONE open-air shopping complex'),
(4, 2, 'Cavern Club', 53.404000, -2.991300, 'The world-famous music venue on Mathew Street where The Beatles performed over 290 times in the early 1960s. The current club is a faithful reconstruction of the original and continues to host live music daily.', 0.01, '1957-01-16', 6, 4.00, 500, 'cavern_club.jpg', 'The iconic entrance to the Cavern Club on Mathew Street'),
(5, 3, 'Royal Albert Dock', 53.399700, -2.992300, 'A UNESCO World Heritage Site and the largest collection of Grade I listed buildings in the UK. Built in 1846, the restored Victorian dock complex is now home to museums, galleries, restaurants, bars and shops along the iconic waterfront.', 0.11, '1846-07-30', 8, 0.00, 20000, 'royal_albert_dock.jpg', 'The Victorian warehouses of Royal Albert Dock'),
(6, 3, 'Pier Head', 53.404500, -2.997000, 'The iconic riverside plaza at the heart of Liverpool\'s UNESCO World Heritage waterfront. Home to the Three Graces — the Royal Liver Building, Cunard Building and Port of Liverpool Building — as well as the Mersey Ferry terminal and statues of Beatles legends.', 0.05, '1847-01-01', 8, 0.00, 25000, 'pier_head.jpg', 'The Three Graces at Pier Head on the Liverpool waterfront'),
(7, 4, 'Liverpool Cathedral', 53.399400, -2.972400, 'The largest cathedral in the UK and the fifth largest in the world, completed in 1978 after 74 years of construction. A stunning example of Gothic Revival architecture with the highest and heaviest bells ever hung, and panoramic city views from the tower.', 0.09, '1904-07-19', 7, 0.00, 3000, 'liverpool_cathedral.jpg', 'Liverpool Anglican Cathedral from the south'),
(8, 4, 'Philharmonic Hall', 53.401800, -2.969200, 'Home to the Royal Liverpool Philharmonic Orchestra, one of the oldest symphony orchestras in the UK. The current Art Deco building, opened in 1939, is renowned as one of the finest concert halls in Europe with outstanding acoustics.', 0.02, '1849-08-27', 8, 15.00, 1750, 'philharmonic_hall.jpg', 'The Art Deco exterior of Philharmonic Hall on Hope Street'),
(9, 5, 'Victoria Gallery & Museum', 53.405800, -2.965900, 'The University of Liverpool\'s free museum and art gallery, housed in a stunning Victorian red brick building. Features collections of fine art, science and technology, and natural history, alongside changing exhibitions.', 0.02, '1892-01-01', 7, 0.00, 800, 'victoria_gallery.jpg', 'The Victorian facade of the Victoria Gallery & Museum'),
(10, 5, 'Liverpool Everyman Theatre', 53.402400, -2.967100, 'A renowned repertory theatre on Hope Street, originally founded in 1964. The current building, which reopened in 2013 after a major rebuild, won the RIBA Stirling Prize for architecture. Known for nurturing major theatrical talent including Alan Bleasdale and Willy Russell.', 0.01, '1964-01-01', 9, 12.00, 400, 'everyman_theatre.avif', 'The award-winning exterior of the Liverpool Everyman Theatre'),
(11, 6, 'The Bund', 31.240400, 121.490500, 'Shanghai\'s most iconic waterfront promenade stretching 1.5km along the Huangpu River. Features 52 buildings in a variety of architectural styles from the early 20th century. Offers spectacular views of the Pudong skyline across the river.', 0.15, '1846-01-01', 7, 0.00, 50000, 'the_bund.jpg', 'The historic waterfront buildings of the Bund at night'),
(12, 6, 'Xintiandi', 31.219700, 121.473700, 'A upscale pedestrianised entertainment and shopping district built around restored Shikumen stone-gate houses from the 1920s. A flagship urban regeneration project blending preserved heritage architecture with modern restaurants, boutiques, bars and galleries.', 0.09, '2001-01-01', 9, 0.00, 15000, 'xintiandi.jpg', 'Restored Shikumen houses in Xintiandi, Shanghai'),
(13, 7, 'Jing\'an Temple', 31.224400, 121.448000, 'One of Shanghai\'s most famous and active Buddhist temples, with origins dating back to 247 AD. The current ornate structure features gilded rooftops and houses a 3.8-metre jade Buddha, set dramatically against the backdrop of modern skyscrapers on Nanjing Road West.', 0.02, '1000-01-01', 6, 50.00, 3000, 'jingan_temple.jpg', 'The gilded rooftops of Jing\'an Temple against the Shanghai skyline'),
(14, 7, 'Nanjing Road West', 31.225500, 121.452400, 'The upscale western section of Shanghai\'s most famous shopping street, lined with luxury boutiques, international brands, and department stores. Stretching over 5km, it is one of the world\'s busiest retail streets and a key commercial artery of Jing\'an district.', 0.08, '1851-01-01', 8, 0.00, 100000, 'nanjing_road_west.jpg', 'Nanjing Road West lined with luxury boutiques'),
(15, 8, 'Former French Concession', 31.216500, 121.455400, 'A leafy, atmospheric neighbourhood covering much of Xuhui, characterised by tree-lined avenues, Art Deco villas, and converted lane houses. Originally administered by France from 1849, it is now home to boutique shops, cafes, restaurants and some of Shanghai\'s most sought-after residential streets.', 2.50, '1849-01-01', 7, 0.00, 20000, 'french_concession.jpg', 'Tree-lined avenue in the Former French Concession'),
(16, 8, 'Xujiahui Park', 31.194300, 121.437100, 'A large public park in the heart of the Xujiahui commercial district, opened in 1999 on the site of a former factory. Features lawns, lakes, and tree-lined paths providing a green respite from the surrounding shopping malls and transport interchange.', 0.18, '1999-01-01', 9, 0.00, 15000, 'xujiahui_park.jpg', 'Lakes and greenery in Xujiahui Park'),
(17, 9, 'Shanghai Jewish Refugees Museum', 31.265000, 121.502000, 'Located in the former Ohel Moshe Synagogue, the museum documents the lives of approximately 18,000 Jewish refugees who fled Nazi persecution to Shanghai between 1933 and 1941. Features personal artefacts, photographs and film testimonies.', 0.01, '2007-03-23', 8, 50.00, 500, 'jewish_refugees_museum.jpg', 'The former Ohel Moshe Synagogue housing the Jewish Refugees Museum'),
(18, 9, 'Lu Xun Park', 31.269900, 121.498100, 'A historic public park in northern Hongkou named after celebrated Chinese writer Lu Xun. Features the Lu Xun Memorial Hall, his tomb, and pleasant gardens with lakes and traditional Chinese pavilions. A popular spot for morning exercises and cultural events.', 0.22, '1896-01-01', 8, 0.00, 10000, 'lu_xun_park.jpg', 'Traditional pavilion in Lu Xun Park, Hongkou'),
(19, 10, 'Wujiaochang Shopping Area', 31.298000, 121.509700, 'The main commercial hub of Yangpu district, centred on a large pedestrianised zone surrounded by major shopping malls including Wanda Plaza and Bailian又一城. A busy retail, dining and entertainment destination popular with students from nearby Fudan and Tongji universities.', 0.30, '2000-01-01', 8, 0.00, 50000, 'wujiaochang.jpg', 'The busy pedestrianised Wujiaochang shopping area'),
(20, 10, 'Gongqing Forest Park', 31.314300, 121.527400, 'One of Shanghai\'s largest urban parks, covering 1.58 km² in the northeast of Yangpu district. Features dense woodland, lakes, cycling trails, a campsite and recreational facilities. A popular escape from the city for families and outdoor enthusiasts.', 1.58, '1986-01-01', 7, 15.00, 20000, 'gongqing_forest_park.jpg', 'Woodland trails in Gongqing Forest Park'),
(21, 11, 'Jade Buddha Temple', 31.251800, 121.447100, 'One of Shanghai\'s most active and revered Buddhist temples, famous for its two jade Buddha statues brought from Burma in 1882. The temple was built in 1928 and continues to be a working monastery, attracting both worshippers and tourists with its traditional Chinese Buddhist architecture.', 0.02, '1928-01-01', 6, 40.00, 5000, 'jade_buddha_temple.jpg', 'The ornate entrance to the Jade Buddha Temple'),
(22, 11, '1000 Trees', 31.238000, 121.418000, 'A striking contemporary mixed-use development designed by British architect Thomas Heatherwick, opened in 2021. Built on the banks of Suzhou Creek, the terraced structure is covered with over 1000 trees and plants. Houses shops, restaurants, a hotel and cultural spaces.', 0.10, '2021-01-01', 9, 0.00, 8000, '1000_trees.jpg', '1000 Trees development rising above Suzhou Creek');

-- --------------------------------------------------------

--
-- Table structure for table `public_service`
--

CREATE TABLE `public_service` (
  `service_id` int(11) NOT NULL,
  `service_area_id` int(11) NOT NULL,
  `service_type_id` int(11) NOT NULL,
  `service_name` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `lng` decimal(9,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `public_service`
--

INSERT INTO `public_service` (`service_id`, `service_area_id`, `service_type_id`, `service_name`, `description`, `lat`, `lng`) VALUES
(1, 1, 1, 'Liverpool Central Library', 'Liverpool Central Library is the main public library for the city, located on William Brown Street. It offers extensive research facilities, reading rooms, and community spaces.', 53.407100, -2.981100),
(2, 2, 2, 'Liverpool City Centre Police Station', 'Liverpool City Centre Police Station serves the southern city centre area, providing community policing and emergency response services for residents and visitors.', 53.403900, -2.988100),
(3, 3, 3, 'The Museum of Liverpool', 'The Museum of Liverpool on the waterfront is one of the largest purpose-built national museums in the UK, exploring the citys history, culture, and people.', 53.403500, -2.994400),
(4, 4, 4, 'Liverpool Womens Hospital', 'Liverpool Womens Hospital is a specialist NHS hospital providing maternity, gynaecology, and neonatal services, located on Crown Street in the Canning district.', 53.394600, -2.961800),
(5, 5, 5, 'The University of Liverpool', 'The University of Liverpool is a Russell Group research university founded in 1881, offering a wide range of undergraduate and postgraduate programmes across its Brownlow Hill campus.', 53.406400, -2.966200),
(6, 6, 3, 'The Shanghai Museum', 'The Shanghai Museum on People\'s Square is one of China\'s foremost museums, housing a collection of over 140,000 ancient Chinese art works including bronzes, ceramics, and calligraphy.', 31.228600, 121.473900),
(7, 7, 4, 'Jing\'an District Central Hospital', 'Jing\'an District Central Hospital is a major public hospital serving the residents of Jing\'an, offering a broad range of medical and surgical services.', 31.224500, 121.447200),
(8, 8, 1, 'Xuhui District Library', 'Xuhui District Library is a modern public library serving the Xuhui community, offering extensive Chinese and foreign language collections alongside digital research resources.', 31.188700, 121.436200),
(9, 9, 6, 'Hongkou District Post Office', 'Hongkou District Post Office provides postal and courier services to residents and businesses across the Hongkou area, located centrally within the district.', 31.264000, 121.503000),
(10, 10, 5, 'Fudan University', 'Fudan University is one of China\'s most prestigious universities, founded in 1905, offering world-class education and research across a wide range of disciplines.', 31.298000, 121.503600),
(11, 11, 4, 'Putuo District People\'s Hospital', 'Putuo District People\'s Hospital is a comprehensive public hospital providing emergency, medical, and surgical services to the residents of Putuo district.', 31.249800, 121.401200);

-- --------------------------------------------------------

--
-- Table structure for table `service_area`
--

CREATE TABLE `service_area` (
  `service_area_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service_area`
--

INSERT INTO `service_area` (`service_area_id`, `district_id`, `service_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 1, 2),
(5, 3, 3),
(6, 2, 3),
(7, 4, 4),
(8, 2, 4),
(9, 5, 5),
(10, 4, 5),
(11, 6, 6),
(12, 7, 6),
(13, 7, 7),
(14, 6, 7),
(15, 8, 8),
(16, 9, 9),
(17, 10, 10),
(18, 11, 11),
(19, 10, 11);

-- --------------------------------------------------------

--
-- Table structure for table `public_service_type`
--

CREATE TABLE `public_service_type` (
  `service_type_id` int(11) NOT NULL,
  `service_type_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `public_service_type`
--

INSERT INTO `public_service_type` (`service_type_id`, `service_type_name`) VALUES
(1, 'Library'),
(2, 'Police Station'),
(3, 'Museum'),
(4, 'Hospital'),
(5, 'University'),
(6, 'Post Office');

-- --------------------------------------------------------

--
-- Table structure for table `timezone`
--

CREATE TABLE `timezone` (
  `timezone_id` int(11) NOT NULL,
  `timezone_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `timezone`
--

INSERT INTO `timezone` (`timezone_id`, `timezone_name`) VALUES
(1, 'Europe/London'),
(2, 'Asia/Shanghai');

-- --------------------------------------------------------

--
-- Table structure for table `transport_station`
--

CREATE TABLE `transport_station` (
  `station_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `station_type_id` int(11) NOT NULL,
  `station_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `lng` decimal(9,6) NOT NULL,
  `toilets_available` tinyint(1) NOT NULL DEFAULT 0,
  `accessibility_rating` tinyint(3) UNSIGNED NOT NULL CHECK (`accessibility_rating` between 1 and 10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transport_station`
--

INSERT INTO `transport_station` (`station_id`, `district_id`, `station_type_id`, `station_name`, `description`, `lat`, `lng`, `toilets_available`, `accessibility_rating`) VALUES
(1, 1, 1, 'Liverpool Lime Street', 'Liverpool\'s principal railway station serving longer distance and local services.', 53.407500, -2.977700, 1, 9),
(2, 2, 2, 'Liverpool Central', 'Liverpool Central serves as the main underground interchange for the Northern and Wirral Lines, with step-free access to all platforms.', 53.403800, -2.979400, 1, 8),
(3, 3, 2, 'James Street', 'An underground station on the Wirral Line. Access to platforms is via lifts from the booking hall, and it serves as a key gateway to the Waterfront and business district.', 53.404800, -2.992000, 1, 7),
(4, 6, 3, 'People\'s Square', 'A major interchange station below People\'s Square, serving Lines 1, 2, and 8. One of the busiest metro stations in mainland China.', 31.230400, 121.473700, 1, 8),
(5, 7, 3, 'West Nanjing Road', 'A major interchange on Lines 2 and 13, situated at the heart of Jing\'an\'s commercial and luxury retail corridor.', 31.227100, 121.456500, 1, 8),
(6, 8, 3, 'Xujiahui', 'One of Shanghai\'s largest and most complex interchange stations, serving Lines 1, 9, and 11.', 31.194100, 121.432700, 1, 9),
(7, 9, 3, 'Hailun Road', 'An interchange station on Lines 4 and 10, serving as a key access point for the southern part of Hongkou district. ', 31.259300, 121.487600, 1, 7),
(8, 10, 3, 'Wujiaochang', 'Served by Line 10, Wujiaochang is the commercial and student hub of Yangpu, situated at a major road intersection surrounded by shopping centres, restaurants, and universities including Fudan.', 31.298050, 121.509700, 1, 7),
(9, 11, 3, 'Zhongshan Park', 'A significant multi-line interchange serving Lines 2, 3, and 4, located adjacent to Zhongshan Park and a large retail complex.', 31.224400, 121.412400, 1, 8);

-- --------------------------------------------------------

--
-- Table structure for table `transport_station_type`
--

CREATE TABLE `transport_station_type` (
  `station_type_id` int(11) NOT NULL,
  `station_type_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transport_station_type`
--

INSERT INTO `transport_station_type` (`station_type_id`, `station_type_name`) VALUES
(1, 'National Rail'),
(2, 'Suburban Rail'),
(3, 'Metro');

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
-- Indexes for table `relevant_news`
--
ALTER TABLE `relevant_news`
  ADD PRIMARY KEY (`relevant_news_id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`news_id`),
  ADD KEY `author_id` (`author_id`),
  ADD KEY `source_id` (`source_id`);

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `source`
--
ALTER TABLE `source`
  ADD PRIMARY KEY (`source_id`);

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
-- Indexes for table `POI`
--
ALTER TABLE `POI`
  ADD PRIMARY KEY (`POI_id`),
  ADD KEY `district_id` (`district_id`);

--
-- Indexes for table `public_service`
--
ALTER TABLE `public_service`
  ADD PRIMARY KEY (`service_id`),
  ADD KEY `service_area_id` (`service_area_id`),
  ADD KEY `service_type_id` (`service_type_id`);

--
-- Indexes for table `service_area`
--
ALTER TABLE `service_area`
  ADD PRIMARY KEY (`service_area_id`),
  ADD KEY `district_id` (`district_id`);

--
-- Indexes for table `public_service_type`
--
ALTER TABLE `public_service_type`
  ADD PRIMARY KEY (`service_type_id`);

--
-- Indexes for table `timezone`
--
ALTER TABLE `timezone`
  ADD PRIMARY KEY (`timezone_id`);

--
-- Indexes for table `transport_station`
--
ALTER TABLE `transport_station`
  ADD PRIMARY KEY (`station_id`),
  ADD KEY `district_id` (`district_id`),
  ADD KEY `station_type_id` (`station_type_id`);

--
-- Indexes for table `transport_station_type`
--
ALTER TABLE `transport_station_type`
  ADD PRIMARY KEY (`station_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `relevant_news`
--
ALTER TABLE `relevant_news`
  MODIFY `relevant_news_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `news_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `author_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `source`
--
ALTER TABLE `source`
  MODIFY `source_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `district`
--
ALTER TABLE `district`
  MODIFY `district_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `POI`
--
ALTER TABLE `POI`
  MODIFY `POI_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `public_service`
--
ALTER TABLE `public_service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `service_area`
--
ALTER TABLE `service_area`
  MODIFY `service_area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `public_service_type`
--
ALTER TABLE `public_service_type`
  MODIFY `service_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `timezone`
--
ALTER TABLE `timezone`
  MODIFY `timezone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transport_station`
--
ALTER TABLE `transport_station`
  MODIFY `station_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `transport_station_type`
--
ALTER TABLE `transport_station_type`
  MODIFY `station_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- Constraints for table `relevant_news`
--
ALTER TABLE `relevant_news`
  ADD CONSTRAINT `relevant_news_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news` (`news_id`),
  ADD CONSTRAINT `relevant_news_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`),
  ADD CONSTRAINT `news_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `source` (`source_id`);

--
-- Constraints for table `district`
--
ALTER TABLE `district`
  ADD CONSTRAINT `district_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `POI`
--
ALTER TABLE `POI`
  ADD CONSTRAINT `POI_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`);

--
-- Constraints for table `public_service`
--
ALTER TABLE `public_service`
  ADD CONSTRAINT `public_service_ibfk_1` FOREIGN KEY (`service_area_id`) REFERENCES `service_area` (`service_area_id`),
  ADD CONSTRAINT `public_service_ibfk_2` FOREIGN KEY (`service_type_id`) REFERENCES `public_service_type` (`service_type_id`);

--
-- Constraints for table `service_area`
--
ALTER TABLE `service_area`
  ADD CONSTRAINT `service_area_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`);

--
-- Constraints for table `transport_station`
--
ALTER TABLE `transport_station`
  ADD CONSTRAINT `transport_station_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`),
  ADD CONSTRAINT `transport_station_ibfk_2` FOREIGN KEY (`station_type_id`) REFERENCES `transport_station_type` (`station_type_id`);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
