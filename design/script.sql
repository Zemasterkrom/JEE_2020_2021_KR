DROP DATABASE IF EXISTS COVID_KR_TR;
CREATE DATABASE COVID_KR_TR;
USE COVID_KR_TR;

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
  longitude DECIMAL(10,0) DEFAULT NULL,
  latitude DECIMAL(10,0) DEFAULT NULL
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
  login VARCHAR(64) NOT NULL CHECK (LENGTH(TRIM(login)) > 0 AND LENGTH(login) >= 5),
  motDePasse VARCHAR(255) NOT NULL CHECK (LENGTH(TRIM(motDePasse)) > 0 AND LENGTH(motDePasse) >= 5),
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
-- Procédure permettant d'envoyer une notification de suppression d'ami à un des deux utilisateurs qui étaient auparavant amis
--
DELIMITER $$;
CREATE PROCEDURE envoi_notifications_suppression_ami(IN id_utilisateur_courant INT, IN id_ami_supprime INT) READS SQL DATA
BEGIN
  DECLARE id_utilisateur INT;
  DECLARE id_ami INT;
  DECLARE nom_utilisateur VARCHAR(64);
  DECLARE prenom_utilisateur VARCHAR(64);
  DECLARE notification VARCHAR(512);

  SELECT idUtilisateur, idAmi INTO id_utilisateur, id_ami FROM Ami WHERE (idUtilisateur = id_utilisateur_courant AND idAmi = id_ami_supprime) OR (idUtilisateur = id_ami_supprime AND idAmi = id_utilisateur_courant);
  SELECT nom, prenom INTO nom_utilisateur, prenom_utilisateur FROM Utilisateur WHERE idUtilisateur = id_utilisateur_courant;
  SELECT CONCAT(nom_utilisateur, " ", prenom_utilisateur, " vous a supprimé de vos amis.") INTO notification FROM DUAL;

  INSERT INTO NotificationAmi(message, idUtilisateur, idAmi, idConcerne) VALUES(notification, id_utilisateur, id_ami, id_ami_supprime);
END;
$$;
DELIMITER ;

