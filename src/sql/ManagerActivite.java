package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Activite;
import bean.Utilisateur;

/**
 * 
 * @author Théo Roton
 * Classe ManagerActivite
 */
public class ManagerActivite extends Manager {

	/**
	 * Constructeur de la classe ManagerActivite
	 */
	public ManagerActivite() {
		super();
	}
	
	/**
	 * Méthode qui permet de récupérer toutes les activités d'un utilisateur
	 * @param id de l'utilisateur dont on veut récupérer les activités
	 * @return liste des activités de l'utilisateur
	 */
	public List<Activite> getActivitesUtilisateur(int id) {
		//Initialisation de la liste
		List<Activite> activites = new ArrayList<Activite>();
		
		try {
			//Requête
			String req = "SELECT * FROM Activite WHERE idUtilisateur=?";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			
			//Récupération des activités
			activites = getAllActivites(stmt);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return activites;
	}
	
	/**
	 * Méthode qui permet de récupérer toutes les activités d'un lieu
	 * @param id du lieu dont on veut récupérer les activités
	 * @return liste des activités du lieu
	 */
	public List<Activite> getActivitesLieu(int id) {
		//Initialisation de la liste
		List<Activite> activites = new ArrayList<Activite>();
		
		try {
			//Requête
			String req = "SELECT * FROM Activite WHERE idLieu=?";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			
			//Récupération des activités
			activites = getAllActivites(stmt);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return activites;
	}
	
	/**
	 * Méthode qui permet de récupérer toutes les activités
	 * @param stmt requête pour récupérer toutes les activités
	 * @return liste des activités
	 */
	public List<Activite> getAllActivites(PreparedStatement stmt) {
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
					e.printStackTrace();
				}
				
				return activites;
	}
	
	/**
	 * Méthode qui permet de supprimer une activité
	 * @param id de l'activité à supprimer
	 */
	public void supprimerActivite(int id) {
		try {
			//Requête
			String req = "DELETE FROM Activite WHERE idActivite=?";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			//Exécution  de la requête
			stmt.execute();	
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
