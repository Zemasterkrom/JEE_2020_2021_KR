package servlet.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Utilisateur;
import exception.AppException;
import sql.ManagerUtilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère l'affichage des utilisateurs
 */
@WebServlet("/UsersServlet")
public class UsersServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsersServlet() {
        super();
    }

	/**
	 * Get : affiche la liste des utilisateurs de l'application
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Récupération de la session et de l'utilisateur
			HttpSession session = request.getSession();
			Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
			
			//Création du manager des utilisateurs
			ManagerUtilisateur manager = new ManagerUtilisateur(request, response);
			
			//Récupération des utilisateurs
			List<Utilisateur> utilisateurs = manager.getAllUtilisateursSansActivites(utilisateur.getLogin());
					
			//Ajout des utilisateurs à la requête
			request.setAttribute("Utilisateurs", utilisateurs);
					
			//Affichage de la page de gestion des utilisateurs
			request.getRequestDispatcher("/JSP_pages/admin/users.jsp").forward(request, response);
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
