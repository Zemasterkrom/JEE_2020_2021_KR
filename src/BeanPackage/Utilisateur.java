package BeanPackage;

import java.util.Date;

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
	
}
