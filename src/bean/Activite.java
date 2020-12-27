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
	 * Id de l'utilisateur possédant l'activité
	 */
	private int idUtilisateur;
	/**
	 * Id du lieu où se déroule l'activité
	 */
	private int idLieu;
	
	/**
	 * Méthode getter de l'id
	 * @return id de l'activité
	 */
	public int getId() {
		return id;
	}
	
	/**
	 * Méthode setter de l'id
	 * @param id de l'activité
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Méthode getter de la date de début
	 * @return dateDebut de l'activité
	 */
	public Timestamp getDateDebut() {
		return dateDebut;
	}
	
	/**
	 * Méthode setter de la date de début
	 * @param dateDebut de l'activité
	 */
	public void setDateDebut(Timestamp dateDebut) {
		this.dateDebut = dateDebut;
	}
	
	/**
	 * Méthode getter de la date de fin
	 * @return dateFin de l'activité
	 */
	public Timestamp getDateFin() {
		return dateFin;
	}
	
	/**
	 * Méthode setter de la date de fin
	 * @param dateFin de l'activité
	 */
	public void setDateFin(Timestamp dateFin) {
		this.dateFin = dateFin;
	}

	/**
	 * Méthode getter de l'id de l'utilisateur
	 * @return idUtilisateur de l'activité
	 */
	public int getIdUtilisateur() {
		return idUtilisateur;
	}

	/**
	 * Méthode setter de l'id de l'utilisateur
	 * @param idUtilisateur de l'activité
	 */
	public void setIdUtilisateur(int idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}

	/**
	 * Méthode getter de l'id du lieu
	 * @return idLieu de l'activité
	 */
	public int getIdLieu() {
		return idLieu;
	}

	/**
	 * Méthode setter de l'id du lieu
	 * @param idLieu de l'activité
	 */
	public void setIdLieu(int idLieu) {
		this.idLieu = idLieu;
	}

	
}
