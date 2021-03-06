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
 * Servlet qui gère le refus d'une demande d'ami
 */
@WebServlet("/RejectFriendRequestServlet")
public class RejectFriendRequestServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RejectFriendRequestServlet() {
        super();
    }

	/**
	 * Get : redirection vers la page des amis
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Redirection vers la page des amis
		response.sendRedirect(request.getContextPath() + "/friends");
	}

	/**
	 * Post : rejet de la demande d'ami
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
			try {
				//Création du manager des amis
				ManagerAmi manager = new ManagerAmi(request, response);
				//Récupération de l'id du refuseur
				int idRefuseur = ((Utilisateur)request.getSession().getAttribute("Utilisateur_courant")).getId();
				//Récupération de l'id de l'ami
				int idAmi = Integer.parseInt(request.getParameter("idAmi"));
			
				//Suppression de l'ami
				manager.refuserDemandeAmi(idRefuseur, idAmi);
				
				//Redirection
				response.sendRedirect(request.getHeader("referer"));
			} catch (AppException e) {
				e.redirigerPageErreur("/friends");
			} catch (IllegalArgumentException e) {
				new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_DELETION_ERROR, request, response).redirigerPageErreur("/friends");
			}
	}

}
