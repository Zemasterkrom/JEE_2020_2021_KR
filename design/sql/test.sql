--
-- Note : ce test a été réalisé sur MySQL Workbench qui donne la possibilité de continuer l'exécution du script malgré les erreurs, notamment pour vérifier le fonctionnement des triggers
-- Note : test à exécuter après la création des tables et des triggers
-- Note : ce test est destiné à tester les triggers à déclenchement immédiat, l'événement MySQL s'exécutant tous les jours ne peut donc pas être testé avec ce script
-- Option utilisée : Toggle whether execution of SQL script should continue after failed statements
--

--
-- Suppression des données des tables pour le test
--
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

TRUNCATE TABLE Activite;
TRUNCATE TABLE Ami;
TRUNCATE TABLE Etat;
TRUNCATE TABLE Lieu;
TRUNCATE TABLE NotificationAmi;
TRUNCATE TABLE NotificationContamination;
TRUNCATE TABLE Utilisateur;

DELETE FROM Activite;
DELETE FROM Ami;
DELETE FROM Etat;
DELETE FROM Lieu;
DELETE FROM NotificationAmi;
DELETE FROM NotificationContamination;
DELETE FROM Utilisateur;

SET FOREIGN_KEY_CHECKS = 1;

--
-- Création des utilisateurs. Mot de passe : test
--
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom1', 'TestPrenom1', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin1', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom2', 'TestPrenom2', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin2', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom3', 'TestPrenom3', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin3', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom4', 'TestPrenom4', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin4', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom5', 'TestPrenom5', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin5', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom6', 'TestPrenom6', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin6', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');

