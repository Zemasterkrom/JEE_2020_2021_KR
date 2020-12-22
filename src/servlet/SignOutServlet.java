package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Utilisateur;

/**
 * @author Th�o Roton
 * Servlet qui g�re la d�connexion
 */
public class SignOutServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignOutServlet() {
        super();
    }

	/**
	 * Get : on affiche la confirmation de d�connexion
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//R�cup�ration de la session et de l'utilisateur
		HttpSession session = request.getSession();
		Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
		
		//Si l'utilisateur est connect�
		if (utilisateur != null) {
			//D�connexion de l'utilisateur
			session.setAttribute("Utilisateur_courant", null);
			request.setAttribute("Utilisateur_courant", null);
			session.invalidate();
		}
		
		//Redirection vers la page d'accueil
		response.sendRedirect("home");
	}

	/**
	 * Post : redirige vers le get
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
