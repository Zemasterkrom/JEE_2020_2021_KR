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
	public String getNomLieu() {
		return nomLieu;
	}
	public void setNomLieu(String nomLieu) {
		this.nomLieu = nomLieu;
	}

	
}
