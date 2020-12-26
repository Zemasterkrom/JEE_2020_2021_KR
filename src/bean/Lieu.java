package bean;

import java.util.List;

public class Lieu {

	private int id;
	private String nom;
	private String adresse;
	private List<Activite> activites;
	
	/**
	 * Méthode getter de l'id
	 * @return id du lieu
	 */
	public int getId() {
		return id;
	}
	
	/**
	 * Méthode setter de l'id
	 * @param id du lieu
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Méthode getter du nom
	 * @return nom du lieu
	 */
	public String getNom() {
		return nom;
	}
	
	/**
	 * Méthode setter du nom
	 * @param nom du lieu
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	/**
	 * Méthode getter de l'adresse
	 * @return adresse du lieu
	 */
	public String getAdresse() {
		return adresse;
	}
	
	/**
	 * Méthode setter de l'adresse
	 * @param adresse du lieu
	 */
	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}
	
	/**
	 * Méthode getter des activités
	 * @return activites du lieu
	 */
	public List<Activite> getActivites() {
		return activites;
	}
	
	/**
	 * Méthode setter des activités
	 * @param activites du lieu
	 */
	public void setActivites(List<Activite> activites) {
		this.activites = activites;
	}
	
	
}
