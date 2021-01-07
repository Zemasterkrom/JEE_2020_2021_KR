package servlet.activity;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Utilisateur;
import exception.AppException;
import sql.ManagerUtilisateur;

/**
 * @author Théo Roton, Raphaël Kimm
 * Servlet qui gère l'affichage des activités des utilisateurs
 */
@WebServlet("/ActivitiesServlet")
public class ActivitiesServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActivitiesServlet() {
        super();
    }

	/**
	 * Get : affiche la liste des utilisateurs et de leurs activités
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			response.setContentType("text/html");
			
			//Création du manager des utilisateurs
			ManagerUtilisateur manager = new ManagerUtilisateur(request, response);
	
			//Récupération des utilisateurs
			List<Utilisateur> utilisateurs = manager.getAllUtilisateurs();
					
			//Ajout des utilisateurs à la requête
			request.setAttribute("Utilisateurs", utilisateurs);
				
			//Affichage de la page de gestion des activités
			request.getRequestDispatcher("/JSP_pages/admin/activities.jsp").forward(request, response);
		} catch (AppException e) {
			e.redirigerPageErreur();
		}
	}

	/**
	 * Post : redirige vers le Get
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
