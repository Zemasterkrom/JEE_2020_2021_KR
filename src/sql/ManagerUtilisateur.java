package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import bean.Utilisateur;

/**
 * 
 * @author Théo Roton
 * Classe ManagerUtilisateur
 */
public class ManagerUtilisateur extends Manager {

	/**
	 * Constructeur de la classe ManagerUtilisateur
	 */
	public ManagerUtilisateur() {
		super();
	}
	
	/**
	 * Méthode qui permet d'ajouter un utilisateur dans la bdd
	 * @param nom de l'utilisateur
	 * @param prénom de l'utilisateur
	 * @param dateNaiss de l'utilisateur
	 * @param login de l'utilisateur
	 * @param motDePasse de l'utilisateur
	 */
	public void ajouterUtilisateur(String nom, String prenom, Date dateNaiss, String login, String motDePasse) {
		try {
			//Requête
			String req = "INSERT INTO Utilisateur (nom, prenom, dateNaiss, login, motDePasse, rang) VALUES (?, ?, ?, ?, ?, 'normal')";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout des informations à la requête
			stmt.setString(1, nom);
			stmt.setString(2, prenom);
			stmt.setDate(3, new java.sql.Date(dateNaiss.getTime()));
			stmt.setString(4, login);
			//Hashage du mot de passe
			String mdp = BCrypt.hashpw(motDePasse, BCrypt.gensalt());
			stmt.setString(5, mdp);	
			
			//Exécution  de la requête
			stmt.execute();			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Méthode pour vérifier si un utilisateur existe déjà à l'aide
	 * de son login.
	 * @param login : login de l'utilisateur
	 * @return true si l'utilisateur existe déjà
	 */
	public boolean verifierUtilisateurPresent(String login) {
		boolean res = false;
	
		try {
			//Requête
			String req = "SELECT count(*) FROM Utilisateur WHERE login = ?";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout du login à la requête
			stmt.setString(1, login);
			//Exécution  de la requête
			ResultSet results = stmt.executeQuery();
			
			//Récupération du résultat
			results.next();
			int count = results.getInt(1);
			//Si le count est différent de zéro, alors l'utilisateur existé déjà
			if (count != 0) {
				res = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * Méthode qui permet de récupérer un utilisateur dans la BDD
	 * @param login
	 * @return
	 */
	public Utilisateur getUtilisateur(String login) {
		//Création de l'utilisateur
		Utilisateur utilisateur = new Utilisateur();
		
		try {
			//Requête
			String req = "SELECT * FROM Utilisateur WHERE login = ?";
			//Pr�paration de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout du login � la requête
			stmt.setString(1, login);
			//Exécution de la requête
			ResultSet results = stmt.executeQuery();
			
			//Récupération du résultat
			results.next();
			
			//Ajout des informations de l'utilisateur
			utilisateur.setId(results.getInt("idUtilisateur"));
			utilisateur.setNom(results.getString("nom"));
			utilisateur.setPrenom(results.getString("prenom"));
			utilisateur.setDateNaiss(results.getDate("dateNaiss"));
			utilisateur.setLogin(results.getString("login"));
			utilisateur.setMotDePasse(results.getString("motDePasse"));
			utilisateur.setRang(results.getString("rang"));
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return utilisateur;
	}

	public void modifierUtilisateur(int id, String nom, String prenom, Date dateNaiss, String login) {
		try {
			//Requête
			String req = "UPDATE Utilisateur SET nom=?, prenom=?, dateNaiss=?, login=? WHERE idUtilisateur=?";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout des informations à la requête
			stmt.setString(1, nom);
			stmt.setString(2, prenom);
			stmt.setDate(3, new java.sql.Date(dateNaiss.getTime()));
			stmt.setString(4, login);
			stmt.setInt(5, id);	
			
			//Exécution  de la requête
			stmt.execute();			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
}
