<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.Utilisateur" %>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  	  <a class="navbar-brand" href="home">Tous AntiLaCovid <img src="front/img/logo.png" id="logo" alt="Tous AntiLaCovid" /></a>
		  
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <ul class="navbar-nav mr-auto">
		      
		      <% Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");  
		      if (utilisateur == null) { %>
		      
			      <li class="nav-item">
			        <a class="nav-link" href="login"><i class="fas fa-sign-in-alt fa-lg"></i> Se connecter</a>		        
			      </li>
			      
			       <li class="nav-item">
			        <a class="nav-link" href="register"><i class="fas fa-plus-square fa-lg"></i> S'inscrire</a>		        
			      </li>
			 
			 <% } else { %>	
			 
			 	  <li class="nav-item">
			        <a class="nav-link" href="account"><i class="fas fa-address-card fa-lg"></i> Voir le profil</a>		        
			      </li>
			      
			      <li class="nav-item">
			        <a class="nav-link" href="friends"><i class="fas fa-user-friends fa-lg"></i> Amis</a>		        
			      </li>
			      
			      <li class="nav-item">
			      	<a class="nav-link" href="notificationsContaminations"><i class="fas fa-bell fa-lg"></i> Notifications</a>
			      </li>
			      
			      <% if (utilisateur.getRang().equals("admin")) { %>
			      
				      <li class="nav-item">
				        <a class="nav-link" href="admin">Interface administrateur</a>		        
				      </li>
			      
			      <% } %>
			      
			 	  <li class="nav-item">
			        <a class="nav-link" href="signout" style="color:red;"><i class="fas fa-sign-out-alt fa-lg"></i> Se déconnecter</a>		        
			      </li>
			 
			 <% } %>	  
		      
		    </ul>
		  </div>
		</nav>