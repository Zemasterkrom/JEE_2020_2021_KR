package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Utilisateur;

/**
 * @author Th�o Roton
 * Servlet qui g�re l'index
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
	 * Get : on affiche l'index en fonction de si l'utilisateur est connect� ou non
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//R�cup�ration de la session et de l'utilisateur
		HttpSession session = request.getSession();
		Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
		
		response.setContentType("text/html");
		
		//Si l'utilisateur n'est pas connect�
		if (utilisateur == null) {
			//Affichage de l'index pour l'utilisateur non connect�
			request.getRequestDispatcher("/JSP_pages/index_non_connecte.jsp").forward(request, response);
		
		//Si l'utilisateur est connect�
		} else {
			//Affichage de l'index pour l'utilisateur normal connect�
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
