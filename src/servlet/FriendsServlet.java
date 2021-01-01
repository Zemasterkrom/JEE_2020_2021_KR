package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Ami;
import bean.Utilisateur;
import exception.AppException;
import sql.ManagerAmi;

/**
 * @author Théo Roton
 * Servlet qui gère l'affichage des amis et des demandes d'amis
 */
public class FriendsServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FriendsServlet() {
        super();
    }

	/**
	 * Get : affiche la liste des amis et des demandes d'amis
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
				//Création du manager des amis
				ManagerAmi manager = new ManagerAmi(request, response);
				
				//Récupération des amis
				List<Ami> amis = manager.getAmis(utilisateur.getId());
				utilisateur.setAmis(amis);
				
				//Récupération des demande d'amis reçues
				List<Ami> demandesRecues = manager.getDemandesAmiRecues(utilisateur.getId());
				utilisateur.setDemandesRecues(demandesRecues);
				
				//Récupération des demande d'amis envoyées
				List<Ami> demandesEnvoyees = manager.getDemandesAmiEnvoyees(utilisateur.getId());
				utilisateur.setDemandesEnvoyees(demandesEnvoyees);
				
				//Affichage de la page des amis
				request.getRequestDispatcher("/JSP_pages/friends.jsp").forward(request, response);
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
