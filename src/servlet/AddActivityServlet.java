package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Utilisateur;
import exception.AppException;
import sql.ManagerActivite;

/**
 * @author Raphaël Kimm
 * Servlet qui gère la création d'une activité
 */
@WebServlet("/AddActivityServlet")
public class AddActivityServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddActivityServlet() {
        super();
    }

	/**
	 *  Get : redirection vers la page de création d'une activité
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
			//Affichage du formulaire de création d'activité
			request.getRequestDispatcher("/JSP_pages/addActivity.jsp").forward(request, response);
		}
	}

	/**
	 * Post : ajout de l'activité
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Création du manager des activités
			ManagerActivite manager = new ManagerActivite(request, response);
			
			//Récupération des données
			HttpSession session = request.getSession();
			int idUtilisateur = ((Utilisateur)session.getAttribute("Utilisateur_courant")).getId();
			int idLieu = Integer.valueOf(request.getParameter("idLieu"));
			
			// Conversion des chaînes en Timestamp pour les dates de début et de fin
			String dateDebut = request.getParameter("dateDebut");
			String heureDebut = request.getParameter("heureDebut");
			String dateFin = request.getParameter("dateFin");
			String heureFin = request.getParameter("heureFin");

			//Création de l'activité
			manager.ajouterActivite(dateDebut, heureDebut, dateFin, heureFin, idUtilisateur, idLieu);
			
			//Redirection vers la page d'accueil
			response.sendRedirect("home");
		} catch (AppException e) {
			e.redirigerPageErreur("addActivity");
		} 
	}

}
