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
			//Affichage du formulaire de création d'un lieu
			request.getRequestDispatcher("/JSP_pages/modifyPlace.jsp").forward(request, response);
	
		}
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
			
			//Redirection vers la page d'accueil
			response.sendRedirect("places");
		} catch (AppException e) {
			e.ajouterAttribut("idLieu");
			e.redirigerPageErreur("modifyPlace");
		} 
	}

}
