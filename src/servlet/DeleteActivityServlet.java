package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sql.ManagerActivite;
import sql.ManagerUtilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère la suppression d'une activité
 */
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
		//Création du manager des activité
		ManagerActivite manager = new ManagerActivite();
		//Récupération de l'id de l'activité
		int id = Integer.parseInt(request.getParameter("idActivite"));
	
		//Suppression de l'activité
		manager.supprimerActivite(id);
		
		//Redirection vers la page d'administration des activités
		response.sendRedirect("activities");
	}

}
