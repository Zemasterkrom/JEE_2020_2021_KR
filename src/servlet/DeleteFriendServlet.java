package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Utilisateur;
import exception.AppException;
import sql.ManagerAmi;

/**
 * @author Théo Roton
 * Servlet qui gère la suppression d'un ami
 */
@WebServlet("/DeleteFriendServlet")
public class DeleteFriendServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteFriendServlet() {
        super();
    }

	/**
	 * Get : redirection vers la page des amis
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Redirection vers la page des amis
		response.sendRedirect("friends");
	}

	/**
	 * Post : suppression de l'ami
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if ((Utilisateur)request.getSession().getAttribute("Utilisateur_courant") != null) {
			try {
				//Création du manager des amis
				ManagerAmi manager = new ManagerAmi(request, response);
				
				//Récupération de l'id de l'utilisateur
				int idUtilisateur = ((Utilisateur)request.getSession().getAttribute("Utilisateur_courant")).getId();
				
				//Récupération de l'id de l'ami
				int idAmi = Integer.parseInt(request.getParameter("idAmi"));
			
				//Suppression de la demande d'ami
				manager.refuserDemandeAmi(idUtilisateur, idAmi);
				
				//Redirection vers la page des amis
				response.sendRedirect("friends");
			} catch (AppException e) {
				e.redirigerPageErreur("friends");
			}
		} else {
			response.sendRedirect("home");
		}
	}

}
