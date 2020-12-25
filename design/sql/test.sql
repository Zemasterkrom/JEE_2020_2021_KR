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
SET SQL_SAFE_UPDATES = 1;

--
-- Création des utilisateurs
--
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom1', 'TestPrenom1', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin1', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom2', 'TestPrenom2', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin2', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom3', 'TestPrenom3', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin3', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom4', 'TestPrenom4', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin4', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom5', 'TestPrenom5', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin5', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');

-- Fails : données incohérentes (champs vides, données NULL, valeurs incorrectes)
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom4', 'TestPrenom4', 'DateIncorrecte', 'TestLogin4', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'Te', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal'); -- Taille du login < 3 caractères
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES (NULL, 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', '', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', NULL, STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('', '', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES (NULL, NULL, STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', NULL, 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), '', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), NULL, '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', NULL, 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), '', '', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), NULL, NULL, 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', '');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', NULL);
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestOK', 'TestOK', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin', '$2a$10$NH8PBAHX9VqThLW8.CAQRujJMDgLb8g5N3xpy9d37aUH5cIdNJSgq', 'inconnu');

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
INSERT INTO Lieu(nom, adresse, longitude, latitude) VALUES('TestPositionGPS', 'Test', 48.692054, 6.184417);

-- Fails : données des lieux incohérentes ou lieux déjà existants
INSERT INTO Lieu(nom, adresse) VALUES('', 'Test');
INSERT INTO Lieu(nom, adresse) VALUES(NULL, 'Test');
INSERT INTO Lieu(nom, adresse) VALUES('Test', '');
INSERT INTO Lieu(nom, adresse) VALUES('Test', NULL);
INSERT INTO Lieu(nom, adresse) VALUES('TestNonContamine', 'Test'); -- Fail : lieu déjà existant
INSERT INTO Lieu(nom, adresse, longitude, latitude) VALUES('TestPositionGPSIncorrecte', 'Test', -180.01, 6.184417); -- Fail : longitude incorrecte
INSERT INTO Lieu(nom, adresse, longitude, latitude) VALUES('TestPositionGPSIncorrecte', 'Test', 180.01, 6.184417); -- Fail : longitude incorrecte
INSERT INTO Lieu(nom, adresse, longitude, latitude) VALUES('TestPositionGPSIncorrecte', 'Test', 48.692054, -90.01); -- Fail : latitude incorrecte
INSERT INTO Lieu(nom, adresse, longitude, latitude) VALUES('TestPositionGPSIncorrecte', 'Test', 48.692054, 90.01); -- Fail : latitude incorrecte
INSERT INTO Lieu(nom, adresse, longitude, latitude) VALUES('TestPositionGPSIncorrecte', 'Test', -180.01, -90.01); -- Fail : longitude et latitude incorrectes
INSERT INTO Lieu(nom, adresse, longitude, latitude) VALUES('TestPositionGPSIncorrecte', 'Test', -180.01, -90.01); -- Fail : longitude et latitude incorrectes
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
