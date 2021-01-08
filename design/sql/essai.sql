--
-- Fichier de base permettant d'insérer des données pour tester plus rapidement le site
-- Note : à exécuter après la création des tables et des triggers
--

--
-- Suppression des données des tables pour le test
--
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

DELETE FROM Utilisateur;
DELETE FROM Lieu;
DELETE FROM Activite;
DELETE FROM Ami;
DELETE FROM Etat;
DELETE FROM NotificationAmi;
DELETE FROM NotificationContamination;

ALTER TABLE Utilisateur AUTO_INCREMENT = 1;
ALTER TABLE Lieu AUTO_INCREMENT = 1;
ALTER TABLE Activite AUTO_INCREMENT = 1;
ALTER TABLE Ami AUTO_INCREMENT = 1;
ALTER TABLE Etat AUTO_INCREMENT = 1;
ALTER TABLE NotificationAmi AUTO_INCREMENT = 1;
ALTER TABLE NotificationContamination AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;

--
-- Création des utilisateurs. Mot de passe : MotDePasse
--
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom1', 'TestPrenom1', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin1', '$2a$10$sLehEBiHfGOFEcWGU5ikP.WEi/mLCrdaEtE9beReZK//5MaJ8dQd2', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom2', 'TestPrenom2', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin2', '$2a$10$sLehEBiHfGOFEcWGU5ikP.WEi/mLCrdaEtE9beReZK//5MaJ8dQd2', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNom3', 'TestPrenom3', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestLogin3', '$2a$10$sLehEBiHfGOFEcWGU5ikP.WEi/mLCrdaEtE9beReZK//5MaJ8dQd2', 'normal');
INSERT INTO Utilisateur(nom, prenom, dateNaiss, login, motDePasse, rang) VALUES ('TestNomAdmin', 'TestPrenomAdmin', STR_TO_DATE('18-02-1998','%d-%m-%Y'), 'TestAdmin', '$2a$10$sLehEBiHfGOFEcWGU5ikP.WEi/mLCrdaEtE9beReZK//5MaJ8dQd2', 'admin');

--
-- Création des lieux
--
INSERT INTO Lieu(nom, adresse) VALUES('Lieu1', 'Adresse1');
INSERT INTO Lieu(nom, adresse) VALUES('Lieu2', 'Adresse2');
INSERT INTO Lieu(nom, adresse) VALUES('Lieu3', 'Adresse3');

--
-- Création des demandes d'amis (non acceptées)
--
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(1, 2);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(1, 4);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(2, 3);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(2, 4);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(3, 1);
INSERT INTO Ami(idUtilisateur, idAmi) VALUES(4, 3);


--
-- Création des activités
--
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('07-01-2021 00:00', '%d-%m-%Y %T'), STR_TO_DATE('07-01-2021 01:00', '%d-%m-%Y %T'), 1, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('05-01-2021 00:00', '%d-%m-%Y %T'), STR_TO_DATE('07-01-2021 15:00', '%d-%m-%Y %T'), 2, 1);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('08-01-2020 15:00', '%d-%m-%Y %T'), STR_TO_DATE('08-01-2021 15:30', '%d-%m-%Y %T'), 3, 2);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('19-12-2020 12:00', '%d-%m-%Y %T'), STR_TO_DATE('19-12-2020 13:30', '%d-%m-%Y %T'), 4, 2);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('02-01-2020 12:10', '%d-%m-%Y %T'), STR_TO_DATE('03-01-2021 12:20', '%d-%m-%Y %T'), 2, 2);
INSERT INTO Activite(dateDebut, dateFin, idUtilisateur, idLieu) VALUES(STR_TO_DATE('04-01-2021 10:00', '%d-%m-%Y %T'), STR_TO_DATE('04-01-2021 20:00', '%d-%m-%Y %T'), 2, 3);
