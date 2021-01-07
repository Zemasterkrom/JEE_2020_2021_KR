package filter;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Utilisateur;

/**
 * Servlet Filter implementation class JspFilter
 */
@WebFilter("*")
public class JspFilter implements Filter {
	
	private static String[] RESTRICTED_ACCESS_PAGES = new String[] {
			"signout",
			"account",
			"modifyAccount",
			"modifyPassword",
			"friends",
			"acceptFriendRequest",
			"rejectFriendRequest",
			"cancelFriendRequest",
			"deleteFriend",
			"moreFriends",
			"addFriend",
			"contaminationNotifications",
			"deleteContaminationNotification",
			"friendNotifications",
			"deleteFriendNotification",
			"declaration",
			"addActivity",
			"addPlace"
	};
	
	private static String[] ADMIN_RESTRICTED_PAGES = new String[] {
			"admin",
			"users",
			"modifyPlace",
			"modifyUserRank",
			"deleteUser",
			"activities",
			"deleteActivity",
			"places",
			"deletePlace",
	};

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		StringBuffer reqUrl = ((HttpServletRequest) request).getRequestURL();
		boolean blank = reqUrl.toString().matches("^http:\\/\\/.+\\/[^a-z]+\\/$");
		String contextPath = ((HttpServletRequest) request).getContextPath();
		
		// Si la la requête est considérée comme vide, on redirige vers la page d'accueil
		if (blank) {
			((HttpServletResponse) response).sendRedirect(contextPath + "/home");
			return;
		}
		
		int liofSlash = reqUrl.lastIndexOf("/")+1;
		int liofQuestion = reqUrl.lastIndexOf("?") != -1 ? reqUrl.lastIndexOf("?")-1 : reqUrl.length();
		String action = reqUrl.substring(liofSlash, liofQuestion);
		Utilisateur utilisateur = ((Utilisateur)((HttpServletRequest) request).getSession().getAttribute("Utilisateur_courant"));
		
		// On interdit l'accès direct aux pages JSP
		if (reqUrl.toString().contains(".jsp")) {
			((HttpServletResponse) response).sendRedirect(contextPath + "/error?error=" + URLEncoder.encode("Vous n'êtes pas autorisé à accéder à cette page", "UTF-8"));
			return;
		}
		
		if (utilisateur == null) {
			// L'utilisateur n'est pas connecté, il ne doit avoir accès à aucune page hormis l'accueil, la page de connexion ou d'inscription
			for (String restrictedUrl:RESTRICTED_ACCESS_PAGES) {
				if (action.equals(restrictedUrl)) {
					((HttpServletResponse) response).sendRedirect(contextPath + "/error?error=" + URLEncoder.encode("Vous n'êtes pas autorisé à accéder à cette page", "UTF-8"));
					return;
				}
			}
				
			for (String restrictedUrl:ADMIN_RESTRICTED_PAGES) {
				if (action.equals(restrictedUrl)) {
					((HttpServletResponse) response).sendRedirect(contextPath + "/error?error=" + URLEncoder.encode("Vous n'êtes pas autorisé à accéder à cette page", "UTF-8"));
					return;
				}
			}
		}
			
		if (utilisateur != null && utilisateur.getRang().equals("normal")) {
			// L'utilisateur n'est pas un administrateur, il ne doit pas pouvoir accéder aux ressources réservées aux administrateurs
			for (String restrictedUrl:ADMIN_RESTRICTED_PAGES) {
				if (action.equals(restrictedUrl)) {
					((HttpServletResponse) response).sendRedirect(contextPath + "/error?error=" + URLEncoder.encode("Vous n'êtes pas autorisé à accéder à cette page", "UTF-8"));
					return;
				}
			}
		}
		
		// Toutes les conditions ont été vérifiées, on valide la requête
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
