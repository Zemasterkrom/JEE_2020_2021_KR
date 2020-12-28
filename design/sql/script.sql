DROP DATABASE IF EXISTS COVID_KR_TR;
CREATE DATABASE COVID_KR_TR;
USE COVID_KR_TR;

SET GLOBAL event_scheduler = ON;

--
-- Création des tables
--
CREATE TABLE Activite (
  idActivite INT NOT NULL,
  dateDebut TIMESTAMP NOT NULL,
  dateFin TIMESTAMP NOT NULL,
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
  dateEtat TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  positif BIT(1) NOT NULL DEFAULT b'1',
  idUtilisateur INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table lieu
--

CREATE TABLE Lieu (
  idLieu INT NOT NULL,
  nom VARCHAR(64) NOT NULL CHECK (LENGTH(TRIM(nom)) > 0),
  adresse VARCHAR(255) NOT NULL CHECK (LENGTH(TRIM(adresse)) > 0),
  longitude DECIMAL(17, 15) DEFAULT NULL CHECK(ISNULL(longitude) OR (longitude >= -180 AND longitude <= 180)),
  latitude DECIMAL(17, 15) DEFAULT NULL CHECK(ISNULL(latitude) OR (latitude >= -90 AND latitude <= 90))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table NotificationAmi
--

CREATE TABLE NotificationAmi (
  idNotification INT NOT NULL,
  message VARCHAR(512) NOT NULL CHECK (LENGTH(TRIM(message)) > 0),
  vue BIT(1) NOT NULL DEFAULT b'0',
  idUtilisateur INT NOT NULL,
  idAmi INT NOT NULL,
  idConcerne INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table NotificationContamination
--

CREATE TABLE NotificationContamination (
  idNotification INT NOT NULL,
  message VARCHAR(512) NOT NULL CHECK (LENGTH(TRIM(message)) > 0),
  vue BIT(1) NOT NULL DEFAULT b'0',
  idUtilisateur INT NOT NULL,
  idContamine INT NOT NULL,
  idEtat INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table utilisateur
--

CREATE TABLE Utilisateur (
  idUtilisateur INT NOT NULL,
  nom VARCHAR(64) NOT NULL CHECK (LENGTH(TRIM(nom)) > 0),
  prenom VARCHAR(64) NOT NULL CHECK (LENGTH(TRIM(prenom)) > 0),
  dateNaiss DATE NOT NULL,
  login VARCHAR(64) NOT NULL CHECK (LENGTH(TRIM(login)) > 0 AND LENGTH(login) >= 3),
  motDePasse BINARY(60) NOT NULL CHECK (CONVERT(motDePasse, CHAR(60)) != ''),
  rang SET('normal','admin') NOT NULL CHECK (LENGTH(TRIM(rang)) > 0),
  image VARCHAR(255) DEFAULT NULL CHECK(LENGTH(TRIM(image)) > 0)
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
-- Index pour la table NotificationAmi
--
ALTER TABLE NotificationAmi
  ADD PRIMARY KEY (idNotification),
  ADD KEY idUtilisateur (idUtilisateur),
  ADD KEY idAmi (idAmi),
  ADD KEY idConcerne (idConcerne);

  --
  -- Index pour la table NotificationContamination
  --
  ALTER TABLE NotificationContamination
    ADD PRIMARY KEY (idNotification),
    ADD KEY idContamine (idContamine),
    ADD KEY idUtilisateur (idUtilisateur),
    ADD KEY idEtat (idEtat);

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
-- AUTO_INCREMENT pour la table NotificationAmi
--
ALTER TABLE NotificationAmi
  MODIFY idNotification INT NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table NotificationAmi
--
ALTER TABLE NotificationContamination
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
-- Contraintes pour la table NotificationAmi
--
ALTER TABLE NotificationAmi
  ADD CONSTRAINT idUtilisateurNA FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur (idUtilisateur),
  ADD CONSTRAINT idAmiNA FOREIGN KEY (idAmi) REFERENCES Utilisateur (idUtilisateur),
  ADD CONSTRAINT idConcerneNA FOREIGN KEY (idConcerne) REFERENCES Utilisateur(idUtilisateur);

--
-- Contraintes pour la table NotificationContamination
--
ALTER TABLE NotificationContamination
  ADD CONSTRAINT idUtilisateurNC FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur (idUtilisateur),
  ADD CONSTRAINT idContamineNC FOREIGN KEY (idContamine) REFERENCES Utilisateur (idUtilisateur),
  ADD CONSTRAINT idEtatNC FOREIGN KEY (idEtat) REFERENCES Etat(idEtat);


--
-- Création des procédures
--

--
-- Procédure permettant d'accepter un ami
--
DELIMITER $$;
CREATE PROCEDURE accepter_ami(IN id_accepteur INT, IN id_ami_accepte INT) READS SQL DATA
BEGIN
  DECLARE id_utilisateur INT;
  DECLARE id_ami INT;
  DECLARE nom_utilisateur VARCHAR(64);
  DECLARE prenom_utilisateur VARCHAR(64);

  SELECT idUtilisateur, idAmi INTO id_utilisateur, id_ami FROM Ami WHERE (idUtilisateur = id_accepteur AND idAmi = id_ami_accepte) OR (idUtilisateur = id_ami_accepte AND idAmi = id_accepteur);

  IF (id_utilisateur IS NOT NULL AND id_ami IS NOT NULL) THEN
    UPDATE Ami SET accepte = b'1' WHERE idUtilisateur = id_utilisateur AND idAmi = id_ami;
  ELSEIF (id_utilisateur IS NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Aucune requête n'existe pour cette demande d'ami.";
  END IF;
END;
$$;
DELIMITER $;

--
-- Procédure permettant de supprimer un ami (ou refuser sa demande) et d'envoyer une notification de suppression (ou refus) d'ami à un des deux utilisateurs qui étaient auparavant amis
--
DELIMITER $$;
CREATE PROCEDURE supprimer_refuser_ami(IN id_utilisateur_courant INT, IN id_ami_supprime INT) READS SQL DATA
BEGIN
  DECLARE id_utilisateur INT;
  DECLARE id_ami INT;
  DECLARE etat_ami BIT(1);
  DECLARE nom_utilisateur VARCHAR(64);
  DECLARE prenom_utilisateur VARCHAR(64);
  DECLARE notification VARCHAR(512);

  SELECT idUtilisateur, idAmi, accepte INTO id_utilisateur, id_ami, etat_ami FROM Ami WHERE (idUtilisateur = id_utilisateur_courant AND idAmi = id_ami_supprime) OR (idUtilisateur = id_ami_supprime AND idAmi = id_utilisateur_courant);
  SELECT nom, prenom INTO nom_utilisateur, prenom_utilisateur FROM Utilisateur WHERE idUtilisateur = id_utilisateur_courant;

  IF (id_utilisateur IS NOT NULL AND etat_ami = b'1') THEN
    SELECT CONCAT(nom_utilisateur, " ", prenom_utilisateur, " vous a supprimé de vos amis.") INTO notification FROM DUAL;
    INSERT INTO NotificationAmi(message, idUtilisateur, idAmi, idConcerne) VALUES(notification, id_utilisateur, id_ami, id_ami_supprime);
  ELSEIF (id_utilisateur IS NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Aucune requête n'existe pour cette demande d'ami.";
  END IF;

  DELETE FROM Ami WHERE (idUtilisateur = id_utilisateur_courant AND idAmi = id_ami_supprime) OR (idUtilisateur = id_ami_supprime AND idAmi = id_utilisateur_courant);
END;
$$;
DELIMITER ;

--
-- Procédure commune à l'ajout et la mise à jour des activités : vérifier que les données sont cohérentes
--
DELIMITER $$;
CREATE PROCEDURE verifier_activite(IN id_utilisateur INT, IN id_lieu INT, IN date_debut_activite TIMESTAMP, IN date_fin_activite TIMESTAMP) READS SQL DATA
BEGIN
  DECLARE lieu_existe INT;
  DECLARE utilisateur_existe INT;
  DECLARE activite_existe INT;
  DECLARE date_naiss DATE;
  DECLARE date_timestamp TIMESTAMP;
  DECLARE date_dernier_etat TIMESTAMP;
  DECLARE etat_incoherent INT;
  DECLARE message VARCHAR(512);

  SELECT COUNT(idUtilisateur), dateNaiss INTO utilisateur_existe, date_naiss FROM Utilisateur
  WHERE idUtilisateur = id_utilisateur;

  IF (utilisateur_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'utilisateur spécifié n'existe pas.";
  END IF;

  IF (DATE(date_debut_activite) < date_naiss) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date du nouvel état ne peut être inférieure à votre date de naissance.";
  ELSEIF (DATE(date_debut_activite) < STR_TO_DATE('17-11-2019','%d-%m-%Y')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date du nouvel état ne peut être inférieure à la date de début de l'épidémie du COVID-19 (17/11/2019).";
  ELSEIF (date_debut_activite > CURRENT_TIMESTAMP() OR date_fin_activite > CURRENT_TIMESTAMP()) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date du nouvel état ne peut être supérieure à la date actuelle.";
  END IF;


  SELECT COUNT(idLieu) INTO lieu_existe FROM Lieu WHERE idLieu = id_lieu;

  IF (lieu_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le lieu spécifié n'existe pas.";
  ELSEIF (date_debut_activite >= date_fin_activite) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date de début de l'activité doit être inférieure à la date de fin de l'activité.";
  END IF;

  SELECT COUNT(idEtat) INTO etat_incoherent FROM Etat E NATURAL JOIN Utilisateur U
  WHERE idEtat = (SELECT MAX(idEtat) FROM Etat WHERE idUtilisateur = id_utilisateur)
  AND positif = b'1'
  AND (date_fin_activite > dateEtat
  OR date_debut_activite < (SELECT dateEtat FROM Etat WHERE idUtilisateur = id_utilisateur AND idEtat = E.idEtat - 1))
  ORDER BY dateEtat DESC LIMIT 1;

  IF (etat_incoherent != 0 AND date_debut_activite IS NOT NULL AND date_fin_activite IS NOT NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous ne pouvez pas déclarer d'activités dans une période où vous êtes en isolement ou inférieure à votre dernier état positif.";
  END IF;

  SELECT COUNT(idActivite) INTO activite_existe FROM Activite
  WHERE ((date_debut_activite BETWEEN dateDebut AND dateFin) OR (date_fin_activite BETWEEN dateDebut and dateFin)
  OR (date_debut_activite < dateDebut AND date_fin_activite > dateFin))
  AND idUtilisateur = id_utilisateur;

  IF (activite_existe != 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous avez déjà déclaré une activité à cette période.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Procédure pour envoyer une notification aux utilisateurs à risque lorsqu'un utilisateur est positif
--
DELIMITER $$;
CREATE PROCEDURE envoyer_notification_contamination_positif(IN id_utilisateur_positif INT, IN id_max_etat INT) READS SQL DATA
BEGIN
  DECLARE id_infecte_potentiel INT;
  DECLARE id_ami INT;
  DECLARE nom_utilisateur_positif VARCHAR(64);
  DECLARE prenom_utilisateur_positif VARCHAR(64);
  DECLARE notification_utilisateur_externe VARCHAR(512);
  DECLARE notification_ami VARCHAR(512);

  IF (id_max_etat IS NOT NULL) THEN
    SELECT nom, prenom INTO nom_utilisateur_positif, prenom_utilisateur_positif FROM Utilisateur WHERE idUtilisateur = id_utilisateur_positif;

    SELECT CONCAT("Vous avez probablement été en contact avec ", nom_utilisateur_positif, " ", nom_utilisateur_positif, " au cours de ces 10 derniers jours. Cet individu s'est déclaré positif.") INTO notification_utilisateur_externe FROM DUAL;
    SELECT CONCAT("Votre ami ", nom_utilisateur_positif, " ", nom_utilisateur_positif, " s'est déclaré positif.") INTO notification_ami FROM DUAL;

    -- Pour chaque ami de l'utilisateur positif , on émet une notification
    INSERT INTO NotificationContamination(message, idUtilisateur, idContamine, idEtat)
      SELECT notification_ami, idUtilisateur, id_utilisateur_positif, id_max_etat FROM (
        SELECT idAmi AS idUtilisateur FROM Ami WHERE idUtilisateur = id_utilisateur_positif AND accepte = b'1'
          UNION
        SELECT idUtilisateur FROM Ami WHERE idAmi = id_utilisateur_positif AND accepte = b'1'
      ) amis
      WHERE NOT EXISTS (
        SELECT idNotification FROM NotificationContamination
        WHERE idEtat = id_max_etat
        AND idContamine = id_utilisateur_positif
        AND idUtilisateur = amis.idUtilisateur
      );

    -- Pour chaque utilisateur ayant été cas contact, on émet une notification
    INSERT INTO NotificationContamination(message, idUtilisateur, idContamine, idEtat)
      SELECT DISTINCT notification_utilisateur_externe, idUtilisateur, id_utilisateur_positif, id_max_etat FROM Activite AM INNER JOIN (
        SELECT idLieu, dateDebut, dateFin, dateEtat FROM Activite A INNER JOIN Etat E
          ON A.idUtilisateur = E.idUtilisateur
          WHERE E.positif = b'1'
          AND E.idEtat = id_max_etat
          AND A.idUtilisateur = id_utilisateur_positif
          AND ((DATE(A.dateDebut) BETWEEN DATE(E.dateEtat - INTERVAL 10 DAY) AND DATE(E.dateEtat)) OR (DATE(A.dateFin) BETWEEN DATE(E.dateEtat - INTERVAL 10 DAY) AND DATE(E.dateEtat)))
          ORDER BY dateDebut, dateFin
      ) lieux
      WHERE idUtilisateur IN (
        SELECT idUtilisateur FROM Activite AC
        WHERE idUtilisateur != id_utilisateur_positif
        AND idLieu = lieux.idLieu
        AND (DATE(AC.dateDebut) >= DATE(lieux.dateEtat - INTERVAL 10 DAY) OR DATE(AC.dateFin) >= DATE(lieux.dateEtat - INTERVAL 10 DAY))
        AND (((AC.dateDebut BETWEEN lieux.dateDebut AND lieux.dateFin) OR (AC.dateFin BETWEEN lieux.dateDebut AND lieux.dateFin))
        OR ((AC.dateDebut < lieux.dateDebut) AND (AC.dateFin > lieux.dateFin)))
      )
      AND NOT EXISTS ( -- S'il n'existe pas déjà de notification concernant l'utilisateur potentiellement positif sur sa période positive
        SELECT idNotification FROM NotificationContamination
        WHERE idEtat = id_max_etat
        AND idContamine = id_utilisateur_positif
        AND idUtilisateur = AM.idUtilisateur
      )
      AND idUtilisateur NOT IN ( -- Si les utilisateurs ne sont pas des amis (car notification personnalisée)
        SELECT idAmi AS idUtilisateur FROM Ami WHERE idUtilisateur = id_utilisateur_positif AND accepte = b'1'
          UNION
        SELECT idUtilisateur FROM Ami WHERE idAmi = id_utilisateur_positif AND accepte = b'1'
      );
  END IF;
END;
$$;
DELIMITER ;

--
-- Création des triggers
--

--
-- Trigger pour vérifier qu'un compte peut être créé (login inexistant dans la BDD)
--
DELIMITER $$;
CREATE TRIGGER verifier_creation_compte BEFORE INSERT ON Utilisateur FOR EACH ROW
BEGIN
  DECLARE login_existe INT;

  SELECT COUNT(idUtilisateur) INTO login_existe FROM Utilisateur WHERE login = NEW.login;

  IF (login_existe != 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ce pseudo est déjà pris. Veuillez en choisir un autre.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'un compte peut être créé (login inexistant dans la BDD ou déjà égal à l'utilisateur actuel)
--
DELIMITER $$;
CREATE TRIGGER verifier_maj_compte BEFORE UPDATE ON Utilisateur FOR EACH ROW
BEGIN
  DECLARE login_existe INT;

  SELECT COUNT(idUtilisateur) INTO login_existe FROM Utilisateur WHERE login = NEW.login AND NEW.login != OLD.login;

  IF (login_existe != 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ce pseudo est déjà pris. Veuillez en choisir un autre.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour supprimer totalement un utilisateur après sa suppression (suppression des amis le possédant ou des amis associés à cet utilisateur)
--
DELIMITER $$;
CREATE TRIGGER suppression_totale_utilisateur BEFORE DELETE ON Utilisateur FOR EACH ROW
BEGIN
  DECLARE utilisateur_existe INT;

  SELECT COUNT(idUtilisateur) INTO utilisateur_existe FROM Utilisateur WHERE idUtilisateur = OLD.idUtilisateur;

  IF (utilisateur_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'utilisateur spécifié n'existe pas.";
  END IF;

  DELETE FROM Activite WHERE idUtilisateur = OLD.idUtilisateur;
  DELETE FROM NotificationContamination WHERE idUtilisateur = OLD.idUtilisateur;
  DELETE FROM NotificationAmi WHERE idConcerne = OLD.idUtilisateur;
  DELETE FROM Etat WHERE idUtilisatuer = OLD.idUtilisateur;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier si une demande d’ami peut être effectuée (utilisateur existant, requête pas encore effectuée, pas encore ami)
--
DELIMITER $$;
CREATE TRIGGER verifier_demande_nouvel_ami BEFORE INSERT ON Ami FOR EACH ROW
BEGIN
  DECLARE utilisateur_existe INT;
  DECLARE requete_existe INT;
  DECLARE est_accepte BIT;

  IF (NEW.idUtilisateur = NEW.idAmi) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous ne pouvez pas vous demander en tant qu'ami.";
  END IF;

  SELECT COUNT(idUtilisateur) INTO utilisateur_existe FROM Utilisateur WHERE idUtilisateur = NEW.idUtilisateur;

  IF (utilisateur_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'utilisateur spécifié n'existe pas.";
  END IF;

  SELECT COUNT(idUtilisateur) INTO utilisateur_existe FROM Utilisateur WHERE idUtilisateur = NEW.idAmi;

  IF (utilisateur_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'ami spécifié n'existe pas.";
  END IF;

  IF (NEW.accepte = b'1') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Il n'est pas possible d'ajouter directement un ami. Vous devez attendre sa confirmation.";
  END IF;

  SELECT COUNT(idUtilisateur), accepte INTO requete_existe, est_accepte FROM Ami WHERE (idUtilisateur = NEW.idUtilisateur AND idAmi = NEW.idAmi) OR (idUtilisateur = NEW.idAmi AND idAmi = NEW.idUtilisateur);

  IF (requete_existe = 1) THEN
    IF (est_accepte = 1) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous possédez déjà cet utilisateur en tant qu'ami.";
    ELSE
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous avez déjà envoyé une requête d'ami à cet utilisateur. Elle est encore en attente.";
    END IF;
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier que la demande mise à jour d'une demande d'ami est cohérente
--
DELIMITER $$;
CREATE TRIGGER verifier_maj_demande_ami BEFORE UPDATE ON Ami FOR EACH ROW
BEGIN
  DECLARE requete_existe INT;

  IF (NEW.idUtilisateur != OLD.idUtilisateur OR NEW.idAmi != OLD.idAmi) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous ne pouvez pas modifier les utilisateurs associés à une demande d'ami.";
  END IF;

  IF (NEW.accepte != b'1') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Une mise à jour de la demande d'ami signifie qu'elle est acceptée.";
  END IF;

  IF (NEW.accepte = OLD.accepte) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous possédez déjà cet utilisateur en tant qu'ami.";
  END IF;

  SELECT COUNT(idUtilisateur) INTO requete_existe FROM Ami WHERE (idUtilisateur = OLD.idUtilisateur AND idAmi = OLD.idAmi);

  IF (requete_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous ne possédez pas cet utilisateur en tant qu'ami.";
  END IF;
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

  SELECT COUNT(idUtilisateur) INTO requete_existe FROM Ami WHERE (idUtilisateur = OLD.idUtilisateur AND idAmi = OLD.idAmi);

  IF (requete_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous ne possédez pas cet utilisateur en tant qu'ami.";
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
  CALL verifier_activite(NEW.idUtilisateur, NEW.idLieu, NEW.dateDebut, NEW.dateFin);
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'une activité peut être mise à jour (qu'elle est cohérente vis-à-vis du lieu et des heures)
--
DELIMITER $$;
CREATE TRIGGER verifier_maj_activite BEFORE UPDATE ON Activite FOR EACH ROW
BEGIN
  CALL verifier_activite(NEW.idUtilisateur, NEW.idLieu, NEW.dateDebut, NEW.dateFin);
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
-- Trigger pour vérifier qu'un lieu peut être ajouté (le nom du lieu ne doit pas déjà exister)
--
DELIMITER $$;
CREATE TRIGGER verifier_ajout_lieu BEFORE INSERT ON Lieu FOR EACH ROW
BEGIN
  DECLARE lieu_existe INT;

  SELECT COUNT(idLieu) INTO lieu_existe FROM Lieu WHERE nom = NEW.nom;

  IF (lieu_existe != 0) THEN
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
-- Trigger pour vérifier qu'un lieu peut bien être supprimé s'il existe et qu'il n'est associé à aucune activité
--
DELIMITER $$;
CREATE TRIGGER verifier_suppression_lieu BEFORE DELETE ON Lieu FOR EACH ROW
BEGIN
  DECLARE lieu_existe INT;
  DECLARE activites_associees INT;

  SELECT COUNT(idLieu) INTO lieu_existe FROM Lieu WHERE idLieu = OLD.idLieu;

  IF (lieu_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le lieu spécifié n'existe pas.";
  END IF;

  SELECT COUNT(idLieu) INTO activites_associees FROM Activite NATURAL JOIN Lieu WHERE idLieu = OLD.idLieu;

  IF (activites_associees != 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Il n'est pas possible de supprimer un lieu qui est déjà associé à au moins une activité.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier que l'ajout d'un état est cohérent pour un utilisateur (état différent du précédent, date supérieure à celle de l'état précédent)
--
DELIMITER $$;
CREATE TRIGGER verifier_etat BEFORE INSERT ON Etat FOR EACH ROW
BEGIN
  DECLARE date_naissance_utilisateur_positif DATE;
  DECLARE derniere_date_etat TIMESTAMP;
  DECLARE dernier_etat BIT;
  DECLARE etat_incoherent INT;
  DECLARE message VARCHAR(512);

  SELECT dateEtat, positif INTO derniere_date_etat, dernier_etat FROM Etat
  WHERE idUtilisateur = NEW.idUtilisateur
  ORDER BY idEtat DESC LIMIT 1;

  SELECT dateNaiss INTO date_naissance_utilisateur_positif FROM Utilisateur WHERE idUtilisateur = NEW.idUtilisateur;

  IF (NEW.dateEtat < date_naissance_utilisateur_positif) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date du nouvel état ne peut être inférieure à votre date de naissance.";
  ELSEIF (NEW.dateEtat < STR_TO_DATE('17-11-2019 00:00:00','%d-%m-%Y %T')) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date du nouvel état ne peut être inférieure à la date de début de l'épidémie du COVID-19 (17/11/2019).";
  ELSEIF (NEW.dateEtat > CURRENT_TIMESTAMP()) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date du nouvel état ne peut être supérieure à la date actuelle.";
  ELSEIF (derniere_date_etat IS NOT NULL) THEN
    IF (NEW.dateEtat <= derniere_date_etat) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date du nouvel état doit être supérieure à celle du dernier état.";
    ELSEIF (dernier_etat = b'1' AND NEW.positif = b'0' AND (DATE(NEW.dateEtat) < DATE(derniere_date_etat) + 10)) THEN
      SELECT CONCAT("L'état est réinitialisé tous les 10 jours. Temps restant : ", DATEDIFF(DATE(derniere_date_etat) + 10, DATE(NEW.dateEtat)), " jours.") INTO message FROM DUAL;
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message;
    ELSEIF (NEW.positif = dernier_etat) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le nouvel état correspond déjà à l'état précédent.";
    END IF;
  ELSEIF (NEW.positif = b'0') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le premier état déclaré d'un utilisateur doit forcément être positif.";
  END IF;

  SELECT COUNT(idActivite) INTO etat_incoherent FROM Activite
  WHERE idUtilisateur = NEW.idUtilisateur
  AND NEW.dateEtat < dateFin
  ORDER BY dateFin DESC LIMIT 1;

  IF (etat_incoherent != 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date du nouvel état doit forcément être supérieure à la date des dernières activités déclarées.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour empêcher la mise à jour de la table des états (un nouvel état = une nouvelle ligne)
--
DELIMITER $$;
CREATE TRIGGER refuser_maj_etat BEFORE UPDATE ON Etat FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Pour insérer un nouvel état, un nouvel état doit être déclaré, aucun état ne doit être modifié.";
END;
$$;
DELIMITER ;

--
-- Trigger pour envoyer une notification aux utilisateurs à risque lorsqu'un utilisateur se déclare positif
--
DELIMITER $$;
CREATE TRIGGER envoi_notification_positif_nouvel_etat AFTER INSERT ON Etat FOR EACH ROW
BEGIN
  DECLARE id_max_etat INT;

  SELECT idEtat INTO id_max_etat FROM Etat
  WHERE idUtilisateur = NEW.idUtilisateur
  AND positif = b'1'
  AND idEtat = (SELECT MAX(idEtat) FROM Etat WHERE idUtilisateur = NEW.idUtilisateur);

  CALL envoyer_notification_contamination_positif(NEW.idUtilisateur, id_max_etat);
END;
$$;
DELIMITER ;

--
-- Trigger permettant de déclencher l'envoi des notifications de contaminations lors de la création d'une activité par un utilisateur
--
DELIMITER $$;
CREATE TRIGGER envoi_notifications_creation_activite_contamination AFTER INSERT ON Activite FOR EACH ROW
BEGIN
  DECLARE id_utilisateur_positif INT;
  DECLARE id_max_etat INT;

  SELECT idEtat INTO id_max_etat FROM Etat
  WHERE idUtilisateur = NEW.idUtilisateur
  AND positif = b'1'
  AND idEtat = (SELECT MAX(idEtat) FROM Etat WHERE idUtilisateur = NEW.idUtilisateur);

  IF (id_max_etat IS NOT NULL) THEN
    CALL envoyer_notification_contamination_positif(NEW.idUtilisateur, id_max_etat);
  ELSE
    INSERT INTO NotificationContamination(message, idUtilisateur, idContamine, idEtat)
      SELECT DISTINCT CONCAT("Vous avez probablement été en contact avec ", nom, " ", prenom, " au cours de ces 10 derniers jours. Cet individu s'est déclaré positif."), NEW.idUtilisateur, infectes.idUtilisateur, idEtat FROM Activite AM INNER JOIN (
        SELECT DISTINCT idLieu, A.idUtilisateur, nom, prenom, dateDebut, dateFin, idEtat, dateEtat FROM Activite A INNER JOIN Etat E NATURAL JOIN Utilisateur
          ON A.idUtilisateur = E.idUtilisateur
          WHERE E.positif = b'1'
          AND idLieu = NEW.idLieu
          AND E.idEtat = (SELECT MAX(idEtat) FROM Etat WHERE idUtilisateur = E.idUtilisateur)
          AND ((DATE(A.dateDebut) BETWEEN DATE(E.dateEtat - INTERVAL 10 DAY) AND DATE(E.dateEtat)) OR (DATE(A.dateFin) BETWEEN DATE(E.dateEtat - INTERVAL 10 DAY) AND DATE(E.dateEtat)))
          ORDER BY dateDebut, dateFin
      ) infectes
      WHERE NEW.idUtilisateur IN (
        SELECT idUtilisateur FROM Activite AC
        WHERE idUtilisateur != infectes.idUtilisateur
        AND idLieu = infectes.idLieu
        AND (DATE(AC.dateDebut) >= DATE(infectes.dateEtat - INTERVAL 10 DAY) OR DATE(AC.dateFin) >= DATE(infectes.dateEtat - INTERVAL 10 DAY))
        AND (((AC.dateDebut BETWEEN infectes.dateDebut AND infectes.dateFin) OR (AC.dateFin BETWEEN infectes.dateDebut AND infectes.dateFin))
        OR ((AC.dateDebut < infectes.dateDebut) AND (AC.dateFin > infectes.dateFin)))
      )
      AND NOT EXISTS ( -- S'il n'existe pas déjà de notification concernant l'utilisateur potentiellement positif sur sa période positive
        SELECT idNotification FROM NotificationContamination
        WHERE idEtat = infectes.idEtat
        AND idContamine = infectes.idUtilisateur
        AND idUtilisateur = NEW.idUtilisateur
      );
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger permettant d'envoyer une notification de contamination potentielle à un demandeur d'ami si sa requête est acceptée
--
DELIMITER $$;
CREATE TRIGGER envoi_notifications_nouvel_ami_contamination AFTER UPDATE ON Ami FOR EACH ROW
BEGIN
  DECLARE id_utilisateur_positif INT;
  DECLARE id_max_etat INT;
  DECLARE nom_utilisateur_positif VARCHAR(64);
  DECLARE prenom_utilisateur_positif VARCHAR(64);
  DECLARE notification_ami VARCHAR(512);
  DECLARE done INT DEFAULT 0;

  INSERT INTO NotificationContamination(message, idUtilisateur, idContamine, idEtat)
    SELECT CONCAT("Votre ami ", nom, prenom," s'est déclaré positif."), idConcerne, idUtilisateur, idEtat FROM (
      SELECT idUtilisateur, IF(idUtilisateur = NEW.idUtilisateur, NEW.idAmi, NEW.idUtilisateur) AS idConcerne, nom, prenom, idEtat FROM Etat NATURAL JOIN Utilisateur U
      WHERE positif = b'1'
      AND idEtat = (SELECT MAX(idEtat) FROM Etat WHERE idUtilisateur = U.idUtilisateur)
      AND idUtilisateur IN (NEW.idUtilisateur, NEW.idAmi)
    ) notif
    WHERE NOT EXISTS (
      SELECT idNotification FROM NotificationContamination
      WHERE idEtat = notif.idEtat
      AND idContamine = notif.idUtilisateur
      AND idUtilisateur = notif.idConcerne
    );
END;
$$;
DELIMITER ;


--
-- Trigger permettant l'envoi d'une notification d'acceptation lorsqu'un utilisateur accepte une demande d'ami
--
DELIMITER $$;
CREATE TRIGGER envoi_notification_nouvel_ami AFTER UPDATE ON Ami FOR EACH ROW
BEGIN
  DECLARE nom_utilisateur VARCHAR(64);
  DECLARE prenom_utilisateur VARCHAR(64);
  DECLARE notification VARCHAR(512);

  SELECT nom, prenom INTO nom_utilisateur, prenom_utilisateur FROM Utilisateur WHERE idUtilisateur = NEW.idAmi;
  SELECT CONCAT("Votre demande d'ami de ", nom_utilisateur, " ", prenom_utilisateur, " a été acceptée.") INTO notification FROM DUAL;

  INSERT INTO NotificationAmi(message, idUtilisateur, idAmi, idConcerne) VALUES(notification, NEW.idUtilisateur, NEW.idAmi, NEW.idUtilisateur);
END;
$$;
DELIMITER ;

--
-- Trigger permettant l'envoi d'une notification d'acceptation lorsqu'un utilisateur refuse une demande d'ami
--
DELIMITER $$;
CREATE TRIGGER envoi_notification_ami_refuse AFTER DELETE ON Ami FOR EACH ROW
BEGIN
  DECLARE nom_utilisateur VARCHAR(64);
  DECLARE prenom_utilisateur VARCHAR(64);
  DECLARE etat_utilisateur BIT(1);
  DECLARE notification VARCHAR(512);

  IF (OLD.accepte = b'0') THEN
    SELECT nom, prenom INTO nom_utilisateur, prenom_utilisateur FROM Utilisateur WHERE idUtilisateur = OLD.idAmi;
    SELECT CONCAT("Votre demande d'ami de ", nom_utilisateur, " ", prenom_utilisateur, " a été rejetée.") INTO notification FROM DUAL;

    INSERT INTO NotificationAmi(message, idUtilisateur, idAmi, idConcerne) VALUES(notification, OLD.idUtilisateur, OLD.idAmi, OLD.idUtilisateur);
  END IF;
END;
$$;
DELIMITER ;

DELIMITER $$;
CREATE EVENT maj_etat_automatique ON SCHEDULE EVERY 1 DAY
DO BEGIN
  INSERT INTO Etat(dateEtat, positif, idUtilisateur)
    SELECT TIMESTAMP(CURRENT_DATE()), b'0', E.dateEtat, E.idUtilisateur FROM Etat E INNER JOIN(
      SELECT dateEtat, MAX(idEtat) AS idEtat FROM Etat GROUP BY idUtilisateur
    ) EM
    ON E.idEtat = EM.idEtat
    WHERE E.positif = b'1'
    AND DATEDIFF(CURRENT_DATE(), DATE(EM.dateEtat)) >= 10
    GROUP BY idUtilisateur;
END;
$$;
DELIMITER ;

COMMIT;
