-- Create DB
DROP DATABASE IF EXISTS db_course_conversions;
CREATE DATABASE db_course_conversions;
USE db_course_conversions;

-- Table structure for table `student_engagement`
DROP TABLE IF EXISTS `student_engagement`;
CREATE TABLE `student_engagement` (
  `student_id` int DEFAULT NULL,
  `date_watched` date DEFAULT NULL
);

-- Table structure for table `student_info`
DROP TABLE IF EXISTS 'student_info';
CREATE TABLE `student_info` (
  `student_id` int NOT NULL,
  `date_registered` date DEFAULT NULL,
  PRIMARY KEY (`student_id`)
);

-- Table structure for table `student_purchases`
DROP TABLE IF EXISTS `student_purchases`;
CREATE TABLE `student_purchases` (
  `purchase_id` int NOT NULL,
  `student_id` int DEFAULT NULL,
  `date_purchased` date DEFAULT NULL,
  PRIMARY KEY (`purchase_id`)
);
