package bean;

/**
 * Classe représentant une notification de contamination
 * @author Raphaël Kimm
 *
 */
public class NotificationContamination extends Notification {

	/**
	 * id de l'utilisateur concerné par la notification de contamination
	 */
	private int idUtilisateur;
	
	/**
	 * id de l'utilisateur contaminé
	 */
	private int idContamine;
	
	/**
	 * id de l'état positif de l'utilisateur contaminé
	 */
	private int idEtat;
	
	/**
	 * Méthode getter de l'id de l'utilisateur concerné par la notification de contamination
	 * @return id de l'utilisateur concerné par la notification de contamination
	 */
	public int getIdUtilisateur() {
		return this.idUtilisateur;
	}
	
	/**
	 * Méthode setter de l'id de l'utilisateur concerné par la notification de contamination
	 * @param idUtilisateur id de l'utilisateur concerné par la notification de contamination
	 */
	public void setIdUtilisateur(int idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}
	
	/**
	 * Méthode setter de l'id de l'utilisateur contaminé
	 * @param idAmi id de l'utilisateur contaminé
	 */
	public void setIdAmi(int idContamine) {
		this.idContamine = idContamine;
	}
	
	/**
	 * Méthode getter de l'id de l'utilisateur contaminé
	 * @return id de l'utilisateur contaminé
	 */
	public int getIdContamine() {
		return this.idContamine;
	}
	
	/**
	 * Méthode getter de l'id de l'état positif de l'utilisateur contaminé
	 * @return id de l'état positif de l'utilisateur contaminé
	 */
	public int getIdEtat() {
		return this.idEtat;
	}
	
	/**
	 * Méthode setter de l'id de l'état positif de l'utilisateur contaminé
	 * @param idAmi id de l'état positif de l'utilisateur contaminé
	 */
	public void setIdEtat(int idEtat) {
		this.idEtat = idEtat;
	}
}
