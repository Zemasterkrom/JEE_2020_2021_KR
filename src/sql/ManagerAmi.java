package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Ami;

/**
 * 
 * @author Théo Roton
 * Classe ManagerAmi
 */
public class ManagerAmi extends Manager {

	/**
	 * Constructeur de la classe ManagerAmi
	 */
	public ManagerAmi() {
		super();
	}
	
	public List<Ami> getAmis(int id) {
		//Initialisation de la liste
		List<Ami> amis = new ArrayList<Ami>();
		
		try {
			//Requête
			String req = "SELECT * FROM Ami WHERE (idUtilisateur=? OR idAmi=?) AND accepte=1";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			stmt.setInt(2, id);
			//Exécution de la requête
			ResultSet results = stmt.executeQuery();
			
			Ami a;
			//Pour chaque ami
			while (results.next()) {
				a = new Ami();
				
				//Ajout des informations de l'ami
				a.setIdUtilisateur(results.getInt("idUtilisateur"));
				a.setIdAmi(results.getInt("idAmi"));
				a.setAccepte(results.getBoolean("accepte"));
				
				//Ajout de l'ami à la liste
				amis.add(a);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return amis;
	}
	
	public List<Ami> getDemandesAmi(int id) {
		//Initialisation de la liste
		List<Ami> demandes = new ArrayList<Ami>();
		
		try {
			//Requête
			String req = "SELECT * FROM Ami WHERE idAmi=? AND accepte=0";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout de l'id à la requête
			stmt.setInt(1, id);
			//Exécution de la requête
			ResultSet results = stmt.executeQuery();
			
			Ami a;
			//Pour chaque demande d'ami
			while (results.next()) {
				a = new Ami();
				
				//Ajout des informations de la demande d'ami
				a.setIdUtilisateur(results.getInt("idUtilisateur"));
				a.setIdAmi(results.getInt("idAmi"));
				a.setAccepte(results.getBoolean("accepte"));
				
				//Ajout de la demande d'ami à la liste
				demandes.add(a);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return demandes;
	}
}
