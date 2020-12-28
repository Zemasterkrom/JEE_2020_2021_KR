package bean;

import java.util.Date;
import java.util.List;

/**
 * 
 * @author Théo Roton
 * Classe Utilisateur
 */
public class Utilisateur {
	
	/**
	 * Id de l'utilisateur
	 */
	private int id;
	/**
	 * Nom de l'utilisateur
	 */
	private String nom;
	/**
	 * Prénom de l'utilisateur
	 */
	private String prenom;
	/**
	 * Date de naissance de l'utilisateur
	 */
	private Date dateNaiss;
	/**
	 * Login de l'utilisateur
	 */
	private String login;
	/**
	 * Mot de passe de l'utilisateur
	 */
	private String motDePasse;
	/**
	 * Rang de l'utilisateur
	 */
	private String rang;
	/**
	 * image de profil de l'utilisateur
	 */
	private String image;
	/**
	 * Liste des activités de l'utilisateur
	 */
	private List<Activite> activites;
	/**
	 * Liste des amis de l'utilisateur
	 */
	private List<Ami> amis;
	/**
	 * Liste des demandes d'amis reçues de l'utilisateur
	 */
	private List<Ami> demandesRecues;
	/**
	 * Liste des demandes d'amis envoyées par l'utilisateur
	 */
	private List<Ami> demandesEnvoyees;
	
	/**
	 * Méthode getter du nom
	 * @return nom de l'utilisateur
	 */
	public String getNom() {
		return nom;
	}
	
	/**
	 * Méthode setter du nom
	 * @param nom de l'utilisateur
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	/**
	 * Méthode getter du prénom
	 * @return prénom de l'utilisateur
	 */
	public String getPrenom() {
		return prenom;
	}
	
	/**
	 * Méthode setter du prénom
	 * @param prénom de l'utilisateur
	 */
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	
	/**
	 * Méthode getter de la date de naissance
	 * @return date de naissance de l'utilisateur
	 */
	public Date getDateNaiss() {
		return dateNaiss;
	}
	
	/**
	 * Méthode setter de la date de naissance
	 * @param date de naissance de l'utilisateur
	 */
	public void setDateNaiss(Date dateNaiss) {
		this.dateNaiss = dateNaiss;
	}
	
	/**
	 * Méthode getter du login
	 * @return login de l'utilisateur
	 */
	public String getLogin() {
		return login;
	}
	
	/**
	 * Méthode setter du login
	 * @param login de l'utilisateur
	 */
	public void setLogin(String login) {
		this.login = login;
	}
	
	/**
	 * Méthode getter du mot de passe
	 * @return mot de passe de l'utilisateur
	 */
	public String getMotDePasse() {
		return motDePasse;
	}
	
	/**
	 * Méthode setter du mot de passe
	 * @param mot de passe de l'utilisateur
	 */
	public void setMotDePasse(String motDePasse) {
		this.motDePasse = motDePasse;
	}
	
	/**
	 * Méthode getter du rang
	 * @return rang de l'utilisateur
	 */
	public String getRang() {
		return rang;
	}
	
	/**
	 * Méthode setter du rang
	 * @param rang de l'utilisateur
	 */
	public void setRang(String rang) {
		this.rang = rang;
	}
	
	/**
	 * Méthode getter de l'id
	 * @return id de l'utilisateur
	 */
	public int getId() {
		return id;
	}

	/**
	 * Méthode setter de l'id
	 * @param id de l'utilisateur
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Méthode getter de l'image de profil
	 * @return image de profil de l'utilisateur
	 */
	public String getImage() {
		return image;
	}

	/**
	 * Méthode setter de l'image de profil
	 * @param image de profil de l'utilisateur
	 */
	public void setImage(String image) {
		this.image = image;
	}

	/**
	 * Méthode getter de la liste des activités de l'utilisateur
	 * @return activités de l'utilisateur
	 */
	public List<Activite> getActivites() {
		return activites;
	}

	/**
	 * Méthode setter de la liste des activités de l'utilisateur
	 * @param activites de l'utilisateur
	 */
	public void setActivites(List<Activite> activites) {
		this.activites = activites;
	}

	/**
	 * Méthode getter de la liste des amis de l'utilisateur
	 * @return amis de l'utilisateur
	 */
	public List<Ami> getAmis() {
		return amis;
	}

	/**
	 * Méthode setter de la liste des amis de l'utilisateur
	 * @param amis de l'utilisateur
	 */
	public void setAmis(List<Ami> amis) {
		this.amis = amis;
	}

	/**
	 * Méthode getter de la liste des demandes d'ami reçues de l'utilisateur
	 * @return demandes d'ami reçues de l'utilisateur
	 */
	public List<Ami> getDemandesRecues() {
		return demandesRecues;
	}

	/**
	 * Méthode setter de la liste des demandes d'ami reçues de l'utilisateur
	 * @return demandes d'ami reçues de l'utilisateur
	 */
	public void setDemandesRecues(List<Ami> demandesRecues) {
		this.demandesRecues = demandesRecues;
	}

	/**
	 * Méthode getter de la liste des demandes d'ami envoyées par l'utilisateur
	 * @return demandes d'ami envoyées par l'utilisateur
	 */
	public List<Ami> getDemandesEnvoyees() {
		return demandesEnvoyees;
	}

	/**
	 * Méthode setter de la liste des demandes d'ami envoyées par l'utilisateur
	 * @return demandes d'ami envoyées par l'utilisateur
	 */
	public void setDemandesEnvoyees(List<Ami> demandesEnvoyees) {
		this.demandesEnvoyees = demandesEnvoyees;
	}
		
}
