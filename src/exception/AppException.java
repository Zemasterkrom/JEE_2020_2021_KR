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
	
	/**
	 * Pages génériques de redirection
	 */
	protected static final String HOME = "/", ERROR = "/error";
	
	/**
	 * Requête HTTP actuelle
	 */
	protected HttpServletRequest request;
	
	/**
	 * Réponse HTTP actuelle
	 */
	protected HttpServletResponse response;
	
	/**
	 * Message de l'erreur, URL et paramètres supplémentaires
	 */
	protected String message, url, params;
	
	/**
	 * Messages d'erreurs génériques en cas de tentative de corruption des données
	 */
	public static final String ALTERED_DATA_ERROR = "Les données ont été altérées. ",
			FORBIDDEN_ADDITION_ERROR = "Ajout non autorisé. ",
			FORBIDDEN_DELETION_ERROR = "Suppression non autorisée. ",
			FORBIDDEN_MODIFICATION_ERROR = "Modification non autorisée. ",
			FORBIDDEN_CONNECTION_ERROR = "Connexion non autorisée. ",
			FORBIDDEN_REGISTRATION_ERROR = "Connexion non autorisée. ";

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
		this.params = "";
		try {
			this.url = url != null ? url + "?error=" + URLEncoder.encode(this.message, "UTF-8") : request.getContextPath() + "/error?error=" + URLEncoder.encode(this.message, "UTF-8");
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
		this.params = "";
		try {
			this.url = url != null ? request.getContextPath() + url + "?error=" + URLEncoder.encode(this.message, "UTF-8") : request.getContextPath() + "/error?error=" + URLEncoder.encode(this.message, "UTF-8");
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
	 * Ajouter un attribut à la requête de redirection
	 * @param param Id de l'attribut dans la requête
	 */
	public void ajouterAttribut(String param) {
		if (this.request != null) {
			try {
				this.params += "&" + param + "=" + URLEncoder.encode(this.request.getParameter(param), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		else {
			System.err.println("Request can't be null");
		}
	}
	
	/**
	 * Rediriger vers une route personnalisée
	 * @param url Route
	 */
	public void redirigerPageErreur(String url) {
		try {
			this.url = url != null ? request.getContextPath() + url + "?error=" + URLEncoder.encode(this.message, "UTF-8") + this.params : request.getContextPath() + "/error?error=" + URLEncoder.encode(this.message, "UTF-8") + this.params;
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
