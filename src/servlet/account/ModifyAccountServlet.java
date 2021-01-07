package servlet.account;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import bean.Utilisateur;
import controller.Upload;
import controller.VerificationsInformations;
import exception.AppException;
import exception.FormAppException;
import sql.ManagerUtilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère la modification des informations du compte
 */
@MultipartConfig(fileSizeThreshold=1024*1024*2,
				 maxFileSize=1024*1024*10,      
				 maxRequestSize=1024*1024*50)
@WebServlet("/ModifyAccountServlet")
public class ModifyAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyAccountServlet() {
        super();
    }

	/**
	 * Get : on affiche la page de modification des informations
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		//Affichage du formulaire de modification
		request.getRequestDispatcher("/JSP_pages/account/modifyAccount.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				//Création du manager des utilisateurs
				ManagerUtilisateur manager = new ManagerUtilisateur(request, response);
				//Création du controleur de vérifications
				VerificationsInformations verif = new VerificationsInformations();
				//Liste des erreurs à afficher
				List<String> erreurs = new ArrayList<String>();
				//UTF-8
				request.setCharacterEncoding("UTF-8");
				//Récupération de la session
				HttpSession session = request.getSession();
				//Récupération de l'utilisateur
				Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
				
				//Image de profil de l'utilisateur
				Part part = request.getPart("image");
				String nomImage = part.getSubmittedFileName();
				boolean traiterImage = false;
				//Si une image a été ajoutée
				if (!nomImage.equals("")) {
					
					//Vérification de l'extension de l'image
					if (verif.verifExtensionImage(nomImage)) {
						traiterImage = true;
						
					} else {
						erreurs.add("ExtensionImage");
					}
					
				}
				
				//Nom de l'utilisateur
				String nom = request.getParameter("nom");
				//Vérification du format du nom
				if (verif.verifFormatNom(nom)) {
					
					//Vérification de la taille du nom
					if (verif.verifTailleNom(nom)) {
						request.setAttribute("nom", nom);
						
					} else {
						erreurs.add("TailleNom");
					}
					
				} else {
					erreurs.add("FormatNom");
				}
				
				//Prénom de l'utilisateur
				String prenom = request.getParameter("prenom");
				//Vérification du format du prénom
				if (verif.verifFormatPrenom(prenom)) {
					
					//Vérification de la taille du prénom
					if (verif.verifTaillePrenom(prenom)) {
						request.setAttribute("prenom", prenom);
						
					} else {
						erreurs.add("TaillePrenom");
					}		
					
				} else {
					erreurs.add("FormatPrenom");
				}
				
				//Date de naissance de l'utilisateur
				String dateNaissance = request.getParameter("dateNaiss");
				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");		
				Date dateNaiss = null;
				try {
					dateNaiss = sdf.parse(dateNaissance);
					
					//Vérification de la date
					if (verif.verifDate(dateNaiss)) {
						request.setAttribute("dateNaiss", dateNaissance);
						
					} else {
						erreurs.add("DatePasPassee");
					}
						
				} catch (ParseException e) {
					e.printStackTrace();
				}
				
				//Login de l'utilisateur
				String login = request.getParameter("login");
				//On vérifie si le login entré est différent de celui de l'utilisateur courant
				if (!login.equals(utilisateur.getLogin())) {
					
					//Vérification du format du login
					if (verif.verifFormatLogin(login)) {
						
						//Vérification de la taille du login
						if (verif.verifTailleLogin(login)) {
							
							//Vérification de l'existence du login
							if (!manager.verifierUtilisateurPresent(login)) {
								request.setAttribute("login", login);
								
							} else {
								erreurs.add("LoginExistant");
							}
							
						} else {
							erreurs.add("TailleLogin");
						}
						
					} else {
						erreurs.add("FormatLogin");
					}
				}
				
				//Si on a des erreurs, on renvoie sur le formulaire
				if (erreurs.size() > 0) {
					request.setAttribute("Erreurs", erreurs);
					doGet(request, response);
					
				//Sinon on modifie les informations de l'utilisateur dans la BDD
				} else {
					
					//Modification de l'utilisateur
					if (traiterImage) {
						Upload upload = new Upload();
						upload.uploadImage(request, part);
						manager.modifierUtilisateur(utilisateur.getId(), nom, prenom, dateNaiss, login, nomImage);
						
					} else {
						manager.modifierUtilisateur(utilisateur.getId(), nom, prenom, dateNaiss, login, utilisateur.getImage());
					}
					
					//Récupération de l'utilisateur modifier
					utilisateur = manager.getUtilisateur(login);
					//Ajout de l'utilisateur à la session
					session.setAttribute("Utilisateur_courant", utilisateur);
					request.setAttribute("Utilisateur_courant", utilisateur);
					
					//Redirection
					response.sendRedirect(request.getContextPath() + "/account");
				}
			} catch (AppException e) {
				e.redirigerPageErreur("/account/modifyAccount");
			} catch (IllegalArgumentException | NullPointerException e) {
				new FormAppException(AppException.ALTERED_DATA_ERROR + AppException.FORBIDDEN_MODIFICATION_ERROR, request, response).redirigerPageErreur("/account/modifyAccount");
			}
	}

}
