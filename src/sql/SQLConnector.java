package sql;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Classe singleton permettant la connexion à la base de données
 * @author Raphaël Kimm, Théo Roton
 *
 */
public class SQLConnector {

	/**
	 * Objet représentant la database
	 */
	private static SQLConnector database = null;
	
	/**
	 * Connexion MySQL réelle
	 */
	private Connection connection = null;
	
	/**
	 * Si la connexion est établie, cette variable est à true
	 */
	private boolean connected = false;
	
	/**
	 * Constructeur privé de la connexion à la base de données. Réalise en même temps la connexion.
	 */
	private SQLConnector() {
		this.connect("database.properties");
	}
	
	/**
	 * Obtenir la base de données unique
	 * @author Raphaël Kimm, Théo Roton
	 * @return SQLConnector Singleton de la base de données unique
	 */
	public static SQLConnector getInstance() {
		if (database == null) {
			database = new SQLConnector();
		}
		
		try {
			if (!database.connected || !database.connection.isValid(5)) {
				database.connect("database.properties");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return database;
	}
	
	/**
	 * Réaliser la connexion à la base de données
	 * @author Raphaël Kimm, Théo Roton
	 * @param databaseFile Nom du fichier permettant la configuration de la base de données
	 */
	public void connect(String databaseFile) {
		if (!this.connected) {
			try {
				Class.forName("org.mariadb.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			
			try {
				InputStream is = SQLConnector.class.getClassLoader().getResourceAsStream(databaseFile);
				Properties props = new Properties();
				props.load(is);
				is.close();
				
				this.connection = DriverManager.getConnection("jdbc:" + 
																props.getProperty("database.sgbd") + 
																"://" +
																props.getProperty("database.host") +
																":" +
																props.getProperty("database.port") +
																"/" + 
																props.getProperty("database.name") + 
																"?serverTimezone=UTC", 
															   props.getProperty("database.user"), 
															   props.getProperty("database.password"));
				this.connected = true;
					
			} catch (IOException e) {
				this.connected = false;
				e.printStackTrace();
			} catch (SQLException e) {
				this.connected = false;
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Fermer la connexion à la base de données
	 * @author Raphaël Kimm
	 */
	public void close() {
		if (this.connected) {
			try {
				this.connection.close();
				this.connected = false;
			} catch (SQLException e) {
				this.connected = false;
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Retourne la connexion réelle à la base de données
	 * @author Raphaël Kimm
	 * @return Connexion réelle à la base de données
	 */
	public Connection getEffectiveConnection() {
		return this.connection;
	}
}
