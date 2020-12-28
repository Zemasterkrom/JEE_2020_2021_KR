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
 * Servlet qui gère l'ajout d'un ami
 */
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
		response.sendRedirect("moreFriends");
	}

	/**
	 * Post : ajout et envoi d'une requête d'ami
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Création du manager des amis
		ManagerAmi manager = new ManagerAmi();
		//Récupération de l'id de l'utilisateur
		int idUtilisateur = Integer.parseInt(request.getParameter("idUtilisateur"));
		//Récupération de l'id de l'ami
		int idAmi = Integer.parseInt(request.getParameter("idAmi"));
		
		//Création de la demande d'ami
		manager.ajouterAmi(idUtilisateur, idAmi);
		
		//Redirection vers la page des amis
		response.sendRedirect("moreFriends");
	}

}