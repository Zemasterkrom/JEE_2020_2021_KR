<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.Utilisateur" %>
<%@ page import="bean.Etat" %>
<%@ page import="sql.ManagerEtat" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Tous AntiLaCovid</title>
    
    <!-- https://bbbootstrap.com/snippets/bootstrap-our-services-section-hover-effect-38722692 -->
	<link href="front/bootstrap/css/admin.css" rel="stylesheet">
    <jsp:include page="head.jsp" />
  </head>

  <body>

	<% 
	   Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant"); 
	   ManagerEtat manager = new ManagerEtat(request, response); 
	   Etat e = manager.obtenirDernierEtat(utilisateur.getId());
	   String tempsRestant = "Vous êtes actuellement en isolement. Temps restant : " + manager.obtenirNbJoursRestant(utilisateur.getId()) + " jours.";
	%>
	 
	<jsp:include page="navbar.jsp" />

    <main role="main">
      <div class="jumbotron">
        <div class="container">
        	<h1 class="display-3">Accueil</h1>
        	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bienvenue <% out.print(utilisateur.getPrenom()); %>.</p>
        	
        	<jsp:include page="index.jsp" />
        </div>
      </div>

      <div class="container-fluid mb-5">
		<div class="text-center mt-5">
			<h1>Vous êtes connecté</h1>
		</div>
		<hr>
      	<div class="col-md-12 mx-auto text-center">
	    	<% if (request.getParameter("error") != null)
		out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
 			<div class="col-md-8 mx-auto">
      			<% if (!e.isPositif()) { %>
			  		<div class="row">
			            <div class="box">
			                <div class="our-services settings d-flex align-items-center flex-column align-self-center justify-content-center">
			                	<form action="declaration" class="d-flex flex-column" method="POST">
					            	<span class="actionTitle">Je suis positif</span>
					            	<button type="submit" class="btn btn-primary">Je me signale et je reste isolé pendant 10 jours</button>
					            </form>
				          	</div>
			            </div>
			        </div>
			 	<% } else { %>
			 		<div class="alert alert-info">
			 			<% out.print(tempsRestant); %>		
			 		</div>
			 	<% } %>
		    </div>  
          </div>
		</div>
    </main>
  </body>
</html>
