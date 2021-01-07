package servlet.place;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exception.AppException;
import exception.FormAppException;
import sql.ManagerLieu;

/**
 * @author Raphaël Kimm
 * Servlet qui gère la création d'un lieu
 */
@WebServlet("/AddPlaceServlet")
public class AddPlaceServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPlaceServlet() {
        super();
    }

	/**
	 *  Get : redirection vers la page de création d'un lieu
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Affichage du formulaire de création d'un lieu
		request.getRequestDispatcher("/JSP_pages/activities/addPlace.jsp").forward(request, response);
	}

	/**
	 * Post : ajout du lieu
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Création du manager des activités
			ManagerLieu manager = new ManagerLieu(request, response);
			
			//Récupération des données
			String nom = request.getParameter("nom");
			String adresse = request.getParameter("adresse");

			//Création du lieu
			manager.ajouterLieu(nom, adresse);
			
			//Redirection vers la page d'accueil
			response.sendRedirect(request.getContextPath() + "/home");
		} catch (AppException e) {
			e.redirigerPageErreur("/places/addPlace");
		} catch (IllegalArgumentException | NullPointerException e) {
			new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_ADDITION_ERROR, request, response).redirigerPageErreur("/places/addPlace");
		}
	}

}
