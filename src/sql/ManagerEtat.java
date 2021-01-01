package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Etat;
import exception.AppException;
import exception.FormAppException;
import exception.SevereAppException;

/**
 * 
 * @author Théo Roton, Raphaël Kimm
 * Classe ManagerEtat
 */
public class ManagerEtat extends Manager {

	/**
	 * Constructeur de la classe ManagerEtat
	 * @param request Objet associé à la requête HTTP actuelle
	 * @param response Objet associé à la réponse HTTP
	 * @throws AppException
	 */
	public ManagerEtat(HttpServletRequest request, HttpServletResponse response) throws AppException  {
		super(request, response);
	}
	
	/**
	 * Méthode qui permet d'obtenir le dernier état d'un utilisateur
	 * @param id de l'utilisateur
	 * @return true si positif, false sinon
	 * @throws SevereAppException 
	 */
	public Etat obtenirDernierEtat(int idUtilisateur) throws AppException {
		Etat e = new Etat();
		e.setId(-1);
		
		try {
			//Requête
			String req = "SELECT * FROM Etat WHERE idUtilisateur=? ORDER BY idEtat DESC LIMIT 1";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			//Ajout de l'id à la requête
			stmt.setInt(1, idUtilisateur);
			
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
				e.setId(rs.getInt("idEtat"));
				e.setDateEtat(rs.getTimestamp("dateEtat"));
				e.setPositif(rs.getBoolean("positif"));
			}
			
		} catch (SQLException ex) {
			throw new FormAppException(ex, this.request, this.response);
		}
		
		return e;
	}
	
	/**
	 * Méthode qui permet d'obtenir le nombre de jours restant avant de nouveau pouvoir déclarer un état positif
	 * @param id de l'utilisateur
	 * @throws SevereAppException 
	 */
	public int obtenirNbJoursRestant(int idUtilisateur) throws AppException {
		int nbJours = 0;
		
		try {
			//Requête
			String req = "SELECT DATEDIFF(DATE(dateEtat) + 10, CURRENT_DATE()) FROM Etat WHERE idUtilisateur=? ORDER BY idEtat DESC LIMIT 1";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			//Ajout de l'id à la requête
			stmt.setInt(1, idUtilisateur);
			
			ResultSet rs = stmt.executeQuery();
			
			// Obtention de la différence
			if (rs.next()) {
				nbJours = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
		
		return nbJours;
	}
	
	/**
	 * Méthode qui permet de mettre à jour l'état d'un utilisateur en positif
	 * @param id de l'utilisateur Id de l'utilisateur dont l'état doit être modifié
	 * @throws SevereAppException 
	 */
	public int majEtatPositif(int idUtilisateur) throws AppException {
		int nbJours = 0;
		
		try {
			//Requête
			String req = "INSERT INTO Etat(dateEtat, positif, idUtilisateur) VALUES(CURRENT_TIMESTAMP(), 1, ?)";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			//Ajout de l'id à la requête
			stmt.setInt(1, idUtilisateur);
			
			// Exécution de la requête
			stmt.executeUpdate();
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
		
		return nbJours;
	}
	
	
}
