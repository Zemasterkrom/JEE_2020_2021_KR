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
			ManagerAmi manager = new ManagerAmi();
			//Récupération des amis
			List<Ami> amis = manager.getAmis(utilisateur.getId());
			utilisateur.setAmis(amis);
			//Récupération des demande d'amis
			List<Ami> demandes = manager.getDemandesAmi(utilisateur.getId());
			utilisateur.setDemandes(demandes);
			
			//Affichage de la page des amis
			request.getRequestDispatcher("/JSP_pages/friends.jsp").forward(request, response);
		}
	}

	/**
	 * Post : redirige vers le Get
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
