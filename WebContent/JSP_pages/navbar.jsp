<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.Utilisateur" %>
<%@ page import="sql.ManagerNotification" %>
		<nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
		  <a class="navbar-brand" href="home">Tous AntiLaCovid <img src="front/img/logo.png" id="logo" alt="Tous AntiLaCovid" /></a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="collapse navbar-collapse" id="navbarNav">
		    <ul class="navbar-nav">
		      
		      <% Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant"); 
		      	 
		      if (utilisateur == null) { %>
		      
		      <li class="nav-item">
		        <a class="nav-link" href="account/login"><i class="fas fa-sign-in-alt fa-lg"></i> Se connecter</a>		        
		      </li>
		      
		       <li class="nav-item">
		        <a class="nav-link" href="account/register"><i class="fas fa-plus-square fa-lg"></i> S'inscrire</a>		        
		      </li>
		 
		 <% } else { 
	      	 	 ManagerNotification manager = new ManagerNotification(request, response);
		         int nbNotifications = manager.getNbNotificationsNonVues(utilisateur.getId());
		         String nbNotificationsNonVues = nbNotifications != 0 ? String.valueOf("("+nbNotifications+")") : "";
		         
		         %>	
			 	  <li class="nav-item">
			        <a class="nav-link" href="account"><i class="fas fa-address-card fa-lg"></i> Voir le profil</a>		        
			      </li>
			      
			      <li class="nav-item">
			        <a class="nav-link" href="friends"><i class="fas fa-user-friends fa-lg"></i> Amis</a>		        
			      </li>
			      
			      <li class="nav-item">
			      	<a class="nav-link" href="notifications/contaminationNotifications"><i class="fas fa-bell fa-lg"></i> Notifications <% out.print(nbNotificationsNonVues); %></a>
			      </li>
			      
			      <% if (utilisateur.getRang().equals("admin")) { %>
			      
				      <li class="nav-item">
				        <a class="nav-link" href="admin"><i class="fas fa-key fa-lg"></i> Interface administrateur</a>		        
				      </li>
			      
			      <% } %>
			      
			 	  <li class="nav-item">
			        <a class="nav-link text-danger" href="account/signout"><i class="fas fa-sign-out-alt fa-lg"></i> Se déconnecter</a>		        
			      </li>
			 
			 <% } %>	  
		      
		    </ul>
		  </div>
		</nav>