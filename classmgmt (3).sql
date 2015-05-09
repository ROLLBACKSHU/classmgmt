-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2015-05-07 18:34:20
-- 服务器版本： 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `classmgmt`
--

-- --------------------------------------------------------

--
-- 表的结构 `auth_assignment`
--

CREATE TABLE IF NOT EXISTS `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `auth_item`
--

CREATE TABLE IF NOT EXISTS `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `auth_item_child`
--

CREATE TABLE IF NOT EXISTS `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `auth_rule`
--

CREATE TABLE IF NOT EXISTS `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `choose`
--

CREATE TABLE IF NOT EXISTS `choose` (
  `stu_id` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `semester` char(11) COLLATE utf8_unicode_ci NOT NULL,
  `class_id` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `prof_id` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `grade_basic` int(11) DEFAULT NULL,
  `grade_exam` int(11) DEFAULT NULL,
  `grade_acc` int(11) DEFAULT NULL,
  PRIMARY KEY (`stu_id`,`semester`,`class_id`,`prof_id`),
  KEY `choose-class` (`class_id`),
  KEY `choose-prof` (`prof_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `class`
--

CREATE TABLE IF NOT EXISTS `class` (
  `class_id` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `class_name` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `credit` int(1) NOT NULL,
  `credit_hour` int(2) NOT NULL,
  `dept_id` char(2) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`class_id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `department`
--

CREATE TABLE IF NOT EXISTS `department` (
  `dept_id` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `dept_name` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `dept_address` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `dept_phone` char(8) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Department info table';

-- --------------------------------------------------------

--
-- 表的结构 `migration`
--

CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1429956094),
('m130524_201442_init', 1430138595),
('m140506_102106_rbac_init', 1429957255);

-- --------------------------------------------------------

--
-- 表的结构 `opening`
--

CREATE TABLE IF NOT EXISTS `opening` (
  `semester` char(11) COLLATE utf8_unicode_ci NOT NULL,
  `class_id` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `prof_id` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `class_time` char(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`semester`,`class_id`,`prof_id`),
  KEY `open-class` (`class_id`),
  KEY `open-prof` (`prof_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `professor`
--

CREATE TABLE IF NOT EXISTS `professor` (
  `prof_id` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `prof_name` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `prof_gender` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `prof_birthdate` date NOT NULL,
  `prof_position` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `prof_salary` decimal(10,2) NOT NULL,
  `dept_id` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`prof_id`),
  KEY `dept_id` (`dept_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Professor info table';

-- --------------------------------------------------------

--
-- 表的结构 `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `stu_id` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `stu_name` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `stu_gender` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `stu_birthdate` date NOT NULL,
  `stu_birthplace` char(4) COLLATE utf8_unicode_ci NOT NULL,
  `stu_cell` char(11) COLLATE utf8_unicode_ci NOT NULL,
  `dept_id` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`stu_id`),
  KEY `dept_id` (`dept_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Student info table';

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `status`, `created_at`, `updated_at`) VALUES
(1, 'yeeking', '', '$2y$13$6l7a7KD/j8V.uKQdKZfxRuU/yVfDhbSWOBlP9Vr3Jy52L/as8zV5W', NULL, 'yijunzhou88@hotmail.com', 10, 0, 0);

--
-- 限制导出的表
--

--
-- 限制表 `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `auth_item`
--
ALTER TABLE `auth_item`
  ADD CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- 限制表 `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `choose`
--
ALTER TABLE `choose`
  ADD CONSTRAINT `choose-class` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `choose-prof` FOREIGN KEY (`prof_id`) REFERENCES `professor` (`prof_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `choose-stu` FOREIGN KEY (`stu_id`) REFERENCES `student` (`stu_id`) ON UPDATE CASCADE;

--
-- 限制表 `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class-dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON UPDATE CASCADE;

--
-- 限制表 `opening`
--
ALTER TABLE `opening`
  ADD CONSTRAINT `open-class` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `open-prof` FOREIGN KEY (`prof_id`) REFERENCES `professor` (`prof_id`) ON UPDATE CASCADE;

--
-- 限制表 `professor`
--
ALTER TABLE `professor`
  ADD CONSTRAINT `prof-user` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `prof-dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON UPDATE CASCADE;

--
-- 限制表 `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `stu-user` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `stu-dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
