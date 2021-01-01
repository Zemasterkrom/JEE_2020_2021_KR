package exception;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Classe abstraite représentant une exception générique
 * @author Raphaël Kimm
 *
 */
public abstract class AppException extends Exception {
	private static final long serialVersionUID = 1L;
	protected static final String HOME = "/", ERROR = "error";
	
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected String message, url;

	/**
	 * Constructeur d'une exception de l'application
	 * @param url Url de redirection
	 * @param s Exception de type AppException
	 * @param request Requête HTTP
	 * @param response Réponse HTTP
	 */
	public AppException(String url, Throwable t, HttpServletRequest request, HttpServletResponse response) {
		super(t);
		this.request = request;
		this.response = response;
		this.message = t.getMessage() != null ? t.getMessage() : "Erreur";
		try {
			this.url = url != null ? url + "?error=" + URLEncoder.encode(this.message, "UTF-8") : "/error?error=" + URLEncoder.encode(this.message, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Constructeur d'une exception de l'application
	 * @param s Message de l'exception
	 * @param request Requête HTTP
	 * @param response Réponse HTTP
	 */
	public AppException(String url, String s, HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		this.message = s != null ? s : "Erreur";
		try {
			this.url = url != null ? url + "?error=" + URLEncoder.encode(this.message, "UTF-8") : "/error?error=" + URLEncoder.encode(this.message, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Rediriger à une page d'erreur selon l'exception utilisée
	 */
	public void redirigerPageErreur() {
		try {
			if (this.request != null && this.response != null) {
				response.sendRedirect(this.url);
			}
			else {
				System.err.println("Request and response can't be null");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Rediriger vers une route personnalisée
	 * @param url Route
	 */
	public void redirigerPageErreur(String url) {
		try {
			this.url = url != null ? url + "?error=" + URLEncoder.encode(this.message, "UTF-8") : "/error?error=" + URLEncoder.encode(this.message, "UTF-8");
			this.redirigerPageErreur();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Retourne le message d'erreur de l'exception
	 * @return Message d'erreur de l'exception
	 */
	public String getMessage() {
		return this.message;
	}
}
