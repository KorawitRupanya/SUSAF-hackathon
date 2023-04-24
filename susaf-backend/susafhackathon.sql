-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 24 Apr 2023 pada 14.33
-- Versi server: 10.4.25-MariaDB
-- Versi PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `susafhackathon`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `answer`
--

CREATE TABLE `answer` (
  `ID` int(11) NOT NULL,
  `Features_ID` varchar(100) NOT NULL,
  `Questions_ID` varchar(3) NOT NULL,
  `Answers` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `answer`
--

INSERT INTO `answer` (`ID`, `Features_ID`, `Questions_ID`, `Answers`) VALUES
(1, 'FEATURE1', 'S1', 'value'),
(2, 'FEATURE1', 'S1', 'value'),
(3, 'FEATURE1', 'S1', 'value');

-- --------------------------------------------------------

--
-- Struktur dari tabel `features`
--

CREATE TABLE `features` (
  `Features_ID` varchar(100) NOT NULL,
  `Project_ID` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `features`
--

INSERT INTO `features` (`Features_ID`, `Project_ID`) VALUES
('FEATURE1', 'Project1');

-- --------------------------------------------------------

--
-- Struktur dari tabel `projects`
--

CREATE TABLE `projects` (
  `Project_ID` varchar(100) NOT NULL,
  `owner` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `projects`
--

INSERT INTO `projects` (`Project_ID`, `owner`) VALUES
('Project1', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `questions`
--

CREATE TABLE `questions` (
  `Questions_ID` varchar(3) NOT NULL,
  `Questions_Header` enum('ECONOMIC','TECHNICAL','INDIVIDUAL','SOCIAL','ENVIRONMENTAL') NOT NULL,
  `Prompt` varchar(300) DEFAULT NULL,
  `Questions` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `questions`
--

INSERT INTO `questions` (`Questions_ID`, `Questions_Header`, `Prompt`, `Questions`) VALUES
('S1', 'SOCIAL', 'Sense of community means the feeling of belong to an organization, to an area or to a group of like-minded people.', 'How can the product or service affect a person’s sense of belonging to these \r\ngroups?'),
('S2', 'SOCIAL', 'Trust means having a firm belief in the reliability, truth, or ability of someone or something.', 'How can the product or service change the trust between the users and the business that owns the system?'),
('S3', 'SOCIAL', 'Inclusiveness and diversity refers to the inclusion of people who might otherwise be  excluded or marginalized.', 'How can the product or service change the trust between the users and the business that owns the system?'),
('S4', 'SOCIAL', 'Inclusiveness and diversity refers to the inclusion of people who might otherwise be  excluded or marginalized.', 'What effects can it have on users with different backgrounds, age groups, education levels, or other differences?');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Features_ID` (`Features_ID`),
  ADD KEY `Questions_ID` (`Questions_ID`);

--
-- Indeks untuk tabel `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`Features_ID`),
  ADD KEY `Project_ID` (`Project_ID`);

--
-- Indeks untuk tabel `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`Project_ID`);

--
-- Indeks untuk tabel `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`Questions_ID`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `answer`
--
ALTER TABLE `answer`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`Questions_ID`) REFERENCES `questions` (`Questions_ID`);

--
-- Ketidakleluasaan untuk tabel `features`
--
ALTER TABLE `features`
  ADD CONSTRAINT `features_ibfk_1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`Project_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
