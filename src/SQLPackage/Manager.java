package SQLPackage;

import java.sql.Connection;

/**
 * 
 * @author Théo Roton
 * Classe Manager
 */
public abstract class Manager {

	//Connexion à la BDD
	protected Connection connection;
	
	/**
	 * Constructeur de la classe Manager
	 */
	public Manager() {
		connection = SQLConnector.getInstance().getEffectiveConnection();
	}
}
