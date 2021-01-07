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
 * @author Théo Roton, Raphaël Kimm
 * Servlet qui gère l'acceptation d'une demande d'ami
 */
@WebServlet("/AcceptFriendRequestServlet")
public class AcceptFriendRequestServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AcceptFriendRequestServlet() {
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
	 * Post : acceptation de la demande d'ami
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				//Création du manager des amis
				ManagerAmi manager = new ManagerAmi(request, response);
				
				//Récupération de l'id de l'accepteur
				int idAccepteur = ((Utilisateur)request.getSession().getAttribute("Utilisateur_courant")).getId();
				
				//Récupération de l'id de l'ami
				int idAmi = Integer.parseInt(request.getParameter("idAmi"));
			
				//Accpeter la demande d'ami
				manager.accepterDemandeAmi(idAccepteur, idAmi);
	
				//Redirection
				response.sendRedirect(request.getHeader("referer"));
			} catch (AppException e) {
				e.redirigerPageErreur("/friends");
			} catch (IllegalArgumentException | NullPointerException e) {
				new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_ADDITION_ERROR, request, response).redirigerPageErreur("/friends");
			}
	}

}
