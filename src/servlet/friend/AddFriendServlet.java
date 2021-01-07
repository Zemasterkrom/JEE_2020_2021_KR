package servlet.friend;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Utilisateur;
import exception.AppException;
import exception.FormAppException;
import sql.ManagerAmi;

/**
 * @author Théo Roton
 * Servlet qui gère l'ajout d'un ami
 */
@WebServlet("/AddFriendServlet")
public class AddFriendServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddFriendServlet() {
        super();
    }

	/**
	 *  Get : redirection vers la page d'ajout des amis
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Redirection vers la page d'ajout des amis
		response.sendRedirect(request.getContextPath() + "/moreFriends");
	}

	/**
	 * Post : ajout et envoi d'une requête d'ami
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				//Création du manager des amis
				ManagerAmi manager = new ManagerAmi(request, response);
				
				//Récupération de l'id de l'utilisateur
				int idUtilisateur = ((Utilisateur)request.getSession().getAttribute("Utilisateur_courant")).getId();
				
				//Récupération de l'id de l'ami
				int idAmi = Integer.parseInt(request.getParameter("idAmi"));
				
				//Création de la demande d'ami
				manager.ajouterAmi(idUtilisateur, idAmi);
				
				//Redirection vers la page des amis
				response.sendRedirect(request.getContextPath() + "/friends/moreFriends");
			} catch (AppException e) {
				e.redirigerPageErreur("/friends/moreFriends");
			} catch (IllegalArgumentException | NullPointerException e) {
				new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_ADDITION_ERROR, request, response).redirigerPageErreur("/friends/moreFriends");
			}
	}

}
