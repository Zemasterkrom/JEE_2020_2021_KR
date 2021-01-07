package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Utilisateur;
import exception.AppException;
import sql.ManagerEtat;

/**
 * @author Raphaël Kimm
 * Servlet qui gère la mise à jour de l'état
 */
@WebServlet("/PositiveDeclarationServlet")
public class PositiveDeclarationServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PositiveDeclarationServlet() {
        super();
    }

	/**
	 * Get : rediriger vers la page d'accueil
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/home");
	}

	/**
	 * Post : mise à jour de l'état en positif si possible
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				//Création du manager d'état
				ManagerEtat manager = new ManagerEtat(request, response);
				
				//Récupération de l'id de l'utilisateur
				int idUtilisateur = ((Utilisateur)request.getSession().getAttribute("Utilisateur_courant")).getId();
			
				//Mise à jour de l'état
				manager.majEtatPositif(idUtilisateur);
				
				//Redirection vers la page des notifications
				response.sendRedirect(request.getContextPath() + "/home");
			} catch (AppException e) {
				e.redirigerPageErreur("/home");
			}
	}

}
