package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Utilisateur;
import controller.VerificationsInformations;
import exception.AppException;
import sql.BCrypt;
import sql.ManagerUtilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère la modification du mot de passe
 */
@WebServlet("/ModifyPasswordServlet")
public class ModifyPasswordServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyPasswordServlet() {
        super();
    }

	/**
	 * Get : on affiche la page de modification du mot de passe
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
			//Affichage du formulaire de modification
			request.getRequestDispatcher("/JSP_pages/modifyPassword.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Création du manager des utilisateurs
			ManagerUtilisateur manager = new ManagerUtilisateur(request, response);
			//Création du controleur de vérifications
			VerificationsInformations verif = new VerificationsInformations();
			//Liste des erreurs à afficher
			List<String> erreurs = new ArrayList<String>();
			//UTF-8
			request.setCharacterEncoding("UTF-8");
			//Récupération de la session
			HttpSession session = request.getSession();
			//Récupération de l'utilisateur
			Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
			
			//Ancien mot de passe de l'utilisateur
			String ancienmdp = request.getParameter("ancienmdp");
			//On vérifie que l'ancien mot de passe correspond au mot de passe courant
			if (!BCrypt.checkpw(ancienmdp, utilisateur.getMotDePasse())) {
				erreurs.add("AncienMDPIncorrect");
			}
			
			//Mot de passe de l'utilisateur
			String mdp = request.getParameter("mdp");		
			//Confirmation du mot de passe de l'utilisateur
			String mdpVerif = request.getParameter("mdpVerif");
			//On vérifie que le mot de passe fait plus de 6 caractères et moins de 64 caractères
			if (mdp.length() >= 6 && mdp.length() <= 64) {
				
				//On vérifie que le mot de passe est égal à sa confirmation
				if (!mdp.equals(mdpVerif)) {
					erreurs.add("MDPPasEgal");
				}
				
			} else {
				erreurs.add("TailleMDP");
			}
			
			//Si on a des erreurs, on renvoie sur le formulaire
			if (erreurs.size() > 0) {
				request.setAttribute("Erreurs", erreurs);
				doGet(request, response);
				
				//Sinon on modifie le mot de passe de l'utilisateur dans la BDD
			} else {
				//Modification du mot de passe de l'utilisateur
				manager.modifierMDPUtilisateur(utilisateur.getId(), mdp);
				
				//Récupération de l'utilisateur modifier
				utilisateur = manager.getUtilisateur(utilisateur.getLogin());
				//Ajout de l'utilisateur à la session
				session.setAttribute("Utilisateur_courant", utilisateur);
				request.setAttribute("Utilisateur_courant", utilisateur);
				
				//Redirection
				response.sendRedirect("account");
			}
		} catch (AppException e) {
			e.redirigerPageErreur();
		}
	}

}
