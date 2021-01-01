package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.NotificationAmi;
import exception.AppException;
import exception.SevereAppException;

/**
 * Classe représentant le manager des notifications d'amis
 * @author Raphaël Kimm
 * Classe ManagerUtilisateur
 */
public class ManagerNotificationAmi extends Manager {


	/**
	 * Constructeur de la classe ManagerNotificationAmi
	 * @param request Objet associé à la requête HTTP actuelle
	 * @param response Objet associé à la réponse HTTP
	 * @throws AppException
	 */
	public ManagerNotificationAmi(HttpServletRequest request, HttpServletResponse response) throws AppException {
		super(request, response);
	}
	
	/**
	 * Obtenir les notifications de notifications d'amis
	 * @param idUtilisateur Id de l'utilisateur pour les notifications d'amis
	 * @throws AppException
	 */
	public List<NotificationAmi> obtenirNotifications(int idUtilisateur) throws AppException {
		List<NotificationAmi> notifications = new ArrayList<NotificationAmi>();
		
		try {
			//Requête
			String req = "SELECT * FROM NotificationAmi WHERE idConcerne = ?";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			// On indique l'id de l'utilisateur
			stmt.setInt(1, idUtilisateur);
			
			// Exécution de la requête
			ResultSet results = stmt.executeQuery();

			// On récupère les notifications de l'utilisateur
			while (results.next()) {
				NotificationAmi notif = new NotificationAmi();
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
	 * Mettre à jour les notifications d'amis
	 * @param idUtilisateur Id de l'utilisateur pour les notifications d'amis
	 * @throws AppException
	 */
	public void setVueNotifications(int idUtilisateur) throws AppException {
		try {
			//Requête
			String req = "UPDATE NotificationAmi SET vue=1 WHERE idConcerne = ?";
			
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
	 * Supprimer une notification d'ami d'un utilisateur
	 * @param idUtilisateur Id de l'utilisateur pour la notification d'ami
	 * @throws AppException
	 */
	public void supprimerNotification(int idUtilisateur, int idNotification) throws AppException {
		try {
			//Requête
			String req = "DELETE FROM NotificationAmi WHERE idConcerne = ? AND idNotification = ?";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			// On indique l'id de l'utilisateur et de la notification
			stmt.setInt(1, idUtilisateur);
			stmt.setInt(2, idNotification);

			// Exécution de la requête
			stmt.executeUpdate();	
		} catch (SQLException e) {
			throw new SevereAppException(e, this.request, this.response);
		}
	}
	
	/**
	 * Obtenir le nombre de notifications d'amis non vues par l'utilisateur
	 * @param idUtilisateur Id de l'utilisateur
	 * @return Nombre de notifications non vues
	 * @throws AppException
	 */
	public int getNbNotificationsNonVues(int idUtilisateur) throws AppException {
		int nb = 0;
		
		try {
			//Requête
			String req = "SELECT COUNT(idNotification) FROM NotificationAmi WHERE idConcerne = ? AND vue=0";
			
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
