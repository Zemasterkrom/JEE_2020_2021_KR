package sql;

import java.sql.Connection;

/**
 * 
 * @author Th�o Roton
 * Classe Manager
 */
public abstract class Manager {

	//Connexion � la BDD
	protected Connection connection;
	
	/**
	 * Constructeur de la classe Manager
	 */
	public Manager() {
		connection = SQLConnector.getInstance().getEffectiveConnection();
	}
}