-- Fails : données incohérentes (champs vides, données NULL, valeurs incorrectes)
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom4', 'TestPrenom4', 'DateIncorrecte', 'TestLogin4', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'Te', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal'); -- Taille du login < 3 caractères
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES (NULL, 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', '', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', NULL, STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('', '', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES (NULL, NULL, STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', NULL, 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), '', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), NULL, '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', NULL, 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), '', '', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), NULL, NULL, 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', '');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', NULL);
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'inconnu');

--
-- Mise à jour des utilisateurs
--
UPDATE Utilisateur SET login = 'TestLogin1MAJ' WHERE idUtilisateur = 1;

-- Fails : utilisateur déjà existant
UPDATE Utilisateur SET login = 'TestLogin2' WHERE idUtilisateur = 1; -- Fail : utilisateur déjà existant

--
-- Création des demandes d'amis
--
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(1, 2);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(1, 3);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(1, 4);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(3, 2);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(3, 4);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(4, 2);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(6, 1);
SELECT * FROM NotificationAmi;

-- Fails : demandes incohérentes ou impossibles
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(NULL, 1); -- Fail : donnée incorrecte
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(1, NULL); -- Fail : donnée incorrecte
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(NULL, NULL); -- Fail : donnée incorrecte
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(2, 1); -- Fail : l'utilisateur 0 possède déjà l'utilisateur 2 en ami
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(1, 1); -- Fail : un utilisateur ne peut pas se demander en ami
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(-1, 0); -- Fail : l'utilisateur -1 est inexistant
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(0, -1); -- Fail : l'utilisateur -1 est inexistant
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(-1, -1); -- Fail : les deux utilisateurs sont inexistants
SELECT * FROM NotificationAmi;

--
-- Mise à jour des demandes d'amis
--
CALL accepter_ami(2, 1); -- L'utilisateur 1 va recevoir une notification d'acceptation de l'utilisateur 2
CALL accepter_ami(3, 1); -- L'utilisateur 1 va recevoir une notification d'acceptation de l'utilisateur 3
CALL accepter_ami(4, 1); -- L'utilisateur 1 va recevoir une notification d'acceptation de l'utilisateur 4
CALL accepter_ami(2, 3); -- L'utilisateur 3 va recevoir une notification d'acceptation de l'utilisateur 2
CALL accepter_ami(4, 3); -- L'utilisateur 3 va recevoir une notification d'acceptation de l'utilisateur 4
CALL accepter_ami(1, 6); -- L'utilisateur 6 va recevoir une notification d'acceptation de l'utilisateur 1
SELECT * FROM NotificationAmi;

CALL supprimer_refuser_ami(2, 4); -- L'utilisateur 4 va recevoir une notification de refus de la demande d'ami de l'utilisateur 2
CALL supprimer_refuser_ami(1, 2); -- L'utilisateur 2 va recevoir une notification de suppression d'ami de la part de l'utilisateur 1
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(1, 2);
CALL accepter_ami(2, 1); -- L'utilisateur 1 va recevoir une notification d'acceptation de l'utilisateur 2
CALL supprimer_refuser_ami(2, 1); -- L'utilisateur 1 va recevoir une notification de suppression d'ami de la part de l'utilisateur 2
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(1, 2);
CALL accepter_ami(2, 1); -- L'utilisateur 1 va recevoir une notification d'acceptation de l'utilisateur 2
SELECT * FROM NotificationAmi;

-- Fails : données d'acceptation incohérentes ou demandes inexistantes
CALL accepter_ami(2, 5); -- Fail : aucune demande n'a été initiée entre les utilisateurs 2 et 5
CALL supprimer_refuser_ami(2, 5); -- Fail : aucune demande n'a été initiée entre les utilisateurs 2 et 5
UPDATE Ami SET accepte = b'0' WHERE idUtilisateur = 1 AND idAmi = 3; -- Fail : on ne peut pas basculer une demande acceptée en non-acceptée
UPDATE Ami SET idUtilisateur = -1 WHERE idUtilisateur = 1 AND idAmi = 2; -- Fail : on ne peut pas mettre à jour les identifiants d'une demande d'ami
UPDATE Ami SET idUtilisateur = -1, idAmi = -1 WHERE idUtilisateur = 1 AND idAmi = 2; -- Fail : on ne peut pas mettre à jour les identifiants d'une demande d'ami
UPDATE Ami SET idUtilisateur = -1 WHERE idUtilisateur = 1 AND idAmi = 2; -- Fail : on ne peut pas mettre à jour les identifiants d'une demande d'ami
UPDATE Ami SET accepte = b'1' WHERE idUtilisateur = 1 AND idAmi = 2; -- Fail : requête déjà acceptée
UPDATE Ami SET accepte = b'1' WHERE idUtilisateur = 1 AND idAmi = 3; -- Fail : requête déjà acceptée
UPDATE Ami SET accepte = b'1' WHERE idUtilisateur = 3 AND idAmi = 2; -- Fail : requête déjà acceptée
UPDATE Ami SET accepte = b'1' WHERE idUtilisateur = 3 AND idAmi = 4; -- Fail : requête déjà acceptée
SELECT * FROM NotificationAmi;

--
-- Création des lieux
--
INSERT INTO Lieu(nom, adresse) VALUES('TestNonContamine', 'Test');
INSERT INTO Lieu(nom, adresse) VALUES('TestContamine', 'Test');
INSERT INTO Lieu(nom, adresse) VALUES('TestPositionGPS', 'Test'); -- Gardé pour ne pas perturber le fonctionnement des tests, mais les coordonnées GPS ne sont pas utilisées
INSERT INTO Lieu(nom, adresse) VALUES('TestContamine2', 'Test');

-- Fails : données des lieux incohérentes ou lieux déjà existants
INSERT INTO Lieu(nom, adresse) VALUES('', 'Test');
INSERT INTO Lieu(nom, adresse) VALUES(NULL, 'Test');
INSERT INTO Lieu(nom, adresse) VALUES('Test', '');
INSERT INTO Lieu(nom, adresse) VALUES('Test', NULL);
INSERT INTO Lieu(nom, adresse) VALUES('TestNonContamine', 'Test'); -- Fail : lieu déjà existant
SELECT * FROM Lieu;

--
-- Mise à jour des lieux
--
UPDATE Lieu SET nom = 'TestNonContamineMAJ' WHERE idLieu = 1;
UPDATE Lieu SET nom = 'TestContamineeMAJ' WHERE idLieu = 2;
UPDATE Lieu SET nom = 'TestPositionGPSMAJ' WHERE idLieu = 3;
UPDATE Lieu SET nom = 'TestPositionGPSMAJ' WHERE idLieu = 3; -- Possible car le nom du lieu reste le même

-- Fails : lieu déjà existant
UPDATE Lieu SET nom = 'TestNonContamineMAJ' WHERE idLieu = 2; -- Fail : un lieu existe déjà avec ce nom
SELECT * FROM Lieu;

--
-- Tests des signalements (pas d'activités)
--
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('01-01-2020 00:00:00','%d-%m-%Y %T'), b'1', 1); -- Aucune activité n'est encore déclarée : les amis de l'utilisateur 1 sont informés (2, 3, 4, 6)
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('11-01-2020 00:00:00','%d-%m-%Y %T'), b'0', 1);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('11-01-2020 00:00:02','%d-%m-%Y %T'), b'1', 1); -- Aucune activité n'est encore déclarée : les amis de l'utilisateur 1 sont informés (2, 3, 4, 6)
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('21-01-2020 00:00:00','%d-%m-%Y %T'), b'0', 1);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('10-02-2020 00:00:01','%d-%m-%Y %T'), b'1', 1); -- Aucune activité n'est encore déclarée : les amis de l'utilisateur 2 sont informés (2, 3, 4, 6)
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('02-01-2020 00:00:00','%d-%m-%Y %T'), b'1', 2); -- Aucune activité n'est encore déclarée : les amis de l'utilisateur 2 sont informés (1, 3)
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('12-01-2020 00:00:00','%d-%m-%Y %T'), b'0', 2);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('22-01-2020 00:00:01','%d-%m-%Y %T'), b'1', 2); -- Aucune activité n'est encore déclarée : les amis de l'utilisateur 2 sont informés (1, 3)
SELECT * FROM NotificationContamination;

