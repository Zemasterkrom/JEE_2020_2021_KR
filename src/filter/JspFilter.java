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
@WebFilter("*.jsp")
public class JspFilter implements Filter {
	
	private static String[] RESTRICTED_ACCESS_PAGES = new String[] {
			"/signout",
			"/account",
			"/modifyAccount",
			"/modifyPassword",
			"/admin",
			"/users",
			"/modifyUserRank",
			"/deleteUser",
			"/activities",
			"/deleteActivity",
			"/places",
			"/deletePlace",
			"/friends",
			"/acceptFriendRequest",
			"/rejectFriendRequest",
			"/cancelFriendRequest",
			"/deleteFriend",
			"/moreFriends",
			"/addFriend",
			"/contaminationNotifications",
			"/deleteContaminationNotification",
			"/friendNotifications",
			"/deleteFriendNotification",
			"/declaration",
			"/addActivity",
			"/addPlace"
	};

    /**
     * Default constructor. 
     */
    public JspFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		StringBuffer reqUrl = ((HttpServletRequest) request).getRequestURL();
		int liofSlash = reqUrl.lastIndexOf("/")+1;
		int liofQuestion = reqUrl.lastIndexOf("?") != -1 ? reqUrl.lastIndexOf("?")-1 : reqUrl.length();
		String action = reqUrl.substring(liofSlash, liofQuestion);
		Utilisateur utilisateur = ((Utilisateur)((HttpServletRequest) request).getSession().getAttribute("Utilisateur_courant"));
			

		if (action.isBlank()) {
			((HttpServletResponse) response).sendRedirect("home");
		}
		else {
			boolean authorized = true;
			
			if (reqUrl.toString().contains(".jsp")) {
				authorized = false;
				((HttpServletResponse) response).sendRedirect("error?error=" + URLEncoder.encode("Vous n'êtes pas autorisé à accéder à cette page", "UTF-8"));
			}
			
			for (String restrictedUrl:RESTRICTED_ACCESS_PAGES) {
				if (reqUrl.toString().contains(restrictedUrl) && utilisateur == null) {
					authorized = false;
					((HttpServletResponse) response).sendRedirect("error?error=" + URLEncoder.encode("Vous n'êtes pas autorisé à accéder à cette page", "UTF-8"));
				}
			}
			
			if (authorized) {
				chain.doFilter(request, response);
			}
		}	
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
