package ServletPackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import BeanPackage.Utilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère l'index
 */
public class IndexServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexServlet() {
        super();
    }

	/**
	 * Get : on affiche l'index en fonction de si l'utilisateur est connecté ou non
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Récupération de la session et de l'utilisateur
		HttpSession session = request.getSession();
		Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
		
		response.setContentType("text/html");
		
		//Si l'utilisateur n'est pas connecté
		if (utilisateur == null) {
			//Affichage de l'index pour l'utilisateur non connecté
			request.getRequestDispatcher("/JSP_pages/index_non_connecte.jsp").forward(request, response);
		
		//Si l'utilisateur est connecté
		} else {
			//Affichage de l'index pour l'utilisateur normal connecté
			request.getRequestDispatcher("/JSP_pages/index_connecte.jsp").forward(request, response);
		}

	}

	/**
	 * Post : redirige vers le Get
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