-- Fails : états incohérents
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(NULL, b'1', 1);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('01-01-2035 00:00:00', '%d-%m-%Y %T'), b'0', 1); -- Fail : la date de l'état ne doit pas être supérieure à la date actuelle
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('02-01-2020 00:00:00','%d-%m-%Y %T'), b'0', 1); -- Fail : la date de l'état doit être supérieure à la dernière
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('21-01-2020 00:00:01','%d-%m-%Y %T'), b'0', 1); -- Fail : la date de l'état doit être supérieure à la dernière
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('12-01-2020 00:00:01','%d-%m-%Y %T'), b'1', 1); -- Fail : un état positif existe déjà
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('21-01-2020 00:00:02','%d-%m-%Y %T'), b'0', 1); -- Fail : l'état est automatiquement remis à 0 au bout de 10 jours
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('02-01-2020 00:00:00','%d-%m-%Y %T'), b'0', 3); -- Fail : le premier état d'un utilisateur est forcément positif
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('17-02-1998 00:00:00','%d-%m-%Y %T'), b'1', 2); -- Fail : la date de l'état ne peut être inférieure à la date de naissance de l'utilisateur
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('19-02-1998 00:00:00','%d-%m-%Y %T'), b'1', 2); -- Fail : la date de l'état ne peut être inférieure au 17/11/2019 (date de début de l'épidémie COVID-19)
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('11-01-2020 00:00:01','%d-%m-%Y %T'), b'0', 1); -- Fail : impossible d'ajout un état dont la date est inférieure ou égale au dernier état non-positif
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('23-01-2020 00:00:01','%d-%m-%Y %T'), b'0', 1); -- Fail : impossible d'ajout un état alors que l'état non positif existe déjà
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('09-01-2020 00:00:01','%d-%m-%Y %T'), b'0', 1); -- Fail : impossible d'ajout un état sur une période déjà passée

-- Ces états ayant déjà été insérés, ils ne peuvent plus être réinsérés
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('01-01-2020 00:00:00','%d-%m-%Y %T'), b'1', 1);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('11-01-2020 00:00:00','%d-%m-%Y %T'), b'0', 1);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('11-01-2020 00:00:02','%d-%m-%Y %T'), b'1', 1);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('21-01-2020 00:00:00','%d-%m-%Y %T'), b'0', 1);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('10-02-2020 00:00:01','%d-%m-%Y %T'), b'1', 1);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('02-01-2020 00:00:00','%d-%m-%Y %T'), b'1', 2);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('12-01-2020 00:00:00','%d-%m-%Y %T'), b'0', 2);
INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('22-01-2020 00:00:01','%d-%m-%Y %T'), b'1', 2);
UPDATE Etat SET positif = b'1' WHERE idUtilisateur = 1; -- Fail : chaque état correspond à une nouvelle ligne dans la table Etat et pas à une mise à jour de la table
SELECT * FROM NotificationContamination;

