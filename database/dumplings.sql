-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 08, 2019 at 05:32 AM
-- Server version: 5.7.21
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `dumplings`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_user`
--

CREATE TABLE `account_user` (
  `account_id` int(11) NOT NULL,
  `email` varchar(70) NOT NULL,
  `password` varchar(70) NOT NULL,
  `verified` tinyint(7) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `account_user`
--

INSERT INTO `account_user` (`account_id`, `email`, `password`, `verified`, `creation_time`) VALUES
(1, '752048018@qq.com', '202cb962ac59075b964b07152d234b70', 1, '2019-07-04 00:00:00'),
(4, 'email@braewebb.com', '482c811da5d5b4bc6d497ffa98491e38', 0, '2019-07-05 02:31:48');

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `activity_id` int(11) NOT NULL,
  `activity_name` varchar(70) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `picture_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`activity_id`, `activity_name`, `creation_time`, `picture_id`) VALUES
(2, 'basketball', '2019-07-04 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `initiator_id` int(11) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(70) NOT NULL,
  `location` varchar(70) NOT NULL,
  `start_time` datetime NOT NULL,
  `finish_time` datetime NOT NULL,
  `picture_id` int(11) NOT NULL,
  `minimum_number_participants` int(70) NOT NULL,
  `maximum_number_participants` int(70) NOT NULL,
  `cost` int(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `activity_id`, `initiator_id`, `creation_time`, `name`, `location`, `start_time`, `finish_time`, `picture_id`, `minimum_number_participants`, `maximum_number_participants`, `cost`) VALUES
(1, 2, 1, '2019-07-05 00:00:00', 'basketball', 'square', '2019-07-05 00:00:00', '2019-07-12 00:00:00', 1, 1, 20, 1);

-- --------------------------------------------------------

--
-- Table structure for table `logins`
--

CREATE TABLE `logins` (
  `login_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `logins`
--

INSERT INTO `logins` (`login_id`, `account_id`, `creation_time`) VALUES
(1, 1, '2019-07-05 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `participations`
--

CREATE TABLE `participations` (
  `participation_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `role` varchar(70) NOT NULL,
  `account_id` int(11) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `participations`
--

INSERT INTO `participations` (`participation_id`, `event_id`, `activity_id`, `role`, `account_id`, `creation_time`) VALUES
(1, 1, 2, 'organized', 1, '2019-07-05 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pictures`
--

CREATE TABLE `pictures` (
  `picture_id` int(11) NOT NULL,
  `image` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pictures`
--

INSERT INTO `pictures` (`picture_id`, `image`) VALUES
(1, '1.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `profile_user`
--

CREATE TABLE `profile_user` (
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `given_name` varchar(70) NOT NULL,
  `family_name` varchar(70) NOT NULL,
  `country` varchar(70) NOT NULL,
  `city` varchar(70) NOT NULL,
  `birthday` datetime NOT NULL,
  `sex` varchar(10) NOT NULL,
  `picture_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `profile_user`
--

INSERT INTO `profile_user` (`user_id`, `account_id`, `given_name`, `family_name`, `country`, `city`, `birthday`, `sex`, `picture_id`) VALUES
(1, 1, 'Mike', 'Brown', 'China', 'Dalian', '2019-07-02 00:00:00', 'man', 1);

-- --------------------------------------------------------

--
-- Table structure for table `quality_user`
--

CREATE TABLE `quality_user` (
  `rating_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `rating` int(70) NOT NULL,
  `count_visited_events` int(70) NOT NULL,
  `last_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rating_events`
--

CREATE TABLE `rating_events` (
  `rating_event_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `rate` int(70) NOT NULL,
  `creation_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rating_user`
--

CREATE TABLE `rating_user` (
  `rate_id` int(11) NOT NULL,
  `rater_account_id` int(11) NOT NULL,
  `ratee_account_id` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_user`
--
ALTER TABLE `account_user`
  ADD PRIMARY KEY (`account_id`);

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `activities_ibfk_1` (`picture_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `events_ibfk_1` (`initiator_id`),
  ADD KEY `picture_id` (`picture_id`);

--
-- Indexes for table `logins`
--
ALTER TABLE `logins`
  ADD PRIMARY KEY (`login_id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indexes for table `participations`
--
ALTER TABLE `participations`
  ADD PRIMARY KEY (`participation_id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `pictures`
--
ALTER TABLE `pictures`
  ADD PRIMARY KEY (`picture_id`);

--
-- Indexes for table `profile_user`
--
ALTER TABLE `profile_user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `profile_user_ibfk_1` (`account_id`),
  ADD KEY `picture_id` (`picture_id`);

--
-- Indexes for table `quality_user`
--
ALTER TABLE `quality_user`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indexes for table `rating_events`
--
ALTER TABLE `rating_events`
  ADD PRIMARY KEY (`rating_event_id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `rating_user`
--
ALTER TABLE `rating_user`
  ADD PRIMARY KEY (`rate_id`),
  ADD KEY `rater_account_id` (`rater_account_id`),
  ADD KEY `rating_user_ibfk_2` (`ratee_account_id`),
  ADD KEY `event_id` (`event_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_user`
--
ALTER TABLE `account_user`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `logins`
--
ALTER TABLE `logins`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `participations`
--
ALTER TABLE `participations`
  MODIFY `participation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pictures`
--
ALTER TABLE `pictures`
  MODIFY `picture_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `profile_user`
--
ALTER TABLE `profile_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quality_user`
--
ALTER TABLE `quality_user`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rating_events`
--
ALTER TABLE `rating_events`
  MODIFY `rating_event_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rating_user`
--
ALTER TABLE `rating_user`
  MODIFY `rate_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`picture_id`) REFERENCES `pictures` (`picture_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`initiator_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`picture_id`) REFERENCES `pictures` (`picture_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `logins`
--
ALTER TABLE `logins`
  ADD CONSTRAINT `logins_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `participations`
--
ALTER TABLE `participations`
  ADD CONSTRAINT `participations_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `participations_ibfk_2` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`activity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `participations_ibfk_3` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `profile_user`
--
ALTER TABLE `profile_user`
  ADD CONSTRAINT `profile_user_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `profile_user_ibfk_2` FOREIGN KEY (`picture_id`) REFERENCES `pictures` (`picture_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `quality_user`
--
ALTER TABLE `quality_user`
  ADD CONSTRAINT `quality_user_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rating_events`
--
ALTER TABLE `rating_events`
  ADD CONSTRAINT `rating_events_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `rating_events_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

--
-- Constraints for table `rating_user`
--
ALTER TABLE `rating_user`
  ADD CONSTRAINT `rating_user_ibfk_1` FOREIGN KEY (`rater_account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `rating_user_ibfk_2` FOREIGN KEY (`ratee_account_id`) REFERENCES `account_user` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `rating_user_ibfk_3` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
