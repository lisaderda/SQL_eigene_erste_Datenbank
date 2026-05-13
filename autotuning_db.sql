-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 13. Mai 2026 um 09:29
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `autotuning_db`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fahrzeug`
--

CREATE TABLE `fahrzeug` (
  `fahrzeug_id` int(11) NOT NULL,
  `modell` varchar(100) DEFAULT NULL,
  `motorisierung_ps` int(11) DEFAULT NULL,
  `hubraum_liter` decimal(5,2) DEFAULT NULL,
  `baujahr` year(4) DEFAULT NULL,
  `hersteller_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `hersteller`
--

CREATE TABLE `hersteller` (
  `hersteller_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `herkunftsland` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `hersteller`
--

INSERT INTO `hersteller` (`hersteller_id`, `name`, `herkunftsland`) VALUES
(1, 'Audi', 'Deutschland'),
(2, 'VW', 'Deutschland'),
(3, 'BMW', 'Deutschland'),
(4, 'Mercedes', 'Deutschland'),
(5, 'Skoda', 'Tschechien');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lackierung`
--

CREATE TABLE `lackierung` (
  `lack_id` int(11) NOT NULL,
  `lackcode` varchar(100) DEFAULT NULL,
  `lackbezeichnung` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lackierung`
--

INSERT INTO `lackierung` (`lack_id`, `lackcode`, `lackbezeichnung`) VALUES
(1, 'C1K', 'BMW Marina Bay Blue Metallic'),
(2, 'P28', 'BMW Twillight Purple Metallic'),
(3, 'C68', 'BMW Fire Red Metallic'),
(4, '475', 'BMW Saphirschwarz Metallic'),
(5, 'LC9Z', 'Black Magic Perleffekt');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `teil`
--

CREATE TABLE `teil` (
  `teil_id` int(11) NOT NULL,
  `bezeichnung` varchar(100) DEFAULT NULL,
  `einbauort` varchar(100) DEFAULT NULL,
  `kosten` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tuning_projekt`
--

CREATE TABLE `tuning_projekt` (
  `projekt_id` int(11) NOT NULL,
  `bezeichnung` varchar(100) DEFAULT NULL,
  `von_datum` date DEFAULT NULL,
  `bis_datum` date DEFAULT NULL,
  `fahrzeug_id` int(11) DEFAULT NULL,
  `lack_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tuning_projekt_teil`
--

CREATE TABLE `tuning_projekt_teil` (
  `projekt_id` int(11) NOT NULL,
  `teil_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `fahrzeug`
--
ALTER TABLE `fahrzeug`
  ADD PRIMARY KEY (`fahrzeug_id`),
  ADD KEY `hersteller_id` (`hersteller_id`);

--
-- Indizes für die Tabelle `hersteller`
--
ALTER TABLE `hersteller`
  ADD PRIMARY KEY (`hersteller_id`);

--
-- Indizes für die Tabelle `lackierung`
--
ALTER TABLE `lackierung`
  ADD PRIMARY KEY (`lack_id`),
  ADD UNIQUE KEY `lackcode` (`lackcode`);

--
-- Indizes für die Tabelle `teil`
--
ALTER TABLE `teil`
  ADD PRIMARY KEY (`teil_id`);

--
-- Indizes für die Tabelle `tuning_projekt`
--
ALTER TABLE `tuning_projekt`
  ADD PRIMARY KEY (`projekt_id`),
  ADD KEY `fahrzeug_id` (`fahrzeug_id`),
  ADD KEY `lack_id` (`lack_id`);

--
-- Indizes für die Tabelle `tuning_projekt_teil`
--
ALTER TABLE `tuning_projekt_teil`
  ADD PRIMARY KEY (`projekt_id`,`teil_id`),
  ADD KEY `teil_id` (`teil_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `fahrzeug`
--
ALTER TABLE `fahrzeug`
  MODIFY `fahrzeug_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `hersteller`
--
ALTER TABLE `hersteller`
  MODIFY `hersteller_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `lackierung`
--
ALTER TABLE `lackierung`
  MODIFY `lack_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `teil`
--
ALTER TABLE `teil`
  MODIFY `teil_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tuning_projekt`
--
ALTER TABLE `tuning_projekt`
  MODIFY `projekt_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `fahrzeug`
--
ALTER TABLE `fahrzeug`
  ADD CONSTRAINT `fahrzeug_ibfk_1` FOREIGN KEY (`hersteller_id`) REFERENCES `hersteller` (`hersteller_id`);

--
-- Constraints der Tabelle `tuning_projekt`
--
ALTER TABLE `tuning_projekt`
  ADD CONSTRAINT `tuning_projekt_ibfk_1` FOREIGN KEY (`fahrzeug_id`) REFERENCES `fahrzeug` (`fahrzeug_id`),
  ADD CONSTRAINT `tuning_projekt_ibfk_2` FOREIGN KEY (`lack_id`) REFERENCES `lackierung` (`lack_id`);

--
-- Constraints der Tabelle `tuning_projekt_teil`
--
ALTER TABLE `tuning_projekt_teil`
  ADD CONSTRAINT `tuning_projekt_teil_ibfk_1` FOREIGN KEY (`projekt_id`) REFERENCES `tuning_projekt` (`projekt_id`),
  ADD CONSTRAINT `tuning_projekt_teil_ibfk_2` FOREIGN KEY (`teil_id`) REFERENCES `teil` (`teil_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
