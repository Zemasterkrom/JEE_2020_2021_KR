package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Ami;
import bean.Utilisateur;
import sql.ManagerAmi;
import sql.ManagerUtilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère l'affichage des utilisateurs pouvant être ajouté en ami
 */
public class MoreFriendsServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MoreFriendsServlet() {
        super();
    }

	/**
	 * Get : affiche la liste des utilisateurs pouvant être ajouté en ami
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			//Création du manager des utilisateurs
			ManagerUtilisateur manager = new ManagerUtilisateur();
			//Récupération des utilisateurs
			List<Utilisateur> utilisateurs = manager.getAllUtilisateursSansActivites(utilisateur.getLogin());
			
			//Ajout des utilisateurs à la requête
			request.setAttribute("Utilisateurs", utilisateurs);
			
			//Affichage de la page des amis
			request.getRequestDispatcher("/JSP_pages/moreFriends.jsp").forward(request, response);
		}
	}

	/**
	 * Post : redirige vers le Get
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
