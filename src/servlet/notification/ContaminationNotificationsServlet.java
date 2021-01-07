package servlet.notification;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.NotificationContamination;
import bean.Utilisateur;
import exception.AppException;
import sql.ManagerNotificationContamination;

/**
 * @author Raphaël Kimm
 * Servlet qui gère l'affichage des notifications de contamination
 */
@WebServlet("/ContaminationNotificationsServlet")
public class ContaminationNotificationsServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContaminationNotificationsServlet() {
        super();
    }

	/**
	 * Get : affiche les notifications de contamination
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Récupération de la session et de l'utilisateur
			HttpSession session = request.getSession();
			Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
			
			//Création du manager des notifications de contamination
			ManagerNotificationContamination manager = new ManagerNotificationContamination(request, response);
				
			//Récupération des notifications
			List<NotificationContamination> notifications = manager.obtenirNotifications(utilisateur.getId());
				
			// Ajout des notifications à la requête
			request.setAttribute("contaminationNotifications", notifications);
				
			//Affichage de la page de gestion des notifications
			request.getRequestDispatcher("/JSP_pages/notifications/contaminationNotifications.jsp").forward(request, response);
		} catch (AppException e) {
			e.redirigerPageErreur();
		}
	}

	/**
	 * Post : redirige vers le Get
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
