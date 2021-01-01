package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.NotificationContamination;
import exception.AppException;
import exception.FormAppException;
import exception.SevereAppException;

/**
 * Classe représentant le manager des notifications de contaminations
 * @author Raphaël Kimm
 * Classe ManagerUtilisateur
 */
public class ManagerNotificationContamination extends Manager {


	/**
	 * Constructeur de la classe ManagerNotificationContamination
	 * @param request Objet associé à la requête HTTP actuelle
	 * @param response Objet associé à la réponse HTTP
	 * @throws AppException
	 */
	public ManagerNotificationContamination(HttpServletRequest request, HttpServletResponse response) throws AppException {
		super(request, response);
	}
	
	/**
	 * Obtenir les notifications de contaminations
	 * @param idUtilisateur Id de l'utilisateur pour les notifications de contaminations
	 * @throws AppException
	 */
	public List<NotificationContamination> obtenirNotifications(int idUtilisateur) throws AppException {
		List<NotificationContamination> notifications = new ArrayList<NotificationContamination>();
		
		try {
			//Requête
			String req = "SELECT * FROM NotificationContamination WHERE idUtilisateur = ?";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			// On indique l'id de l'utilisateur
			stmt.setInt(1, idUtilisateur);
			
			// Exécution de la requête
			ResultSet results = stmt.executeQuery();

			// On récupère les notifications de l'utilisateur
			while (results.next()) {
				NotificationContamination notif = new NotificationContamination();
				notif.setId(results.getInt("idNotification"));
				notif.setMessage(results.getString("message"));
				notifications.add(notif);
			}
			
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
		
		return notifications;
	}
	
	/**
	 * Mettre à jour les notifications de contamination comme étant vues
	 * @param idUtilisateur Id de l'utilisateur pour les notifications de contamination
	 * @throws AppException
	 */
	public void setVueNotifications(int idUtilisateur) throws AppException {
		try {
			//Requête
			String req = "UPDATE NotificationContamination SET vue=1 WHERE idUtilisateur = ?";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			// On indique l'id de l'utilisateur
			stmt.setInt(1, idUtilisateur);

			// Exécution de la requête
			stmt.executeUpdate();			
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
	}
	
	/**
	 * Supprimer une notification de contamination
	 * @param idUtilisateur Id de l'utilisateur pour notification de contamination
	 * @param idNotification Id de la notification de contamination
	 * @throws AppException
	 */
	public void supprimerNotification(int idUtilisateur, int idNotification) throws AppException {
		try {
			//Requête
			String req = "DELETE FROM NotificationContamination WHERE idUtilisateur = ? AND idNotification = ?";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			// On indique l'id de l'utilisateur et de la notification
			stmt.setInt(1, idUtilisateur);
			stmt.setInt(2, idNotification);

			// Exécution de la requête
			stmt.executeUpdate();	
		} catch (SQLException e) {
			throw new FormAppException(e, this.request, this.response);
		}
	}
	
	/**
	 * Obtenir le nombre de notifications de contaminations non vues par l'utilisateur
	 * @param idUtilisateur Id de l'utilisateur
	 * @return Nombre de notifications non vues
	 * @throws AppException
	 */
	public int getNbNotificationsNonVues(int idUtilisateur) throws AppException {
		int nb = 0;
		
		try {
			//Requête
			String req = "SELECT COUNT(idNotification) FROM NotificationContamination WHERE idUtilisateur = ? AND vue=0";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			// On indique l'id de l'utilisateur
			stmt.setInt(1, idUtilisateur);
			
			// Exécution de la requête
			ResultSet results = stmt.executeQuery();

			results.next();
			nb = results.getInt(1);
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
		
		return nb;
	}
}
