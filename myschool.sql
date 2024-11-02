SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `absence` (
  `id_absence` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `id_module` int(11) NOT NULL,
  `date_absence` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `enseignant` (
  `id_enseignant` int(11) NOT NULL,
  `nom_enseignant` varchar(255) NOT NULL,
  `prenom_enseignant` varchar(255) NOT NULL,
  `date_de_naissance_enseignant` date NOT NULL,
  `cin_enseignant` varchar(255) NOT NULL,
  `adresse_enseignant` varchar(255) NOT NULL,
  `domaine_enseignant` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `etudiant` (
  `id_etudiant` int(11) NOT NULL,
  `nom_etudiant` varchar(50) NOT NULL,
  `prenom_etudiant` varchar(50) NOT NULL,
  `date_de_naissance_etudiant` date NOT NULL,
  `cin_etudiant` varchar(50) NOT NULL,
  `adresse_etudiant` varchar(150) NOT NULL,
  `id_groupe` int(11) NOT NULL,
  `photo_etudiant` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE `filiere` (
  `id_filiere` int(11) NOT NULL,
  `nom_filiere` varchar(255) NOT NULL,
  `abreviation_filiere` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `filiere` VALUES(1, 'Génie Informatiqe', 'GI');
INSERT INTO `filiere` VALUES(3, 'Génie des Systèmes Industriels', 'GSI');

CREATE TABLE `groupe` (
  `id_groupe` int(11) NOT NULL,
  `id_filiere` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `groupe` VALUES(1, 3);
INSERT INTO `groupe` VALUES(2, 1);

CREATE TABLE `message` (
  `id_message` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `sujet_message` varchar(50) NOT NULL,
  `contenu_message` text NOT NULL,
  `date_envoi_message` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `module` (
  `id_module` int(11) NOT NULL,
  `nom_module` varchar(255) NOT NULL,
  `id_filiere` int(11) NOT NULL,
  `id_enseignant` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `note` (
  `id_etudiant` int(11) NOT NULL,
  `id_module` int(11) NOT NULL,
  `valeur_note` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


ALTER TABLE `absence`
  ADD PRIMARY KEY (`id_absence`);

ALTER TABLE `enseignant`
  ADD PRIMARY KEY (`id_enseignant`);

ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`id_etudiant`),
  ADD KEY `FKgroupe` (`id_groupe`);

ALTER TABLE `filiere`
  ADD PRIMARY KEY (`id_filiere`);

ALTER TABLE `groupe`
  ADD PRIMARY KEY (`id_groupe`);

ALTER TABLE `message`
  ADD PRIMARY KEY (`id_message`);

ALTER TABLE `module`
  ADD PRIMARY KEY (`id_module`),
  ADD KEY `FKfiliere` (`id_filiere`),
  ADD KEY `FKenseignant` (`id_enseignant`);

ALTER TABLE `note`
  ADD KEY `FKetudiant` (`id_etudiant`),
  ADD KEY `FKmodule` (`id_module`);


ALTER TABLE `absence`
  MODIFY `id_absence` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `enseignant`
  MODIFY `id_enseignant` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `etudiant`
  MODIFY `id_etudiant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `filiere`
  MODIFY `id_filiere` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `groupe`
  MODIFY `id_groupe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `message`
  MODIFY `id_message` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `module`
  MODIFY `id_module` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `etudiant`
  ADD CONSTRAINT `FKgroupe` FOREIGN KEY (`id_groupe`) REFERENCES `groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `module`
  ADD CONSTRAINT `FKenseignant` FOREIGN KEY (`id_enseignant`) REFERENCES `enseignant` (`id_enseignant`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FKfiliere` FOREIGN KEY (`id_filiere`) REFERENCES `filiere` (`id_filiere`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `note`
  ADD CONSTRAINT `FKetudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FKmodule` FOREIGN KEY (`id_module`) REFERENCES `module` (`id_module`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
