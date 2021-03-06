package servlet.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exception.AppException;
import exception.FormAppException;
import sql.ManagerUtilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère la suppression d'un utilisateur
 */
@WebServlet("/DeleteUserServlet")
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
		response.sendRedirect(request.getContextPath() + "admin");
	}

	/**
	 * Post : on supprime l'utilisateur
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				//Création du manager des utilisateurs
				ManagerUtilisateur manager = new ManagerUtilisateur(request, response);
				//Récupération de l'id de l'utilisateur
				int id = Integer.parseInt(request.getParameter("idUtilisateur"));
			
				//Suppression de l'utilisateur
				manager.supprimerUtilisateur(id);
				
				//Redirection vers la page d'administration des utilisateus
				response.sendRedirect(request.getContextPath() + "/admin/users");
			} catch (AppException e) {
				e.redirigerPageErreur("/admin/users");
			} catch (IllegalArgumentException | NullPointerException e) {
				new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_DELETION_ERROR, request, response).redirigerPageErreur("/admin/users");
			}
	}

}
