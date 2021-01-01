package servlet;

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
 * Servlet qui gère l'affichage des activités des utilisateurs
 */
@WebServlet("/ActivitiesServlet")
public class ActivitiesServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActivitiesServlet() {
        super();
    }

	/**
	 * Get : affiche la liste des utilisateurs et de leurs activités
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
				
				//Si l'utilisateur est un administrateur
				if (utilisateur.getRang().equals("admin")) {
					//Création du manager des utilisateurs
					ManagerUtilisateur manager = new ManagerUtilisateur(request, response);
	
					//Récupération des utilisateurs
					List<Utilisateur> utilisateurs = manager.getAllUtilisateurs(utilisateur.getLogin());
					
					//Ajout des utilisateurs à la requête
					request.setAttribute("Utilisateurs", utilisateurs);
					
					//Affichage de la page de gestion des activités
					request.getRequestDispatcher("/JSP_pages/activities.jsp").forward(request, response);
					
			    //Si l'utilisateur n'est pas un administrateur
				} else {
					//Redirection vers la page d'accueil
					response.sendRedirect("home");
				}
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
