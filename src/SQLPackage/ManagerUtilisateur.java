package SQLPackage;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

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
	 * @param prenom de l'utilisateur
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
}
