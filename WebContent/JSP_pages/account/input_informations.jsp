<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@ page import="bean.Utilisateur" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%! @SuppressWarnings("unchecked") %>

	<body>
			<% List<String> erreurs = (List<String>) request.getAttribute("Erreurs"); 
			   Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant"); 
			   String nom, prenom, dateNaiss, login, image;
			   
			   if (utilisateur != null) {
				   nom = utilisateur.getNom();
				   prenom = utilisateur.getPrenom();
				   SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				   dateNaiss = format.format(utilisateur.getDateNaiss());
				   login = utilisateur.getLogin();
				   if (utilisateur.getImage() == null){
					   image = "front/img/addImage.png";
				   } else {
					   image = "uploads/" + utilisateur.getImage();
				   }
				   			   
			   } else {		   
					   if (request.getAttribute("nom") != null) { nom = (String) request.getAttribute("nom"); } else { nom = ""; }
					   if (request.getAttribute("prenom") != null) { prenom = (String) request.getAttribute("prenom"); } else { prenom = ""; }
					   if (request.getAttribute("dateNaiss") != null) { dateNaiss = (String) request.getAttribute("dateNaiss"); } else { dateNaiss = "2000-01-01"; }
					   if (request.getAttribute("login") != null) { login = (String) request.getAttribute("login"); } else { login =""; }
					   image = "front/img/addImage.png";
			   } %>
					
			<label for="image" class="visually-hidden">Image de profil</label>
			<label id="imageProfil" for="image"><img id="output" src="<% out.print(image); %>" /></label>
			<input type="file"  name="image"  accept="image/*" id="image"  onchange="afficheImage(event)" style="display: none;">
			
			<% if (erreurs != null && erreurs.contains("ExtensionImage")) {
				out.print("<p style=\"color:red;font-size:11px;\">Ce fichier n'est pas une image</p>"); 
			} else { out.print("<p></p>"); } %>
			
		    <label for="nom" class="visually-hidden">Nom</label>
		    <input type="text" id="nom" name="nom" class="form-control" value="<% out.print(nom); %>" required>
		    
		    <% if (erreurs != null && erreurs.contains("FormatNom")) { 
		    	out.println("<p style=\"color:red;font-size:11px;\">Le nom doit être composé seulement de lettres et caractères accentuées</p>");
		    } else if (erreurs != null && erreurs.contains("TailleNom")) {
		    	out.println("<p style=\"color:red;font-size:11px;\">Le nom doit faire au plus 64 lettres</p>");
		    } else { out.print("<p></p>"); } %>
		    
		    <label for="prenom" class="visually-hidden">Prénom</label>
		    <input type="text" id="prenom" name="prenom" class="form-control" value="<% out.print(prenom); %>" required>
		    
  			<% if (erreurs != null && erreurs.contains("FormatPrenom")) { 
	    		out.println("<p style=\"color:red;font-size:11px;\">Le prénom doit être composé seulement de lettres et caractères accentuées</p>");
		    } else if (erreurs != null && erreurs.contains("TaillePrenom")) {
		    	out.println("<p style=\"color:red;font-size:11px;\">Le prénom doit faire au plus 64 lettres</p>");
		    } else { out.print("<p></p>"); } %>
		    
			<label for="dateNaiss" class="visually-hidden">Date de naissance</label>
		    <input type="date" id="dateNaiss" name="dateNaiss" class="form-control" value="<% out.print(dateNaiss); %>" required>
		    
		    <% if (erreurs != null && erreurs.contains("DatePasPassee")) { 
		    	out.println("<p style=\"color:red;font-size:11px;\">La date n'est pas encore passée</p>");
		    } else { out.print("<p></p>"); } %>			 
		    
		    <label for="login" class="visually-hidden">Login</label>
		    <span class="infobulle" aria-label="Le login doit faire entre 3 et 64 caractères et contenir uniquement des lettres et des chiffres">
		    	<img src="front/img/info.png" style="margin-left:5px;width:16px;height:16px;" />
		    </span>
		    <input type="text" id="login" name="login" class="form-control" value="<% out.print(login); %>" required>	
		    	    
			    <% if (erreurs != null && erreurs.contains("FormatLogin")) { 
	    		out.print("<p style=\"color:red;font-size:11px;\">Le login doit être composé de lettres et de chiffres et doit être constitué d'un seul mot</p>");
			    } else if (erreurs != null && erreurs.contains("TailleLogin")) {
			    	out.print("<p style=\"color:red;font-size:11px;\">Le login doit faire plus de 3 caractères et moins de 64 caractères</p>");
			    } else if (erreurs != null && erreurs.contains("LoginExistant")) {
			    	out.print("<p style=\"color:red;font-size:11px;\">Le login est déjà pris</p>");
		   		} else { out.print("<p></p>"); } %>

			<script>
			
				function afficheImage(event) {
					var image = document.getElementById('output');
					image.src = URL.createObjectURL(event.target.files[0]);
				};
				
			</script>    
	</body>