package bean;

import java.sql.Timestamp;

/**
 * 
 * @author Théo Roton
 * Classe Activite
 */
public class Activite {

	/**
	 * Id de l'activité
	 */
	private int id;
	/**
	 * Date de début de l'activité
	 */
	private Timestamp dateDebut;
	/**
	 * Date de fin de l'activité
	 */
	private Timestamp dateFin;
	/**
	 * Id de l'utilisateur à qui appartient l'activité
	 */
	private int idUtilisateur;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Timestamp getDateDebut() {
		return dateDebut;
	}
	public void setDateDebut(Timestamp dateDebut) {
		this.dateDebut = dateDebut;
	}
	public Timestamp getDateFin() {
		return dateFin;
	}
	public void setDateFin(Timestamp dateFin) {
		this.dateFin = dateFin;
	}
	public int getIdUtilisateur() {
		return idUtilisateur;
	}
	public void setIdUtilisateur(int idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}
	

	
}
