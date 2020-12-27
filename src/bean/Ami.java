package bean;

/**
 * 
 * @author Théo Roton
 * Classe Ami
 */
public class Ami {
	
	/**
	 * Id de l'utilisateur effectuant la demande
	 */
	private int idUtilisateur;	
	/**
	 * Id de l'utilisateur ajouté en ami
	 */
	private int idAmi;
	/**
	 * Boolean qui indique si la demande a été accepté
	 */
	private boolean accepte;
	
	/**
	 * Méthode getter de l'id de l'utilisateur effectuant la demande
	 * @return id de l'utilisateur
	 */
	public int getIdUtilisateur() {
		return idUtilisateur;
	}
	
	/**
	 * Méthode setter de l'id de l'utilisateur effectuant la demande
	 * @param id de l'utilisateur
	 */
	public void setIdUtilisateur(int idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}
	
	/**
	 * Méthode getter de l'id de l'utilisateur ajouté en ami
	 * @return id de l'ami
	 */
	public int getIdAmi() {
		return idAmi;
	}
	
	/**
	 * Méthode setter de l'id de l'utilisateur ajouté en ami
	 * @param id de l'ami
	 */
	public void setIdAmi(int idAmi) {
		this.idAmi = idAmi;
	}
	
	/**
	 * Méthode getter de l'état de la demande d'ami
	 * @return true si la demande a été acceptée
	 */
	public boolean isAccepte() {
		return accepte;
	}
	
	/**
	 * Méthode setter de l'état de la demande d'ami
	 * @param boolean qui indique l'état de la demande
	 */
	public void setAccepte(boolean accepte) {
		this.accepte = accepte;
	}
	
	

}
