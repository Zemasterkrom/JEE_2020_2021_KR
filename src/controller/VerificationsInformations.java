package controller;

import java.util.Date;

/**
 * 
 * @author Théo Roton
 * Classe qui permet de vérifier les informations données par l'utlisateur
 */
public class VerificationsInformations {

	/**
	 * Méthode qui permet de vérifier le format du nom
	 * @param nom de l'utilisateur
	 * @return true si le nom respecte le format (lettres minuscules et majuscules, caractères accentuées et tiret)
	 */
	public boolean verifFormatNom(String nom) {
		return nom.matches("[a-zA-ZÀ-ÖÙ-öù-ÿ-]+");
	}
	
	/**
	 * Méthode qui permet de vérifier la taille du nom
	 * @param nom de l'utilisateur
	 * @return true si le nom respecte la taille (max: 64 caractères)
	 */
	public boolean verifTailleNom(String nom) {
		return (nom.length() <= 64);
	}
	
	/**
	 * Méthode qui permet de vérifier le format du prénom
	 * @param prenom de l'utilisateur
	 * @return true si le prénom respecte le format (lettres minuscules et majuscules, caractères accentuées et tiret)
	 */
	public boolean verifFormatPrenom(String prenom) {
		return prenom.matches("[a-zA-ZÀ-ÖÙ-öù-ÿ-]+");
	}
	
	/**
	 * Méthode qui permet de vérifier la taille du prénom
	 * @param prenom de l'utilisateur
	 * @return true si le prénom respecte la taille (max: 64 caractères)
	 */
	public boolean verifTaillePrenom(String prenom) {
		return (prenom.length() <= 64);
	}
	
	/**
	 * Méthode qui permet de vérifier si la date de naissance n'est pas encore passée
	 * @param date de naissance de l'utilisateur
	 * @return true si la date est déjà passée
	 */
	public boolean verifDate(Date date) {
		return date.before(new Date());
	}
	
	/**
	 * Méthode qui permet de vérifier le format du login
	 * @param login de l'utilisateur
	 * @return true si le login respecte le format (lettres minuscules et majuscules, chiffres, tiret et un seul mot)
	 */
	public boolean verifFormatLogin(String login) {
		return login.matches("^[a-zA-Z0-9-]+$");
	}
	
	/**
	 * Méthode qui permet de vérifier la taille du login
	 * @param login de l'utilisateur
	 * @return true si le login respecte la taille (min: 3 caractères & max: 64 caractères)
	 */
	public boolean verifTailleLogin(String login) {
		return (login.length() >= 3 && login.length() <= 64);
	}
}
