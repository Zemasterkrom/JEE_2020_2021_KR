package bean;

import java.sql.Timestamp;

/**
 * 
 * @author Raphaël Kimm
 * Classe Etat
 */
public class Etat {
	
	/**
	 * Id de l'état
	 */
	private int id;
	
	/**
	 * Date de l'état
	 */
	private Timestamp dateEtat;
	
	/**
	 * Représente si l'individu est positif ou non à l'état actuel
	 */
	private boolean positif;

	/**
	 * Méthode getter de l'id
	 * @return id de l'état
	 */
	public int getId() {
		return id;
	}

	/**
	 * Méthode setter de l'id
	 * @param id id de l'état
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * Méthode getter de la date de l'état
	 * @return date de l'état
	 */
	public Timestamp getDateEtat() {
		return dateEtat;
	}

	/**
	 * Méthode setter de la date de l'état
	 * @param dateEtat
	 */
	public void setDateEtat(Timestamp dateEtat) {
		this.dateEtat = dateEtat;
	}

	/**
	 * Méthode getter de l'état
	 * @return true si positif, false sinon
	 */
	public boolean isPositif() {
		return positif;
	}

	/**
	 * Méthode setter de l'état
	 * @param positif true si positif, false sinon
	 */
	public void setPositif(boolean positif) {
		this.positif = positif;
	}
	
	
		
}
