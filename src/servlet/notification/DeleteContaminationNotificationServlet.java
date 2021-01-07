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
import sql.ManagerNotificationContamination;

/**
 * @author Raphaël Kimm
 * Servlet qui gère la suppression des notifications de contaminations
 */
@WebServlet("/DeleteContaminationNotificationServlet")
public class DeleteContaminationNotificationServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteContaminationNotificationServlet() {
        super();
    }

	/**
	 * Get : affiche les notifications de contamination
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "contaminationNotifications");
	}

	/**
	 * Post : suppression de la notification
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				//Création du manager des amis
				ManagerNotificationContamination manager = new ManagerNotificationContamination(request, response);
				
				//Récupération de l'id de l'utilisateur
				int idUtilisateur = ((Utilisateur)request.getSession().getAttribute("Utilisateur_courant")).getId();
				
				//Récupération de l'id de la notification
				int idNotification = Integer.parseInt(request.getParameter("idNotification"));
			
				//Suppression de la notification
				manager.supprimerNotification(idUtilisateur, idNotification);
				
				//Redirection vers la page des notifications
				response.sendRedirect(request.getContextPath() + "/notifications/contaminationNotifications");
			} catch (AppException e) {
				e.redirigerPageErreur("/notifications/contaminationNotifications");
			} catch (IllegalArgumentException | NullPointerException e) {
				new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_ADDITION_ERROR, request, response).redirigerPageErreur("/notifications/contaminationNotifications");
			}
	}

}
