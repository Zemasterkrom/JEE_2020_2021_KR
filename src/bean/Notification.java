package bean;

/**
 * Classe générale représentant les notifications
 * @author Raphaël Kimm
 *
 */
public abstract class Notification {

	protected int id;
	protected String message;
	protected boolean vue;
	
	/**
	 * Méthode getter de l'id
	 * @return id de la notification
	 */
	public int getId() {
		return id;
	}
	
	/**
	 * Méthode setter de l'id
	 * @param id de la notification
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Méthode getter du message
	 * @return Message de la notification
	 */
	public String getMessage() {
		return this.message;
	}
	
	/**
	 * Méthode setter du message
	 * @param message Message de la notification
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	
	/**
	 * Méthode getter de l'état de la notification
	 * @return Etat de la notification  (false = non vue, true = vue)
	 */
	public boolean getVue() {
		return this.vue;
	}
	
	/**
	 * Méthode setter de l'état de la notification
	 * @param vue Etat de la notification  (false = non vue, true = vue)
	 */
	public void setVue(boolean vue) {
		this.vue = vue;
	}
}
