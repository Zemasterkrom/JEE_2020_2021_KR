package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Utilisateur;
import exception.AppException;
import sql.ManagerActivite;

/**
 * @author Théo Roton
 * Servlet qui gère la suppression d'une activité
 */
@WebServlet("/DeleteActivityServlet")
public class DeleteActivityServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteActivityServlet() {
        super();
    }

	/**
	 * Get : redirection vers la page d'administration
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Redirection vers la page d'administration
		response.sendRedirect("admin");
	}

	/**
	 * Post : on supprime l'activité
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Création du manager des activité
			ManagerActivite manager = new ManagerActivite(request, response);
			
			//Récupération de l'id de l'activité
			int idActivite = Integer.parseInt(request.getParameter("idActivite"));
		
			//Suppression de l'activité
			manager.supprimerActivite(idActivite);
			
			//Redirection vers la page d'administration des activités
			response.sendRedirect("activities");
		} catch (AppException e) {
			e.redirigerPageErreur("activities");
		}
	}

}
