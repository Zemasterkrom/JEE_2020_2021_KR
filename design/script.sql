DROP DATABASE IF EXISTS COVID_KR_TR;
CREATE DATABASE COVID_KR_TR;
USE COVID_KR_TR;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Création des tables
--
CREATE TABLE Activite (
  idActivite INT NOT NULL,
  dateActivite DATE NOT NULL,
  heureDebut time NOT NULL,
  heureFin time NOT NULL,
  idUtilisateur INT NOT NULL,
  idLieu INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table ami
--

CREATE TABLE Ami (
  idUtilisateur INT NOT NULL,
  idAmi INT NOT NULL,
  accepte BIT(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table etat
--

CREATE TABLE Etat (
  idEtat INT NOT NULL,
  dateEtat timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  positif BIT(1) NOT NULL DEFAULT b'1',
  idUtilisateur INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table lieu
--

CREATE TABLE Lieu (
  idLieu INT NOT NULL,
  nom VARCHAR(64) NOT NULL,
  adresse VARCHAR(255) NOT NULL,
  longitude decimal(10,0) DEFAULT NULL,
  latitude decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table notification
--

CREATE TABLE Notification (
  idNotification INT NOT NULL,
  message VARCHAR(512) NOT NULL,
  vue BIT(1) NOT NULL DEFAULT b'0',
  idUtilisateur INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table utilisateur
--

CREATE TABLE Utilisateur (
  idUtilisateur INT NOT NULL,
  nom VARCHAR(64) NOT NULL,
  prenom VARCHAR(64) NOT NULL,
  dateNaiss DATE NOT NULL,
  login VARCHAR(64) NOT NULL,
  motDePasse VARCHAR(255) NOT NULL,
  rang SET('normal','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour la table activite
--
ALTER TABLE Activite
  ADD PRIMARY KEY (idActivite),
  ADD KEY idUtilisateur (idUtilisateur),
  ADD KEY idLieu (idLieu);

--
-- Index pour la table ami
--
ALTER TABLE Ami
  ADD PRIMARY KEY (idUtilisateur,idAmi),
  ADD KEY idAmi (idAmi);

--
-- Index pour la table etat
--
ALTER TABLE Etat
  ADD PRIMARY KEY (idEtat),
  ADD KEY idUtilisateur (idUtilisateur);

--
-- Index pour la table lieu
--
ALTER TABLE Lieu
  ADD PRIMARY KEY (idLieu);

--
-- Index pour la table notification
--
ALTER TABLE Notification
  ADD PRIMARY KEY (idNotification),
  ADD KEY idUtilisateur (idUtilisateur);

--
-- Index pour la table utilisateur
--
ALTER TABLE Utilisateur
  ADD PRIMARY KEY (idUtilisateur);

--
-- AUTO_INCREMENT pour la table activite
--
ALTER TABLE Activite
  MODIFY idActivite INT NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table etat
--
ALTER TABLE Etat
  MODIFY idEtat INT NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table lieu
--
ALTER TABLE Lieu
  MODIFY idLieu INT NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table notification
--
ALTER TABLE Notification
  MODIFY idNotification INT NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table utilisateur
--
ALTER TABLE Utilisateur
  MODIFY idUtilisateur INT NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour la table activite
--
ALTER TABLE Activite
  ADD CONSTRAINT activite_ibfk_1 FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur (idUtilisateur),
  ADD CONSTRAINT activite_ibfk_2 FOREIGN KEY (idLieu) REFERENCES Lieu (idLieu);

--
-- Contraintes pour la table ami
--
ALTER TABLE Ami
  ADD CONSTRAINT ami_ibfk_1 FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur (idUtilisateur),
  ADD CONSTRAINT ami_ibfk_2 FOREIGN KEY (idAmi) REFERENCES Utilisateur (idUtilisateur);

--
-- Contraintes pour la table etat
--
ALTER TABLE Etat
  ADD CONSTRAINT etat_ibfk_1 FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur (idUtilisateur);

--
-- Contraintes pour la table notification
--
ALTER TABLE Notification
  ADD CONSTRAINT idUtilisateur FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur (idUtilisateur);


--
-- Création des triggers
--


--
-- Trigger pour vérifier si une demande d’ami peut être effectuée (utilisateur existant, requête pas encore effectuée, pas encore ami)
--
DELIMITER $$;
CREATE TRIGGER verifier_demande_nouvel_ami BEFORE INSERT ON Ami FOR EACH ROW
BEGIN
  DECLARE utilisateur_existe INT;
  DECLARE requete_existe INT;
  DECLARE est_accepte BIT;

  SELECT COUNT(idUtilisateur) INTO utilisateur_existe FROM Utilisateur WHERE idUtilisateur = NEW.idUtilisateur;

  IF (utilisateur_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'utilisateur spécifié n'existe pas.";
  END IF;

  SELECT COUNT(idUtilisateur), accepte INTO requete_existe, est_accepte FROM Ami WHERE (idUtilisateur = NEW.idUtilisateur AND idAmi = NEW.idAmi) OR (idUtilisateur = NEW.idAmi AND idAmi = NEW.idUtilisateur);

  IF (requete_existe = 1) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous avez déjà envoyé une requête d'ami à cet utilisateur. Elle est encore en attente.";
  ELSEIF (est_accepte = 1) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous possédez déjà cet utilisateur en tant qu'ami.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'un utilisateur peut être supprimé s'il existe
--
DELIMITER $$;
CREATE TRIGGER verifier_suppression_utilisateur BEFORE DELETE ON Utilisateur FOR EACH ROW
BEGIN
  DECLARE utilisateur_existe INT;

  SELECT COUNT(idUtilisateur) INTO utilisateur_existe FROM Utilisateur WHERE idUtilisateur = OLD.idUtilisateur;

  IF (utilisateur_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'utilisateur spécifié n'existe pas.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour supprimer totalement un utilisateur après sa suppression (suppression des amis le possédant ou des amis associés à cet utilisateur)
--
DELIMITER $$;
CREATE TRIGGER suppression_totale_utilisateur AFTER DELETE ON Utilisateur FOR EACH ROW
BEGIN
  DELETE FROM Ami WHERE idUtilisateur = OLD.idUtilisateur OR idAmi = OLD.idUtilisateur;
END;
$$;
DELIMITER ;


--
-- Trigger pour vérifier qu’une demande de suppression d’ami peut être effectué (si l'utilisateur existe et qu'il est possédé en tant qu'ami par une des deux relations)
--
DELIMITER $$;
CREATE TRIGGER verifier_demande_suppression_ami BEFORE DELETE ON Ami FOR EACH ROW
BEGIN
  DECLARE utilisateur_existe INT;
  DECLARE requete_existe INT;

  SELECT COUNT(idUtilisateur) INTO utilisateur_existe FROM Utilisateur WHERE idUtilisateur = OLD.idUtilisateur;

  IF (utilisateur_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'utilisateur spécifié n'existe pas.";
  END IF;

  SELECT COUNT(idUtilisateur) INTO requete_existe FROM Ami WHERE (idUtilisateur = OLD.idUtilisateur AND idAmi = OLD.idAmi) OR (idUtilisateur = OLD.idAmi AND idAmi = OLD.idUtilisateur);

  IF (requete_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous ne possédez pas cet utilisateur en tant qu'ami.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Procédure commune à l'ajout et la mise à jour des activités : vérifier que les données sont cohérentes
--
DELIMITER $$;
CREATE PROCEDURE verifier_activite(IN id_lieu INT, IN heure_debut TIME, IN heure_fin TIME) READS SQL DATA
BEGIN
  DECLARE lieu_existe INT;

  SELECT COUNT(idLieu) INTO lieu_existe FROM Lieu WHERE idLieu = id_lieu;

  IF (lieu_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le lieu spécifié n'existe pas.";
  END IF;

  IF (heure_debut >= heure_fin) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'heure de début de l'activité doit être inférieure à l'heure de fin de l'activité.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'une activité peut être ajoutée (qu'elle est cohérente vis-à-vis du lieu et des heures)
--
DELIMITER $$;
CREATE TRIGGER verifier_ajout_activite BEFORE INSERT ON Activite FOR EACH ROW
BEGIN
  CALL verifier_activite(NEW.idLieu, NEW.heureDebut, NEW.heureFin);
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'une activité peut être mise à jour (qu'elle est cohérente vis-à-vis du lieu et des heures)
--
DELIMITER $$;
CREATE TRIGGER verifier_maj_activite BEFORE UPDATE ON Activite FOR EACH ROW
BEGIN
  CALL verifier_activite(NEW.idLieu, NEW.heureDebut, NEW.heureFin);
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'une activité peut bien être supprimée si elle existe
--
DELIMITER $$;
CREATE TRIGGER verifier_suppression_activite BEFORE DELETE ON Activite FOR EACH ROW
BEGIN
  DECLARE activite_existe INT;

  SELECT COUNT(idLieu) INTO activite_existe FROM Activite WHERE idActivite = OLD.idActivite;

  IF (activite_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'activité spécifiée n'existe pas.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'un lieu peut être ajouté (le lieu ne doit pas déjà exister)
--
DELIMITER $$;
CREATE TRIGGER verifier_ajout_lieu BEFORE INSERT ON Lieu FOR EACH ROW
BEGIN
  DECLARE lieu_existe INT;

  SELECT COUNT(idLieu) INTO lieu_existe FROM Lieu WHERE nom = NEW.nom;

  IF (lieu_existe > 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un lieu associé à ce nom existe déjà.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'un lieu peut être mis à jour (le lieu ne doit pas correspondre au nom d'un autre lieu)
--
DELIMITER $$;
CREATE TRIGGER verifier_maj_lieu BEFORE UPDATE ON Lieu FOR EACH ROW
BEGIN
  DECLARE lieu_existe INT;

  SELECT COUNT(idLieu) INTO lieu_existe FROM Lieu WHERE nom = NEW.nom AND NEW.nom != OLD.nom;

  IF (lieu_existe > 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Un lieu associé à ce nom existe déjà.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'un lieu peut bien être supprimé s'il existe
--
DELIMITER $$;
CREATE TRIGGER verifier_suppression_lieu BEFORE DELETE ON Lieu FOR EACH ROW
BEGIN
  DECLARE lieu_existe INT;

  SELECT COUNT(idLieu) INTO lieu_existe FROM Lieu WHERE idLieu = OLD.idLieu;

  IF (lieu_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le lieu spécifié n'existe pas.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier que l'ajout d'un état est cohérent pour un utilisateur (état différent du précédent, DATE supérieure à celle de l'état précédent)
--
DELIMITER $$;
CREATE TRIGGER verifier_etat BEFORE INSERT ON Etat FOR EACH ROW
BEGIN
  DECLARE derniere_DATE_etat TIMESTAMP;
  DECLARE est_positif BIT;

  SELECT DATEEtat, positif INTO derniere_DATE_etat, est_positif FROM Etat WHERE idUtilisateur = NEW.idUtilisateur;

  IF (NEW.DATEEtat <= derniere_DATE_etat) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La DATE du nouvel état doit être supérieure à celle du dernier état.";
  ELSEIF (NEW.positif = est_positif) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le nouvel état correspond déjà à l'état précédent.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Procédure se chargeant d'envoyer les notifications aux utilisateurs pouvant être contaminés par un utilisateur (aux amis et aux utilisateurs ayant été en contact dans un même lieu avec cet utilisateur sur une période de 10 jours)
--
DELIMITER $$;
CREATE PROCEDURE envoyer_notifications_contamination(IN id_utilisateur_positif INT) READS SQL DATA
BEGIN
  DECLARE nom_utilisateur VARCHAR(64);
  DECLARE prenom_utilisateur VARCHAR(64);
  DECLARE cas_contact_potentiel VARCHAR(500);
  DECLARE cas_contact_ami VARCHAR(500);
  DECLARE id_ami INT;
  DECLARE id_utilisateur INT;
  DECLARE done INT DEFAULT 0;

  DECLARE cur_amis CURSOR FOR
    SELECT idAmi FROM Ami WHERE idUtilisateur = id_utilisateur_positif;

  DECLARE cur_infectes_potentiels CURSOR FOR
    SELECT idUtilisateur FROM (
      SELECT DISTINCT idUtilisateur, idLieu, heureDebut, heureFin FROM Activite NATURAL JOIN Lieu WHERE idUtilisateur = id_utilisateur_positif
        AND DATEActivite BETWEEN CURRENT_DATE() AND CURRENT_DATE() - 10
        GROUP BY idLieu
      ) lieux_frequentes_utilisateur
    WHERE idUtilisateur != id_utilisateur_positif
    AND ((heureDebut BETWEEN lieux_frequentes_utilisateur.heureDebut AND lieux_frequentes_utilisateur.heureFin) OR (heureFin BETWEEN lieux_frequentes_utilisateur.heureDebut AND lieux_frequentes_utilisateur.heureFin))
    GROUP BY idUtilisateur;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  SELECT nom, prenom INTO @nom_utilisateur, @prenom_utilisateur FROM Utilisateur WHERE idUtilisateur = id_utilisateur_positif;
  SELECT CONCAT("Votre ami ", @nom_utilisateur, " ", @prenom_utilisateur, " s'est déclaré positif.") INTO @cas_contact_ami;
  SELECT CONCAT("Vous avez probablement été en contact avec ", @nom_utilisateur, " ", @prenom_utilisateur, " au cours de ces 10 derniers jours. Cet individu s'est déclaré positif.") INTO @cas_contact_potentiel;

  OPEN cur_amis;
  cur_amis: LOOP
    FETCH cur_amis INTO id_ami;

    IF (done = 1) THEN
      LEAVE cur_amis;
    END IF;

    INSERT INTO Notification(message, idUtilisateur) VALUES(@cas_contact, id_ami);
  END LOOP;
  CLOSE cur_amis;

  OPEN cur_infectes_potentiels;
  cur_infectes_potentiels: LOOP
    FETCH cur_infectes_potentiels INTO id_utilisateur;

    IF (done = 1) THEN
      LEAVE cur_infectes_potentiels;
    END IF;

    INSERT INTO Notification(message, idUtilisateur) VALUES(@cas_contact_potentiel, id_utilisateur);
  END LOOP;
  CLOSE cur_infectes_potentiels;
END;
$$;
DELIMITER ;

--
-- Trigger pour envoyer une notification aux utilisateurs à risque lorsqu'un utilisateur se déclare positif
--
DELIMITER $$;
CREATE TRIGGER envoi_notifications AFTER INSERT ON Etat FOR EACH ROW
BEGIN
  IF (NEW.positif = b'1') THEN
    CALL envoyer_notifications_infection(NEW.idUtilisateur);
  END IF;
END;
$$;
DELIMITER ;

COMMIT;