--
-- Tests des signalements (demandes d'amis)
--
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(4, 2);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(5, 2);
CALL accepter_ami(2, 4); -- L'utilisateur 2 étant actuellement infecté, l'utilisateur 4 va recevoir une notification indiquant que son ami est infecté
CALL accepter_ami(2, 5); -- L'utilisateur 2 étant actuellement infecté, l'utilisateur 5 va recevoir une notification indiquant que son ami est infecté
CALL supprimer_refuser_ami(2, 4);
CALL supprimer_refuser_ami(2, 5);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(4, 2);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(5, 2);
CALL accepter_ami(2, 4); -- Une notification ayant déjà été émise, la notification d'infection concernant l'ami 2 ne sera pas ré-émise
CALL accepter_ami(2, 5); -- Une notification ayant déjà été émise, la notification d'infection concernant l'ami 2 ne sera pas ré-émise
SELECT * FROM NotificationContamination;

CALL supprimer_refuser_ami(2, 4);
CALL supprimer_refuser_ami(2, 5);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(4, 2);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(5, 2);
CALL accepter_ami(2, 4); -- L'utilisateur 4 étant déjà informé, l'utilisateur 4 ne va pas recevoir de notification
CALL accepter_ami(2, 5); -- L'utilisateur 5 étant déjà informé, l'utilisateur 5 ne va pas recevoir de notification
SELECT * FROM NotificationContamination; -- 18 notifications


--
-- Création des activités (lieux non contaminés)
--
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 01:00', '%d-%m-%Y %T'), 3, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 01:01', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 02:00', '%d-%m-%Y %T'), 3, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 04:32', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 23:59', '%d-%m-%Y %T'), 3, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-12-2020 04:32', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 23:59', '%d-%m-%Y %T'), 3, 3);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-12-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 03:00', '%d-%m-%Y %T'), 4, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-12-2020 05:00', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 07:00', '%d-%m-%Y %T'), 4, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-12-2020 05:00', '%d-%m-%Y %T'), STR_TO_DATE('23-12-2020 07:00', '%d-%m-%Y %T'), 5, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('22-12-2020 05:00', '%d-%m-%Y %T'), STR_TO_DATE('22-12-2020 23:59', '%d-%m-%Y %T'), 5, 3);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('25-12-2020 05:40', '%d-%m-%Y %T'), STR_TO_DATE('25-12-2020 07:10', '%d-%m-%Y %T'), 6, 3);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-12-2020 02:30', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 03:00', '%d-%m-%Y %T'), 3, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 22:30', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 01:00', '%d-%m-%Y %T'), 6, 3);
SELECT * FROM NotificationContamination; -- 18 notifications

