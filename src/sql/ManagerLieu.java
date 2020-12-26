package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Activite;
import bean.Lieu;
import bean.Utilisateur;

/**
 * 
 * @author Théo Roton
 * Classe ManagerLieu
 */
public class ManagerLieu extends Manager {

	/**
	 * Constructeur de la classe ManagerLieu
	 */
	public ManagerLieu() {
		super();
	}
	
	/**
	 * Méthode qui permet de récupérer tous les lieux de l'application
	 * @return liste des lieux de l'application
	 */
	public List<Lieu> getAllLieux() {
		//Initialisation de la liste
		List<Lieu> lieux = new ArrayList<Lieu>();
		//Création du manager des activités
		ManagerActivite manager = new ManagerActivite();
		
		try {
			//Requête
			String req = "SELECT * FROM Lieu";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Exécution de la requête
			ResultSet results = stmt.executeQuery();
			
			Lieu l;
			List<Activite> acts;
			//Pour chaque lieu
			while (results.next()) {
				l = new Lieu();
				
				//Ajout des informations du lieu
				l.setId(results.getInt("idLieu"));
				l.setNom(results.getString("nom"));
				l.setAdresse(results.getString("adresse"));				
				
				//Ajout des activités du lieu
				acts = manager.getActivitesLieu(l.getId());
				l.setActivites(acts);
				
				//Ajout de l'utilisateur à la liste
				lieux.add(l);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lieux;
	}
	
	/**
	 * Méthode qui permet de récupérer un lieu dans la BDD
	 * @param id du lieu
	 * @return lieu correspondant
	 */
	public Lieu getLieu(int id) {
		//Création du
		Lieu lieu = new Lieu();
		//Création de la liste des activités du lieu
		List<Activite> activites;
		//Création du manager des activités
		ManagerActivite manager = new ManagerActivite();
		
		try {
			//Requête
			String req = "SELECT * FROM Lieu WHERE idLieu=?";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Exécution de la requête
			ResultSet results = stmt.executeQuery();
				
			//Ajout des informations du lieu
			lieu.setId(results.getInt("idLieu"));
			lieu.setNom(results.getString("nom"));
			lieu.setAdresse(results.getString("adresse"));				
				
			//Ajout des activités du lieu
			activites = manager.getActivitesLieu(lieu.getId());
			lieu.setActivites(activites);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lieu;
	}
	
	/**
	 * Méthode qui permet de supprimer un lieu
	 * @param id du lieu à supprimer
	 */
	public void supprimerLieu(int id) {
		try {
			//Requête
			String req = "DELETE FROM Lieu WHERE idLieu=?";
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
	
	/**
	 * Méthode pour vérifier si un lieu peut être supprimé
	 * @param id : id du lieu
	 * @return true si le lieu peut être supprimé
	 */
	public boolean verifierLieuPeutEtreSupprimer(int id) {
		boolean res = false;
	
		try {
			//Requête
			String req = "SELECT count(*) FROM Lieu l INNER JOIN Activite a ON l.idLieu = a.idLieu WHERE l.idLieu=?";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			//Exécution  de la requête
			ResultSet results = stmt.executeQuery();
			
			//Récupération du résultat
			results.next();
			int count = results.getInt(1);
			//Si le count est égal à zéro, le lieu peut être supprimé
			if (count == 0) {
				res = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
}
