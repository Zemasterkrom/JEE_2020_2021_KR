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
	/*
	 * Lieu de l'activité
	 */
	private String nomLieu;
	
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
	 * Méthode getter du nom du lieu
	 * @return nomLieu de l'activité
	 */
	public String getNomLieu() {
		return nomLieu;
	}
	
	/**
	 * Méthode setter du nom du lieu
	 * @param nomLieu de l'activité
	 */
	public void setNomLieu(String nomLieu) {
		this.nomLieu = nomLieu;
	}

	
}
