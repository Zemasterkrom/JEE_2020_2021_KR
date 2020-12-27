package controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

/**
 * 
 * @author Théo Roton
 * Classe qui permet d'upload une image sur le serveur
 */
public class Upload {
	
	/**
	 * Répertoire des images upload
	 */
	private static final String REPERTOIRE = "uploads";

	/**
	 * Méthode qui permet d'upload une image
	 * @param request : requête HTTP
	 * @param image : image à upload
	 * @throws IOException
	 */
	public void uploadImage(HttpServletRequest request, Part image) throws IOException {
		//Chemin de l'application
        String cheminApplication = request.getServletContext().getRealPath("");
        //Chemin du dossier d'upload
        String cheminUpload = cheminApplication + File.separator + REPERTOIRE;
         
        //Création du dossier s'il n'existe pas
        File fileSaveDir = new File(cheminUpload);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        //Ecriture du fichier
        String fileName = image.getSubmittedFileName();
        image.write(cheminUpload + File.separator + fileName);		
	}

}
