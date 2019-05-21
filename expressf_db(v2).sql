-- -----------------------------------------------------
-- Schema expressf_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `expressf_db` ;

-- -----------------------------------------------------
-- Schema expressf_db
-- -----------------------------------------------------
CREATE DATABASE `expressf_db` DEFAULT CHARACTER SET utf8 ;
USE `expressf_db` ;

-- -----------------------------------------------------
-- Table `expressf_db`.`Utilisateur`
-- -----------------------------------------------------
CREATE TABLE `expressf_db`.`Utilisateur` 
(
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `civilite` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(75) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `tel_domicile` INT(10) UNSIGNED NULL,
  `tel_portable` INT(10) UNSIGNED NULL,
  `email` VARCHAR(150) NOT NULL,
  `mot_de_passe` VARCHAR(20) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `mot_de_passe_UNIQUE` (`mot_de_passe` ASC)
  )
ENGINE = InnoDB
AUTO_INCREMENT = 124
DEFAULT CHARACTER SET = utf8;
--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `nom`, `prenom`, `tel_domicile`, `tel_portable`, `email`, `mot_de_passe`, `role`, `civilite`)
VALUES
(1, 'ALBERTINI', 'Josette', 325010201, 600010101, 'jalbertini@orange.fr', '!1717e', 'client', 'MADAME'),
(2, 'TEPES', 'VLAD', 325820101, 602505050, 'vtepes@gmail.com', '141414z#', 'client', 'MONSIEUR'),
(3, 'HAWK', 'Thomas', NULL, NULL, 'thawk@outlook.fr', 'Superadmin#', 'gestionnaire', 'MONSIEUR'),
(4, 'ROUSSIE', 'Carla', NULL, NULL, 'croussie@hotmail.com', '#toplivreuse', 'livreur', 'mademoiselle');


-- -----------------------------------------------------
-- Table `expressf_db`.`adresse`
-- -----------------------------------------------------
CREATE TABLE `expressf_db`.`adresse` (
  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero` TINYINT NOT NULL,
  `adresse` VARCHAR(100) NOT NULL,
  `complement` VARCHAR(100) NULL DEFAULT NULL,
  `ville` VARCHAR(50) NOT NULL,
  `code_postal` MEDIUMINT UNSIGNED NOT NULL,
  `Utilisateur_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_adresse_Utilisateur1_idx` (`Utilisateur_id` ASC),
  CONSTRAINT `fk_adresse_Utilisateur1`
    FOREIGN KEY (`Utilisateur_id`)
    REFERENCES `expressf_db`.`Utilisateur` (`id`)
    )
    ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;
INSERT INTO `adresse` (`id`, `numero`, `adresse`, `complement`, `ville`, `code_postal`, `Utilisateur_id`)
VALUES
(1, 10, 'rue de la maison de retraite', NULL, 'Troyes', 10000, 1),
(2, 25, 'rue des plats et desserts', 'bat 1 escalier 2 4ème étage porte de droite', 'Troyes', 10000, 2);

-- -----------------------------------------------------
-- Table `expressf_db`.`livreur`
-- -----------------------------------------------------
CREATE TABLE `expressf_db`.`livreur` 
(
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `numero_id` SMALLINT(6) UNSIGNED NOT NULL,
  `gps` VARCHAR(50) NULL DEFAULT NULL,
  `disponibilite` BIT NOT NULL,
  `Utilisateur_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `Utilisateur_id`),
  INDEX `fk_livreur_Utilisateur1_idx` (`Utilisateur_id` ASC),
  CONSTRAINT `fk_livreur_Utilisateur1`
    FOREIGN KEY (`Utilisateur_id`)
    REFERENCES `expressf_db`.`Utilisateur` (`id`)
    )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;
--
-- Déchargement des données de la table `livreur`
--

INSERT INTO `livreur` (`id`, `nom`, `numero_id`, `gps`, `disponibilite`, `Utilisateur_id`)
VALUES
(1, 'ROUSSIE', 1, '48° 17\' 50.442\" N 4° 4\' 27.843\" E ', b'0', 4);

-- -----------------------------------------------------
-- Table `expressf_db`.`commande`
-- -----------------------------------------------------
CREATE TABLE `expressf_db`.`commande` 
(
  `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `prix_HT` DECIMAL(8,2) UNSIGNED NOT NULL,
  `mode_paiement` VARCHAR(20) NOT NULL,
  `paiement` DECIMAL(8,2) UNSIGNED NOT NULL,
  `statut_commande` VARCHAR(50) NOT NULL,
  `livreur_id` TINYINT UNSIGNED NOT NULL,
  `Utilisateur_id` SMALLINT UNSIGNED NOT NULL,
  `adresse_id` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `Utilisateur_id`),
  INDEX `fk_commande_livreur1_idx` (`livreur_id` ASC),
  INDEX `fk_commande_Utilisateur1_idx` (`Utilisateur_id` ASC),
  INDEX `fk_commande_adresse1_idx` (`adresse_id` ASC),
  CONSTRAINT `fk_commande_livreur1`
    FOREIGN KEY (`livreur_id`)
    REFERENCES `expressf_db`.`livreur` (`id`),
    CONSTRAINT `fk_commande_Utilisateur1`
    FOREIGN KEY (`Utilisateur_id`)
    REFERENCES `expressf_db`.`Utilisateur` (`id`),
    CONSTRAINT `fk_commande_adresse1`
    FOREIGN KEY (`adresse_id`)
    REFERENCES `expressf_db`.`adresse` (`id`)
    )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;
--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `date`, `prix_HT`, `mode_paiement`, `paiement`, `statut_commande`, `livreur_id`, `Utilisateur_id`, `adresse_id`) VALUES
(1, '2019-05-12 12:20:12', '18.50', 'carte ', '22.20', 'livrée', 1, 1, 1),
(2, '2019-05-02 13:00:00', '20.00', 'espèce', '24.00', 'livrée', 1, 2, 2);

-- -----------------------------------------------------
-- Table `expressf_db`.`produits`
-- -----------------------------------------------------
CREATE TABLE `expressf_db`.`produits` 
(
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `produit` VARCHAR(80) NOT NULL,
  `quantite` TINYINT UNSIGNED NOT NULL,
  `categorie_produits` MEDIUMINT UNSIGNED NOT NULL,
  `prix` DECIMAL(2,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `produit`, `quantite`, `categorie_produits`, `prix`)
VALUES
(1, 'panini poulet', 1, 1, '2.00'),
(2, 'tiramisu', 1, 2, '2.00');

-- -----------------------------------------------------
-- Table `expressf_db`.`commande_produits`
-- -----------------------------------------------------
CREATE TABLE `expressf_db`.`commande_produits`
 (
  `commande_id` MEDIUMINT NOT NULL,
  `produits_id` SMALLINT NOT NULL,
  `quantite` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`commande_id`, `produits_id`)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `expressf_db`.`produits_livreur`
-- -----------------------------------------------------
CREATE TABLE `expressf_db`.`produits_livreur` 
(
  `produits_id` SMALLINT UNSIGNED NOT NULL,
  `livreur_id` TINYINT UNSIGNED NOT NULL,
  `quantite` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`produits_id`, `livreur_id`)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
