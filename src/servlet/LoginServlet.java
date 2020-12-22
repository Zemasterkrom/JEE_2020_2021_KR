package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Utilisateur;
import sql.BCrypt;
import sql.ManagerUtilisateur;

/**
 * @author Th�o Roton
 * Servlet qui g�re la connexion
 */
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
    }

	/**
	 * Get : on affiche le formulaire de connexion
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		//R�cup�ration de la session et de l'utilisateur
		HttpSession session = request.getSession();
		Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
		
		response.setContentType("text/html");
		
		//Si l'utilisateur n'est pas connect�
		if (utilisateur == null) {
			//Affichage du formulaire de connexion
			request.getRequestDispatcher("/JSP_pages/login.jsp").forward(request, response);
			
		//Si l'utilisateur est connect�
		} else {
			//Redirection vers la page d'accueil
			response.sendRedirect("home");
		}
	}

	/**
	 * Post : on traite la connexion de l'utilisateur
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Cr�ation du manager des utilisateurs
		ManagerUtilisateur manager = new ManagerUtilisateur();
		//Liste des erreurs � afficher
		List<String> erreurs = new ArrayList<String>();
		//Utilisateur � connecter
		Utilisateur utilisateur = null;
		
		//Login de l'utilisateur
		String login = request.getParameter("login");
		//On v�rifie que le login existe
		if (manager.verifierUtilisateurPresent(login)) {
			request.setAttribute("login", login);
			
			//Mot de passe de l'utilisateur
			String mdp = request.getParameter("mdp");
			//Utilisateur
			utilisateur = manager.getUtilisateur(login);
			
			//On v�rifie que le mot de passe entr� correspond au mot de passe de l'utilisateur
			if (!BCrypt.checkpw(mdp, utilisateur.getMotDePasse())) {
				erreurs.add("MDPIncorrect");
			}
			
		} else {
			erreurs.add("LoginInexistant");
		}
		

		
		//Si on a des erreurs, on renvoie sur le formulaire
		if (erreurs.size() > 0) {
			request.setAttribute("Erreurs", erreurs);
			doGet(request, response);
			
		//Sinon on ajoute l'utilisateur dans la BDD
		} else {
			//Cr�ation de la session
			HttpSession session = request.getSession();
			
			//Ajout de l'utilisateur � la session
			session.setAttribute("Utilisateur_courant", utilisateur);
			request.setAttribute("Utilisateur_courant", utilisateur);
			
			//Redirection
			response.sendRedirect("home");
		}
	}

}
