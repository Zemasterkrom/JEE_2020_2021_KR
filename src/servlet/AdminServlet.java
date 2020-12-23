package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Utilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère l'affichage de l'interface admin
 */
public class AdminServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
        super();
    }

	/**
	 * Get : affichage de l'interface admin
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
			
			//Si l'utilisateur est un administrateur
			if (utilisateur.getRang().equals("admin")) {
				//Affichage de l'interface administrateur
				request.getRequestDispatcher("/JSP_pages/admin.jsp").forward(request, response);
				
		    //Si l'utilisateur n'est pas un administrateur
			} else {
				//Redirection vers la page d'accueil
				response.sendRedirect("home");
			}
		}
	}

	/**
	 * Post : redirige vers le Get
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
