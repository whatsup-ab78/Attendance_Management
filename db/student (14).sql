-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 11, 2026 at 05:31 AM
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
-- Database: `student`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add acknowledgement', 7, 'add_acknowledgement'),
(26, 'Can change acknowledgement', 7, 'change_acknowledgement'),
(27, 'Can delete acknowledgement', 7, 'delete_acknowledgement'),
(28, 'Can view acknowledgement', 7, 'view_acknowledgement'),
(29, 'Can add assign', 8, 'add_assign'),
(30, 'Can change assign', 8, 'change_assign'),
(31, 'Can delete assign', 8, 'delete_assign'),
(32, 'Can view assign', 8, 'view_assign'),
(33, 'Can add hod', 9, 'add_hod'),
(34, 'Can change hod', 9, 'change_hod'),
(35, 'Can delete hod', 9, 'delete_hod'),
(36, 'Can view hod', 9, 'view_hod'),
(37, 'Can add pcomplaint', 10, 'add_pcomplaint'),
(38, 'Can change pcomplaint', 10, 'change_pcomplaint'),
(39, 'Can delete pcomplaint', 10, 'delete_pcomplaint'),
(40, 'Can view pcomplaint', 10, 'view_pcomplaint'),
(41, 'Can add principals', 11, 'add_principals'),
(42, 'Can change principals', 11, 'change_principals'),
(43, 'Can delete principals', 11, 'delete_principals'),
(44, 'Can view principals', 11, 'view_principals'),
(45, 'Can add prodetails', 12, 'add_prodetails'),
(46, 'Can change prodetails', 12, 'change_prodetails'),
(47, 'Can delete prodetails', 12, 'delete_prodetails'),
(48, 'Can view prodetails', 12, 'view_prodetails'),
(49, 'Can add staffcomplaint', 13, 'add_staffcomplaint'),
(50, 'Can change staffcomplaint', 13, 'change_staffcomplaint'),
(51, 'Can delete staffcomplaint', 13, 'delete_staffcomplaint'),
(52, 'Can view staffcomplaint', 13, 'view_staffcomplaint'),
(53, 'Can add stdcomplaint', 14, 'add_stdcomplaint'),
(54, 'Can change stdcomplaint', 14, 'change_stdcomplaint'),
(55, 'Can delete stdcomplaint', 14, 'delete_stdcomplaint'),
(56, 'Can view stdcomplaint', 14, 'view_stdcomplaint'),
(57, 'Can add students', 15, 'add_students'),
(58, 'Can change students', 15, 'change_students'),
(59, 'Can delete students', 15, 'delete_students'),
(60, 'Can view students', 15, 'view_students'),
(61, 'Can add teachers', 16, 'add_teachers'),
(62, 'Can change teachers', 16, 'change_teachers'),
(63, 'Can delete teachers', 16, 'delete_teachers'),
(64, 'Can view teachers', 16, 'view_teachers'),
(65, 'Can add student_attendance', 17, 'add_student_attendance'),
(66, 'Can change student_attendance', 17, 'change_student_attendance'),
(67, 'Can delete student_attendance', 17, 'delete_student_attendance'),
(68, 'Can view student_attendance', 17, 'view_student_attendance'),
(69, 'Can add chat message', 18, 'add_chatmessage'),
(70, 'Can change chat message', 18, 'change_chatmessage'),
(71, 'Can delete chat message', 18, 'delete_chatmessage'),
(72, 'Can view chat message', 18, 'view_chatmessage'),
(73, 'Can add teacher_attendance', 19, 'add_teacher_attendance'),
(74, 'Can change teacher_attendance', 19, 'change_teacher_attendance'),
(75, 'Can delete teacher_attendance', 19, 'delete_teacher_attendance'),
(76, 'Can view teacher_attendance', 19, 'view_teacher_attendance');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'studentgrievence', 'acknowledgement'),
(8, 'studentgrievence', 'assign'),
(18, 'studentgrievence', 'chatmessage'),
(9, 'studentgrievence', 'hod'),
(10, 'studentgrievence', 'pcomplaint'),
(11, 'studentgrievence', 'principals'),
(12, 'studentgrievence', 'prodetails'),
(13, 'studentgrievence', 'staffcomplaint'),
(14, 'studentgrievence', 'stdcomplaint'),
(15, 'studentgrievence', 'students'),
(17, 'studentgrievence', 'student_attendance'),
(16, 'studentgrievence', 'teachers'),
(19, 'studentgrievence', 'teacher_attendance');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-02-06 08:33:45.820968'),
(2, 'auth', '0001_initial', '2026-02-06 08:33:46.473076'),
(3, 'admin', '0001_initial', '2026-02-06 08:33:46.664451'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-02-06 08:33:46.686316'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-02-06 08:33:46.699698'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-02-06 08:33:46.796515'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-02-06 08:33:47.034485'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-02-06 08:33:47.104528'),
(9, 'auth', '0004_alter_user_username_opts', '2026-02-06 08:33:47.120342'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-02-06 08:33:47.200713'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-02-06 08:33:47.206732'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-02-06 08:33:47.219603'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-02-06 08:33:47.244593'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-02-06 08:33:47.269173'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-02-06 08:33:47.292203'),
(16, 'auth', '0011_update_proxy_permissions', '2026-02-06 08:33:47.304039'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-02-06 08:33:47.326950'),
(18, 'sessions', '0001_initial', '2026-02-06 08:33:47.392646'),
(19, 'studentgrievence', '0001_initial', '2026-02-06 08:33:47.620301'),
(20, 'studentgrievence', '0002_student_attendance', '2026-02-06 08:33:47.651855'),
(21, 'studentgrievence', '0003_student_attendance_time', '2026-02-06 09:11:55.484533'),
(22, 'studentgrievence', '0004_auto_20260205_2229', '2026-02-06 09:11:55.597032'),
(23, 'studentgrievence', '0005_chatmessage', '2026-02-06 09:42:20.772837'),
(24, 'studentgrievence', '0004_add_slot_field', '2026-02-09 19:14:51.729818'),
(25, 'studentgrievence', '0006_merge_0004_add_slot_field_0005_chatmessage', '2026-02-09 19:14:51.744424'),
(26, 'studentgrievence', '0007_students_parent_email', '2026-02-09 19:55:39.934476'),
(27, 'studentgrievence', '0008_teacher_attendance', '2026-02-10 15:24:22.197965'),
(28, 'studentgrievence', '0009_delete_teacher_attendance', '2026-02-10 15:32:26.806496');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('an1nmfftrjogks633ribf4bz5t2f8j8o', 'e30:1vpqrv:MJHTBMOwkgFtjSkrx2DU57mQrQtPyBiojLJtmxNUdGo', '2026-02-24 16:45:43.448131'),
('e8uyfpqg780kr963ttl0pniixpb3hz1y', '.eJyrVirJTFGyMtRRykvMTVWyUvJNzMnMy1TSUUrNTczMAQrkggUc0kFcveT8XKBUaXFqEVAGTNUCALkkFWU:1vq1mf:r3pvizku8-suaAfCk0JCodMsiVNaXktezHxH4d0Bby4', '2026-02-25 04:25:01.193717'),
('l4ht9bne2z023igbyoknymhjnc0qyolq', 'e30:1voIXm:nehSMBCMPFMITvqIfCWqW5eV9h6R1_iYRCmj4N7n6q0', '2026-02-20 09:54:30.961465'),
('uqkp238wsduk1ozpy6ttrk8zhctq2g6d', '.eJyrVsrJT8_MK0lJLUnMzFGyUkpMyc3Mc0jPBfL0kvNzlXQgIjAZpVoAy3IRew:1voLks:-hnMSjhrBbeTStBeidEl4-cCN7LruA1937fD2n-6FIc', '2026-02-20 13:20:14.814822'),
('w1vzkfy7xpvgi3yoqrnecse22w1n0h1a', '.eJyrVsrJT8_MK0lJLUnMzFGyUkpMyc3Mc0jPBfL0kvNzlXQgIjAZpVoAy3IRew:1vpXTX:Kd8xdalk_bLGaiLqR0NprLnVBT4eHP9CAeTXU708GCE', '2026-02-23 20:03:15.643111');

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_acknowledgement`
--

CREATE TABLE `studentgrievence_acknowledgement` (
  `id` bigint(20) NOT NULL,
  `ack` varchar(150) NOT NULL,
  `status` varchar(150) NOT NULL,
  `date` varchar(150) NOT NULL,
  `cid` varchar(150) NOT NULL,
  `apid` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_assign`
--

CREATE TABLE `studentgrievence_assign` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `date` varchar(150) NOT NULL,
  `cmpid` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_chatmessage`
--

CREATE TABLE `studentgrievence_chatmessage` (
  `id` bigint(20) NOT NULL,
  `sender` varchar(150) NOT NULL,
  `role` varchar(50) NOT NULL,
  `message` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentgrievence_chatmessage`
--

INSERT INTO `studentgrievence_chatmessage` (`id`, `sender`, `role`, `message`, `created_at`) VALUES
(1, 'Tency', 'hod', 'Gd Morning All', '2026-02-06 09:44:49.050085'),
(2, 'Malini', 'teacher', 'Good Mrng', '2026-02-06 09:45:49.573006'),
(3, 'Anna', 'student', 'Gd Mrng', '2026-02-06 09:46:42.724941'),
(4, 'Anna', 'student', 'hlo', '2026-02-06 13:00:07.500530'),
(5, 'Malini', 'teacher', 'hlo', '2026-02-06 13:01:06.828752'),
(6, 'Admin', 'admin', 'hyyy', '2026-02-06 13:21:09.225129');

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_hod`
--

CREATE TABLE `studentgrievence_hod` (
  `id` bigint(20) NOT NULL,
  `p_name` varchar(150) NOT NULL,
  `p_age` varchar(150) NOT NULL,
  `p_email` varchar(150) NOT NULL,
  `p_phone` varchar(150) NOT NULL,
  `p_password` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentgrievence_hod`
--

INSERT INTO `studentgrievence_hod` (`id`, `p_name`, `p_age`, `p_email`, `p_phone`, `p_password`) VALUES
(1, 'Tency', '45', 'tency@gmail.com', '8679874567', 'tency@03');

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_pcomplaint`
--

CREATE TABLE `studentgrievence_pcomplaint` (
  `id` bigint(20) NOT NULL,
  `complaint` varchar(150) NOT NULL,
  `status` varchar(150) NOT NULL,
  `uid` varchar(150) NOT NULL,
  `princy` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_principals`
--

CREATE TABLE `studentgrievence_principals` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phone` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_prodetails`
--

CREATE TABLE `studentgrievence_prodetails` (
  `id` bigint(20) NOT NULL,
  `p_name` varchar(150) NOT NULL,
  `p_age` varchar(150) NOT NULL,
  `p_email` varchar(150) NOT NULL,
  `p_phone` varchar(150) NOT NULL,
  `p_password` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_staffcomplaint`
--

CREATE TABLE `studentgrievence_staffcomplaint` (
  `id` bigint(20) NOT NULL,
  `complaint` varchar(150) NOT NULL,
  `status` varchar(150) NOT NULL,
  `uid` varchar(150) NOT NULL,
  `princy` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentgrievence_staffcomplaint`
--

INSERT INTO `studentgrievence_staffcomplaint` (`id`, `complaint`, `status`, `uid`, `princy`) VALUES
(1, 'hello', 'pending', 'Anna', 'Malini'),
(2, 'hello teacher', 'pending', 'Anna', 'Malini'),
(3, 'hlo Mam', 'pending', 'Anna', 'Malini'),
(5, 'hi', 'pending', 'Rahul Kumar', 'Gokul');

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_stdcomplaint`
--

CREATE TABLE `studentgrievence_stdcomplaint` (
  `id` bigint(20) NOT NULL,
  `complaint` varchar(150) NOT NULL,
  `status` varchar(150) NOT NULL,
  `uid` varchar(150) NOT NULL,
  `hod` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentgrievence_stdcomplaint`
--

INSERT INTO `studentgrievence_stdcomplaint` (`id`, `complaint`, `status`, `uid`, `hod`) VALUES
(1, 'abcd', 'pending', 'Anna', ''),
(2, 'hello hod', 'pending', 'Anna', 'Tency'),
(3, 'hlo Sir', 'pending', 'Anna', 'Tency'),
(4, 'Ashwathy', 'pending', 'Anna', 'Tency');

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_students`
--

CREATE TABLE `studentgrievence_students` (
  `id` bigint(20) NOT NULL,
  `st_name` varchar(150) NOT NULL,
  `st_email` varchar(150) NOT NULL,
  `st_department` varchar(150) NOT NULL,
  `st_semester` varchar(150) NOT NULL,
  `st_phone` varchar(150) NOT NULL,
  `st_password` varchar(150) NOT NULL,
  `st_fathername` varchar(150) NOT NULL,
  `parent_email` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentgrievence_students`
--

INSERT INTO `studentgrievence_students` (`id`, `st_name`, `st_email`, `st_department`, `st_semester`, `st_phone`, `st_password`, `st_fathername`, `parent_email`) VALUES
(1, 'Anna', 'anna@gmail.com', 'MCA', '2', '8958345678', 'Annamol@03', 'Rajesh', NULL),
(2, 'riya', 'ririyasaji@gmail.com', 'computer science', '6th', '8281149770', 'Riya@1234', 'shiji ka', NULL),
(4, 'riya', 'ririyasaji@gmail.com', 'computer science', '6th', '8281149770', 'Riya@1234', 'shiji ka', NULL),
(5, 'aswathy', 'a@gmail.com', 'mca', '1', '9718712510', 'Achu@1234', 'abu', NULL),
(6, 'aswathy', 'a@gmail.com', 'mca', '1', '9718712510', 'Achu@1234', 'abu', NULL),
(7, 'aswathy', 'a@gmail.com', 'mca', '1', '9718712510', 'Achu@1234', 'abu', NULL),
(8, 'aswathy', 'ab@gmail.com', 'mca', '1', '9718712510', 'Achu@1234', 'abu', NULL),
(9, 'aswathy', 'ab@gmail.com', 'mca', '1', '9718712510', 'Achu@1234', 'abu', NULL),
(10, 'aswathy2', 'ab@gmail.com', 'mca', '1', '9718712510hh', 'Achu@1234', 'abu', NULL),
(11, 'aswathy2', 'ab@gmail.com', 'mca', '1', '9718712510hh', 'Achu@12345', 'abu', NULL),
(12, 'aswathy2', 'ab@gmail.com', 'mca', '1', '9718712510hh', 'Achu@12345', 'abu', NULL),
(13, 'aswathy2', 'ab@gmail.com', 'mca', '1', '9718712510hh', 'Achu@12345', 'abu', NULL),
(14, 'gv', 'gv@gmail.com', 'mca', '1', '09718712510', 'Gokul@123#', 'w', NULL),
(15, 'Rahul Kumar', 'rahul.kumar@test.com', 'Computer Science', 'Semester 6', '9876543210', 'test123', 'Mr. Kumar', 'gokulvishnu2021@gmail.com'),
(16, 'Priya Sharma', 'priya.sharma@test.com', 'Computer Science', 'Semester 6', '9876543211', 'test123', 'Mr. Sharma', NULL),
(17, 'Amit Patel', 'amit.patel@test.com', 'Information Technology', 'Semester 6', '9876543212', 'test123', 'Mr. Patel', NULL),
(18, 'Sneha Reddy', 'sneha.reddy@test.com', 'Computer Science', 'Semester 6', '9876543213', 'test123', 'Mr. Reddy', NULL),
(19, 'Vikram Singh', 'vikram.singh@test.com', 'Information Technology', 'Semester 6', '9876543214', 'test123', 'Mr. Singh', NULL),
(20, 'Anjali Gupta', 'anjali.gupta@test.com', 'Computer Science', 'Semester 6', '9876543215', 'test123', 'Mr. Gupta', NULL),
(21, 'Rohan Verma', 'rohan.verma@test.com', 'Information Technology', 'Semester 6', '9876543216', 'test123', 'Mr. Verma', NULL),
(22, 'Kavya Nair', 'kavya.nair@test.com', 'Computer Science', 'Semester 6', '9876543217', 'test123', 'Mr. Nair', NULL),
(23, 'Arjun Mehta', 'arjun.mehta@test.com', 'Information Technology', 'Semester 6', '9876543218', 'test123', 'Mr. Mehta', NULL),
(24, 'Pooja Desai', 'pooja.desai@test.com', 'Computer Science', 'Semester 6', '9876543219', 'test123', 'Mr. Desai', NULL),
(25, 'Karan Joshi', 'karan.joshi@test.com', 'Information Technology', 'Semester 6', '9876543220', 'test123', 'Mr. Joshi', NULL),
(26, 'Divya Iyer', 'divya.iyer@test.com', 'Computer Science', 'Semester 6', '9876543221', 'test123', 'Mr. Iyer', NULL),
(27, 'Siddharth Rao', 'siddharth.rao@test.com', 'Information Technology', 'Semester 6', '9876543222', 'test123', 'Mr. Rao', NULL),
(28, 'Neha Kapoor', 'neha.kapoor@test.com', 'Computer Science', 'Semester 6', '9876543223', 'test123', 'Mr. Kapoor', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_student_attendance`
--

CREATE TABLE `studentgrievence_student_attendance` (
  `id` bigint(20) NOT NULL,
  `st_id` varchar(150) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(150) NOT NULL,
  `time` time(6) NOT NULL,
  `slot` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentgrievence_student_attendance`
--

INSERT INTO `studentgrievence_student_attendance` (`id`, `st_id`, `date`, `status`, `time`, `slot`) VALUES
(1, '1', '2026-02-06', 'entry', '14:45:14.000000', NULL),
(2, '3', '2026-02-06', 'entry', '14:45:38.000000', NULL),
(3, '1', '2026-02-06', 'entry', '15:00:12.000000', NULL),
(4, '3', '2026-02-06', 'entry', '15:00:13.000000', NULL),
(5, '3', '2026-02-06', 'entry', '18:33:47.000000', NULL),
(6, '1', '2026-02-06', 'exit', '19:34:05.000000', NULL),
(7, '1', '2026-02-05', 'entry', '14:45:14.000000', NULL),
(8, '1', '2026-02-05', 'exit', '17:34:05.000000', NULL),
(9, '2', '2026-02-06', 'exit', '18:52:03.000000', NULL),
(10, '15', '2026-02-10', 'entry', '11:04:00.000000', 3),
(11, '15', '2026-02-10', 'exit', '11:58:00.000000', 3),
(12, '15', '2026-02-10', 'entry', '09:55:00.000000', 2),
(13, '15', '2026-02-10', 'exit', '10:50:00.000000', 2),
(14, '15', '2026-02-10', 'entry', '08:55:00.000000', 1),
(15, '15', '2026-02-10', 'exit', '09:51:00.000000', 1),
(16, '15', '2026-02-10', 'entry', '11:59:00.000000', 4),
(17, '15', '2026-02-10', 'exit', '12:53:00.000000', 4),
(18, '15', '2026-02-10', 'entry', '14:56:00.000000', 6),
(19, '15', '2026-02-10', 'exit', '15:56:00.000000', 6),
(20, '17', '2026-02-10', 'entry', '15:04:00.000000', 6),
(21, '17', '2026-02-10', 'exit', '15:56:00.000000', 6),
(22, '17', '2026-02-10', 'entry', '13:55:00.000000', 5),
(23, '17', '2026-02-10', 'exit', '14:59:00.000000', 5),
(24, '17', '2026-02-10', 'entry', '08:57:00.000000', 1),
(25, '17', '2026-02-10', 'exit', '10:00:00.000000', 1),
(26, '17', '2026-02-10', 'entry', '10:55:00.000000', 3),
(27, '17', '2026-02-10', 'exit', '11:52:00.000000', 3),
(28, '18', '2026-02-10', 'entry', '14:01:00.000000', 5),
(29, '18', '2026-02-10', 'exit', '15:00:00.000000', 5),
(30, '18', '2026-02-10', 'entry', '11:05:00.000000', 3),
(31, '18', '2026-02-10', 'exit', '11:57:00.000000', 3),
(32, '19', '2026-02-10', 'entry', '08:57:00.000000', 1),
(33, '19', '2026-02-10', 'exit', '09:51:00.000000', 1),
(34, '19', '2026-02-10', 'entry', '09:57:00.000000', 2),
(35, '19', '2026-02-10', 'exit', '10:51:00.000000', 2),
(36, '19', '2026-02-10', 'entry', '11:18:00.000000', 3),
(37, '19', '2026-02-10', 'exit', '11:55:00.000000', 3),
(38, '19', '2026-02-10', 'entry', '12:20:00.000000', 4),
(39, '19', '2026-02-10', 'exit', '12:52:00.000000', 4),
(40, '19', '2026-02-10', 'entry', '13:58:00.000000', 5),
(41, '19', '2026-02-10', 'exit', '14:58:00.000000', 5),
(42, '19', '2026-02-10', 'entry', '15:13:00.000000', 6),
(43, '19', '2026-02-10', 'exit', '15:55:00.000000', 6),
(44, '20', '2026-02-10', 'entry', '09:11:00.000000', 1),
(45, '20', '2026-02-10', 'exit', '09:55:00.000000', 1),
(46, '20', '2026-02-10', 'entry', '09:55:00.000000', 2),
(47, '20', '2026-02-10', 'exit', '10:59:00.000000', 2),
(48, '20', '2026-02-10', 'entry', '11:12:00.000000', 3),
(49, '20', '2026-02-10', 'exit', '11:57:00.000000', 3),
(50, '20', '2026-02-10', 'entry', '11:58:00.000000', 4),
(51, '20', '2026-02-10', 'exit', '12:56:00.000000', 4),
(52, '20', '2026-02-10', 'entry', '14:14:00.000000', 5),
(53, '20', '2026-02-10', 'exit', '14:57:00.000000', 5),
(54, '20', '2026-02-10', 'entry', '15:05:00.000000', 6),
(55, '20', '2026-02-10', 'exit', '15:53:00.000000', 6),
(56, '21', '2026-02-10', 'entry', '15:00:00.000000', 6),
(57, '21', '2026-02-10', 'exit', '15:55:00.000000', 6),
(58, '21', '2026-02-10', 'entry', '14:02:00.000000', 5),
(59, '21', '2026-02-10', 'exit', '14:54:00.000000', 5),
(60, '21', '2026-02-10', 'entry', '11:04:00.000000', 3),
(61, '21', '2026-02-10', 'exit', '11:50:00.000000', 3),
(62, '21', '2026-02-10', 'entry', '09:01:00.000000', 1),
(63, '21', '2026-02-10', 'exit', '09:59:00.000000', 1),
(64, '21', '2026-02-10', 'entry', '10:00:00.000000', 2),
(65, '21', '2026-02-10', 'exit', '10:58:00.000000', 2),
(66, '22', '2026-02-10', 'entry', '14:55:00.000000', 6),
(67, '22', '2026-02-10', 'exit', '16:00:00.000000', 6),
(68, '23', '2026-02-10', 'entry', '10:00:00.000000', 2),
(69, '23', '2026-02-10', 'exit', '10:54:00.000000', 2),
(70, '23', '2026-02-10', 'entry', '11:02:00.000000', 3),
(71, '23', '2026-02-10', 'exit', '11:50:00.000000', 3),
(72, '23', '2026-02-10', 'entry', '13:57:00.000000', 5),
(73, '23', '2026-02-10', 'exit', '14:52:00.000000', 5),
(74, '23', '2026-02-10', 'entry', '14:55:00.000000', 6),
(75, '23', '2026-02-10', 'exit', '15:56:00.000000', 6),
(76, '25', '2026-02-10', 'entry', '09:05:00.000000', 1),
(77, '25', '2026-02-10', 'exit', '10:00:00.000000', 1),
(78, '25', '2026-02-10', 'entry', '10:05:00.000000', 2),
(79, '25', '2026-02-10', 'exit', '10:57:00.000000', 2),
(80, '25', '2026-02-10', 'entry', '10:57:00.000000', 3),
(81, '25', '2026-02-10', 'exit', '11:55:00.000000', 3),
(82, '25', '2026-02-10', 'entry', '12:04:00.000000', 4),
(83, '25', '2026-02-10', 'exit', '12:51:00.000000', 4),
(84, '25', '2026-02-10', 'entry', '14:02:00.000000', 5),
(85, '25', '2026-02-10', 'exit', '14:59:00.000000', 5),
(86, '25', '2026-02-10', 'entry', '15:18:00.000000', 6),
(87, '25', '2026-02-10', 'exit', '15:54:00.000000', 6),
(88, '26', '2026-02-10', 'entry', '08:57:00.000000', 1),
(89, '26', '2026-02-10', 'exit', '09:53:00.000000', 1),
(90, '26', '2026-02-10', 'entry', '09:59:00.000000', 2),
(91, '26', '2026-02-10', 'exit', '10:52:00.000000', 2),
(92, '26', '2026-02-10', 'entry', '11:01:00.000000', 3),
(93, '26', '2026-02-10', 'exit', '11:58:00.000000', 3),
(94, '26', '2026-02-10', 'entry', '11:57:00.000000', 4),
(95, '26', '2026-02-10', 'exit', '12:57:00.000000', 4),
(96, '26', '2026-02-10', 'entry', '14:04:00.000000', 5),
(97, '26', '2026-02-10', 'exit', '14:50:00.000000', 5),
(98, '26', '2026-02-10', 'entry', '15:04:00.000000', 6),
(99, '26', '2026-02-10', 'exit', '15:52:00.000000', 6),
(100, '27', '2026-02-10', 'entry', '11:57:00.000000', 4),
(101, '27', '2026-02-10', 'exit', '12:53:00.000000', 4),
(102, '27', '2026-02-10', 'entry', '15:02:00.000000', 6),
(103, '27', '2026-02-10', 'exit', '15:51:00.000000', 6),
(104, '27', '2026-02-10', 'entry', '13:55:00.000000', 5),
(105, '27', '2026-02-10', 'exit', '15:00:00.000000', 5),
(106, '28', '2026-02-10', 'entry', '09:10:00.000000', 1),
(107, '28', '2026-02-10', 'exit', '09:59:00.000000', 1),
(108, '28', '2026-02-10', 'entry', '10:01:00.000000', 2),
(109, '28', '2026-02-10', 'exit', '10:55:00.000000', 2),
(110, '28', '2026-02-10', 'entry', '11:16:00.000000', 3),
(111, '28', '2026-02-10', 'exit', '11:52:00.000000', 3),
(112, '28', '2026-02-10', 'entry', '12:03:00.000000', 4),
(113, '28', '2026-02-10', 'exit', '12:59:00.000000', 4),
(114, '28', '2026-02-10', 'entry', '14:04:00.000000', 5),
(115, '28', '2026-02-10', 'exit', '14:58:00.000000', 5),
(116, '28', '2026-02-10', 'entry', '15:20:00.000000', 6),
(117, '28', '2026-02-10', 'exit', '15:52:00.000000', 6),
(118, '16', '2026-02-09', 'entry', '09:11:00.000000', 1),
(119, '16', '2026-02-09', 'exit', '09:51:00.000000', 1),
(120, '16', '2026-02-09', 'entry', '10:10:00.000000', 2),
(121, '16', '2026-02-09', 'exit', '10:55:00.000000', 2),
(122, '16', '2026-02-09', 'entry', '11:00:00.000000', 3),
(123, '16', '2026-02-09', 'exit', '11:51:00.000000', 3),
(124, '16', '2026-02-09', 'entry', '12:15:00.000000', 4),
(125, '16', '2026-02-09', 'exit', '12:50:00.000000', 4),
(126, '16', '2026-02-09', 'entry', '14:12:00.000000', 5),
(127, '16', '2026-02-09', 'exit', '14:59:00.000000', 5),
(128, '16', '2026-02-09', 'entry', '15:14:00.000000', 6),
(129, '16', '2026-02-09', 'exit', '16:00:00.000000', 6),
(130, '17', '2026-02-09', 'entry', '09:04:00.000000', 1),
(131, '17', '2026-02-09', 'exit', '09:58:00.000000', 1),
(132, '17', '2026-02-09', 'entry', '10:03:00.000000', 2),
(133, '17', '2026-02-09', 'exit', '10:59:00.000000', 2),
(134, '17', '2026-02-09', 'entry', '11:01:00.000000', 3),
(135, '17', '2026-02-09', 'exit', '11:54:00.000000', 3),
(136, '17', '2026-02-09', 'entry', '12:05:00.000000', 4),
(137, '17', '2026-02-09', 'exit', '12:56:00.000000', 4),
(138, '17', '2026-02-09', 'entry', '14:03:00.000000', 5),
(139, '17', '2026-02-09', 'exit', '14:53:00.000000', 5),
(140, '17', '2026-02-09', 'entry', '14:57:00.000000', 6),
(141, '17', '2026-02-09', 'exit', '15:54:00.000000', 6),
(142, '18', '2026-02-09', 'entry', '14:03:00.000000', 5),
(143, '18', '2026-02-09', 'exit', '14:55:00.000000', 5),
(144, '18', '2026-02-09', 'entry', '08:58:00.000000', 1),
(145, '18', '2026-02-09', 'exit', '09:58:00.000000', 1),
(146, '18', '2026-02-09', 'entry', '15:04:00.000000', 6),
(147, '18', '2026-02-09', 'exit', '15:54:00.000000', 6),
(148, '18', '2026-02-09', 'entry', '12:04:00.000000', 4),
(149, '18', '2026-02-09', 'exit', '12:54:00.000000', 4),
(150, '18', '2026-02-09', 'entry', '10:00:00.000000', 2),
(151, '18', '2026-02-09', 'exit', '10:51:00.000000', 2),
(152, '19', '2026-02-09', 'entry', '09:03:00.000000', 1),
(153, '19', '2026-02-09', 'exit', '09:53:00.000000', 1),
(154, '19', '2026-02-09', 'entry', '09:56:00.000000', 2),
(155, '19', '2026-02-09', 'exit', '10:55:00.000000', 2),
(156, '19', '2026-02-09', 'entry', '11:00:00.000000', 3),
(157, '19', '2026-02-09', 'exit', '11:50:00.000000', 3),
(158, '19', '2026-02-09', 'entry', '12:14:00.000000', 4),
(159, '19', '2026-02-09', 'exit', '13:00:00.000000', 4),
(160, '19', '2026-02-09', 'entry', '13:59:00.000000', 5),
(161, '19', '2026-02-09', 'exit', '14:56:00.000000', 5),
(162, '19', '2026-02-09', 'entry', '15:12:00.000000', 6),
(163, '19', '2026-02-09', 'exit', '15:55:00.000000', 6),
(164, '20', '2026-02-09', 'entry', '09:03:00.000000', 1),
(165, '20', '2026-02-09', 'exit', '09:58:00.000000', 1),
(166, '20', '2026-02-09', 'entry', '10:20:00.000000', 2),
(167, '20', '2026-02-09', 'exit', '10:53:00.000000', 2),
(168, '20', '2026-02-09', 'entry', '11:20:00.000000', 3),
(169, '20', '2026-02-09', 'exit', '11:58:00.000000', 3),
(170, '20', '2026-02-09', 'entry', '12:16:00.000000', 4),
(171, '20', '2026-02-09', 'exit', '12:56:00.000000', 4),
(172, '20', '2026-02-09', 'entry', '14:02:00.000000', 5),
(173, '20', '2026-02-09', 'exit', '14:51:00.000000', 5),
(174, '20', '2026-02-09', 'entry', '15:20:00.000000', 6),
(175, '20', '2026-02-09', 'exit', '15:52:00.000000', 6),
(176, '21', '2026-02-09', 'entry', '09:16:00.000000', 1),
(177, '21', '2026-02-09', 'exit', '09:54:00.000000', 1),
(178, '21', '2026-02-09', 'entry', '09:59:00.000000', 2),
(179, '21', '2026-02-09', 'exit', '10:59:00.000000', 2),
(180, '21', '2026-02-09', 'entry', '11:01:00.000000', 3),
(181, '21', '2026-02-09', 'exit', '11:58:00.000000', 3),
(182, '21', '2026-02-09', 'entry', '12:10:00.000000', 4),
(183, '21', '2026-02-09', 'exit', '12:52:00.000000', 4),
(184, '21', '2026-02-09', 'entry', '14:01:00.000000', 5),
(185, '21', '2026-02-09', 'exit', '15:00:00.000000', 5),
(186, '21', '2026-02-09', 'entry', '15:14:00.000000', 6),
(187, '21', '2026-02-09', 'exit', '15:51:00.000000', 6),
(188, '22', '2026-02-09', 'entry', '10:01:00.000000', 2),
(189, '22', '2026-02-09', 'exit', '11:00:00.000000', 2),
(190, '22', '2026-02-09', 'entry', '15:05:00.000000', 6),
(191, '22', '2026-02-09', 'exit', '15:58:00.000000', 6),
(192, '22', '2026-02-09', 'entry', '09:02:00.000000', 1),
(193, '22', '2026-02-09', 'exit', '10:00:00.000000', 1),
(194, '22', '2026-02-09', 'entry', '13:55:00.000000', 5),
(195, '22', '2026-02-09', 'exit', '14:50:00.000000', 5),
(196, '22', '2026-02-09', 'entry', '12:02:00.000000', 4),
(197, '22', '2026-02-09', 'exit', '12:52:00.000000', 4),
(198, '23', '2026-02-09', 'entry', '10:05:00.000000', 2),
(199, '23', '2026-02-09', 'exit', '10:55:00.000000', 2),
(200, '23', '2026-02-09', 'entry', '09:05:00.000000', 1),
(201, '23', '2026-02-09', 'exit', '09:54:00.000000', 1),
(202, '24', '2026-02-09', 'entry', '11:56:00.000000', 4),
(203, '24', '2026-02-09', 'exit', '12:56:00.000000', 4),
(204, '25', '2026-02-09', 'entry', '09:05:00.000000', 1),
(205, '25', '2026-02-09', 'exit', '09:50:00.000000', 1),
(206, '25', '2026-02-09', 'entry', '10:05:00.000000', 2),
(207, '25', '2026-02-09', 'exit', '10:59:00.000000', 2),
(208, '25', '2026-02-09', 'entry', '11:00:00.000000', 3),
(209, '25', '2026-02-09', 'exit', '11:52:00.000000', 3),
(210, '25', '2026-02-09', 'entry', '11:55:00.000000', 4),
(211, '25', '2026-02-09', 'exit', '12:56:00.000000', 4),
(212, '25', '2026-02-09', 'entry', '14:05:00.000000', 5),
(213, '25', '2026-02-09', 'exit', '14:50:00.000000', 5),
(214, '25', '2026-02-09', 'entry', '14:58:00.000000', 6),
(215, '25', '2026-02-09', 'exit', '15:56:00.000000', 6),
(216, '26', '2026-02-09', 'entry', '09:01:00.000000', 1),
(217, '26', '2026-02-09', 'exit', '09:53:00.000000', 1),
(218, '26', '2026-02-09', 'entry', '10:03:00.000000', 2),
(219, '26', '2026-02-09', 'exit', '10:55:00.000000', 2),
(220, '26', '2026-02-09', 'entry', '10:55:00.000000', 3),
(221, '26', '2026-02-09', 'exit', '11:52:00.000000', 3),
(222, '26', '2026-02-09', 'entry', '11:58:00.000000', 4),
(223, '26', '2026-02-09', 'exit', '12:53:00.000000', 4),
(224, '26', '2026-02-09', 'entry', '13:59:00.000000', 5),
(225, '26', '2026-02-09', 'exit', '14:59:00.000000', 5),
(226, '26', '2026-02-09', 'entry', '14:59:00.000000', 6),
(227, '26', '2026-02-09', 'exit', '15:54:00.000000', 6),
(228, '27', '2026-02-09', 'entry', '14:04:00.000000', 5),
(229, '27', '2026-02-09', 'exit', '14:54:00.000000', 5),
(230, '27', '2026-02-09', 'entry', '10:03:00.000000', 2),
(231, '27', '2026-02-09', 'exit', '10:57:00.000000', 2),
(232, '27', '2026-02-09', 'entry', '11:55:00.000000', 4),
(233, '27', '2026-02-09', 'exit', '12:53:00.000000', 4),
(234, '27', '2026-02-09', 'entry', '14:57:00.000000', 6),
(235, '27', '2026-02-09', 'exit', '15:58:00.000000', 6),
(236, '27', '2026-02-09', 'entry', '09:02:00.000000', 1),
(237, '27', '2026-02-09', 'exit', '09:54:00.000000', 1),
(238, '28', '2026-02-09', 'entry', '08:58:00.000000', 1),
(239, '28', '2026-02-09', 'exit', '09:58:00.000000', 1),
(240, '28', '2026-02-09', 'entry', '10:18:00.000000', 2),
(241, '28', '2026-02-09', 'exit', '10:56:00.000000', 2),
(242, '28', '2026-02-09', 'entry', '11:18:00.000000', 3),
(243, '28', '2026-02-09', 'exit', '11:58:00.000000', 3),
(244, '28', '2026-02-09', 'entry', '12:10:00.000000', 4),
(245, '28', '2026-02-09', 'exit', '12:53:00.000000', 4),
(246, '28', '2026-02-09', 'entry', '14:20:00.000000', 5),
(247, '28', '2026-02-09', 'exit', '14:55:00.000000', 5),
(248, '28', '2026-02-09', 'entry', '15:16:00.000000', 6),
(249, '28', '2026-02-09', 'exit', '15:52:00.000000', 6),
(250, '15', '2026-02-06', 'entry', '15:00:00.000000', 6),
(251, '15', '2026-02-06', 'exit', '16:00:00.000000', 6),
(252, '15', '2026-02-06', 'entry', '11:56:00.000000', 4),
(253, '15', '2026-02-06', 'exit', '13:00:00.000000', 4),
(254, '15', '2026-02-06', 'entry', '11:03:00.000000', 3),
(255, '15', '2026-02-06', 'exit', '11:50:00.000000', 3),
(256, '15', '2026-02-06', 'entry', '13:56:00.000000', 5),
(257, '15', '2026-02-06', 'exit', '15:00:00.000000', 5),
(258, '15', '2026-02-06', 'entry', '09:59:00.000000', 2),
(259, '15', '2026-02-06', 'exit', '10:50:00.000000', 2),
(260, '16', '2026-02-06', 'entry', '10:59:00.000000', 3),
(261, '16', '2026-02-06', 'exit', '11:55:00.000000', 3),
(262, '16', '2026-02-06', 'entry', '09:59:00.000000', 2),
(263, '16', '2026-02-06', 'exit', '10:54:00.000000', 2),
(264, '17', '2026-02-06', 'entry', '08:59:00.000000', 1),
(265, '17', '2026-02-06', 'exit', '10:00:00.000000', 1),
(266, '17', '2026-02-06', 'entry', '10:04:00.000000', 2),
(267, '17', '2026-02-06', 'exit', '10:56:00.000000', 2),
(268, '17', '2026-02-06', 'entry', '10:57:00.000000', 3),
(269, '17', '2026-02-06', 'exit', '11:57:00.000000', 3),
(270, '17', '2026-02-06', 'entry', '11:58:00.000000', 4),
(271, '17', '2026-02-06', 'exit', '13:00:00.000000', 4),
(272, '17', '2026-02-06', 'entry', '14:05:00.000000', 5),
(273, '17', '2026-02-06', 'exit', '14:54:00.000000', 5),
(274, '17', '2026-02-06', 'entry', '15:00:00.000000', 6),
(275, '17', '2026-02-06', 'exit', '15:53:00.000000', 6),
(276, '19', '2026-02-06', 'entry', '09:55:00.000000', 2),
(277, '19', '2026-02-06', 'exit', '10:54:00.000000', 2),
(278, '19', '2026-02-06', 'entry', '10:58:00.000000', 3),
(279, '19', '2026-02-06', 'exit', '11:51:00.000000', 3),
(280, '19', '2026-02-06', 'entry', '08:55:00.000000', 1),
(281, '19', '2026-02-06', 'exit', '09:57:00.000000', 1),
(282, '19', '2026-02-06', 'entry', '11:57:00.000000', 4),
(283, '19', '2026-02-06', 'exit', '12:58:00.000000', 4),
(284, '19', '2026-02-06', 'entry', '15:04:00.000000', 6),
(285, '19', '2026-02-06', 'exit', '16:00:00.000000', 6),
(286, '20', '2026-02-06', 'entry', '08:57:00.000000', 1),
(287, '20', '2026-02-06', 'exit', '09:51:00.000000', 1),
(288, '20', '2026-02-06', 'entry', '09:58:00.000000', 2),
(289, '20', '2026-02-06', 'exit', '10:56:00.000000', 2),
(290, '20', '2026-02-06', 'entry', '11:00:00.000000', 3),
(291, '20', '2026-02-06', 'exit', '11:55:00.000000', 3),
(292, '20', '2026-02-06', 'entry', '12:12:00.000000', 4),
(293, '20', '2026-02-06', 'exit', '12:52:00.000000', 4),
(294, '20', '2026-02-06', 'entry', '14:04:00.000000', 5),
(295, '20', '2026-02-06', 'exit', '14:58:00.000000', 5),
(296, '20', '2026-02-06', 'entry', '15:14:00.000000', 6),
(297, '20', '2026-02-06', 'exit', '15:55:00.000000', 6),
(298, '21', '2026-02-06', 'entry', '08:56:00.000000', 1),
(299, '21', '2026-02-06', 'exit', '09:55:00.000000', 1),
(300, '21', '2026-02-06', 'entry', '10:04:00.000000', 2),
(301, '21', '2026-02-06', 'exit', '10:57:00.000000', 2),
(302, '21', '2026-02-06', 'entry', '11:02:00.000000', 3),
(303, '21', '2026-02-06', 'exit', '11:55:00.000000', 3),
(304, '21', '2026-02-06', 'entry', '11:58:00.000000', 4),
(305, '21', '2026-02-06', 'exit', '12:59:00.000000', 4),
(306, '21', '2026-02-06', 'entry', '13:56:00.000000', 5),
(307, '21', '2026-02-06', 'exit', '14:58:00.000000', 5),
(308, '21', '2026-02-06', 'entry', '14:59:00.000000', 6),
(309, '21', '2026-02-06', 'exit', '15:50:00.000000', 6),
(310, '22', '2026-02-06', 'entry', '08:55:00.000000', 1),
(311, '22', '2026-02-06', 'exit', '09:55:00.000000', 1),
(312, '22', '2026-02-06', 'entry', '10:05:00.000000', 2),
(313, '22', '2026-02-06', 'exit', '10:51:00.000000', 2),
(314, '22', '2026-02-06', 'entry', '10:58:00.000000', 3),
(315, '22', '2026-02-06', 'exit', '11:50:00.000000', 3),
(316, '22', '2026-02-06', 'entry', '11:56:00.000000', 4),
(317, '22', '2026-02-06', 'exit', '12:56:00.000000', 4),
(318, '22', '2026-02-06', 'entry', '13:57:00.000000', 5),
(319, '22', '2026-02-06', 'exit', '14:51:00.000000', 5),
(320, '22', '2026-02-06', 'entry', '14:56:00.000000', 6),
(321, '22', '2026-02-06', 'exit', '15:58:00.000000', 6),
(322, '23', '2026-02-06', 'entry', '08:57:00.000000', 1),
(323, '23', '2026-02-06', 'exit', '09:58:00.000000', 1),
(324, '23', '2026-02-06', 'entry', '10:02:00.000000', 2),
(325, '23', '2026-02-06', 'exit', '10:54:00.000000', 2),
(326, '23', '2026-02-06', 'entry', '10:58:00.000000', 3),
(327, '23', '2026-02-06', 'exit', '11:55:00.000000', 3),
(328, '23', '2026-02-06', 'entry', '11:58:00.000000', 4),
(329, '23', '2026-02-06', 'exit', '12:59:00.000000', 4),
(330, '23', '2026-02-06', 'entry', '14:17:00.000000', 5),
(331, '23', '2026-02-06', 'exit', '14:52:00.000000', 5),
(332, '23', '2026-02-06', 'entry', '15:13:00.000000', 6),
(333, '23', '2026-02-06', 'exit', '15:50:00.000000', 6),
(334, '24', '2026-02-06', 'entry', '11:02:00.000000', 3),
(335, '24', '2026-02-06', 'exit', '11:54:00.000000', 3),
(336, '24', '2026-02-06', 'entry', '13:58:00.000000', 5),
(337, '24', '2026-02-06', 'exit', '14:53:00.000000', 5),
(338, '24', '2026-02-06', 'entry', '12:05:00.000000', 4),
(339, '24', '2026-02-06', 'exit', '12:58:00.000000', 4),
(340, '24', '2026-02-06', 'entry', '14:55:00.000000', 6),
(341, '24', '2026-02-06', 'exit', '15:50:00.000000', 6),
(342, '24', '2026-02-06', 'entry', '09:58:00.000000', 2),
(343, '24', '2026-02-06', 'exit', '10:54:00.000000', 2),
(344, '25', '2026-02-06', 'entry', '10:02:00.000000', 2),
(345, '25', '2026-02-06', 'exit', '10:51:00.000000', 2),
(346, '25', '2026-02-06', 'entry', '12:05:00.000000', 4),
(347, '25', '2026-02-06', 'exit', '12:54:00.000000', 4),
(348, '25', '2026-02-06', 'entry', '09:03:00.000000', 1),
(349, '25', '2026-02-06', 'exit', '09:58:00.000000', 1),
(350, '25', '2026-02-06', 'entry', '14:04:00.000000', 5),
(351, '25', '2026-02-06', 'exit', '15:00:00.000000', 5),
(352, '25', '2026-02-06', 'entry', '10:57:00.000000', 3),
(353, '25', '2026-02-06', 'exit', '11:57:00.000000', 3),
(354, '26', '2026-02-06', 'entry', '08:57:00.000000', 1),
(355, '26', '2026-02-06', 'exit', '09:53:00.000000', 1),
(356, '26', '2026-02-06', 'entry', '10:04:00.000000', 2),
(357, '26', '2026-02-06', 'exit', '10:55:00.000000', 2),
(358, '26', '2026-02-06', 'entry', '10:58:00.000000', 3),
(359, '26', '2026-02-06', 'exit', '11:54:00.000000', 3),
(360, '26', '2026-02-06', 'entry', '11:57:00.000000', 4),
(361, '26', '2026-02-06', 'exit', '12:52:00.000000', 4),
(362, '26', '2026-02-06', 'entry', '14:03:00.000000', 5),
(363, '26', '2026-02-06', 'exit', '14:55:00.000000', 5),
(364, '26', '2026-02-06', 'entry', '14:56:00.000000', 6),
(365, '26', '2026-02-06', 'exit', '15:55:00.000000', 6),
(366, '27', '2026-02-06', 'entry', '08:58:00.000000', 1),
(367, '27', '2026-02-06', 'exit', '09:54:00.000000', 1),
(368, '27', '2026-02-06', 'entry', '09:59:00.000000', 2),
(369, '27', '2026-02-06', 'exit', '10:55:00.000000', 2),
(370, '27', '2026-02-06', 'entry', '11:00:00.000000', 3),
(371, '27', '2026-02-06', 'exit', '11:50:00.000000', 3),
(372, '27', '2026-02-06', 'entry', '12:03:00.000000', 4),
(373, '27', '2026-02-06', 'exit', '12:53:00.000000', 4),
(374, '27', '2026-02-06', 'entry', '14:00:00.000000', 5),
(375, '27', '2026-02-06', 'exit', '14:59:00.000000', 5),
(376, '27', '2026-02-06', 'entry', '15:02:00.000000', 6),
(377, '27', '2026-02-06', 'exit', '15:56:00.000000', 6),
(378, '28', '2026-02-06', 'entry', '09:00:00.000000', 1),
(379, '28', '2026-02-06', 'exit', '09:54:00.000000', 1),
(380, '28', '2026-02-06', 'entry', '09:55:00.000000', 2),
(381, '28', '2026-02-06', 'exit', '10:54:00.000000', 2),
(382, '28', '2026-02-06', 'entry', '10:59:00.000000', 3),
(383, '28', '2026-02-06', 'exit', '11:56:00.000000', 3),
(384, '28', '2026-02-06', 'entry', '12:17:00.000000', 4),
(385, '28', '2026-02-06', 'exit', '12:54:00.000000', 4),
(386, '28', '2026-02-06', 'entry', '14:03:00.000000', 5),
(387, '28', '2026-02-06', 'exit', '14:56:00.000000', 5),
(388, '28', '2026-02-06', 'entry', '15:01:00.000000', 6),
(389, '28', '2026-02-06', 'exit', '15:51:00.000000', 6),
(390, '15', '2026-02-05', 'entry', '09:01:00.000000', 1),
(391, '15', '2026-02-05', 'exit', '09:59:00.000000', 1),
(392, '15', '2026-02-05', 'entry', '10:18:00.000000', 2),
(393, '15', '2026-02-05', 'exit', '10:52:00.000000', 2),
(394, '15', '2026-02-05', 'entry', '10:58:00.000000', 3),
(395, '15', '2026-02-05', 'exit', '11:54:00.000000', 3),
(396, '15', '2026-02-05', 'entry', '12:05:00.000000', 4),
(397, '15', '2026-02-05', 'exit', '12:57:00.000000', 4),
(398, '15', '2026-02-05', 'entry', '13:57:00.000000', 5),
(399, '15', '2026-02-05', 'exit', '14:55:00.000000', 5),
(400, '15', '2026-02-05', 'entry', '15:00:00.000000', 6),
(401, '15', '2026-02-05', 'exit', '15:59:00.000000', 6),
(402, '16', '2026-02-05', 'entry', '12:05:00.000000', 4),
(403, '16', '2026-02-05', 'exit', '12:54:00.000000', 4),
(404, '16', '2026-02-05', 'entry', '09:59:00.000000', 2),
(405, '16', '2026-02-05', 'exit', '10:52:00.000000', 2),
(406, '16', '2026-02-05', 'entry', '14:55:00.000000', 6),
(407, '16', '2026-02-05', 'exit', '15:52:00.000000', 6),
(408, '16', '2026-02-05', 'entry', '08:55:00.000000', 1),
(409, '16', '2026-02-05', 'exit', '09:52:00.000000', 1),
(410, '16', '2026-02-05', 'entry', '10:55:00.000000', 3),
(411, '16', '2026-02-05', 'exit', '11:57:00.000000', 3),
(412, '17', '2026-02-05', 'entry', '08:57:00.000000', 1),
(413, '17', '2026-02-05', 'exit', '09:54:00.000000', 1),
(414, '17', '2026-02-05', 'entry', '09:58:00.000000', 2),
(415, '17', '2026-02-05', 'exit', '10:56:00.000000', 2),
(416, '17', '2026-02-05', 'entry', '11:05:00.000000', 3),
(417, '17', '2026-02-05', 'exit', '11:53:00.000000', 3),
(418, '17', '2026-02-05', 'entry', '11:57:00.000000', 4),
(419, '17', '2026-02-05', 'exit', '12:57:00.000000', 4),
(420, '17', '2026-02-05', 'entry', '13:57:00.000000', 5),
(421, '17', '2026-02-05', 'exit', '14:59:00.000000', 5),
(422, '17', '2026-02-05', 'entry', '14:58:00.000000', 6),
(423, '17', '2026-02-05', 'exit', '15:54:00.000000', 6),
(424, '18', '2026-02-05', 'entry', '13:59:00.000000', 5),
(425, '18', '2026-02-05', 'exit', '14:50:00.000000', 5),
(426, '18', '2026-02-05', 'entry', '08:58:00.000000', 1),
(427, '18', '2026-02-05', 'exit', '09:51:00.000000', 1),
(428, '19', '2026-02-05', 'entry', '09:02:00.000000', 1),
(429, '19', '2026-02-05', 'exit', '09:55:00.000000', 1),
(430, '19', '2026-02-05', 'entry', '10:03:00.000000', 2),
(431, '19', '2026-02-05', 'exit', '10:57:00.000000', 2),
(432, '19', '2026-02-05', 'entry', '10:55:00.000000', 3),
(433, '19', '2026-02-05', 'exit', '11:53:00.000000', 3),
(434, '19', '2026-02-05', 'entry', '12:04:00.000000', 4),
(435, '19', '2026-02-05', 'exit', '12:58:00.000000', 4),
(436, '19', '2026-02-05', 'entry', '14:03:00.000000', 5),
(437, '19', '2026-02-05', 'exit', '14:53:00.000000', 5),
(438, '19', '2026-02-05', 'entry', '15:03:00.000000', 6),
(439, '19', '2026-02-05', 'exit', '15:53:00.000000', 6),
(440, '21', '2026-02-05', 'entry', '08:56:00.000000', 1),
(441, '21', '2026-02-05', 'exit', '09:53:00.000000', 1),
(442, '21', '2026-02-05', 'entry', '14:59:00.000000', 6),
(443, '21', '2026-02-05', 'exit', '15:54:00.000000', 6),
(444, '22', '2026-02-05', 'entry', '09:04:00.000000', 1),
(445, '22', '2026-02-05', 'exit', '09:58:00.000000', 1),
(446, '22', '2026-02-05', 'entry', '10:17:00.000000', 2),
(447, '22', '2026-02-05', 'exit', '10:53:00.000000', 2),
(448, '22', '2026-02-05', 'entry', '11:20:00.000000', 3),
(449, '22', '2026-02-05', 'exit', '11:50:00.000000', 3),
(450, '22', '2026-02-05', 'entry', '12:17:00.000000', 4),
(451, '22', '2026-02-05', 'exit', '12:52:00.000000', 4),
(452, '22', '2026-02-05', 'entry', '14:00:00.000000', 5),
(453, '22', '2026-02-05', 'exit', '14:51:00.000000', 5),
(454, '22', '2026-02-05', 'entry', '14:58:00.000000', 6),
(455, '22', '2026-02-05', 'exit', '15:52:00.000000', 6),
(456, '23', '2026-02-05', 'entry', '12:03:00.000000', 4),
(457, '23', '2026-02-05', 'exit', '12:55:00.000000', 4),
(458, '23', '2026-02-05', 'entry', '09:04:00.000000', 1),
(459, '23', '2026-02-05', 'exit', '09:52:00.000000', 1),
(460, '23', '2026-02-05', 'entry', '10:55:00.000000', 3),
(461, '23', '2026-02-05', 'exit', '11:56:00.000000', 3),
(462, '23', '2026-02-05', 'entry', '14:02:00.000000', 5),
(463, '23', '2026-02-05', 'exit', '14:56:00.000000', 5),
(464, '23', '2026-02-05', 'entry', '09:56:00.000000', 2),
(465, '23', '2026-02-05', 'exit', '10:51:00.000000', 2),
(466, '24', '2026-02-05', 'entry', '09:00:00.000000', 1),
(467, '24', '2026-02-05', 'exit', '10:00:00.000000', 1),
(468, '24', '2026-02-05', 'entry', '09:56:00.000000', 2),
(469, '24', '2026-02-05', 'exit', '10:55:00.000000', 2),
(470, '24', '2026-02-05', 'entry', '10:55:00.000000', 3),
(471, '24', '2026-02-05', 'exit', '11:53:00.000000', 3),
(472, '24', '2026-02-05', 'entry', '12:01:00.000000', 4),
(473, '24', '2026-02-05', 'exit', '12:55:00.000000', 4),
(474, '24', '2026-02-05', 'entry', '14:03:00.000000', 5),
(475, '24', '2026-02-05', 'exit', '14:55:00.000000', 5),
(476, '24', '2026-02-05', 'entry', '14:56:00.000000', 6),
(477, '24', '2026-02-05', 'exit', '16:00:00.000000', 6),
(478, '25', '2026-02-05', 'entry', '10:00:00.000000', 2),
(479, '25', '2026-02-05', 'exit', '10:51:00.000000', 2),
(480, '25', '2026-02-05', 'entry', '08:56:00.000000', 1),
(481, '25', '2026-02-05', 'exit', '09:57:00.000000', 1),
(482, '25', '2026-02-05', 'entry', '14:01:00.000000', 5),
(483, '25', '2026-02-05', 'exit', '14:50:00.000000', 5),
(484, '26', '2026-02-05', 'entry', '09:11:00.000000', 1),
(485, '26', '2026-02-05', 'exit', '09:55:00.000000', 1),
(486, '26', '2026-02-05', 'entry', '10:17:00.000000', 2),
(487, '26', '2026-02-05', 'exit', '10:52:00.000000', 2),
(488, '26', '2026-02-05', 'entry', '11:00:00.000000', 3),
(489, '26', '2026-02-05', 'exit', '11:56:00.000000', 3),
(490, '26', '2026-02-05', 'entry', '12:14:00.000000', 4),
(491, '26', '2026-02-05', 'exit', '12:56:00.000000', 4),
(492, '26', '2026-02-05', 'entry', '13:56:00.000000', 5),
(493, '26', '2026-02-05', 'exit', '14:54:00.000000', 5),
(494, '26', '2026-02-05', 'entry', '15:16:00.000000', 6),
(495, '26', '2026-02-05', 'exit', '15:59:00.000000', 6),
(496, '27', '2026-02-05', 'entry', '09:05:00.000000', 1),
(497, '27', '2026-02-05', 'exit', '09:56:00.000000', 1),
(498, '27', '2026-02-05', 'entry', '11:56:00.000000', 4),
(499, '27', '2026-02-05', 'exit', '12:50:00.000000', 4),
(500, '27', '2026-02-05', 'entry', '11:03:00.000000', 3),
(501, '27', '2026-02-05', 'exit', '11:54:00.000000', 3),
(502, '27', '2026-02-05', 'entry', '09:55:00.000000', 2),
(503, '27', '2026-02-05', 'exit', '11:00:00.000000', 2),
(504, '28', '2026-02-05', 'entry', '12:01:00.000000', 4),
(505, '28', '2026-02-05', 'exit', '12:58:00.000000', 4),
(506, '28', '2026-02-05', 'entry', '15:04:00.000000', 6),
(507, '28', '2026-02-05', 'exit', '15:51:00.000000', 6),
(508, '28', '2026-02-05', 'entry', '08:59:00.000000', 1),
(509, '28', '2026-02-05', 'exit', '09:59:00.000000', 1),
(510, '28', '2026-02-05', 'entry', '13:56:00.000000', 5),
(511, '28', '2026-02-05', 'exit', '14:54:00.000000', 5),
(512, '28', '2026-02-05', 'entry', '10:59:00.000000', 3),
(513, '28', '2026-02-05', 'exit', '11:53:00.000000', 3),
(514, '15', '2026-02-04', 'entry', '08:55:00.000000', 1),
(515, '15', '2026-02-04', 'exit', '10:00:00.000000', 1),
(516, '15', '2026-02-04', 'entry', '10:04:00.000000', 2),
(517, '15', '2026-02-04', 'exit', '10:58:00.000000', 2),
(518, '15', '2026-02-04', 'entry', '11:03:00.000000', 3),
(519, '15', '2026-02-04', 'exit', '11:59:00.000000', 3),
(520, '15', '2026-02-04', 'entry', '12:04:00.000000', 4),
(521, '15', '2026-02-04', 'exit', '12:54:00.000000', 4),
(522, '15', '2026-02-04', 'entry', '13:56:00.000000', 5),
(523, '15', '2026-02-04', 'exit', '14:51:00.000000', 5),
(524, '15', '2026-02-04', 'entry', '14:59:00.000000', 6),
(525, '15', '2026-02-04', 'exit', '15:55:00.000000', 6),
(526, '16', '2026-02-04', 'entry', '09:00:00.000000', 1),
(527, '16', '2026-02-04', 'exit', '09:59:00.000000', 1),
(528, '16', '2026-02-04', 'entry', '11:55:00.000000', 4),
(529, '16', '2026-02-04', 'exit', '12:56:00.000000', 4),
(530, '17', '2026-02-04', 'entry', '09:02:00.000000', 1),
(531, '17', '2026-02-04', 'exit', '09:55:00.000000', 1),
(532, '17', '2026-02-04', 'entry', '10:03:00.000000', 2),
(533, '17', '2026-02-04', 'exit', '10:53:00.000000', 2),
(534, '17', '2026-02-04', 'entry', '10:55:00.000000', 3),
(535, '17', '2026-02-04', 'exit', '11:59:00.000000', 3),
(536, '17', '2026-02-04', 'entry', '12:00:00.000000', 4),
(537, '17', '2026-02-04', 'exit', '12:52:00.000000', 4),
(538, '17', '2026-02-04', 'entry', '14:00:00.000000', 5),
(539, '17', '2026-02-04', 'exit', '14:56:00.000000', 5),
(540, '17', '2026-02-04', 'entry', '15:04:00.000000', 6),
(541, '17', '2026-02-04', 'exit', '15:51:00.000000', 6),
(542, '18', '2026-02-04', 'entry', '14:55:00.000000', 6),
(543, '18', '2026-02-04', 'exit', '15:54:00.000000', 6),
(544, '19', '2026-02-04', 'entry', '14:59:00.000000', 6),
(545, '19', '2026-02-04', 'exit', '15:58:00.000000', 6),
(546, '19', '2026-02-04', 'entry', '09:02:00.000000', 1),
(547, '19', '2026-02-04', 'exit', '09:53:00.000000', 1),
(548, '19', '2026-02-04', 'entry', '10:02:00.000000', 2),
(549, '19', '2026-02-04', 'exit', '10:52:00.000000', 2),
(550, '19', '2026-02-04', 'entry', '10:59:00.000000', 3),
(551, '19', '2026-02-04', 'exit', '11:59:00.000000', 3),
(552, '20', '2026-02-04', 'entry', '11:55:00.000000', 4),
(553, '20', '2026-02-04', 'exit', '13:00:00.000000', 4),
(554, '20', '2026-02-04', 'entry', '10:58:00.000000', 3),
(555, '20', '2026-02-04', 'exit', '11:59:00.000000', 3),
(556, '20', '2026-02-04', 'entry', '15:04:00.000000', 6),
(557, '20', '2026-02-04', 'exit', '15:55:00.000000', 6),
(558, '20', '2026-02-04', 'entry', '14:00:00.000000', 5),
(559, '20', '2026-02-04', 'exit', '14:52:00.000000', 5),
(560, '21', '2026-02-04', 'entry', '14:01:00.000000', 5),
(561, '21', '2026-02-04', 'exit', '14:55:00.000000', 5),
(562, '21', '2026-02-04', 'entry', '09:05:00.000000', 1),
(563, '21', '2026-02-04', 'exit', '09:54:00.000000', 1),
(564, '21', '2026-02-04', 'entry', '12:04:00.000000', 4),
(565, '21', '2026-02-04', 'exit', '12:50:00.000000', 4),
(566, '21', '2026-02-04', 'entry', '10:05:00.000000', 2),
(567, '21', '2026-02-04', 'exit', '10:53:00.000000', 2),
(568, '21', '2026-02-04', 'entry', '15:03:00.000000', 6),
(569, '21', '2026-02-04', 'exit', '15:59:00.000000', 6),
(570, '22', '2026-02-04', 'entry', '09:14:00.000000', 1),
(571, '22', '2026-02-04', 'exit', '09:55:00.000000', 1),
(572, '22', '2026-02-04', 'entry', '10:20:00.000000', 2),
(573, '22', '2026-02-04', 'exit', '10:58:00.000000', 2),
(574, '22', '2026-02-04', 'entry', '10:58:00.000000', 3),
(575, '22', '2026-02-04', 'exit', '11:51:00.000000', 3),
(576, '22', '2026-02-04', 'entry', '12:11:00.000000', 4),
(577, '22', '2026-02-04', 'exit', '12:57:00.000000', 4),
(578, '22', '2026-02-04', 'entry', '13:56:00.000000', 5),
(579, '22', '2026-02-04', 'exit', '15:00:00.000000', 5),
(580, '22', '2026-02-04', 'entry', '15:14:00.000000', 6),
(581, '22', '2026-02-04', 'exit', '15:59:00.000000', 6),
(582, '23', '2026-02-04', 'entry', '09:14:00.000000', 1),
(583, '23', '2026-02-04', 'exit', '09:55:00.000000', 1),
(584, '23', '2026-02-04', 'entry', '09:56:00.000000', 2),
(585, '23', '2026-02-04', 'exit', '10:59:00.000000', 2),
(586, '23', '2026-02-04', 'entry', '10:59:00.000000', 3),
(587, '23', '2026-02-04', 'exit', '11:59:00.000000', 3),
(588, '23', '2026-02-04', 'entry', '11:57:00.000000', 4),
(589, '23', '2026-02-04', 'exit', '13:00:00.000000', 4),
(590, '23', '2026-02-04', 'entry', '14:00:00.000000', 5),
(591, '23', '2026-02-04', 'exit', '14:59:00.000000', 5),
(592, '23', '2026-02-04', 'entry', '15:17:00.000000', 6),
(593, '23', '2026-02-04', 'exit', '15:57:00.000000', 6),
(594, '25', '2026-02-04', 'entry', '09:20:00.000000', 1),
(595, '25', '2026-02-04', 'exit', '09:55:00.000000', 1),
(596, '25', '2026-02-04', 'entry', '10:20:00.000000', 2),
(597, '25', '2026-02-04', 'exit', '10:55:00.000000', 2),
(598, '25', '2026-02-04', 'entry', '11:17:00.000000', 3),
(599, '25', '2026-02-04', 'exit', '12:00:00.000000', 3),
(600, '25', '2026-02-04', 'entry', '12:02:00.000000', 4),
(601, '25', '2026-02-04', 'exit', '12:51:00.000000', 4),
(602, '25', '2026-02-04', 'entry', '14:13:00.000000', 5),
(603, '25', '2026-02-04', 'exit', '14:54:00.000000', 5),
(604, '25', '2026-02-04', 'entry', '15:18:00.000000', 6),
(605, '25', '2026-02-04', 'exit', '15:51:00.000000', 6),
(606, '26', '2026-02-04', 'entry', '10:03:00.000000', 2),
(607, '26', '2026-02-04', 'exit', '10:59:00.000000', 2),
(608, '26', '2026-02-04', 'entry', '14:02:00.000000', 5),
(609, '26', '2026-02-04', 'exit', '14:58:00.000000', 5),
(610, '26', '2026-02-04', 'entry', '12:00:00.000000', 4),
(611, '26', '2026-02-04', 'exit', '12:53:00.000000', 4),
(612, '26', '2026-02-04', 'entry', '08:56:00.000000', 1),
(613, '26', '2026-02-04', 'exit', '09:53:00.000000', 1),
(614, '27', '2026-02-04', 'entry', '11:58:00.000000', 4),
(615, '27', '2026-02-04', 'exit', '12:56:00.000000', 4),
(616, '27', '2026-02-04', 'entry', '09:05:00.000000', 1),
(617, '27', '2026-02-04', 'exit', '09:56:00.000000', 1),
(618, '27', '2026-02-04', 'entry', '10:03:00.000000', 2),
(619, '27', '2026-02-04', 'exit', '10:53:00.000000', 2),
(620, '27', '2026-02-04', 'entry', '15:00:00.000000', 6),
(621, '27', '2026-02-04', 'exit', '15:54:00.000000', 6),
(622, '27', '2026-02-04', 'entry', '13:59:00.000000', 5),
(623, '27', '2026-02-04', 'exit', '15:00:00.000000', 5),
(624, '28', '2026-02-04', 'entry', '10:57:00.000000', 3),
(625, '28', '2026-02-04', 'exit', '11:57:00.000000', 3),
(626, '28', '2026-02-04', 'entry', '08:56:00.000000', 1),
(627, '28', '2026-02-04', 'exit', '09:50:00.000000', 1),
(628, '28', '2026-02-04', 'entry', '11:57:00.000000', 4),
(629, '28', '2026-02-04', 'exit', '13:00:00.000000', 4),
(630, '28', '2026-02-04', 'entry', '09:57:00.000000', 2),
(631, '28', '2026-02-04', 'exit', '10:55:00.000000', 2),
(632, '15', '2026-02-09', 'entry', '08:55:00.000000', 1),
(633, '15', '2026-02-09', 'exit', '12:00:00.000000', 4),
(638, '1', '2026-02-10', 'entry', '09:02:00.000000', 1),
(639, '1', '2026-02-10', 'entry', '10:03:00.000000', 2),
(640, '1', '2026-02-10', 'entry', '11:01:00.000000', 3),
(641, '1', '2026-02-10', 'entry', '12:00:00.000000', 4),
(642, '1', '2026-02-10', 'exit', '12:58:00.000000', 4),
(643, '1', '2026-02-10', 'entry', '14:05:00.000000', 5),
(644, '1', '2026-02-10', 'entry', '15:02:00.000000', 6),
(645, '1', '2026-02-10', 'exit', '15:55:00.000000', 6),
(646, '1', '2026-02-11', 'entry', '09:52:31.000000', 1),
(647, '14', '2026-02-11', 'entry', '09:52:32.000000', 1),
(648, '3', '2026-02-11', 'entry', '09:52:32.000000', 1),
(649, '8', '2026-02-11', 'entry', '09:52:40.000000', 1),
(650, '14', '2026-02-11', 'exit', '09:52:53.000000', 1),
(651, '3', '2026-02-11', 'exit', '09:52:54.000000', 1),
(652, '1', '2026-02-11', 'exit', '09:52:59.000000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `studentgrievence_teachers`
--

CREATE TABLE `studentgrievence_teachers` (
  `id` bigint(20) NOT NULL,
  `t_name` varchar(150) NOT NULL,
  `t_email` varchar(150) NOT NULL,
  `t_department` varchar(150) NOT NULL,
  `t_semester` varchar(150) NOT NULL,
  `t_password` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentgrievence_teachers`
--

INSERT INTO `studentgrievence_teachers` (`id`, `t_name`, `t_email`, `t_department`, `t_semester`, `t_password`) VALUES
(1, 'Malini', 'malini@gmail.com', 'MCA', '2', 'Malini@03'),
(2, 'Gokul', 'gokul@gmail.com', 'Computer Science', '2', 'gokul123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `studentgrievence_acknowledgement`
--
ALTER TABLE `studentgrievence_acknowledgement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_assign`
--
ALTER TABLE `studentgrievence_assign`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_chatmessage`
--
ALTER TABLE `studentgrievence_chatmessage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_hod`
--
ALTER TABLE `studentgrievence_hod`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_pcomplaint`
--
ALTER TABLE `studentgrievence_pcomplaint`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_principals`
--
ALTER TABLE `studentgrievence_principals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_prodetails`
--
ALTER TABLE `studentgrievence_prodetails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_staffcomplaint`
--
ALTER TABLE `studentgrievence_staffcomplaint`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_stdcomplaint`
--
ALTER TABLE `studentgrievence_stdcomplaint`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_students`
--
ALTER TABLE `studentgrievence_students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_student_attendance`
--
ALTER TABLE `studentgrievence_student_attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentgrievence_teachers`
--
ALTER TABLE `studentgrievence_teachers`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `studentgrievence_acknowledgement`
--
ALTER TABLE `studentgrievence_acknowledgement`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studentgrievence_assign`
--
ALTER TABLE `studentgrievence_assign`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studentgrievence_chatmessage`
--
ALTER TABLE `studentgrievence_chatmessage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `studentgrievence_hod`
--
ALTER TABLE `studentgrievence_hod`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `studentgrievence_pcomplaint`
--
ALTER TABLE `studentgrievence_pcomplaint`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studentgrievence_principals`
--
ALTER TABLE `studentgrievence_principals`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studentgrievence_prodetails`
--
ALTER TABLE `studentgrievence_prodetails`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studentgrievence_staffcomplaint`
--
ALTER TABLE `studentgrievence_staffcomplaint`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `studentgrievence_stdcomplaint`
--
ALTER TABLE `studentgrievence_stdcomplaint`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `studentgrievence_students`
--
ALTER TABLE `studentgrievence_students`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `studentgrievence_student_attendance`
--
ALTER TABLE `studentgrievence_student_attendance`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=653;

--
-- AUTO_INCREMENT for table `studentgrievence_teachers`
--
ALTER TABLE `studentgrievence_teachers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
