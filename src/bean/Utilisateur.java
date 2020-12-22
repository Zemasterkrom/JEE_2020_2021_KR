package bean;

import java.util.Date;

/**
 * 
 * @author Th�o Roton
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
	 * Pr�nom de l'utilisateur
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
	 * M�thode getter du nom
	 * @return nom de l'utilisateur
	 */
	public String getNom() {
		return nom;
	}
	
	/**
	 * M�thode setter du nom
	 * @param nom de l'utilisateur
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	/**
	 * M�thode getter du pr�nom
	 * @return pr�nom de l'utilisateur
	 */
	public String getPrenom() {
		return prenom;
	}
	
	/**
	 * M�thode setter du pr�nom
	 * @param pr�nom de l'utilisateur
	 */
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	
	/**
	 * M�thode getter de la date de naissance
	 * @return date de naissance de l'utilisateur
	 */
	public Date getDateNaiss() {
		return dateNaiss;
	}
	
	/**
	 * M�thode setter de la date de naissance
	 * @param date de naissance de l'utilisateur
	 */
	public void setDateNaiss(Date dateNaiss) {
		this.dateNaiss = dateNaiss;
	}
	
	/**
	 * M�thode getter du login
	 * @return login de l'utilisateur
	 */
	public String getLogin() {
		return login;
	}
	
	/**
	 * M�thode setter du login
	 * @param login de l'utilisateur
	 */
	public void setLogin(String login) {
		this.login = login;
	}
	
	/**
	 * M�thode getter du mot de passe
	 * @return mot de passe de l'utilisateur
	 */
	public String getMotDePasse() {
		return motDePasse;
	}
	
	/**
	 * M�thode setter du mot de passe
	 * @param mot de passe de l'utilisateur
	 */
	public void setMotDePasse(String motDePasse) {
		this.motDePasse = motDePasse;
	}
	
	/**
	 * M�thode getter du rang
	 * @return rang de l'utilisateur
	 */
	public String getRang() {
		return rang;
	}
	
	/**
	 * M�thode setter du rang
	 * @param rang de l'utilisateur
	 */
	public void setRang(String rang) {
		this.rang = rang;
	}
	
	/**
	 * M�thode getter de l'id
	 * @return id de l'utilisateur
	 */
	public int getId() {
		return id;
	}

	/**
	 * M�thode setter de l'id
	 * @param id de l'utilisateur
	 */
	public void setId(int id) {
		this.id = id;
	}
	
}
