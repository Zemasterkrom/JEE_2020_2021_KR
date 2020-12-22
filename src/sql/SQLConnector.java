package sql;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class SQLConnector {

	private static SQLConnector database = null;
	private Connection connection = null;
	private boolean connected = false;
	
	private SQLConnector() {
		this.connect("database.properties");
	}
	
	public static SQLConnector getInstance() {
		if (database == null) {
			database = new SQLConnector();
		}
		
		return database;
	}
	
	public void connect(String databaseFile) {
		if (!this.connected) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			
			try {
				InputStream is = SQLConnector.class.getClassLoader().getResourceAsStream(databaseFile);
				Properties props = new Properties();
				props.load(is);
				is.close();
				
				this.connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+ props.getProperty("database.name")+"?serverTimezone=UTC", 
															   props.getProperty("database.user"), 
															   props.getProperty("database.password"));
				this.connected = true;
					
			} catch (IOException e) {
				database = null;
				this.connected = false;
				e.printStackTrace();
				System.out.println("erreur1");
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("erreur2");
			}
		}
	}
	
	
	public void close() {
		if (this.connected) {
			try {
				this.connection.close();
				this.connected = false;
				
			} catch (SQLException e) {
				e.printStackTrace();
				
			}
		}
	}
	
	
	public Connection getEffectiveConnection() {
		return this.connection;
	}
}
