<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.Utilisateur" %>
    
<!DOCTYPE html>
<html>
	<head>
	</head>
	
	<body>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  	  <a class="navbar-brand" href="home">Tous AntiLaCovid</a>
		  
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <ul class="navbar-nav mr-auto">
		      
		      <% Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");  
		      if (utilisateur == null) { %>
		      
			      <li class="nav-item">
			        <a class="nav-link" href="login">Se connecter</a>		        
			      </li>
			      
			       <li class="nav-item">
			        <a class="nav-link" href="register">S'inscrire</a>		        
			      </li>
			 
			 <% } else { %>	
			 
			 	  <li class="nav-item">
			        <a class="nav-link" href="account">Voir le profil</a>		        
			      </li>
			      
			      <% if (utilisateur.getRang().equals("admin")) { %>
			      
				      <li class="nav-item">
				        <a class="nav-link" href="admin">Interface administrateur</a>		        
				      </li>
			      
			      <% } %>
			      
			 	  <li class="nav-item">
			        <a class="nav-link" href="signout" style="color:red;">Se déconnecter</a>		        
			      </li>
			 
			 <% } %>	  
		      
		    </ul>
		  </div>
		</nav>
	</body>
</html>