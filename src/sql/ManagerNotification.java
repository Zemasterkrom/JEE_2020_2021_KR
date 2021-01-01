package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exception.AppException;
import exception.SevereAppException;

/**
 * Classe représentant le manager global des opérations sur les notifications
 * @author Raphaël Kimm
 * Classe ManagerUtilisateur
 */
public class ManagerNotification extends Manager {


	/**
	 * Constructeur de la classe ManagerNotification
	 * @param request Objet associé à la requête HTTP actuelle
	 * @param response Objet associé à la réponse HTTP
	 * @throws AppException
	 */
	public ManagerNotification(HttpServletRequest request, HttpServletResponse response) throws AppException {
		super(request, response);
	}
	
	/**
	 * Obtenir le nombre total de notifications non vues par l'utilisateur
	 * @param idUtilisateur Id de l'utilisateur
	 * @return Nombre de notifications non vues
	 * @throws AppException
	 */
	public int getNbNotificationsNonVues(int idUtilisateur) throws AppException {
		int nb = 0;
		
		try {
			//Requête
			String req = "SELECT (SELECT COUNT(idNotification) FROM NotificationAmi WHERE idConcerne = ? AND vue=0) + (SELECT COUNT(idNotification) FROM NotificationContamination WHERE idUtilisateur = ? AND vue=0)";
			
			//Préparation de la requête
			PreparedStatement stmt = this.doRequest(req);
			
			// On indique l'id de l'utilisateur
			stmt.setInt(1, idUtilisateur);
			stmt.setInt(2, idUtilisateur);
			
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