-- Fails : activités déjà existantes, lieu/utilisateur inexistant données incohérentes
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(NULL, STR_TO_DATE('23-12-2020 01:00','%d-%m-%Y %T'), 2, 1); -- Fail : NULL non accepté
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-12-2020 01:00', '%d-%m-%Y %T'), NULL, 1, 1); -- Fail : NULL non accepté
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-12-2020 00:00', '%d-%m-%Y %T'), NULL, 1, 1); -- Fail : NULL non accepté
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-12-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('23-12-2020 01:00', '%d-%m-%Y %T'), -1, 1); -- Fail : utilisateur -1 inexistant
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-12-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('23-12-2020 01:00', '%d-%m-%Y %T'), 1, -1); -- Fail : utilisateur -1 inexistant
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-12-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('23-12-2020 01:00', '%d-%m-%Y %T'), -1, -1); -- Fail : utilisateur -1 inexistant
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 00:01', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 01:00', '%d-%m-%Y %T'), 3, 1); -- Fail : activité déjà existante pour l'utilisateur 3 à cette date et à l'heure 00:00
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('19-12-2020 23:59', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 01:00', '%d-%m-%Y %T'), 3, 1); -- Fail : activité déjà existante pour l'utilisateur 3 dans cette période le 20/12/2020
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 02:02', '%d-%m-%Y %T'), 3, 1); -- Fail : activité déjà existante entre les deux dates pour l'utilisateur 3
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 01:02', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 03:00', '%d-%m-%Y %T'), 3, 1); -- Fail : activité déjà existante pour l'utilisateur 3 dans cette période le 20/12/2020
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('19-12-2020 22:59', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 03:00', '%d-%m-%Y %T'), 3, 1); -- Fail : activité déjà existante pour l'utilisateur 3 dans cette période le 20/12/2020
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('19-12-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('19-12-2020 01:00', '%d-%m-%Y %T'), 3, 1); -- Fail : l'heure de début ne peut pas être égale à l'heure de fin
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('19-12-2020 01:01', '%d-%m-%Y %T'), STR_TO_DATE('19-12-2020 01:00', '%d-%m-%Y %T'), 3, 1); -- Fail : une activité existe déjà le 20/12/2020 à 00:00 pour cet utilisateur
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('17-02-1998 01:00', '%d-%m-%Y %T'), STR_TO_DATE('17-02-1998 01:01', '%d-%m-%Y %T'), 3, 1); -- Fail : la date de l'activité ne peut pas être inférieure à la date de naissance de l'utilisateur
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('19-02-1998 01:00', '%d-%m-%Y %T'), STR_TO_DATE('19-02-1998 01:01', '%d-%m-%Y %T'), 3, 1); -- Fail : la date de l'activité ne peut pas être inférieure à la date de début de l'épidémie de COVID-19 (17/11/2019)
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('18-12-2020 22:50', '%d-%m-%Y %T'), STR_TO_DATE('18-12-2020 01:00', '%d-%m-%Y %T'), 6, 3); -- Fail : l'heure de début ne peut pas être supérieure à l'heure de fin
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('18-12-2020 22:50', '%d-%m-%Y %T'), STR_TO_DATE('18-12-2020 23:00', '%d-%m-%Y %T'), 6, -1); -- Fail : lieu inexistant
-- Ces activités ayant déjà été créés, elles ne peuvent pas être recréées.
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 01:00', '%d-%m-%Y %T'), 3, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 01:01', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 02:00', '%d-%m-%Y %T'), 3, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 04:32', '%d-%m-%Y %T'), STR_TO_DATE('20-12-2020 23:59', '%d-%m-%Y %T'), 3, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-12-2020 04:32', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 23:59', '%d-%m-%Y %T'), 3, 3);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-12-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 03:00', '%d-%m-%Y %T'), 4, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-12-2020 05:00', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 07:00', '%d-%m-%Y %T'), 4, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-12-2020 05:00', '%d-%m-%Y %T'), STR_TO_DATE('23-12-2020 07:00', '%d-%m-%Y %T'), 5, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('22-12-2020 05:00', '%d-%m-%Y %T'), STR_TO_DATE('22-12-2020 23:59', '%d-%m-%Y %T'), 5, 3);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('25-12-2020 05:40', '%d-%m-%Y %T'), STR_TO_DATE('25-12-2020 07:10', '%d-%m-%Y %T'), 6, 3);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-12-2020 02:30', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 03:00', '%d-%m-%Y %T'), 3, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-12-2020 22:30', '%d-%m-%Y %T'), STR_TO_DATE('21-12-2020 01:00', '%d-%m-%Y %T'), 6, 3);
DELETE FROM Activite WHERE idUtilisateur = 6 OR idUtilisateur = 5; -- Nécessaire pour les tests suivants sur la contamination des lieux

