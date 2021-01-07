package servlet.activity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Utilisateur;
import exception.AppException;
import exception.FormAppException;
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
		//Affichage du formulaire de création d'activité
		request.getRequestDispatcher("/JSP_pages/activities/addActivity.jsp").forward(request, response);
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
			response.sendRedirect(request.getContextPath() + "/home");
		} catch (AppException e) {
			e.redirigerPageErreur("/activities/addActivity");
		} catch (IllegalArgumentException | NullPointerException e) {
			new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_ADDITION_ERROR, request, response).redirigerPageErreur("/activities/addActivity");
		}
	}

}
