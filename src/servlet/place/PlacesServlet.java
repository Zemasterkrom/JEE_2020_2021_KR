package servlet.place;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Lieu;
import exception.AppException;
import sql.ManagerLieu;

/**
 * @author Théo Roton
 * Servlet qui gère l'affichage des lieux
 */
@WebServlet("/PlacesServlet")
public class PlacesServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlacesServlet() {
        super();
    }

	/**
	 * Get : affiche la liste des lieux de l'application
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			//Création du manager des lieux
			ManagerLieu manager = new ManagerLieu(request, response);
			
			//Récupération des lieux
			List<Lieu> lieux = manager.getAllLieux();
					
			//Ajout des lieux à la requête
			request.setAttribute("Lieux", lieux);
					
			//Affichage de la page de gestion des lieux
			request.getRequestDispatcher("/JSP_pages/admin/places.jsp").forward(request, response);
		} catch (AppException e) {
			e.redirigerPageErreur("/admin/places");
		}
	}

	/**
	 * Post : redirige vers le Get
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
