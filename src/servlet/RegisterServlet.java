package servlet;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import bean.Utilisateur;
import controller.Upload;
import controller.VerificationsInformations;
import sql.ManagerUtilisateur;

/**
 * @author Théo Roton
 * Servlet qui gère l'inscription
 */
@MultipartConfig(fileSizeThreshold=1024*1024*2,
				 maxFileSize=1024*1024*10,      
				 maxRequestSize=1024*1024*50)
public class RegisterServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;		
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
    }

	/**
	 * Get : on affiche le formulaire d'inscription
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Récupération de la session et de l'utilisateur
		HttpSession session = request.getSession();
		Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
		
		response.setContentType("text/html");
		
		//Si l'utilisateur n'est pas connecté
		if (utilisateur == null) {
			//Affichage du formulaire d'inscription
			request.getRequestDispatcher("/JSP_pages/register.jsp").forward(request, response);
			
		//Si l'utilisateur est connecté
		} else {
			//Redirection vers la page d'accueil
			response.sendRedirect("home");
		}
	}

	/**
	 * Post : on traite l'inscription de l'utilisateur avec toutes ses données
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Création du manager des utilisateurs
		ManagerUtilisateur manager = new ManagerUtilisateur();
		//Création du controleur de vérifications
		VerificationsInformations verif = new VerificationsInformations();
		//Liste des erreurs à afficher
		List<String> erreurs = new ArrayList<String>();
		//UTF-8
		request.setCharacterEncoding("UTF-8");
		
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
		
		//Mot de passe de l'utilisateur
		String mdp = request.getParameter("mdp");		
		//Confirmation du mot de passe de l'utilisateur
		String mdpVerif = request.getParameter("mdpVerif");
		//On vérifie que le mot de passe fait plus de 6 caractères et moins de 64 caractères
		if (mdp.length() >= 6 && mdp.length() <= 64) {
			
			//On vérifie que le mot de passe est égal à sa confirmation
			if (!mdp.equals(mdpVerif)) {
				erreurs.add("MDPPasEgal");
			}
			
		} else {
			erreurs.add("TailleMDP");
		}
		
		//Si on a des erreurs, on renvoie sur le formulaire
		if (erreurs.size() > 0) {
			request.setAttribute("Erreurs", erreurs);
			doGet(request, response);
			
		//Sinon on ajoute l'utilisateur dans la BDD
		} else {
			
			//Ajout de l'utilisateur dans la BDD
			if (traiterImage) {
				Upload upload = new Upload();
				upload.uploadImage(request, part);
				manager.ajouterUtilisateur(nom, prenom, dateNaiss, login, mdp, nomImage);
				
			} else {
				manager.ajouterUtilisateur(nom, prenom, dateNaiss, login, mdp, null);
			}
						
			//Redirection
			response.sendRedirect("home");
		}
	}

}