--
-- Création des activités (lieux contaminés, tests multiples)
--
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('22-01-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('22-01-2020 07:00', '%d-%m-%Y %T'), 1, 2); -- Le dernier état a été déclaré le 10/02/2020, donc aucune notification ne sera émise
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('10-01-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('10-01-2020 07:00', '%d-%m-%Y %T'), 3, 2); -- L'utilisateur n'est pas positif et ne rentre dans aucune période de contamination d'autres utilisateurs, aucune notification n'est émise
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('01-02-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('03-02-2020 02:30', '%d-%m-%Y %T'), 6, 2); -- L'utilisateur n'est pas positif et ne rentre dans aucune période de contamination d'autres utilisateurs, aucune notification n'est émise. De plus, il a déjà été informé de la contamination.
SELECT * FROM NotificationContamination; -- 18 notifications
/* Tous les amis de l'utilisateur 1 sont déjà avertis qu'il est positif à cet état, aucune notification ne sera émise pour ses amis (2, 3, 4, 6).
*/
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('02-02-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('03-02-2020 01:30', '%d-%m-%Y %T'), 1, 2);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-01-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('24-01-2020 01:30', '%d-%m-%Y %T'), 1, 2);
SELECT * FROM NotificationContamination; -- 18 notifications car utilisateur 6 déjà averti

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('29-01-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('29-01-2020 01:32', '%d-%m-%Y %T'), 6, 2); -- L'utilisateur n'est pas positif et rentre dans aucune période de contamination de l'utilisateur 1, aucune notification n'est émise pour l'utilisateur 6.
SELECT * FROM NotificationContamination; -- 18 notifications

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-01-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('20-01-2020 05:00', '%d-%m-%Y %T'), 6, 2); -- Aucun utilisateur contaminé n'a fréquenté ce lieu pendant cette période, aucune notification n'est émise
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('24-01-2020 00:00', '%d-%m-%Y %T'), STR_TO_DATE('24-01-2020 07:00', '%d-%m-%Y %T'), 6, 3); -- Aucun utilisateur contaminé n'a fréquenté ce lieu pendant cette période, aucune notification n'est émise
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-01-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('24-01-2020 00:01', '%d-%m-%Y %T'), 4, 3); -- Le lieu a été fréquenté par l'utilisateur 6 sur cette période, mais l'utilisateur 6 n'est pas positif
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('26-01-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('26-01-2020 03:00', '%d-%m-%Y %T'), 5, 3); -- Le lieu n'a été fréquenté par personne à cet instant, aucune notification ne sera émise
SELECT * FROM NotificationContamination; -- 18 notifications

INSERT INTO Etat(dateEtat, idUtilisateur) VALUES(STR_TO_DATE('03-02-2020 10:00','%d-%m-%Y %T'), 6); -- L'utilisateur 6 est positif, celui-ci a l'utilisateur 1 en ami : il est informé. L'utilisateur 4 est averti étant donné qu'il est cas contact
SELECT * FROM NotificationContamination; -- 20 notifications

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('25-01-2020 20:00', '%d-%m-%Y %T'), STR_TO_DATE('26-01-2020 04:00', '%d-%m-%Y %T'), 6, 3); -- L'utilisateur 5 est informé car il a possiblement fréquenté l'utilisateur 6 sur cette période
SELECT * FROM NotificationContamination; -- 21 notifications

INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES('TestNom7', 'TestPrenom7', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin7', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal');
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(7, 6);
CALL accepter_ami(6, 7); -- L'utilisateur 7 va être informé de la contamination de l'utilisateur 6
SELECT * FROM NotificationContamination; -- 22 notifications

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-01-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('25-01-2020 01:45', '%d-%m-%Y %T'), 7, 3); -- L'utilisateur 7 n'est pas positif et a déjà été informé de la contamination de l'utilisateur 6, aucune notification ne sera émise
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(7, 5);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(4, 5);
CALL accepter_ami(5, 7); -- Aucune notification
CALL accepter_ami(4, 5); -- Aucune notification
SELECT * FROM NotificationContamination; -- 22 notifications

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('11-02-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('23-02-2020 01:45', '%d-%m-%Y %T'), 4, 4);
INSERT INTO Etat(dateEtat, positif,  idUtilisateur) VALUES(STR_TO_DATE('20-02-2020 00:00:00','%d-%m-%Y %T'), b'0', 1); -- Aucune notification
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('29-01-2020 05:30','%d-%m-%Y %T'), STR_TO_DATE('22-02-2020 01:45','%d-%m-%Y %T'), 5, 4);
SELECT * FROM NotificationContamination; -- 22 notifications

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('22-02-2020 01:30','%d-%m-%Y %T'), STR_TO_DATE('22-02-2020 07:30','%d-%m-%Y %T'), 1, 4); -- Aucune notification pour l'instant
INSERT INTO Etat(dateEtat,  idUtilisateur) VALUES(STR_TO_DATE('25-02-2020 00:01','%d-%m-%Y %T'), 1); -- Les amis de l'utilisateurs 1 (2, 3, 4, 6) sont prévenus, l'utilisateur 5 également car il a possiblement fréquenté l'utilisateur 1 sur la même période
SELECT * FROM NotificationContamination; -- 27 notifications

INSERT INTO Etat(dateEtat,  idUtilisateur) VALUES(STR_TO_DATE('23-02-2020 07:00','%d-%m-%Y %T'), 5); -- Les amis de l'utilisateur 5 (7, 4, 2) sont prévenus. L'utilisateur 1 est également prévenu car il a possiblement fréquenté l'utilisateur 5 sur la même période
SELECT * FROM NotificationContamination; -- 31 notifications

INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES('TestNom8', 'TestPrenom8', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin8', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal'); -- Utilisateur 8
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES('TestNom9', 'TestPrenom9', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin9', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal'); -- Utilisateur 9
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES('TestNom10', 'TestPrenom10', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin10', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal'); -- Utilisateur 10
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES('TestNom11', 'TestPrenom10', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin11', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'normal'); -- Utilisateur 11

INSERT INTO Lieu(nom, adresse) VALUES('TestContamineNV', 'Test');

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('10-01-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('10-01-2020 01:45', '%d-%m-%Y %T'), 8, 5);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('20-02-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('22-02-2020 01:45', '%d-%m-%Y %T'), 8, 5);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('25-02-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('25-02-2020 10:45', '%d-%m-%Y %T'), 8, 5);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('23-02-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('23-02-2020 10:45', '%d-%m-%Y %T'), 9, 5);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-02-2020 15:00', '%d-%m-%Y %T'), STR_TO_DATE('23-02-2020 17:45', '%d-%m-%Y %T'), 10, 5);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('21-02-2020 15:00', '%d-%m-%Y %T'), STR_TO_DATE('23-02-2020 17:45', '%d-%m-%Y %T'), 11, 5);

INSERT INTO Etat(dateEtat, idUtilisateur) VALUES(STR_TO_DATE('29-02-2020 10:00','%d-%m-%Y %T'), 8); -- Notification pour l'utiisateur 11 et 10
SELECT * FROM NotificationContamination; -- 33 notifications

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('10-01-2020 01:00', '%d-%m-%Y %T'), STR_TO_DATE('10-01-2020 10:45', '%d-%m-%Y %T'), 9, 5); -- Aucune notification car délai de 10 jours dépassé
SELECT * FROM NotificationContamination; -- 33 notifications

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('22-02-2020 01:40', '%d-%m-%Y %T'), STR_TO_DATE('23-02-2020 00:01', '%d-%m-%Y %T'), 9, 5); -- Notification pour l'utilisateur 9 car ayant fréquenté l'utilisateur 8 contaminé
SELECT * FROM NotificationContamination; -- 34 notifications

INSERT INTO Etat(dateEtat,  idUtilisateur) VALUES(STR_TO_DATE('23-02-2020 17:46','%d-%m-%Y %T'), 11); -- Les utilisateurs 10, 9, 8 vont être notifiés car ayant fréquenté le lieu en même temps que l'utilisateur 11
SELECT * FROM NotificationContamination; -- 37 notifications

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('17-02-2020 15:00', '%d-%m-%Y %T'), STR_TO_DATE('20-02-2020 17:45', '%d-%m-%Y %T'), 11, 5); -- L'utilisateur 11 a déjà été notifié, aucune notification n'est donc émise
SELECT * FROM NotificationContamination; -- 37 notifications

INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(STR_TO_DATE('10-03-2020 07:00', '%d-%m-%Y %T'), b'0', 8);
INSERT INTO Etat(dateEtat, idUtilisateur) VALUES(STR_TO_DATE('15-03-2020 07:00', '%d-%m-%Y %T'), 8); -- Aucun ami pour l'instant pour l'utilisateur 8, aucune notification
SELECT * FROM NotificationContamination; -- 37 notifications

INSERT INTO Ami(idUtilisateur, idAmi) VALUES(8, 11);
CALL accepter_ami(11, 8); -- L'utilisateur 11 est notifié de la contamination de l'utilisateur 8
SELECT * FROM NotificationContamination; -- 38 notifications

CALL supprimer_refuser_ami(11, 8);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(8, 11);
CALL accepter_ami(11, 8); -- Notification déjà émise, elle n'est pas ré-émise
SELECT * FROM NotificationContamination; -- 38 notifications

INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('11-03-2020 15:00', '%d-%m-%Y %T'), STR_TO_DATE('12-03-2020 17:45', '%d-%m-%Y %T'), 8, 5); -- Aucune notification car ami 11 déjà prévenu
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('11-03-2020 15:00', '%d-%m-%Y %T'), STR_TO_DATE('11-03-2020 15:01', '%d-%m-%Y %T'), 10, 5); -- Notification émise car nouvel état et l'utilisateur 10 a sûrement fréquenté l'utilisateur 8
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('17-02-2020 15:00', '%d-%m-%Y %T'), STR_TO_DATE('21-02-2020 14:59', '%d-%m-%Y %T'), 9, 5); -- Aucune notification émise car notification déjà émise pour l'utilisateur 9
SELECT * FROM NotificationContamination; -- 39 notifications

INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestAdminNom', 'TestAdminPrenom', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestAdmin', '$2a$10$N7fxw09Q62FXdBw3rcGqOOisf0m0A0oiaTdO3vDp6ElQmZivEkXtu', 'admin');

COMMIT;