package bean;

import java.util.List;

public class Lieu {

	private int id;
	private String nom;
	private String adresse;
	private List<Activite> activites;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getAdresse() {
		return adresse;
	}
	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}
	public List<Activite> getActivites() {
		return activites;
	}
	public void setActivites(List<Activite> activites) {
		this.activites = activites;
	}
	
	
}
