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
 * Servlet qui gère la modification d'un lieu
 */
@WebServlet("/ModifyPlaceServlet")
public class ModifyPlaceServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyPlaceServlet() {
        super();
    }

	/**
	 *  Get : redirection vers la page de modification d'un lieu
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Affichage du formulaire de création d'un lieu
		request.getRequestDispatcher("/JSP_pages/admin/modifyPlace.jsp").forward(request, response);
	}

	/**
	 * Post : modification du lieu
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Création du manager des activités
			ManagerLieu manager = new ManagerLieu(request, response);
			
			//Récupération des données
			int idLieu = Integer.valueOf(request.getParameter("idLieu"));
			String nom = request.getParameter("nom");
			String adresse = request.getParameter("adresse");

			//Création du lieu
			manager.modifierLieu(idLieu, nom, adresse);
			
			//Redirection vers la page des lieux
			response.sendRedirect(request.getContextPath() + "/admin/places");
		} catch (AppException e) {
			e.ajouterAttribut("idLieu");
			e.redirigerPageErreur("/admin/places/modifyPlace");
		} catch (IllegalArgumentException | NullPointerException e) {
			FormAppException ae = new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_MODIFICATION_ERROR, request, response);
			ae.ajouterAttribut("idLieu");
			ae.redirigerPageErreur("/admin/places/modifyPlace");
		}
	}

}