--
-- Procédure commune à l'ajout et la mise à jour des activités : vérifier que les données sont cohérentes
--
DELIMITER $$;
CREATE PROCEDURE verifier_activite(IN id_utilisateur INT, IN id_lieu INT, IN date_activite DATE, IN heure_debut TIME, IN heure_fin TIME) READS SQL DATA
BEGIN
  DECLARE lieu_existe INT;
  DECLARE utilisateur_existe INT;
  DECLARE date_naiss DATE;

  SELECT COUNT(idUtilisateur), dateNaiss INTO utilisateur_existe FROM Utilisateur WHERE idUtilisateur = id_utilisateur;

  IF (utilisateur_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'utilisateur spécifié n'existe pas.";
  END IF;

  SELECT COUNT(idLieu) INTO lieu_existe FROM Lieu WHERE idLieu = id_lieu;

  IF (lieu_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le lieu spécifié n'existe pas.";
  END IF;

  IF (date_activite <= date_naiss) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date de l'activité ne peut être inférieure ou égale à votre date de naissance.";
  END IF;

  IF (heure_debut >= heure_fin) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "L'heure de début de l'activité doit être inférieure à l'heure de fin de l'activité.";
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

  IF (NEW.accepte = b'1') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Il n'est pas possible d'ajouter directement un ami. Vous devez attendre sa confirmation.";
  END IF;

  SELECT COUNT(idUtilisateur), accepte INTO requete_existe, est_accepte FROM Ami WHERE (idUtilisateur = NEW.idUtilisateur AND idAmi = NEW.idAmi);

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
  DECLARE etat_ami INT;

  IF (NEW.idUtilisateur != OLD.idUtilisateur OR NEW.idAmi != OLD.idAmi) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous ne pouvez pas modifier les utilisateurs associés à une demande d'ami.";
  END IF;

  SELECT COUNT(idUtilisateur), accepte INTO requete_existe, etat_ami FROM Ami WHERE (idUtilisateur = OLD.idUtilisateur AND idAmi = OLD.idAmi);

  IF (requete_existe = 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Vous ne possédez pas cet utilisateur en tant qu'ami.";
  ELSEIF (NEW.accepte = b'0' AND OLD.accepte = b'1') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Il n'est pas possible de faire basculer l'état d'une demande à 'En attente' une fois que celle-ci est acceptée.";
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
  CALL verifier_activite(NEW.idUtilisateur, NEW.idLieu, NEW.dateActivite, NEW.heureDebut, NEW.heureFin);
END;
$$;
DELIMITER ;

--
-- Trigger pour vérifier qu'une activité peut être mise à jour (qu'elle est cohérente vis-à-vis du lieu et des heures)
--
DELIMITER $$;
CREATE TRIGGER verifier_maj_activite BEFORE UPDATE ON Activite FOR EACH ROW
BEGIN
  CALL verifier_activite(NEW.idUtilisateur, NEW.idLieu, NEW.dateActivite, NEW.heureDebut, NEW.heureFin);
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
  DECLARE derniere_DATE_etat TIMESTAMP;
  DECLARE dernier_etat BIT;

  SELECT dateEtat, positif INTO derniere_DATE_etat, dernier_etat FROM Etat
  WHERE idUtilisateur = NEW.idUtilisateur
  ORDER BY idEtat DESC LIMIT 1;

  IF (NEW.dateEtat <= derniere_DATE_etat) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "La date du nouvel état doit être supérieure à celle du dernier état.";
  ELSEIF (NEW.positif = dernier_etat) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Le nouvel état correspond déjà à l'état précédent.";
  END IF;
END;
$$;
DELIMITER ;

--
-- Trigger pour envoyer une notification aux utilisateurs à risque lorsqu'un utilisateur se déclare positif
--
DELIMITER $$;
CREATE TRIGGER envoi_notification_positif_nouvel_etat AFTER INSERT ON Etat FOR EACH ROW
BEGIN
  DECLARE id_infecte_potentiel INT;
  DECLARE id_ami INT;
  DECLARE id_max_etat INT;
  DECLARE nom_utilisateur VARCHAR(64);
  DECLARE prenom_utilisateur VARCHAR(64);
  DECLARE nom_utilisateur_positif VARCHAR(64);
  DECLARE prenom_utilisateur_positif VARCHAR(64);
  DECLARE notification_utilisateur_externe VARCHAR(512);
  DECLARE notification_ami VARCHAR(512);
  DECLARE done INT DEFAULT 0;

  -- Récupérer les utilisateurs pouvant avoir été contaminés par l'utilisatuer positif (si lieux communs : lieux fréquentés par l'utilisateur positif sur ses 10 derniers jours)
  DECLARE cur_infectes_potentiels CURSOR FOR
    SELECT DISTINCT idUtilisateur FROM Activite AC
    INNER JOIN (
      -- On récupère les lieux visités durant les 10 derniers jours du contaminé
      SELECT idLieu FROM Activite A INNER JOIN Etat E
        ON A.idUtilisateur = E.idUtilisateur
        WHERE E.positif = b'1'
        AND E.idEtat = id_max_etat
        AND A.idUtilisateur = id_utilisateur_positif
        AND A.dateActivite BETWEEN E.dateEtat AND E.dateEtat - 10
        AND EXISTS ( -- Où les utilisateurs sont allés dans des lieux de l'utilisateur positif pendant le même jour et entre la période de début et de fin
          -- On récupère les lieux visités par tous les utilisateurs autres que celui positif qui sont en corrélation avec les dernières activités du contaminé
          SELECT idLieu FROM Activite
          WHERE idUtilisateur != NEW.idUtilisateur
          AND idLieu = A.idLieu
          AND dateActivite = A.dateActivite
          AND (heureDebut BETWEEN A.heureDebut AND A.heureFin) OR (heureFin BETWEEN A.heureDebut AND A.heureFin)
        )
        ORDER BY dateActivite, heureDebut, heureFin
      ) lieux
    ON AC.idLieu = lieux.idLieu
    WHERE NOT EXISTS ( -- S'il n'existe pas déjà de notification concernant l'utilisateur potentiellement positif sur sa période positive
      SELECT idNotification FROM NotificationContamination
      WHERE idEtat = id_max_etat
      AND idContamine = NEW.idUtilisateur
      AND idUtilisateur = AC.idUtilisateur
    )
    AND idUtilisateur NOT IN ( -- Si les utilisateurs ne sont pas des amis (car notification personnalisée)
      SELECT idAmi AS idUtilisateur FROM Ami WHERE idUtilisateur = id_utilisateur_positif AND accepte = b'1'
      UNION
      SELECT idUtilisateur FROM Ami WHERE idAmi = id_utilisateur_positif AND accepte = b'1'
    );

  -- Amis de l'utilisateur infecté
  DECLARE cur_amis CURSOR FOR
    SELECT idUtilisateur FROM (
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

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  IF (NEW.positif = b'1') THEN
    SELECT nom, prenom INTO nom_utilisateur_positif, prenom_utilisateur_positif FROM Utilisateur WHERE idUtilisateur = id_utilisateur_positif;

    SELECT CONCAT("Vous avez été en probablement été en contact avec ", nom_utilisateur_positif, " ", nom_utilisateur_positif, " au cours de ces 10 derniers jours. Cet individu s'est déclaré positif.") INTO notification_utilisateur_externe FROM DUAL;
    SELECT CONCAT("Votre ami ", nom_utilisateur_positif, " ", nom_utilisateur_positif, " s'est déclaré positif.") INTO notification_ami FROM DUAL;

    SELECT idEtat INTO id_max_etat FROM Etat
    WHERE idUtilisateur = id_utilisateur_positif
    AND positif = b'1'
    AND idEtat = (SELECT MAX(idEtat) FROM Etat WHERE idUtilisateur = id_utilisateur_positif);

    -- Pour chaque utilisateur ayant été cas contact, on émet une notification
    OPEN cur_infectes_potentiels;
    cur_infectes_potentiels: LOOP
      FETCH cur_infectes_potentiels INTO id_infecte_potentiel;

      IF (done = 1) THEN
        SET done = 0;
        LEAVE cur_infectes_potentiels;
      END IF;

      INSERT INTO NotificationContamination(message, idUtilisateur, idContamine, idActivitePremiere) VALUES(notification_utilisateur_externe, id_infecte_potentiel, id_utilisateur_positif, id_max_etat);
    END LOOP;
    CLOSE cur_infectes_potentiels;

    -- Pour chaque ami de l'utilisateur positif , on émet une notification

    OPEN cur_amis;
    cur_amis: LOOP
      FETCH cur_amis INTO id_ami;

      IF (done = 1) THEN
        LEAVE cur_amis;
      END IF;

      INSERT INTO NotificationContamination(message, idUtilisateur, idContamine, idActivitePremiere) VALUES(notification_ami, id_ami, id_utilisateur_positif, id_max_etat);
    END LOOP;
    CLOSE cur_amis;
  END IF;
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
  DECLARE nom_utilisateur_positif VARCHAR(64);
  DECLARE prenom_utilisateur_positif VARCHAR(64);
  DECLARE notification_utilisateur VARCHAR(512);
  DECLARE done INT DEFAULT 0;

  DECLARE cur_utilisateurs_proches_infectes CURSOR FOR
    SELECT * FROM (
      SELECT idUtilisateur, nom, prenom, idEtat FROM Activite A INNER JOIN Etat E
      ON A.idUtilisateur = E.idUtilisateur
      WHERE idLieu = NEW.idLieu
      AND positif = b'1'
      AND idEtat = (SELECT MAX(idEtat) FROM Etat WHERE idUtilisateur = E.idUtilisateur)
    ) infectes
    WHERE NOT EXISTS (
      SELECT idNotification FROM NotificationContamination
      WHERE idEtat = infectes.idEtat
      AND idContamine = infectes.idUtilisateur
      AND idUtilisateur = NEW.idUtilisateur
    );

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur_utilisateurs_proches_infectes;
  cur_utilisateurs_proches_infectes: LOOP
    FETCH cur_utilisateurs_proches_infectes INTO id_utilisateur_positif, nom_utilisateur_positif, prenom_utilisateur_positif, id_max_etat;

    SELECT nom, prenom INTO nom_utilisateur_positif, prenom_utilisateur_positif FROM Utilisateur WHERE idUtilisateur = id_utilisateur_positif;

    SELECT CONCAT("Vous avez été en probablement été en contact avec ", nom_utilisateur_positif, " ", nom_utilisateur_positif, " au cours de ces 10 derniers jours. Cet individu s'est déclaré positif.") INTO notification_utilisateur FROM DUAL;

    IF (done = 1) THEN
      LEAVE cur_utilisateurs_proches_infectes;
    END IF;

    INSERT INTO NotificationContamination(message, idUtilisateur, idContamine, idActivitePremiere) VALUES(notification_utilisateur, NEW.idUtilisateur, id_utilisateur_positif, id_max_etat);
  END LOOP;
  CLOSE cur_utilisateurs_proches_infectes;
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

  SELECT idUtilisateur, nom, prenom, idEtat into id_utilisateur_positif, nom_utilisateur_positif, prenom_utilisateur_positif, id_max_etat FROM (
    SELECT idUtilisateur, nom, prenom, idEtat FROM Activite A NATURAL JOIN Etat E
    WHERE positif = b'1'
    AND idEtat = (SELECT MAX(idEtat) FROM Etat WHERE idUtilisateur = NEW.idAmi)
    AND idUtilisateur = NEW.idAmi
  ) ami
  WHERE NOT EXISTS (
    SELECT idNotification FROM NotificationContamination
    WHERE idEtat = ami.idEtat
    AND idContamine = ami.idUtilisateur
    AND idUtilisateur = NEW.idUtilisateur
  );

  IF (id_utilisateur_positif IS NOT NULL) THEN
    SELECT CONCAT("Votre ami ", nom_utilisateur_positif, " ", nom_utilisateur_positif, " s'est déclaré positif.") INTO notification_ami FROM DUAL;
    INSERT INTO NotificationContamination(message, idUtilisateur, idContamine, idEtat) VALUES(notification_ami, NEW.idUtilisateur, id_utilisateur_positif, id_max_etat);
  END IF;
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

  SELECT nom, prenom INTO nom_utilisateur, prenom_utilisateur FROM Utilisateur WHERE idUtilisateur = NEW.idUtilisateur;
  SELECT CONCAT("Votre demande d'ami de ", nom_utilisateur, " ", prenom_utilisateur, " a été acceptée.") INTO notification FROM DUAL;

  INSERT INTO NotificationAmi(message, idUtilisateur, idAmi, idConcerne) VALUES(notification, NEW.idUtilisateur, NEW.idAmi, NEW.idUtilisateur);
END;
$$;
DELIMITER ;

COMMIT;
