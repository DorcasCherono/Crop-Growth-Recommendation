-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2019 at 06:27 PM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crops2`
--
CREATE DATABASE IF NOT EXISTS `crops2` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `crops2`;

-- --------------------------------------------------------

--
-- Table structure for table `cropdetails`
--

CREATE TABLE `cropdetails` (
  `id` int(15) NOT NULL,
  `crop_name` varchar(20) NOT NULL,
  `temperature_value` float NOT NULL,
  `ph_value` double NOT NULL,
  `moisture_value` double NOT NULL,
  `humidity_value` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cropdetails`
--

INSERT INTO `cropdetails` (`id`, `crop_name`, `temperature_value`, `ph_value`, `moisture_value`, `humidity_value`) VALUES
(1, 'Tea', 21, 4.5, 636, 95),
(2, 'maize', 18, 5.5, 544, 70),
(3, 'Beans', 15, 6, 610, 50),
(4, 'cotton', 27, 5.8, 451, 12),
(5, 'wheat', 15, 6, 570, 50),
(6, 'pyrethrum', 15, 5.6, 583, 70),
(7, 'cashewnuts', 25, 5, 689, 70),
(8, 'coffee', 20, 4.6, 319, 50),
(9, 'coconuts', 23, 5.5, 451, 80),
(10, 'bananas', 26, 5.5, 266, 71),
(11, 'flowers', 28, 6, 398, 50),
(12, 'sugarcane', 20, 6.5, 187, 71),
(13, 'pineapples', 22, 4.5, 544, 70),
(14, 'sisal', 20, 4, 522, 75),
(15, 'cloves', 26, 6.2, 451, 50),
(16, 'potatoes', 27, 5.3, 557, 85),
(17, 'cabbage', 15, 6.5, 603, 98),
(18, 'skumawiki', 17, 5.5, 319, 65),
(19, 'citrus', 7, 5.5, 438, 55),
(20, 'melon', 65, 6, 583, 90),
(21, 'onion', 28, 6, 597, 60),
(22, 'peanut', 15, 5.5, 556, 50),
(23, 'pea', 60, 6, 603, 50),
(24, 'pepper', 25, 5.5, 517, 50),
(25, 'rice', 25, 5.5, 563, 82),
(26, 'sorghum/millet', 15, 5, 570, 65),
(27, 'soybean', 20, 6, 563, 65),
(28, 'blueberries/roses', -20, 4.5, 450, 60),
(29, 'groundnuts', 20, 6, 500, 50),
(30, 'cucumber', 65, 5, 451, 60),
(31, 'lettuce', 60, 5.5, 454, 50),
(32, 'beetroots', 30, 4, 544, 98);

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `recommended_crop` varchar(20) NOT NULL,
  `temperature_value` float NOT NULL,
  `ph_value` double NOT NULL,
  `moisture_value` double NOT NULL,
  `humidity_value` double NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cropdetails`
--
ALTER TABLE `cropdetails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cropdetails`
--
ALTER TABLE `cropdetails`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
