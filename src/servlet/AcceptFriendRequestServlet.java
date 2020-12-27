package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sql.ManagerAmi;
import sql.ManagerLieu;

/**
 * @author Théo Roton
 * Servlet qui gère l'acceptation d'une demande d'ami
 */
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
		response.sendRedirect("friends");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Création du manager des amis
		ManagerAmi manager = new ManagerAmi();
		//Récupération de l'id de l'accepteur
		int idAccepteur = Integer.parseInt(request.getParameter("idAccepteur"));
		//Récupération de l'id de l'ami
		int idAmi = Integer.parseInt(request.getParameter("idAmi"));
	
		//Suppresion de la demande d'ami
		manager.accepterDemandeAmi(idAccepteur, idAmi);
		
		//Redirection vers la page des amis
		response.sendRedirect("friends");
	}

}
