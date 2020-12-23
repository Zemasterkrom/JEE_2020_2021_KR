<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> 
   
<!DOCTYPE html>
<html>

<head>
</head>

<body>
			<% ArrayList<String> erreurs = (ArrayList<String>) request.getAttribute("Erreurs"); %>
			
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
			    
</body>
</html>