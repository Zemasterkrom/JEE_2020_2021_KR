package servlet;

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
 * @author Théo Roton
 * Servlet qui gère la suppression d'un lieu
 */
@WebServlet("/DeletePlaceServlet")
public class DeletePlaceServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletePlaceServlet() {
        super();
    }

	/**
	 * Get : redirection vers la page d'administration
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Redirection vers la page d'administration
		response.sendRedirect("admin");
	}

	/**
	 * Post : on supprime le lieu
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				//Création du manager des lieux
				ManagerLieu manager = new ManagerLieu(request, response);
				//Récupération de l'id du lieu
				int id = Integer.parseInt(request.getParameter("idLieu"));
			
				//Vérifie si on peut supprimer le lieu
				if (manager.verifierLieuPeutEtreSupprimer(id)) {
					//Suppression du lieu
					manager.supprimerLieu(id);
				}
				
				//Redirection vers la page d'administration des activités
				response.sendRedirect("places");
			} catch (AppException e) {
				e.redirigerPageErreur("places");
			} catch (IllegalArgumentException e) {
				new FormAppException("Les données ont été a été altérées. Ajout non autorisé.", request, response).redirigerPageErreur("places");
			}
	}

}
