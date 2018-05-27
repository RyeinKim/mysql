-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- 생성 시간: 16-12-31 06:32
-- 서버 버전: 10.1.16-MariaDB
-- PHP 버전: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `battle`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `bandata`
--

CREATE TABLE `bandata` (
  `admin` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `player` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `reason` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `IP` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `banned` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `buildingdata`
--

CREATE TABLE `buildingdata` (
  `id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `type` int(10) DEFAULT NULL,
  `price` int(10) DEFAULT NULL,
  `ent_X` float DEFAULT NULL,
  `ent_Y` float DEFAULT NULL,
  `ent_Z` float DEFAULT NULL,
  `ex_X` float DEFAULT NULL,
  `ex_Y` float DEFAULT NULL,
  `ex_Z` float DEFAULT NULL,
  `interior` int(10) DEFAULT NULL,
  `locked` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `factiondata`
--

CREATE TABLE `factiondata` (
  `id` int(10) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `type` int(10) DEFAULT NULL,
  `spawn_X` float DEFAULT NULL,
  `spawn_Y` float DEFAULT NULL,
  `spawn_Z` float DEFAULT NULL,
  `spawn_interior` int(10) DEFAULT NULL,
  `spawn_world` int(10) DEFAULT NULL,
  `rank_01` varchar(64) DEFAULT NULL,
  `rank_02` varchar(64) DEFAULT NULL,
  `rank_03` varchar(64) DEFAULT NULL,
  `rank_04` varchar(64) DEFAULT NULL,
  `rank_05` varchar(64) DEFAULT NULL,
  `rank_06` varchar(64) DEFAULT NULL,
  `rank_07` varchar(64) DEFAULT NULL,
  `rank_08` varchar(64) DEFAULT NULL,
  `rank_09` varchar(64) DEFAULT NULL,
  `rank_10` varchar(64) DEFAULT NULL,
  `rank_11` varchar(64) DEFAULT NULL,
  `rank_12` varchar(64) DEFAULT NULL,
  `rank_13` varchar(64) DEFAULT NULL,
  `rank_14` varchar(64) DEFAULT NULL,
  `rank_15` varchar(64) DEFAULT NULL,
  `rank_16` varchar(64) DEFAULT NULL,
  `rank_17` varchar(64) DEFAULT NULL,
  `rank_18` varchar(64) DEFAULT NULL,
  `rank_19` varchar(64) DEFAULT NULL,
  `rank_20` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `factiondata`
--

INSERT INTO `factiondata` (`id`, `name`, `type`, `spawn_X`, `spawn_Y`, `spawn_Z`, `spawn_interior`, `spawn_world`, `rank_01`, `rank_02`, `rank_03`, `rank_04`, `rank_05`, `rank_06`, `rank_07`, `rank_08`, `rank_09`, `rank_10`, `rank_11`, `rank_12`, `rank_13`, `rank_14`, `rank_15`, `rank_16`, `rank_17`, `rank_18`, `rank_19`, `rank_20`) VALUES
(1, 'LSPD', 1, 127.562, -254.744, 1.5781, 0, 0, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None');

-- --------------------------------------------------------

--
-- 테이블 구조 `hackdata`
--

CREATE TABLE `hackdata` (
  `player` varchar(20) DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `IP` varchar(16) DEFAULT NULL,
  `banned` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `hackdata`
--

INSERT INTO `hackdata` (`player`, `reason`, `IP`, `banned`) VALUES
('Police', '무기핵사용', '', 1),
('Art', '무기핵사용', '', 1),
('James_Key', '무기핵사용', '', 1),
('James_Robbe', '무기핵사용', '', 1);

-- --------------------------------------------------------

--
-- 테이블 구조 `itemdata`
--

CREATE TABLE `itemdata` (
  `user` varchar(24) DEFAULT NULL,
  `itemid_1` int(10) DEFAULT NULL,
  `amount_1` int(10) DEFAULT NULL,
  `itemid_2` int(10) DEFAULT NULL,
  `amount_2` int(10) DEFAULT NULL,
  `itemid_3` int(10) DEFAULT NULL,
  `amount_3` int(10) DEFAULT NULL,
  `itemid_4` int(10) DEFAULT NULL,
  `amount_4` int(10) DEFAULT NULL,
  `itemid_5` int(10) DEFAULT NULL,
  `amount_5` int(10) DEFAULT NULL,
  `itemid_6` int(10) DEFAULT NULL,
  `amount_6` int(10) DEFAULT NULL,
  `itemid_7` int(10) DEFAULT NULL,
  `amount_7` int(10) DEFAULT NULL,
  `itemid_8` int(10) DEFAULT NULL,
  `amount_8` int(10) DEFAULT NULL,
  `itemid_9` int(10) DEFAULT NULL,
  `amount_9` int(10) DEFAULT NULL,
  `itemid_10` int(10) DEFAULT NULL,
  `amount_10` int(10) DEFAULT NULL,
  `itemid_11` int(10) DEFAULT NULL,
  `amount_11` int(10) DEFAULT NULL,
  `itemid_12` int(10) DEFAULT NULL,
  `amount_12` int(10) DEFAULT NULL,
  `itemid_13` int(10) DEFAULT NULL,
  `amount_13` int(10) DEFAULT NULL,
  `itemid_14` int(10) DEFAULT NULL,
  `amount_14` int(10) DEFAULT NULL,
  `itemid_15` int(10) DEFAULT NULL,
  `amount_15` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `itemdata`
--

INSERT INTO `itemdata` (`user`, `itemid_1`, `amount_1`, `itemid_2`, `amount_2`, `itemid_3`, `amount_3`, `itemid_4`, `amount_4`, `itemid_5`, `amount_5`, `itemid_6`, `amount_6`, `itemid_7`, `amount_7`, `itemid_8`, `amount_8`, `itemid_9`, `amount_9`, `itemid_10`, `amount_10`, `itemid_11`, `amount_11`, `itemid_12`, `amount_12`, `itemid_13`, `amount_13`, `itemid_14`, `amount_14`, `itemid_15`, `amount_15`) VALUES
('mysql7749', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('mimi_mimi', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Test', 2, 3, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Striker', 2, 1, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('PingPong', 2, 1, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('1234', 2, 1, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('ffffvvvvffffffffbnff', 2, 1, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Yagmur', 2, 1, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Gorro_Gopr', 2, 1, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Hojin_Kim', 2, 1, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Leehi', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Aniston', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Joe_Ji', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Jeolyeong', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Jeonghuun_Go', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Natural', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('dsae', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('nick', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('illot', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Kan_Fes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Joshua_Jackson', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Antonio_Pelle', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('dan', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('redzz', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Picaboo', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Nicholas_James', 2, 1, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('zElda', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Cliff_Chu', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Samoubiuza_Holland', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Steven_Yune', 2, 1, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Middleton_Jaren', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('kostya', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('goku', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Stalone47', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('nm370', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Lance_Wilson', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Jin_Jik', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('kuae', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Taro_Homar', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('matii', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Nikita_PLayYT', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Art', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('[0]pss', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('kkk', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Jasung_Lee', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('frost', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('luap', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Dong_Bae', 2, 1, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Minwoo_Kim', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('billy', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('joedan', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('James_Key', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Laura_', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('tinh', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('ilo', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Akasaki', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Vlad_Maslov', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('sonic', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('33_boec_33', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('walid', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('apo', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('James_Robbe', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('andrei147123', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('YILDIZ', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('burak', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('akash', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Supert_', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Domikan_Rukatin', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('OPTIMUS', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Piltover_Caitlyn', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Hazne', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Howard_Julie', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Daily_Byed', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('adam2135453453456', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Xera123Derp', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('toprak', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('XXXXXX', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('jkuj', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('drn4ik', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('pavel2009', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Dilom', 2, 4, 4, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Skinz_Leon', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('VABRATOR', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('isaakio', 2, 3, 4, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('borao', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('ZSD', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('Kukuruza23', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('mersbmw', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('pepa', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('serdar', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('axel', 2, 2, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- 테이블 구조 `kickdata`
--

CREATE TABLE `kickdata` (
  `year` int(20) DEFAULT NULL,
  `month` int(20) DEFAULT NULL,
  `day` int(20) DEFAULT NULL,
  `hour` int(20) DEFAULT NULL,
  `minute` int(20) DEFAULT NULL,
  `second` int(20) DEFAULT NULL,
  `admin` varchar(20) DEFAULT NULL,
  `player` varchar(20) DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `IP` varchar(16) DEFAULT NULL,
  `kicked` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `kickdata`
--

INSERT INTO `kickdata` (`year`, `month`, `day`, `hour`, `minute`, `second`, `admin`, `player`, `reason`, `IP`, `kicked`) VALUES
(2016, 11, 5, 1, 4, 53, 'Leehi', 'matii', 'Sorry', '93.181.174.173', 1),
(2016, 11, 5, 1, 5, 49, 'Leehi', 'Nikita_PLayYT', 'Sorry', '109.172.46.16', 1);

-- --------------------------------------------------------

--
-- 테이블 구조 `playerdata`
--

CREATE TABLE `playerdata` (
  `user` varchar(24) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `admin` int(10) DEFAULT NULL,
  `score` int(20) DEFAULT NULL,
  `money` int(20) DEFAULT NULL,
  `level` int(20) DEFAULT NULL,
  `vip` int(20) DEFAULT NULL,
  `tutorial` int(20) DEFAULT NULL,
  `kma` int(20) DEFAULT NULL,
  `rank` int(20) DEFAULT NULL,
  `kills` int(20) DEFAULT NULL,
  `deaths` int(20) DEFAULT NULL,
  `muted` int(20) NOT NULL,
  `jailed` int(20) NOT NULL,
  `frozen` int(20) NOT NULL,
  `mutedtimes` int(20) NOT NULL,
  `jailedtimes` int(20) NOT NULL,
  `frozentimes` int(20) NOT NULL,
  `banned` int(20) NOT NULL,
  `bannedby` varchar(24) NOT NULL,
  `logins` int(20) NOT NULL,
  `IP` varchar(15) NOT NULL,
  `posX` float DEFAULT NULL,
  `posY` float DEFAULT NULL,
  `posZ` float DEFAULT NULL,
  `vworld` int(10) DEFAULT NULL,
  `interior` int(10) DEFAULT NULL,
  `bank` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `playerdata`
--

INSERT INTO `playerdata` (`user`, `password`, `admin`, `score`, `money`, `level`, `vip`, `tutorial`, `kma`, `rank`, `kills`, `deaths`, `muted`, `jailed`, `frozen`, `mutedtimes`, `jailedtimes`, `frozentimes`, `banned`, `bannedby`, `logins`, `IP`, `posX`, `posY`, `posZ`, `vworld`, `interior`, `bank`) VALUES
('Leehi', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 22, '127.0.0.1', 0, 0, 0, 0, 0, 0),
('Aniston', 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '112.172.91.186', 0, 0, 0, 0, 0, 0),
('Joe_Ji', 'cbf343c65a885e4e7f58eecf7c639783b0fc4355', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 2, '180.68.224.22', 0, 0, 0, 0, 0, 0),
('Jeolyeong', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '221.167.97.57', 0, 0, 0, 0, 0, 0),
('', '194a2bf71a76de9d6c5c2c927018d7b4d17e1db6', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '211.225.110.113', 0, 0, 0, 0, 0, 0),
('Natural', '1922466a71c505375aabf260fc5d381952ac0103', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '58.124.145.131', 0, 0, 0, 0, 0, 0),
('dsae', 'a28e5e6bc518468404ebaadf2b31032146fa2c97', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '211.179.126.74', 0, 0, 0, 0, 0, 0),
('nick', 'ee0f09e2858afb976f24c99b149b31fa3ead5cd0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '118.217.74.30', 0, 0, 0, 0, 0, 0),
('illot', '9e9d5bc7f43bd7b20677ac430e22a92559651bad', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 2, '116.40.218.182', 0, 0, 0, 0, 0, 0),
('Kan_Fes', 'd0fa0c6ac0da7e8a73e8bb11c34f7965482b598a', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '59.2.103.112', 0, 0, 0, 0, 0, 0),
('Joshua_Jackson', '246153753cfea5331294d3ebf7b4bbede13b5981', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '125.186.66.130', 0, 0, 0, 0, 0, 0),
('Antonio_Pelle', '520e77b44c07a0d12fb319791aa0cfd87904c267', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '211.225.41.162', 0, 0, 0, 0, 0, 0),
('dan', '5cc94d373f6206a35007d000592528620938dec3', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, '188.237.60.240', 0, 0, 0, 0, 0, 0),
('Picaboo', '356a192b7913b04c54574d18c28d46e6395428ab', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, '180.70.170.45', 0, 0, 0, 0, 0, 0),
('Nicholas_James', 'ed5994b1ee198a5328f76ba2ae86f9d924e4e418', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '1.242.13.92', 0, 0, 0, 0, 0, 0),
('zElda', 'ee2dd528e48d6093c4207f84287ad6dd363f982b', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 3, '125.138.160.6', 36.5712, 36.5712, 4.11852, 0, 0, 0),
('Cliff_Chu', '92aa5eee3a15302b80a7d3fee034a09116a34a7d', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '220.87.163.96', 0, 0, 0, 0, 0, 0),
('Samoubiuza_Holland', '4d9012b4a77a9524d675dad27c3276ab5705e5e8', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '46.173.85.72', 0, 0, 0, 0, 0, 0),
('Steven_Yune', '739fa0ea21358a5020762f611091139561c1d9e1', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '180.70.188.71', 0, 0, 0, 0, 0, 0),
('Middleton_Jaren', '7c4a8d09ca3762af61e59520943dc26494f8941b', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '125.181.17.177', 0, 0, 0, 0, 0, 0),
('kostya', 'b490566d49e36e67b3f1847b229d98dfa0b3d1f0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '46.63.26.221', 0, 0, 0, 0, 0, 0),
('goku', '7dbd464b96cc2897507be8a475926dbe173ad452', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, '103.26.52.89', 0, 0, 0, 0, 0, 0),
('', '6a6c1ebd4a9ddfac46e540d288eb146e84c71e1c', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '132.255.169.235', 0, 0, 0, 0, 0, 0),
('nm370', '6934105ad50010b814c933314b1da6841431bc8b', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, '42.7.155.223', 0, 0, 0, 0, 0, 0),
('Jin_Jik', '1d1a537d49eb9912a0069d7508cdf237de4a2434', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '223.62.234.49', 0, 0, 0, 0, 0, 0),
('Lance_Wilson', '5361d5886e290960478baf8a37c9b6891afd7ac5', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '116.46.175.173', 0, 0, 0, 0, 0, 0),
('kuae', '7c7427926b7bdbdc971e0ae8914db32de3dcad85', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '187.67.22.174', 0, 0, 0, 0, 0, 0),
('Taro_Homar', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '220.82.239.30', 0, 0, 0, 0, 0, 0),
('matii', '9047b4c0205d568569b598c813670ae254a5276e', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '93.181.174.173', 0, 0, 0, 0, 0, 0),
('Nikita_PLayYT', 'fdd3717938b838f0d3ce996aa4bfb530216a34d3', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '109.172.46.16', 0, 0, 0, 0, 0, 0),
('Art', '356a192b7913b04c54574d18c28d46e6395428ab', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '175.119.252.46', 0, 0, 0, 0, 0, 0),
('[0]pss', '9f981c88d260074580efb21c7e242df3dfdbf5d5', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '186.158.136.38', 0, 0, 0, 0, 0, 0),
('kkk', '03dbe7fec7bce30e47549bd61ffd394167f6d472', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, '', 23, '183.88.18.177', 0, 0, 0, 0, 0, 0),
('Jasung_Lee', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '180.71.30.78', 0, 0, 0, 0, 0, 0),
('', 'e052ad4a9daa50e731e9bccd6e00f570017685de', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '112.198.118.228', 0, 0, 0, 0, 0, 0),
('luap', '0c7e78629ef4b1404cb7ad6f5b4c2af3e200667e', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '49.150.160.169', 0, 0, 0, 0, 0, 0),
('Dong_Bae', '52c3209fad18e605776814587c06bb7a34365c83', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '221.141.219.33', 0, 0, 0, 0, 0, 0),
('Minwoo_Kim', '2cc53797423cbf821c306b21e7ba717df2cb1b47', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '118.46.254.84', 0, 0, 0, 0, 0, 0),
('billy', '1cb5155599ca1d61458e02ff38596a324070f968', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '61.94.217.109', 0, 0, 0, 0, 0, 0),
('', '8989f7bc2eb8e9ae09553acd93f997372f7add7b', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '112.198.118.228', 0, 0, 0, 0, 0, 0),
('James_Key', '8cb2237d0679ca88db6464eac60da96345513964', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '59.7.20.81', 0, 0, 0, 0, 0, 0),
('', '00fd4b4549a1094aae926ef62e9dbd3cdcc2e456', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '119.201.245.233', 0, 0, 0, 0, 0, 0),
('tinh', 'd6478c501a7302708cb52f1134bac3472bfa4b96', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, '115.78.122.20', 0, 0, 0, 0, 0, 0),
('', 'c5ad4f982e10a9e7f9faaa0eff5f665dfcb4b2e0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '188.129.238.109', 0, 0, 0, 0, 0, 0),
('Akasaki', '8cb2237d0679ca88db6464eac60da96345513964', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '1.233.38.222', 0, 0, 0, 0, 0, 0),
('', 'd8a6d1ba2a61eef27e070b12250e2a7c2a0ba986', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '109.191.194.186', 0, 0, 0, 0, 0, 0),
('33_boec_33', '01b307acba4f54f55aafc33bb06bbbf6ca803e9a', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '109.202.51.128', 0, 0, 0, 0, 0, 0),
('walid', '29cfe565c173377d2c8f1d3b56507c47f300ebd2', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '36.80.31.113', 0, 0, 0, 0, 0, 0),
('James_Robbe', '8cb2237d0679ca88db6464eac60da96345513964', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '59.7.20.81', 0, 0, 0, 0, 0, 0),
('andrei147123', 'a3091f58a8e2df0e656c9b95dce5f4c2f7ad2c2b', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '119.94.30.176', 0, 0, 0, 0, 0, 0),
('YILDIZ', 'f98bd42930fc649029e03df3c67c9f73277eb261', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '88.249.180.238', 0, 0, 0, 0, 0, 0),
('akash', 'e4cf979cf717fd295f4e4edc427ee1aee78fa7dc', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '58.71.156.170', 0, 0, 0, 0, 0, 0),
('', '6039048cd77a464adfabd17014ec358cf14ddbe1', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '211.110.221.204', 0, 0, 0, 0, 0, 0),
('OPTIMUS', 'dce8a86c640abf2233b1c022299939224c186b16', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '89.35.45.250', 0, 0, 0, 0, 0, 0),
('', '48379a1df87de57484f6c248d048c25ba699ecce', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '119.205.152.167', 0, 0, 0, 0, 0, 0),
('Hazne', 'dd9e708d27ece2df67007e717ffb94792766574c', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '213.153.252.64', 0, 0, 0, 0, 0, 0),
('Howard_Julie', 'a6de24df03eea075d8e473667bbce99011feef18', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '116.33.205.80', 0, 0, 0, 0, 0, 0),
('Daily_Byed', '23c215aa77601c8f07840d72c48d822524b835ce', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '59.4.204.208', 0, 0, 0, 0, 0, 0),
('adam2135453453456', 'd1d16e56a9ba42997b9cd22e824a393731afd341', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '41.234.174.235', 0, 0, 0, 0, 0, 0),
('Xera123Derp', '7960a227983566be6b02562cdeb11f9d06e57514', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '49.228.115.141', 0, 0, 0, 0, 0, 0),
('toprak', '3f1035cc0b9f7e38657da37572fd63d80d854516', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 3, '31.223.103.230', 0, 0, 0, 0, 0, 0),
('jkuj', 'eb24e2bec750f0ca94dea948d563c2d642caeb61', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, '31.223.103.230', 0, 0, 0, 0, 0, 0),
('XXXXXX', 'a4c1d0441ce79e81e5b485ea5fcda7d1c56b743e', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 3, '31.223.103.230', 0, 0, 0, 0, 0, 0),
('drn4ik', '89a34be6102126c50a8cd033fe168815e694d84b', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '5.136.82.84', 0, 0, 0, 0, 0, 0),
('', 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '159.224.104.137', 0, 0, 0, 0, 0, 0),
('', '356a192b7913b04c54574d18c28d46e6395428ab', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '121.169.207.185', 0, 0, 0, 0, 0, 0),
('VABRATOR', '9b9664c93b787f3a05654e48e9674b6b0e743fe4', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '2.85.131.156', 0, 0, 0, 0, 0, 0),
('borao', '803ad839741b7f1760661c1cc6aad0380c8e0d08', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '78.187.40.111', 0, 0, 0, 0, 0, 0),
('ZSD', '3608a6d1a05aba23ea390e5f3b48203dbb7241f7', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '83.31.118.100', 0, 0, 0, 0, 0, 0),
('mersbmw', 'baf94e100cc3366cbadb11a1e5bdc8cfc0322308', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '37.157.216.137', 0, 0, 0, 0, 0, 0),
('pepa', 'd0c76bed72e812721b584cef4de35884e760fdb2', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '188.92.11.25', 0, 0, 0, 0, 0, 0),
('serdar', '1033431a28502e53d51f19c5fc1a246b534fb345', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '95.5.28.147', 0, 0, 0, 0, 0, 0),
('axel', '1241336d0bb005a80697dfc9d29289a5cc07c462', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Not Banned', 0, '77.243.144.139', 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- 테이블 구조 `spawndata`
--

CREATE TABLE `spawndata` (
  `year` int(20) DEFAULT NULL,
  `month` int(20) DEFAULT NULL,
  `day` int(20) DEFAULT NULL,
  `hour` int(20) DEFAULT NULL,
  `minute` int(20) DEFAULT NULL,
  `second` int(20) DEFAULT NULL,
  `admin` varchar(20) DEFAULT NULL,
  `player` varchar(20) DEFAULT NULL,
  `IP` varchar(16) DEFAULT NULL,
  `Spawned` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `spawndata`
--

INSERT INTO `spawndata` (`year`, `month`, `day`, `hour`, `minute`, `second`, `admin`, `player`, `IP`, `Spawned`) VALUES
(2016, 10, 23, 14, 17, 13, 'Test', 'Test', '127.0.0.1', 1),
(2016, 10, 23, 20, 40, 17, 'Test', 'Hojin_Kim', '175.118.74.34', 1);

-- --------------------------------------------------------

--
-- 테이블 구조 `vehicledata`
--

CREATE TABLE `vehicledata` (
  `model` int(10) DEFAULT NULL,
  `numberplate` varchar(24) DEFAULT NULL,
  `X` float DEFAULT NULL,
  `Y` float DEFAULT NULL,
  `Z` float DEFAULT NULL,
  `angle` float DEFAULT NULL,
  `color1` int(10) DEFAULT NULL,
  `color2` int(10) DEFAULT NULL,
  `paintjob` int(10) DEFAULT NULL,
  `interior` int(10) DEFAULT NULL,
  `world` int(10) DEFAULT NULL,
  `owner` varchar(24) NOT NULL,
  `door` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `vehicledata`
--

INSERT INTO `vehicledata` (`model`, `numberplate`, `X`, `Y`, `Z`, `angle`, `color1`, `color2`, `paintjob`, `interior`, `world`, `owner`, `door`) VALUES
(400, 'LS2141', 127.13, -260.386, 6.641, 0, 0, 0, 3, 0, 0, 'Leehi', 0),
(521, 'LS2985', 1461.11, -1742.4, 13.5468, 0, 0, 0, 3, 0, 0, 'Leehi', 0);

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `buildingdata`
--
ALTER TABLE `buildingdata`
  ADD PRIMARY KEY (`id`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `buildingdata`
--
ALTER TABLE `buildingdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
