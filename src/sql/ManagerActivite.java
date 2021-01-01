package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Activite;
import exception.AppException;
import exception.FormAppException;
import exception.SevereAppException;

/**
 * 
 * @author Théo Roton, Raphaël Kimm
 * Classe ManagerActivite
 */
public class ManagerActivite extends Manager {

	/**
	 * Constructeur de la classe ManagerActivite
	 * @param request Objet associé à la requête HTTP actuelle
	 * @param response Objet associé à la réponse HTTP
	 * @throws AppException
	 */
	public ManagerActivite(HttpServletRequest request, HttpServletResponse response) throws AppException  {
		super(request, response);
	}
	
	/**
	 * Méthode qui permet de récupérer toutes les activités d'un utilisateur
	 * @param id de l'utilisateur dont on veut récupérer les activités
	 * @return liste des activités de l'utilisateur
	 * @throws SevereAppException 
	 */
	public List<Activite> getActivitesUtilisateur(int id) throws AppException {
		//Initialisation de la liste
		List<Activite> activites = new ArrayList<Activite>();
		
		try {
			//Requête
			String req = "SELECT * FROM Activite WHERE idUtilisateur=?";
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			
			//Récupération des activités
			activites = getAllActivites(stmt);
			
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
		
		return activites;
	}
	
	/**
	 * Méthode qui permet de récupérer toutes les activités d'un lieu
	 * @param id du lieu dont on veut récupérer les activités
	 * @return liste des activités du lieu
	 * @throws SevereAppException 
	 */
	public List<Activite> getActivitesLieu(int id) throws AppException {
		//Initialisation de la liste
		List<Activite> activites = new ArrayList<Activite>();
		
		try {
			//Requête
			String req = "SELECT * FROM Activite WHERE idLieu=?";
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			
			//Récupération des activités
			activites = getAllActivites(stmt);
			
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
		
		return activites;
	}
	
	/**
	 * Méthode qui permet de récupérer toutes les activités
	 * @param stmt requête pour récupérer toutes les activités
	 * @return liste des activités
	 * @throws SevereAppException 
	 */
	public List<Activite> getAllActivites(PreparedStatement stmt) throws AppException {
		//Initialisation de la liste
		List<Activite> activites = new ArrayList<Activite>();
				
		try {
			//Exécution de la requête
			ResultSet results = stmt.executeQuery();
					
			Activite a;
			//Pour chaque activité
			while (results.next()) {
				a = new Activite();
					
				//Ajout des informations de l'activité
				a.setId(results.getInt("idActivite"));
				a.setDateDebut(results.getTimestamp("dateDebut"));
				a.setDateFin(results.getTimestamp("dateFin"));
				a.setIdUtilisateur(results.getInt("idUtilisateur"));
				a.setIdLieu(results.getInt("idLieu"));
						
				//Ajout de l'activité à la liste
				activites.add(a);
			}
			
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
				
		return activites;
	}
	
	/**
	 * Méthode qui permet de supprimer une activité
	 * @param id de l'activité à supprimer
	 * @throws SevereAppException 
	 */
	public void supprimerActivite(int id) throws AppException {
		try {
			//Requête
			String req = "DELETE FROM Activite WHERE idActivite=?";
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			//Exécution  de la requête
			stmt.execute();	
			
		} catch (SQLException e) {
			throw new FormAppException(e, this.request, this.response);
		}
	}
}
