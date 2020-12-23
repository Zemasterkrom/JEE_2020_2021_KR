<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> 

<!DOCTYPE html>
<html>
	<head>
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	     <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	    
	    <title>Inscription</title>

    	<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">    
	    <!-- Custom styles for this template -->
	    <link href="front/bootstrap/css/signin.css" rel="stylesheet">
		<link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	</head>
	
	<body>
	
	
	
	<% ArrayList<String> erreurs = (ArrayList<String>) request.getAttribute("Erreurs"); %>
	<div class="container">
     	<div class="row">
     	
			<div class="form-signin" class="col-md-6">
			
			  <form method="post" action="register">
			    <h1 class="h3 mb-3 fw-normal" style="text-align:center;">Entrez vos informations</h1>
			    <br>
			    
			    <label for="nom" class="visually-hidden">Nom</label>
			    <input type="text" id="nom" name="nom" class="form-control" value="<% if (request.getAttribute("nom") != null) { 
			    																		out.print(request.getAttribute("nom")); 
			    																	} %>"required>
			    <% if (erreurs != null && erreurs.contains("FormatNom")) { 
			    	out.println("<p style=\"color:red;font-size:11px;\">Le nom doit être composé seulement de lettres et caractères accentuées</p>");
			    } else if (erreurs != null && erreurs.contains("TailleNom")) {
			    	out.println("<p style=\"color:red;font-size:11px;\">Le nom doit faire au plus 64 lettres</p>");
			    } else { out.print("<p></p>"); } %>
			    
			    <label for="prenom" class="visually-hidden">Prénom</label>
			    <input type="text" id="prenom" name="prenom" class="form-control" value="<% if (request.getAttribute("prenom") != null) { 
			    																				out.print(request.getAttribute("prenom")); 
			    																		  } %>" required>
   			    <% if (erreurs != null && erreurs.contains("FormatPrenom")) { 
		    		out.println("<p style=\"color:red;font-size:11px;\">Le prénom doit être composé seulement de lettres et caractères accentuées</p>");
			    } else if (erreurs != null && erreurs.contains("TaillePrenom")) {
			    	out.println("<p style=\"color:red;font-size:11px;\">Le prénom doit faire au plus 64 lettres</p>");
			    } else { out.print("<p></p>"); } %>
			    
				<label for="dateNaiss" class="visually-hidden">Date de naissance</label>
			    <input type="date" id="dateNaiss" name="dateNaiss" class="form-control" value="<% if (request.getAttribute("dateNaiss") != null) { 
			    																					out.print(request.getAttribute("dateNaiss")); 
			    																				} else { 
			    																					out.print("2000-01-01"); 
			    																				} %>" required><br>			 
			    
			    <label for="login" class="visually-hidden">Login</label>
			    <input type="text" id="login" name="login" class="form-control" value="<% if (request.getAttribute("login") != null) { 
			    																				out.println(request.getAttribute("login")); 
			    																		  } %>" required>		    
 			    <% if (erreurs != null && erreurs.contains("FormatLogin")) { 
		    		out.print("<p style=\"color:red;font-size:11px;\">Le login doit être composé de lettres et de chiffres et doit être constitué d'un seul mot</p>");
 			    } else if (erreurs != null && erreurs.contains("TailleLogin")) {
 			    	out.print("<p style=\"color:red;font-size:11px;\">Le login doit faire plus de 3 caractères et moins de 64 caractères</p>");
 			    } else if (erreurs != null && erreurs.contains("LoginExistant")) {
 			    	out.print("<p style=\"color:red;font-size:11px;\">Le login est déjà pris</p>");
			    } else { out.print("<p></p>"); } %>
			    
			    <label for="mdp" class="visually-hidden">Mot de passe</label>
			    <input type="password" id="mdp" name="mdp" class="form-control" required>			    
			    <% if (erreurs != null && erreurs.contains("TailleMDP")) { 
 			    	out.print("<p style=\"color:red;font-size:11px;\">Le mot de passe doit faire plus de 6 caractères et moins de 64 caractères</p>");
			    } else { out.print("<p></p>"); } %>
			    
			    <label for="mdpVerif" class="visually-hidden">Confirmer le mot de passe</label>
			    <input type="password" id="mdpVerif" name="mdpVerif" class="form-control" required>			    
			    <% if (erreurs != null && erreurs.contains("MDPPasEgal")) { 
 			    	out.print("<p style=\"color:red;font-size:11px;\">Les mots de passe sont différents</p>");
			    } else { out.print("<p></p>"); } %>
			    
			    <button type="submit" class="w-100 btn btn-lg btn-primary">S'inscrire</button>
			    <button type="reset" class="w-100 btn btn-lg btn-danger">Vider le formulaire</button>
			  </form>
			  
			</div>
		
	
		</div>
	</div>
	
	</body>
</html>