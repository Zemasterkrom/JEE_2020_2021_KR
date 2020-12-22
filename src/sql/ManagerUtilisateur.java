package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import bean.Utilisateur;

/**
 * 
 * @author Th�o Roton
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
	 * M�thode qui permet d'ajouter un utilisateur dans la bdd
	 * @param nom de l'utilisateur
	 * @param prenom de l'utilisateur
	 * @param dateNaiss de l'utilisateur
	 * @param login de l'utilisateur
	 * @param motDePasse de l'utilisateur
	 */
	public void ajouterUtilisateur(String nom, String prenom, Date dateNaiss, String login, String motDePasse) {
		try {
			//Requ�te
			String req = "INSERT INTO Utilisateur (nom, prenom, dateNaiss, login, motDePasse, rang) VALUES (?, ?, ?, ?, ?, 'normal')";
			//Pr�paration de la requ�te
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout des informations � la requ�te
			stmt.setString(1, nom);
			stmt.setString(2, prenom);
			stmt.setDate(3, new java.sql.Date(dateNaiss.getTime()));
			stmt.setString(4, login);
			//Hashage du mot de passe
			String mdp = BCrypt.hashpw(motDePasse, BCrypt.gensalt());
			stmt.setString(5, mdp);	
			
			//Ex�cution  de la requ�te
			stmt.execute();			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * M�thode pour v�rifier si un utilisateur existe d�j� � l'aide
	 * de son login.
	 * @param login : login de l'utilisateur
	 * @return true si l'utilisateur existe d�j�
	 */
	public boolean verifierUtilisateurPresent(String login) {
		boolean res = false;
	
		try {
			//Requ�te
			String req = "SELECT count(*) FROM Utilisateur WHERE login = ?";
			//Pr�paration de la requ�te
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout du login � la requ�te
			stmt.setString(1, login);
			//Ex�cution  de la requ�te
			ResultSet results = stmt.executeQuery();
			
			//R�cup�ration du r�sultat
			results.next();
			int count = results.getInt(1);
			//Si le count est diff�rent de z�ro, alors l'utilisateur exist� d�j�
			if (count != 0) {
				res = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * M�thode qui permet de r�cup�rer un utilisateur dans la BDD
	 * @param login
	 * @return
	 */
	public Utilisateur getUtilisateur(String login) {
		Utilisateur utilisateur = new Utilisateur();
		
		try {
			//Requ�te
			String req = "SELECT * FROM Utilisateur WHERE login = ?";
			//Pr�paration de la requ�te
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout du login � la requ�te
			stmt.setString(1, login);
			//Ex�cution  de la requ�te
			ResultSet results = stmt.executeQuery();
			
			//R�cup�ration du r�sultat
			results.next();
			
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
}
