package sql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.CallableStatement;

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
	
	/**
	 * Méthode qui permet de récupérer tous les amis d'un utilisateur
	 * @param id de l'utilisateur
	 * @return liste d'amis de l'utilisateur
	 */
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
	
	/**
	 * Méthode qui permet de récupérer toutes les demandes d'ami reçues de l'utilisateur
	 * @param id de l'utilisateur
	 * @return liste des demandes d'ami de l'utilisateur
	 */
	public List<Ami> getDemandesAmiRecues(int id) {
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
	
	/**
	 * Méthode qui permet de récupérer toutes les demandes d'ami envoyées par l'utilisateur
	 * @param id de l'utilisateur
	 * @return liste des demandes d'ami de l'utilisateur
	 */
	public List<Ami> getDemandesAmiEnvoyees(int id) {
		//Initialisation de la liste
		List<Ami> demandes = new ArrayList<Ami>();
		
		try {
			//Requête
			String req = "SELECT * FROM Ami WHERE idUtilisateur=? AND accepte=0";
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

	/**
	 * Méthode qui permet d'accepter une demande d'ami
	 * @param idAccepteur : id de l'utilisateur qui accepte la demande
	 * @param idAmi : id de l'utilisateur dont la demande émane
	 */
	public void accepterDemandeAmi(int idAccepteur, int idAmi) {		
		try {
			//Préparation de la requête
			CallableStatement cstmt = connection.prepareCall("{call accepter_ami(?, ?)}");
			//Ajout des id à la requête
			cstmt.setInt(1, idAccepteur);
			cstmt.setInt(2, idAmi);
			//Exécution de la requête
			cstmt.execute();
						
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * Méthode qui permet de refuser une demande d'ami
	 * @param idRefuseur : id de l'utilisateur qui refuse la demande
	 * @param idAmi : id de l'utilisateur dont la demande émane
	 */
	public void refuserDemandeAmi(int idRefuseur, int idAmi) {
		try {
			//Préparation de la requête
			CallableStatement cstmt = connection.prepareCall("{call supprimer_refuser_ami(?, ?)}");
			//Ajout des id à la requête
			cstmt.setInt(1, idRefuseur);
			cstmt.setInt(2, idAmi);
			//Exécution de la requête
			cstmt.execute();
						
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}

	/**
	 * Méthode qui permet de supprimer un ami
	 * @param idUtilisateur : id de l'utilisateur qui supprime un ami
	 * @param idAmi : id de l'ami supprimer
	 */
	public void supprimerAmi(int idUtilisateur, int idAmi) {
		try {
			//Préparation de la requête
			CallableStatement cstmt = connection.prepareCall("{call supprimer_refuser_ami(?, ?)}");
			//Ajout des id à la requête
			cstmt.setInt(1, idUtilisateur);
			cstmt.setInt(2, idAmi);
			//Exécution de la requête
			cstmt.execute();
						
		} catch (SQLException e) {
			e.printStackTrace();
		}			
	}
	
	public Ami getAmi(int idUtilisateur, int idAmi) {
		//Initialisation de l'ami
		Ami ami = null;
		
		try {
			//Requête
			String req = "SELECT * FROM Ami WHERE (idUtilisateur=? AND idAmi=?) OR (idUtilisateur=? AND idAmi=?)";
			//Préparation de la requête
			PreparedStatement stmt = connection.prepareStatement(req);
			//Ajout des id à la requête
			stmt.setInt(1, idUtilisateur);
			stmt.setInt(2, idAmi);
			stmt.setInt(3, idAmi);
			stmt.setInt(4, idUtilisateur);
			//Exécution de la requête
			ResultSet results = stmt.executeQuery();
			
			//Récupération du résultat
			if (results.next()) {
				//Initialisation de l'ami
				ami = new Ami();
				
				//Ajout des informations de l'ami
				ami.setIdUtilisateur(results.getInt("idUtilisateur"));
				ami.setIdAmi(results.getInt("idAmi"));
				ami.setAccepte(results.getBoolean("accepte"));				
			} 
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return ami;
	}

}
