package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sql.ManagerAmi;

/**
 * @author Théo Roton
 * Servlet qui gère le refus d'une demande d'ami
 */
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
		response.sendRedirect("friends");
	}

	/**
	 * Post : rejet de la demande d'ami
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Création du manager des amis
		ManagerAmi manager = new ManagerAmi();
		//Récupération de l'id du refuseur
		int idRefuseur = Integer.parseInt(request.getParameter("idRefuseur"));
		//Récupération de l'id de l'ami
		int idAmi = Integer.parseInt(request.getParameter("idAmi"));
	
		//Suppression de l'ami
		manager.refuserDemandeAmi(idRefuseur, idAmi);
		
		//Récupération de la redicrection
		String[] split = request.getHeader("referer").split("/");
		String redirect = split[split.length-1];
		
		//Redirection
		response.sendRedirect(redirect);
	}

}
