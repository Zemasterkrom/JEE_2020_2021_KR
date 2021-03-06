package sql;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Activite;
import bean.Lieu;
import exception.AppException;
import exception.FormAppException;
import exception.SevereAppException;

/**
 * 
 * @author Théo Roton, Raphaël Kimm
 * Classe ManagerLieu
 */
public class ManagerLieu extends Manager {

	/**
	 * Constructeur de la classe ManagerLieu
	 * @param request Objet associé à la requête HTTP actuelle
	 * @param response Objet associé à la réponse HTTP
	 * @throws AppException
	 */
	public ManagerLieu(HttpServletRequest request, HttpServletResponse response) throws AppException  {
		super(request, response);
	}
	
	/**
	 * Méthode qui permet de récupérer tous les lieux de l'application
	 * @return liste des lieux de l'application
	 * @throws IOException 
	 * @throws ServletException 
	 */
	public List<Lieu> getAllLieux() throws AppException  {
		//Initialisation de la liste
		List<Lieu> lieux = new ArrayList<Lieu>();
		//Création du manager des activités
		ManagerActivite manager = new ManagerActivite(this.request, this.response);
		
		try {
			//Requête
			String req = "SELECT * FROM Lieu";
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
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
			throw new SevereAppException(e, this.request, this.response);
		}
		
		return lieux;
	}
	
	/**
	 * Méthode qui permet de récupérer un lieu dans la BDD (sans ses activités)
	 * @param id du lieu
	 * @return lieu correspondant
	 * @throws SevereAppException 
	 */
	public Lieu getLieuSansActivites(int id) throws AppException {
		//Création du lieu
		Lieu lieu = new Lieu();
		lieu.setId(-1);
		
		try {
			//Requête
			String req = "SELECT * FROM Lieu WHERE idLieu=?";
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			//Exécution de la requête
			ResultSet results = stmt.executeQuery();
				
			//Récupération du résultat
			results.next();
			
			//Ajout des informations du lieu
			lieu.setId(results.getInt("idLieu"));
			lieu.setNom(results.getString("nom"));
			lieu.setAdresse(results.getString("adresse"));	
			
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
		
		if (lieu.getId() == -1) {
			throw new FormAppException("Le lieu est inexistant.", request, response);
		}
		
		return lieu;
	}
	
	/**
	 * Méthode qui permet d'obtenir un lieu
	 * @author Raphaël Kimm
	 * @param id Id du lieu
	 * @throws AppException 
	 */
	public Lieu obtenirLieu(int idLieu) throws AppException {
		Lieu l = new Lieu();
		l.setId(-1);
		
		try {
			//Requête
			String req = "SELECT * FROM Lieu WHERE idLieu = ?";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);

			//Ajout des paramètres à la requête
			stmt.setInt(1, idLieu);
			
			// Exécution de la requête
			ResultSet rs = stmt.executeQuery();
			
			// Obtention des résultats
			if (rs.next()) {
				l.setId(rs.getInt("idLieu"));
				l.setNom(rs.getString("nom"));
				l.setAdresse(rs.getString("adresse"));
			}
			
			//Exécution de la requête
			stmt.execute();	
		} catch (SQLException e) {
			throw new FormAppException(e, this.request, this.response);
		}
		
		if (l.getId() == -1) {
			throw new FormAppException("Le lieu est inexistant.", request, response);
		}
		
		return l;
	}
	
	/**
	 * Méthode qui permet de supprimer un lieu
	 * @param id du lieu à supprimer
	 * @throws SevereAppException 
	 */
	public void supprimerLieu(int id) throws AppException {
		try {
			//Requête
			String req = "DELETE FROM Lieu WHERE idLieu=?";
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
	
	/**
	 * Méthode pour vérifier si un lieu peut être supprimé
	 * @param id : id du lieu
	 * @return true si le lieu peut être supprimé
	 * @throws SevereAppException 
	 */
	public boolean verifierLieuPeutEtreSupprimer(int id) throws AppException {
		boolean res = false;
	
		try {
			//Requête
			String req = "SELECT count(*) FROM Lieu l INNER JOIN Activite a ON l.idLieu = a.idLieu WHERE l.idLieu=?";
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
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
			throw new SevereAppException(e, this.request, this.response);
		}
		
		return res;
	}
	
	/**
	 * Méthode qui permet d'ajouter un lieu
	 * @author Raphaël Kimm
	 * @param nom Nom du lieu
	 * @param adresse Adresse du lieu
	 * @throws AppException 
	 */
	public void ajouterLieu(String nom, String adresse) throws AppException {
		try {
			//Requête
			String req = "INSERT INTO Lieu(nom, adresse) VALUES(?,?)";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);

			//Ajout des paramètres à la requête
			stmt.setString(1, nom);
			stmt.setString(2, adresse);
			
			//Exécution de la requête
			stmt.execute();	
		} catch (SQLException e) {
			throw new FormAppException(e, this.request, this.response);
		}
	}
	
	/**
	 * Méthode qui permet de modifier un lieu
	 * @author Raphaël Kimm
	 * @param id Id du lieu
	 * @param nom Nom du lieu
	 * @param adresse Adresse du lieu
	 * @throws AppException 
	 */
	public void modifierLieu(int idLieu, String nom, String adresse) throws AppException {
		try {
			//Requête
			String req = "UPDATE Lieu SET nom = ?, adresse = ? WHERE idLieu = ?";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);

			//Ajout des paramètres à la requête
			stmt.setString(1, nom);
			stmt.setString(2, adresse);
			stmt.setInt(3, idLieu);
			
			//Exécution de la requête
			stmt.executeUpdate();	
		} catch (SQLException e) {
			throw new FormAppException(e, this.request, this.response);
		}
	}
}
