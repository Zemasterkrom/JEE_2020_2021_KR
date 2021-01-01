package bean;

/**
 * Classe représentant une notification d'ami
 * @author Raphaël Kimm
 *
 */
public class NotificationAmi extends Notification {

	/**
	 * id du demandeur dans le couple d'ami
	 */
	private int idUtilisateur;
	
	/**
	 * id de l'ami dans le couple d'ami
	 */
	private int idAmi;
	
	/**
	 * id de l'utilisateur concerné par la notification d'ami
	 */
	private int idConcerne;
	
	/**
	 * Méthode getter de l'id du demandeur dans le couple
	 * @return id du demandeur
	 */
	public int getIdUtilisateur() {
		return this.idUtilisateur;
	}
	
	/**
	 * Méthode setter de l'id du demandeur dans le couple
	 * @param idUtilisateur id du demandeur
	 */
	public void setIdUtilisateur(int idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}
	
	/**
	 * Méthode getter de l'id de l'ami dans le couple
	 * @return id de l'ami
	 */
	public int getIdAmi() {
		return this.idAmi;
	}
	
	/**
	 * Méthode setter de l'id de l'ami dans le couple
	 * @param idAmi id de l'ami
	 */
	public void setIdAmi(int idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}
	
	/**
	 * Méthode getter de l'id de l'utilisateur concerné par la notification
	 * @return id de l'utilisateur concerné par la notification
	 */
	public int getIdConcerne() {
		return this.idConcerne;
	}
	
	/**
	 * Méthode setter de l'id de l'utilisateur concerné par la notification
	 * @param idAmi id de l'utilisateur concerné
	 */
	public void setIdConcerne(int idConcerne) {
		this.idConcerne = idConcerne;
	}
}
