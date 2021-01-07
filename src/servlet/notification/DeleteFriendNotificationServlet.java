package servlet.notification;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Utilisateur;
import exception.AppException;
import exception.FormAppException;
import sql.ManagerNotificationAmi;

/**
 * @author Raphaël Kimm
 * Servlet qui gère la suppression des notifications d'amis
 */
@WebServlet("/DeleteFriendNotificationServlet")
public class DeleteFriendNotificationServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteFriendNotificationServlet() {
        super();
    }

	/**
	 * Get : rediriger vers la page des notifications
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "friendNotifications");
	}

	/**
	 * Post : suppression de la notification
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				//Création du manager des notifications
				ManagerNotificationAmi manager = new ManagerNotificationAmi(request, response);
				
				//Récupération de l'id de l'utilisateur
				int idUtilisateur = ((Utilisateur)request.getSession().getAttribute("Utilisateur_courant")).getId();
				
				//Récupération de l'id de la notification
				int idNotification = Integer.parseInt(request.getParameter("idNotification"));
			
				//Suppression de la notification
				manager.supprimerNotification(idUtilisateur, idNotification);
				
				//Redirection vers la page des notifications
				response.sendRedirect(request.getContextPath() + "/notifications/friendNotifications");
			} catch (AppException e) {
				e.redirigerPageErreur("/notifications/friendNotifications");
			} catch (IllegalArgumentException | NullPointerException e) {
				new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_DELETION_ERROR, request, response).redirigerPageErreur("/notifications/friendNotifications");
			}
	}

}
