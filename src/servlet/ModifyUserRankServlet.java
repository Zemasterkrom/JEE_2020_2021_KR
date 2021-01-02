package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Utilisateur;
import exception.AppException;
import sql.ManagerUtilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère la modification du rang de l'utilisateur
 */
@WebServlet("/ModifyUserRankServlet")
public class ModifyUserRankServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyUserRankServlet() {
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
	 * Post : on modifie le rang de l'utilisateur de 'normal' à 'admin'
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if ((Utilisateur)request.getSession().getAttribute("Utilisateur_courant") != null) {
			try {
				//Création du manager des utilisateurs
				ManagerUtilisateur manager = new ManagerUtilisateur(request, response);
				//Récupération de l'id de l'utilisateur
				int id = Integer.parseInt(request.getParameter("idUtilisateur"));
			
				//Modification du rang de l'utilisateur
				manager.modifierRang(id);
				
				//Redirection vers la page d'administration
				response.sendRedirect("users");
			} catch (AppException e) {
				e.redirigerPageErreur();
			}
		} else {
			response.sendRedirect("home");
		}
	}

}
