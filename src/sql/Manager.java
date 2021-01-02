package sql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exception.AppException;
import exception.SevereAppException;

/**
 * 
 * @author Théo Roton, Raphaël Kimm
 * Classe Manager
 */
public abstract class Manager {

	//Connexion à la BDD
	protected Connection connection;
	
	/**
	 * Objet associé à la requête HTTP actuelle
	 */
	protected HttpServletRequest request;
	
	/**
	 * Objet associé à la réponse HTTP
	 */
	protected HttpServletResponse response;
	
	/**
	 * Constructeur de la classe Manager
	 * @param request Objet associé à la requête HTTP actuelle
	 * @param response Objet associé à la réponse HTTP
	 * @throws Exception Exception de l'application, pour erreur de BDD ou erreur autre
	 */
	public Manager(HttpServletRequest request, HttpServletResponse response) throws AppException {
		try {
			this.connection = SQLConnector.getInstance().getEffectiveConnection();
			this.request = request;
			this.response = response;
			
			if (this.connection == null)
				throw new SevereAppException("Une erreur est survenue lors de la connexion à la base de données.", request, response);
			if (this.request == null)
				throw new Exception("Request can't be null");
			if (this.response == null)
				throw new Exception("Response can't be null");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Permet d'exécuter la requête si la connexion à la base de données est fiable
	 * @param req Requête SQL
	 * @return PreparedStatement Requête préparée
	 * @throws SevereAppException
	 */
	protected PreparedStatement doRequest(String req) throws AppException {
		if (this.connection != null) {
			try {
				return this.connection.prepareStatement(req);
			} catch (SQLException e) {
				if (e.getErrorCode() == 0) {
					SQLConnector.getInstance().close();
					throw new SevereAppException("Une erreur est survenue durant la connexion à la base de données.", this.request, this.response);
				}
				else {
					throw new SevereAppException(e, this.request, this.response);
				}
			}
		}
		else {
			throw new SevereAppException("Une erreur est survenue durant la connexion à la base de données.", this.request, this.response);
		}
	}

}
