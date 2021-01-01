package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.NotificationAmi;
import bean.Utilisateur;
import exception.AppException;
import sql.ManagerNotificationAmi;

/**
 * @author Raphaël Kimm
 * Servlet qui gère l'affichage des notifications d'amis
 */
@WebServlet("/FriendNotificationServlet")
public class FriendNotificationsServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FriendNotificationsServlet() {
        super();
    }

	/**
	 * Get : affiche les notifications d'amis
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Récupération de la session et de l'utilisateur
			HttpSession session = request.getSession();
			Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
			
			response.setContentType("text/html");
			
			//Si l'utilisateur n'est pas connecté
			if (utilisateur == null) {
				//Redirection vers la page d'accueil
				response.sendRedirect("home");
			//Si l'utilisateur est connecté
			} else {
				//Création du manager des notifications de contamination
				ManagerNotificationAmi manager = new ManagerNotificationAmi(request, response);
				
				//Récupération des notifications
				List<NotificationAmi> notifications = manager.obtenirNotifications(utilisateur.getId());
				
				// Ajout des notifications à la requête
				request.setAttribute("friendNotifications", notifications);
				
				//Affichage de la page de gestion des notifications
				request.getRequestDispatcher("/JSP_pages/friendNotifications.jsp").forward(request, response);
			}
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
