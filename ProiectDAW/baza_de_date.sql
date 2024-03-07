-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: sql302.infinityfree.com
-- Generation Time: Mar 07, 2024 at 01:05 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `if0_35358345_universitate`
--

-- --------------------------------------------------------

--
-- Table structure for table `FACULTATE`
--

CREATE TABLE `FACULTATE` (
  `id_facultate` int(4) NOT NULL,
  `nume_facultate` varchar(256) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `FACULTATE`
--

INSERT INTO `FACULTATE` (`id_facultate`, `nume_facultate`) VALUES
(1, 'Facultatea de Matematica si Informatica'),
(2, 'Facultatea de Administrare si Afaceri'),
(3, 'Facultatea de Chimie');

-- --------------------------------------------------------

--
-- Table structure for table `GRUPA`
--

CREATE TABLE `GRUPA` (
  `id_grupa` int(4) NOT NULL,
  `id_specialitate` int(4) NOT NULL,
  `numar_grupa` int(3) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `GRUPA`
--

INSERT INTO `GRUPA` (`id_grupa`, `id_specialitate`, `numar_grupa`) VALUES
(1, 1, 101),
(2, 2, 131),
(3, 2, 132),
(4, 3, 151),
(5, 0, 204),
(7, 0, 205),
(8, 0, 205),
(9, 0, 205),
(10, 0, 205),
(11, 0, 205);

-- --------------------------------------------------------

--
-- Table structure for table `MATERIE`
--

CREATE TABLE `MATERIE` (
  `id_materie` int(4) NOT NULL,
  `id_specialitate` int(4) NOT NULL,
  `id_profesor` int(4) NOT NULL,
  `nume_materie` varchar(256) NOT NULL,
  `nr_credite` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `MATERIE`
--

INSERT INTO `MATERIE` (`id_materie`, `id_specialitate`, `id_profesor`, `nume_materie`, `nr_credite`) VALUES
(1, 1, 1, 'Algebra I', 6),
(2, 1, 1, 'Analiza I', 5),
(3, 1, 2, 'Algebra liniara', 6),
(4, 1, 1, 'Geometrie', 4),
(5, 2, 3, 'Arhitectura sistemelor de calcul', 6),
(6, 2, 4, 'Calcul Diferential si Integral', 5),
(7, 2, 5, 'Logica Matematica si Computationala', 4),
(8, 2, 3, 'Programarea algoritmilor', 5),
(9, 2, 4, 'Baze de date', 5),
(10, 3, 7, 'Programarea calculatoarelor', 7),
(11, 3, 8, 'Sisteme de operare', 6),
(12, 3, 8, 'Structuri de date', 5),
(13, 3, 3, 'Fizica', 6);

-- --------------------------------------------------------

--
-- Table structure for table `NOTA`
--

CREATE TABLE `NOTA` (
  `nr_matricol` varchar(10) NOT NULL,
  `id_materie` int(4) NOT NULL,
  `nota` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `NOTA`
--

INSERT INTO `NOTA` (`nr_matricol`, `id_materie`, `nota`) VALUES
('817/2023', 4, 0),
('817/2023', 3, 0),
('817/2023', 2, 0),
('817/2023', 1, 7),
('97/2023', 9, 0),
('97/2023', 8, 0),
('97/2023', 7, 0),
('97/2023', 6, 0),
('97/2023', 5, 0),
('654/2023', 4, 0),
('654/2023', 3, 0),
('654/2023', 2, 0),
('654/2023', 1, 9),
('659/2023', 4, 0),
('659/2023', 3, 0),
('659/2023', 2, 0),
('659/2023', 1, 9),
('120/2023', 4, 0),
('120/2023', 3, 0),
('120/2023', 2, 0),
('120/2023', 1, 7),
('608/2023', 9, 0),
('608/2023', 8, 8),
('608/2023', 7, 0),
('608/2023', 6, 10),
('608/2023', 5, 0),
('110/2023', 13, 7),
('110/2023', 12, 0),
('110/2023', 11, 0),
('110/2023', 10, 0),
('738/2023', 13, 8),
('738/2023', 12, 0),
('738/2023', 11, 0),
('738/2023', 10, 0),
('454/2023', 9, 0),
('454/2023', 8, 0),
('454/2023', 7, 0),
('454/2023', 6, 6),
('454/2023', 5, 4),
('366/2023', 4, 0),
('366/2023', 3, 0),
('366/2023', 2, 0),
('366/2023', 1, 8),
('723/2023', 9, 8),
('723/2023', 8, 5),
('723/2023', 7, 0),
('723/2023', 6, 0),
('723/2023', 5, 0),
('245/2023', 4, 0),
('245/2023', 3, 0),
('245/2023', 2, 0),
('245/2023', 1, 7),
('663/2023', 9, 0),
('663/2023', 8, 4),
('663/2023', 7, 0),
('663/2023', 6, 0),
('663/2023', 5, 0),
('552/2023', 4, 0),
('552/2023', 3, 0),
('552/2023', 2, 0),
('552/2023', 1, 5),
('713/2023', 13, 9),
('713/2023', 12, 0),
('713/2023', 11, 0),
('713/2023', 10, 0),
('812/2023', 4, 0),
('812/2023', 3, 0),
('812/2023', 2, 0),
('812/2023', 1, 10),
('353/2023', 9, 0),
('353/2023', 8, 0),
('353/2023', 7, 0),
('353/2023', 6, 0),
('353/2023', 5, 0),
('432/2023', 13, 10),
('432/2023', 12, 0),
('432/2023', 11, 0),
('432/2023', 10, 0),
('690/2023', 9, 0),
('690/2023', 8, 0),
('690/2023', 7, 0),
('690/2023', 6, 0),
('690/2023', 5, 8),
('732/2023', 9, 0),
('732/2023', 8, 3),
('732/2023', 7, 0),
('732/2023', 6, 0),
('732/2023', 5, 8),
('372/2023', 4, 0),
('372/2023', 3, 0),
('372/2023', 2, 0),
('372/2023', 1, 9),
('413/2023', 13, 7),
('413/2023', 12, 0),
('413/2023', 11, 0),
('413/2023', 10, 0),
('890/2023', 9, 0),
('890/2023', 8, 6),
('890/2023', 7, 0),
('890/2023', 6, 0),
('890/2023', 5, 0),
('583/2023', 9, 0),
('583/2023', 8, 0),
('583/2023', 7, 0),
('583/2023', 6, 0),
('583/2023', 5, 0),
('291/2023', 13, 6),
('291/2023', 12, 0),
('291/2023', 11, 0),
('291/2023', 10, 0),
('625/2023', 13, 0),
('625/2023', 12, 0),
('625/2023', 11, 0),
('625/2023', 10, 0),
('705/2023', 13, 0),
('705/2023', 12, 0),
('705/2023', 11, 0),
('705/2023', 10, 0),
('669/2023', 4, 0),
('669/2023', 3, 0),
('669/2023', 2, 0),
('669/2023', 1, 5),
('122/2023', 9, 0),
('122/2023', 8, 5),
('122/2023', 7, 0),
('122/2023', 6, 0),
('122/2023', 5, 6),
('27/2023', 9, 0),
('27/2023', 8, 0),
('27/2023', 7, 0),
('27/2023', 6, 0),
('27/2023', 5, 10),
('737/2023', 4, 0),
('737/2023', 3, 0),
('737/2023', 2, 12),
('737/2023', 1, 6),
('850/2023', 9, 0),
('850/2023', 8, 3),
('850/2023', 7, 0),
('850/2023', 6, 0),
('850/2023', 5, 0),
('918/2023', 9, 0),
('918/2023', 8, 0),
('918/2023', 7, 0),
('918/2023', 6, 0),
('918/2023', 5, 0),
('130/2023', 9, 0),
('130/2023', 8, 0),
('130/2023', 7, 0),
('130/2023', 6, 0),
('130/2023', 5, 0),
('634/2023', 13, 0),
('634/2023', 12, 0),
('634/2023', 11, 0),
('634/2023', 10, 0),
('600/2023', 13, 0),
('600/2023', 12, 0),
('600/2023', 11, 0),
('600/2023', 10, 6),
('160/2023', 13, 0),
('160/2023', 12, 0),
('160/2023', 11, 0),
('160/2023', 10, 0),
('236/2023', 13, 0),
('236/2023', 12, 0),
('236/2023', 11, 0),
('236/2023', 10, 6),
('495/2023', 9, 0),
('495/2023', 8, 0),
('495/2023', 7, 0),
('495/2023', 6, 0),
('495/2023', 5, 1),
('904/2023', 5, 0),
('904/2023', 6, 0),
('904/2023', 7, 0),
('904/2023', 8, 0),
('904/2023', 9, 9),
('678/2023', 5, 0),
('678/2023', 6, 0),
('678/2023', 7, 0),
('678/2023', 8, 9),
('678/2023', 9, 0),
('493/2023', 5, 9),
('493/2023', 6, 8),
('493/2023', 7, 0),
('493/2023', 8, 0),
('493/2023', 9, 0),
('642/2023', 5, 0),
('642/2023', 6, 0),
('642/2023', 7, 0),
('642/2023', 8, 10),
('642/2023', 9, 0),
('153/2023', 5, 0),
('153/2023', 6, 0),
('153/2023', 7, 0),
('153/2023', 8, 0),
('153/2023', 9, 0),
('542/2023', 5, 0),
('542/2023', 6, 0),
('542/2023', 7, 0),
('542/2023', 8, 0),
('542/2023', 9, 9),
('780/2023', 10, 0),
('780/2023', 11, 0),
('780/2023', 12, 0),
('780/2023', 13, 0),
('368/2023', 5, 0),
('368/2023', 6, 0),
('368/2023', 7, 0),
('368/2023', 8, 0),
('368/2023', 9, 4),
('259/2023', 5, 5),
('259/2023', 6, 0),
('259/2023', 7, 0),
('259/2023', 8, 0),
('259/2023', 9, 8),
('628/2023', 5, 6),
('628/2023', 6, 0),
('628/2023', 7, 0),
('628/2023', 8, 0),
('628/2023', 9, 0),
('765/2023', 5, 0),
('765/2023', 6, 0),
('765/2023', 7, 0),
('765/2023', 8, 0),
('765/2023', 9, 0),
('465/2023', 5, 9),
('465/2023', 6, 0),
('465/2023', 7, 0),
('465/2023', 8, 0),
('465/2023', 9, 0),
('133/2023', 5, 0),
('133/2023', 6, 0),
('133/2023', 7, 0),
('133/2023', 8, 0),
('133/2023', 9, 0),
('516/2023', 1, 8),
('516/2023', 2, 0),
('516/2023', 3, 0),
('516/2023', 4, 0),
('338/2023', 5, 0),
('338/2023', 6, 0),
('338/2023', 7, 0),
('338/2023', 8, 7),
('338/2023', 9, 0),
('907/2023', 5, 0),
('907/2023', 6, 0),
('907/2023', 7, 0),
('907/2023', 8, 0),
('907/2023', 9, 0),
('481/2023', 5, 7),
('481/2023', 6, 0),
('481/2023', 7, 0),
('481/2023', 8, 9),
('481/2023', 9, 0),
('100/2022', 10, 0),
('100/2022', 11, 0),
('100/2022', 12, 0),
('100/2022', 13, 9),
('969/2021', 10, 0),
('969/2021', 11, 0),
('969/2021', 12, 0),
('969/2021', 13, 8),
('12/2022', 5, 0),
('12/2022', 6, 0),
('12/2022', 7, 0),
('12/2022', 8, 0),
('12/2022', 9, 0),
('13/2022', 10, 10),
('13/2022', 11, 0),
('13/2022', 12, 0),
('13/2022', 13, 0);

-- --------------------------------------------------------

--
-- Table structure for table `PROFESOR`
--

CREATE TABLE `PROFESOR` (
  `id_profesor` int(4) NOT NULL,
  `id_facultate` int(4) NOT NULL,
  `cnp` varchar(13) NOT NULL,
  `profesor_nume` varchar(256) NOT NULL,
  `data_nastere` date NOT NULL,
  `email` varchar(256) NOT NULL,
  `parola` varchar(256) NOT NULL,
  `telefon` varchar(12) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PROFESOR`
--

INSERT INTO `PROFESOR` (`id_profesor`, `id_facultate`, `cnp`, `profesor_nume`, `data_nastere`, `email`, `parola`, `telefon`) VALUES
(1, 1, '1451011256477', 'Mirel Voinea', '1991-01-17', 'mirel_voinea@gmail.com', '$2y$10$QES2WeNXSst4fP8jlNdirO744VTvE3WNT2yi6Y/EzGRtJaiXqfBtS', '0752310659'),
(2, 1, '2640704391563', 'Eugen Nita', '1979-10-18', 'eugen_nita@gmail.com', '$2y$10$3x/Lqj91nZfYDcRgtaE9NezqU6W1gzWU5gFvDl5DEAHDggxdLvaj.', '0752946645'),
(3, 1, '5110109322071', 'Laurentiu Petrescu', '1988-09-05', 'laurentiu_petrescu@gmail.com', '$2y$10$lEH6hwqha2r7MqxRXjlWle62A9fPqP7EEfllM5nTxha.QQCCaa3I6', '0758710357'),
(4, 1, '6090212366511', 'Andreea Barbu', '1988-08-04', 'andreea_barbu@gmail.com', '$2y$10$TdW6btcTQE8ubOv3Vnvtb.P84uFskiROAY02zdKanvf1vDTVBcSR2', '0750999502'),
(5, 1, '2920314080441', 'Viorela Palici', '1969-11-13', 'viorela_palici@gmail.com', '$2y$10$KsBdISCRHhhb5AIpY0ePmee8Z7s8Mwlzl4L2PJZykisagslNYfkeK', '0235507298'),
(6, 1, '2720428363355', 'Valeriu Ionescu', '1978-07-23', 'valeriu_ionescu@gmail.com', '$2y$10$JtfEY63IkhK7wajHCycsj.0QkH4UnRyvufmlgeHd1PH9JsGWyAsgC', '0363485560'),
(7, 1, '2930115220037', 'Viorela Pavel', '1990-02-02', 'viorela_pavel@gmail.com', '$2y$10$OwN/QWH6dGH3thB1PYwaHeThixCkZgUoYhDTUvIo3T/513FLtES9m', '0788909171'),
(8, 1, '2003500123345', 'Mirel Constantinescu', '1990-01-01', 'mirel_constantinescu@gmail.com', '$2y$10$Sww3LCB8aV.8KD46w8zYr./ZD0JfrxLWErVwJKfS//SVD8U5zeP4O', '0722416153'),
(9, 1, '1320923273910', 'Andreea Ifrim', '1985-05-03', 'andreea_ifrim@gmail.com', '$2y$10$iLXtmxf0Y4I/AgveXdhDbehHGZLU.cpivWsZtH19l2F3vlbWUnivu', '0754860887'),
(20, 1, '2003500123399', 'root', '1990-01-01', 'rapceacatalinc@gmail.com', '$2y$10$5RV7CMkqBqxN.FKOR.DnfOqAProMIVPCHINp.IvsruttW15harroi', '0722416154');

-- --------------------------------------------------------

--
-- Table structure for table `SPECIALITATE`
--

CREATE TABLE `SPECIALITATE` (
  `id_specialitate` int(4) NOT NULL,
  `id_facultate` int(4) NOT NULL,
  `nume_specialitate` varchar(256) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SPECIALITATE`
--

INSERT INTO `SPECIALITATE` (`id_specialitate`, `id_facultate`, `nume_specialitate`) VALUES
(1, 1, 'Matematica'),
(2, 1, 'Informatica'),
(3, 1, 'CTI');

-- --------------------------------------------------------

--
-- Table structure for table `STUDENT`
--

CREATE TABLE `STUDENT` (
  `nr_matricol` varchar(10) NOT NULL,
  `id_grupa` int(4) NOT NULL,
  `cnp` varchar(13) NOT NULL,
  `student_nume` varchar(256) NOT NULL,
  `data_nastere` date NOT NULL,
  `email` varchar(256) NOT NULL,
  `parola` varchar(256) NOT NULL,
  `telefon` varchar(12) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `STUDENT`
--

INSERT INTO `STUDENT` (`nr_matricol`, `id_grupa`, `cnp`, `student_nume`, `data_nastere`, `email`, `parola`, `telefon`) VALUES
('495/2023', 2, '5026427193249', 'Constantinescu Adelina', '2003-10-28', 'constantinescu_adelina@gmail.com', '$2y$10$NjOX/azbKO8lNb0EMW29Ce/fh/KMnjAUT08zKsiZO3M8cDfH3eEma', '0758583644'),
('236/2023', 4, '5014573096308', 'Munteanu Florin', '2003-10-08', 'munteanu_florin@gmail.com', '$2y$10$mES3uMCmcp78FHy7XQsVzOY//game8aJh5LSKG4Su4UL5TZs70I5.', '0751110996'),
('160/2023', 4, '5011496450248', 'Munteanu Elena', '2003-06-27', 'munteanu_elena@gmail.com', '$2y$10$RJTFDFARxODHE20sJRwGOuGQhWcBqqVVklA.WpLHZzuuSBOtpS3hm', '0755663455'),
('600/2023', 4, '5046261743092', 'Radulescu Adelina', '2002-02-21', 'radulescu_adelina@gmail.com', '$2y$10$2mBBR6ZcsQv0DOgguMojM.TNSan87c41WlPOmrRc0NzrntUqnfOmK', '0755196203'),
('634/2023', 4, '5041526849724', 'Serban Maria', '2002-10-18', 'serban_maria@gmail.com', '$2y$10$FbqM/rmE67jPAWx05ljcw.Q2btkXpo8n6u.95YaiX73cc6a6ljIIO', '0755485389'),
('130/2023', 2, '5038900144367', 'Dumitru Florin', '2003-05-25', 'dumitru_florin@gmail.com', '$2y$10$B3y5z1lFfcyIVKWmhbqLxuV.VeQeAA1sNp6RYEG.DXdlSd0oURKNG', '0751851893'),
('918/2023', 3, '5035631290579', 'Rusu George', '2003-06-16', 'rusu_george@gmail.com', '$2y$10$QgeD9oDwVUeDD/Jrzi46ceJLFWDI.1jDATdcWy.t5k.8y49ZNwPK2', '0758839915'),
('850/2023', 3, '5018855264124', 'Ionescu Dragos', '2003-09-15', 'ionescu_dragos@gmail.com', '$2y$10$NfXxNGVUN9MRnE4xxjr4oOpE9Yqux6wfqv5bJVsppSrE5fKsoYXOe', '0754671687'),
('737/2023', 1, '5047612109645', 'Ciobanu Elena', '2003-12-27', 'ciobanu_elena@gmail.com', '$2y$10$FPYAPoX8Hb21aOAqtIFpPeI6P/DOVEI5DiNXQ537DyUcB5.6E7cjK', '0751883093'),
('27/2023', 2, '5046150433117', 'Matei Cristina', '2003-09-18', 'matei_cristina@gmail.com', '$2y$10$ERss1SnGolvTZK/zOdLKXe2UrtsAInvJU9jBkwS5cGRiXZ9AW/WFK', '0751875343'),
('122/2023', 3, '5020954901248', 'Matei Bianca', '2002-11-20', 'matei_bianca@gmail.com', '$2y$10$Rohba4j1UDtyNcHiGzLE1.Gf0S/amXd1DqfNxCqn2VT.I7C7hNHb.', '0758923805'),
('669/2023', 1, '5049654346253', 'Florea Ana', '2002-12-28', 'florea_ana@gmail.com', '$2y$10$rT7tQ/EukF/vhBYZ140d6u9Df4Dw4Bfs6iuDcpQZi7SkbewDrgcc.', '0758273104'),
('705/2023', 4, '5016632099883', 'Munteanu Maria', '2002-07-22', 'munteanu_maria@gmail.com', '$2y$10$4e//qs7IEeS1rKkw15PSYOSqvldsiOk5/ZVI1XyjWAcwYXhUlRpV.', '0755140775'),
('625/2023', 4, '5042083824382', 'Ionescu Andrei', '2003-05-28', 'ionescu_andrei@gmail.com', '$2y$10$kIgAevIZijmij85HOOlCrumElaPg0d0eTKgKHF6y/H/3uKs8HhzLq', '0756733922'),
('291/2023', 4, '5040053272236', 'Ionescu Bianca', '2002-01-03', 'ionescu_bianca@gmail.com', '$2y$10$x406EsaudozbhqOsSv7yqefs7EAfjvxk05dkDHskinTiCrRqoHcZK', '0757657686'),
('583/2023', 2, '5034080011015', 'Georgescu Stefan', '2002-09-04', 'georgescu_stefan@gmail.com', '$2y$10$UDmIREGT80QSpC3B6ZaH0e7TC2j97v6.lFR7wVke47gz8bK8ZQqj.', '0759986291'),
('890/2023', 3, '5016348559943', 'Popescu Octavian', '2003-01-19', 'popescu_octavian@gmail.com', '$2y$10$7UEckyaCaKX9tA/EqlN4wuFCHHDPvF7DRa3ZucgKxhIcVtebes6aa', '0753783679'),
('413/2023', 4, '5033956148625', 'Radulescu Elena', '2002-09-15', 'radulescu_elena@gmail.com', '$2y$10$Ql6Xj5s/hfAsXxW60Dfa7Oc8yn.YnZ14MglcCGup/P7hFJ5ANKLJq', '0755489950'),
('372/2023', 1, '5011018680745', 'Serban Elena', '2002-03-10', 'serban_elena@gmail.com', '$2y$10$2PvTFdAhfR9FQibj/5UJ8uDTmLdjO3dR3JrOLi3vkdKbB8SrS3Ou2', '0759846366'),
('732/2023', 3, '5042915572143', 'Matei Ana', '2003-11-20', 'matei_ana@gmail.com', '$2y$10$Rsc0sajIzQxTi2nqL0cXuunaWRRoZvKudCOtyx/JJ9gzDzYNRQP4i', '0753219722'),
('690/2023', 2, '5040717190018', 'Constantinescu Florin', '2003-01-02', 'constantinescu_florin@gmail.com', '$2y$10$PRCB6Lp8dSmIWOAWyDMjUud16tdLhOvYIxGKlmZryO/kZbtVzdeC2', '0759625114'),
('432/2023', 4, '5033380662994', 'Georgescu Mihai', '2003-01-06', 'georgescu_mihai@gmail.com', '$2y$10$ON8NYQZf6oXfJCK5q7ZPye.YspXk/84xO6xhnyZM.fAO52VTnW9aG', '0752262807'),
('353/2023', 2, '5029109376503', 'Constantinescu Mihai', '2002-12-21', 'constantinescu_mihai@gmail.com', '$2y$10$8JBSaKflpidTEi0DYh9cpeYi0NGoCkfNAodg.a9lPTLAxqMtiuqxW', '0756397142'),
('812/2023', 1, '5021098084557', 'Radulescu Alexandra', '2003-06-21', 'radulescu_alexandra@gmail.com', '$2y$10$7XQJU8S/dAvQpSORNGDTee57vLQzUqwtecW6GoE7CxH1S1lSC5/Ze', '0757862253'),
('713/2023', 4, '5013806751847', 'Matei Mihai', '2003-02-24', 'matei_mihai@gmail.com', '$2y$10$ZZQyN5339V75bhf8JTrKFOB/vTXqVh.ortpb9wbg5Cc7ptKnz29mO', '0752554043'),
('552/2023', 1, '5041945730580', 'Ionescu Adelina', '2002-07-23', 'ionescu_adelina@gmail.com', '$2y$10$P1eN/fejE8V//sJ7jcjJ8.RcvKhFkrahzrAPVP7sELM/50yxVPSnK', '0757379025'),
('663/2023', 3, '5048105205352', 'Ionescu Octavian', '2003-09-26', 'ionescu_octavian@gmail.com', '$2y$10$ARTZaRlFOg15cHOmycCABOzaocyJv4NZX8E./7zmj1C/kT0O7imfa', '0753611688'),
('245/2023', 1, '5046001240999', 'Florea Cristina', '2003-04-19', 'florea_cristina@gmail.com', '$2y$10$wU8OeZgImQd9yBThCNErOeLTQX79bmOrk/DKNRpDC0Y1LeH2DbrQK', '0755257681'),
('723/2023', 3, '5012333190137', 'Georgescu Florin', '2002-07-19', 'georgescu_florin@gmail.com', '$2y$10$trfbd4qgqjP6EcR0ppBUnOJMjWB1uFeVQUXCAW15qP4.Q5q/OzjL.', '0756104409'),
('366/2023', 1, '5035500484175', 'Rusu Elena', '2002-05-18', 'rusu_elena@gmail.com', '$2y$10$rufa1onJDfCUi6IpPlW2m.eZjfcnj/X9ac9HvqLHUW8o3aRZRjPF2', '0757241865'),
('454/2023', 2, '5049329595387', 'Constantinescu Alexandra', '2002-11-13', 'constantinescu_alexandra@gmail.com', '$2y$10$wZIFLJxflBxUcjmMVMilAu.Wd/86DC1UKgvyS9rVHf3st.7CcJd2C', '0754823108'),
('738/2023', 4, '5049232191965', 'Radulescu Andrei', '2003-11-23', 'radulescu_andrei@gmail.com', '$2y$10$wZj/r5qZ4VA/H/e.ZgY7Ye0gi41E5iG02UPiVHX24BZ0KfwfFYOie', '0751683667'),
('110/2023', 4, '5036674364233', 'Radulescu Diana', '2003-06-08', 'radulescu_diana@gmail.com', '$2y$10$pI.DhjuNRfgYKtmmyWpeK.cykE1bRbUfRn4zOx4SW7CX2NhCU1ssW', '0758370779'),
('608/2023', 3, '5046579910578', 'Ciobanu Laurentiu', '2003-06-27', 'ciobanu_laurentiu@gmail.com', '$2y$10$lAWSRaPzPgXuDFpHrPhH9eToQLhcuxv.3KSGIx05jXyuAeJ/30Yey', '0756673888'),
('120/2023', 1, '5016578856092', 'Dumitru Adelina', '2002-08-25', 'dumitru_adelina@gmail.com', '$2y$10$jTpGT5qfLtrPHYGMCTpkxOwIoqzWBNfrfkPDNPY1FDvs0OW9zzShW', '0756062016'),
('659/2023', 1, '5049580958010', 'Constantinescu Diana', '2002-10-02', 'constantinescu_diana@gmail.com', '$2y$10$SKDqPdvVFe64Dvvl6zmqLe2J5y8vDFsupwO8qfSNJXSVSqcvvQRVK', '0753483309'),
('654/2023', 1, '5016523184737', 'Georgescu Ion', '2003-04-24', 'georgescu_ion@gmail.com', '$2y$10$z.l5W6oQFmXjv4s.biuTLuqWQkfaaRmzw2Og/hm7FAVOLCHosfAm6', '0752660195'),
('97/2023', 2, '5028287798847', 'Popescu Bogdan', '2003-11-21', 'popescu_bogdan@gmail.com', '$2y$10$DLIqMN13XiqWvZFPMP3vuuaoeQS1UtmysXlJ9qq/UkkxJR9l2ojFG', '0755126783'),
('817/2023', 1, '5014549247615', 'Georgescu Diana', '2003-10-08', 'georgescu_diana@gmail.com', '$2y$10$Cel7T.udqdSLd9kO3fool.ViIEra0OxN.8pYZfiypplG1EwKoyg4C', '0754552581'),
('904/2023', 2, '5022688103824', 'Rusu Laurentiu', '2002-02-01', 'rusu_laurentiu@gmail.com', '$2y$10$6aW4T7bCTCqWlJCTkFjE0uyw9336tAXz2/Xzn9oPCFBp0ENdWYYoC', '0755497575'),
('678/2023', 3, '5047688604116', 'Ionescu Radu', '2002-08-18', 'ionescu_radu@gmail.com', '$2y$10$A.Gk0QTWDFAq3dv7r8MC5uxSQAeZn3vtrezU5XWCJiE/KO3mssr.C', '0754305622'),
('493/2023', 2, '5048200121381', 'Munteanu Stefan', '2003-04-28', 'munteanu_stefan@gmail.com', '$2y$10$YFC8CyY/RlIVYflYXAVReOaVauUzEtChCZbe5kYXX2U/NKw6OSw1a', '0755765940'),
('642/2023', 3, '5046352448470', 'Munteanu Diana', '2003-01-24', 'munteanu_diana@gmail.com', '$2y$10$ANqM3m3Xx25myZs75yDP0uR1d.mCS4EJxiFoohp0mDCrfVti.vLQW', '0751468750'),
('153/2023', 2, '5014351984176', 'Serban Andrei', '2002-06-23', 'serban_andrei@gmail.com', '$2y$10$4ivBMxRViaxEYCjKVSEoUuKYbMiXXlakKTMGlXB5OOqhzC24Ord2W', '0752550699'),
('542/2023', 3, '5023430785962', 'Georgescu Bogdan', '2003-02-23', 'georgescu_bogdan@gmail.com', '$2y$10$ceq8N20F9tlP/fyGcRsZx.R7XYRPTFWduWObFANYMMVxh1waXpdgu', '0752161816'),
('780/2023', 4, '5021337429803', 'Ciobanu Stefan', '2003-01-28', 'ciobanu_stefan@gmail.com', '$2y$10$lkelf7SAze4pCcmnSVRU5.TLn6Kbl/3VmmDELzJ2TJC7QRUEH6mXq', '0758730560'),
('368/2023', 3, '5023716458429', 'Dumitru Bogdan', '2002-08-28', 'dumitru_bogdan@gmail.com', '$2y$10$P51.mfyQR9qa1XV6SFDYCOgrVciPR8MF9LW5nDh6hIsv7foGT0YlK', '0752343600'),
('259/2023', 3, '5043593425645', 'Ciobanu Adelina', '2003-10-18', 'ciobanu_adelina@gmail.com', '$2y$10$bvTBw2W2vwhHC9865Se90eCcuMNw9dG1CxaGy8VY99t/JCUHufmqq', '0752983149'),
('628/2023', 3, '5013435233206', 'Munteanu Dragos', '2002-11-16', 'munteanu_dragos@gmail.com', '$2y$10$OjZCe9hFzDStpwxitMpHu.QdAZ6DjiPG4jxjvCn.A4BhfqLsggTju', '0759765735'),
('765/2023', 2, '5020992830798', 'Constantinescu Octavian', '2002-06-25', 'constantinescu_octavian@gmail.com', '$2y$10$WiBSEp7fr8vQQKcvlMhvZeDGDQwdUlzE5d1EZ27OUy6SGq87NdLVS', '0754202211'),
('465/2023', 3, '5017149428740', 'Matei Andrei', '2003-02-25', 'matei_andrei@gmail.com', '$2y$10$PRi0YYWLMfk0w3saBba1eenSC586uF9IRfuF1B46uc55ZdoJal/5m', '0755345451'),
('133/2023', 3, '5032160027198', 'Ionescu Elena', '2002-11-24', 'ionescu_elena@gmail.com', '$2y$10$2Y5ODpsfvlsw4FvUFmQxMeap3xyt6rz/NS9taOYpnJWdiEFCnmQvG', '0754363892'),
('516/2023', 1, '5013945066689', 'Ionescu Bogdan', '2002-09-10', 'ionescu_bogdan@gmail.com', '$2y$10$hmuJPlPTYMEzBe5OyFulQeC4.i5hT5korwXU3TaNwffV.d98l12rK', '0751067159'),
('338/2023', 3, '5048641418406', 'Dumitru Maria', '2003-12-17', 'dumitru_maria@gmail.com', '$2y$10$Ee2O7FamPh7hTOhQB5j70eF7.IwED0cIjG7gLzbo/hKnyYQQDJdsa', '0754042060'),
('907/2023', 2, '5041397815029', 'Ciobanu Octavian', '2003-01-10', 'ciobanu_octavian@gmail.com', '$2y$10$q8EEhYmm49XIycQw7sdeQ.6x/Ts9wcmeXarBw2iRDWttrv4Kcj1nO', '0758816147'),
('481/2023', 3, '5017825522104', 'Serban George', '2002-05-23', 'serban_george@gmail.com', '$2y$10$PBRMBWuYBWeLrC0dPQO1keAGAtA0wuI1EKjJJxMY3heaSAB7s3NZS', '0755846120'),
('100/2022', 4, '1111111111111', 'asdada', '2023-12-06', 'adasva@gmail.com', '$2y$10$ZaT4NGdUJB7vl39BsQWZw.mazwkWpbgkISMBEh0gFdeTH6qLKm/qG', '012914951859'),
('969/2021', 4, '1212121212121', 'AASAS', '2000-11-02', 'lambada23la@gmail.com', '$2y$10$3RzXjmEOKPycIxGUsu5pb.kV1FtKOejPa8gj1Cm.F8UI3XsC5/jZ2', '0755123123'),
('13/2022', 4, '1111111111123', 'sala204', '2003-12-10', 'safed74902@trackden.com', '$2y$10$weqqS7cG6BAgW5u6mu5yHeo30yxur7QMBFKSMou3djqTkOdsbrTJW', '0755123777'),
('12/2022', 2, '1212121212129', 'nume2', '2002-06-14', 'mitove2870@wentcity.com', '$2y$10$pzpzVCG3OxyYmDPTcYwh6.KHrGL0nwmD30ef2I0MJw4TxLNsTRr9m', '0755123111');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `FACULTATE`
--
ALTER TABLE `FACULTATE`
  ADD PRIMARY KEY (`id_facultate`);

--
-- Indexes for table `GRUPA`
--
ALTER TABLE `GRUPA`
  ADD PRIMARY KEY (`id_grupa`),
  ADD KEY `id_specialitate` (`id_specialitate`);

--
-- Indexes for table `MATERIE`
--
ALTER TABLE `MATERIE`
  ADD PRIMARY KEY (`id_materie`),
  ADD KEY `id_specialitate` (`id_specialitate`);

--
-- Indexes for table `NOTA`
--
ALTER TABLE `NOTA`
  ADD PRIMARY KEY (`nr_matricol`,`id_materie`),
  ADD KEY `id_materie` (`id_materie`);

--
-- Indexes for table `PROFESOR`
--
ALTER TABLE `PROFESOR`
  ADD PRIMARY KEY (`id_profesor`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `telefon` (`telefon`),
  ADD UNIQUE KEY `cnp` (`cnp`),
  ADD KEY `id_facultate` (`id_facultate`);

--
-- Indexes for table `SPECIALITATE`
--
ALTER TABLE `SPECIALITATE`
  ADD PRIMARY KEY (`id_specialitate`),
  ADD KEY `id_facultate` (`id_facultate`);

--
-- Indexes for table `STUDENT`
--
ALTER TABLE `STUDENT`
  ADD PRIMARY KEY (`nr_matricol`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `telefon` (`telefon`),
  ADD UNIQUE KEY `cnp` (`cnp`),
  ADD KEY `id_grupa` (`id_grupa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `FACULTATE`
--
ALTER TABLE `FACULTATE`
  MODIFY `id_facultate` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `GRUPA`
--
ALTER TABLE `GRUPA`
  MODIFY `id_grupa` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `MATERIE`
--
ALTER TABLE `MATERIE`
  MODIFY `id_materie` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `PROFESOR`
--
ALTER TABLE `PROFESOR`
  MODIFY `id_profesor` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `SPECIALITATE`
--
ALTER TABLE `SPECIALITATE`
  MODIFY `id_specialitate` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
