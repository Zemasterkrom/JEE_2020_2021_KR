package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Utilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère l'affichage du profil de l'utilisateur
 */
public class SeeAccountServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SeeAccountServlet() {
        super();
    }

	/**
	 * Get : on affiche le profil de l'utilisateur
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
			//Affichage du profil de l'utilisateur
			request.getRequestDispatcher("/JSP_pages/account.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
