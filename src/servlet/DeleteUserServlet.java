package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sql.ManagerUtilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère la suppression d'un utilisateur
 */
public class DeleteUserServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserServlet() {
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
	 * Post : on supprime l'utilisateur
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Création du manager des utilisateurs
		ManagerUtilisateur manager = new ManagerUtilisateur();
		//Récupération de l'id de l'utilisateur
		int id = Integer.parseInt(request.getParameter("idUtilisateur"));
	
		//Suppression de l'utilisateur
		manager.supprimerUtilisateur(id);
		
		//Redirection vers la page d'administration
		response.sendRedirect("users");
	}

}
