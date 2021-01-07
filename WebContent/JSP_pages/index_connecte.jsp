<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.Utilisateur" %>
<%@ page import="bean.Etat" %>
<%@ page import="sql.ManagerEtat" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Tous AntiLaCovid</title>
    
    <jsp:include page="/JSP_pages/basePath.jsp" />
    <!-- https://bbbootstrap.com/snippets/bootstrap-our-services-section-hover-effect-38722692 -->
	<link href="front/bootstrap/css/admin.css" rel="stylesheet">
    <jsp:include page="/JSP_pages/head.jsp" />
	
	<script>
			//Dirige vers la page d'ajout d'une activité
			function ajouterActivite() {
				  document.location.href = 'activities/addActivity';
			}
			
			//Dirige vers la page d'ajout d'un lieu
			function ajouterLieu() {
				  document.location.href = 'places/addPlace';
			}
			
			//Permet d'effectuer un auto-signalement en tant que positif
			function signalement() {
				document.getElementById("signal").submit();
			}
			
	</script>
  </head>

  <body>

	<% 
	   Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant"); 
	   ManagerEtat manager = new ManagerEtat(request, response); 
	   Etat e = manager.obtenirDernierEtat(utilisateur.getId());
	   String tempsRestant = "Vous êtes actuellement en isolement. Temps restant : " + manager.obtenirNbJoursRestant(utilisateur.getId()) + " jours.";
	%>
	
    <jsp:include page="/JSP_pages/navbar.jsp" />

    <main role="main">
      <div class="jumbotron rounded">
        <div class="container">
        	<h1 class="display-3">Accueil</h1>
        	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bienvenue <% out.print(utilisateur.getPrenom()); %>.</p>
        	<p>&nbsp;&nbsp;&nbsp;Pour lutter contre la propagation du virus, cette application a été créée pour vous permettre d'indiquer si vous avez été touché par le virus ou si vous avez été en contact d'une personne que vous avez pu côtoyer lors de vos activités et qui a été atteinte par le virus.</p>
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
			                <div class="our-services settings d-flex align-items-center flex-column align-self-center justify-content-center" onclick="signalement()">
			                	<form id="signal" action="declaration" class="d-flex flex-column" method="POST">
					            	<span class="actionTitle">Je suis positif</span>
					            	<span class="actionDescription">Je me signale et je reste isolé pendant 10 jours</span>
					            </form>
				          	</div>
			            </div>
			        </div>
			 	<% } %>
			 	<div class="row">
			    	<div class="box">
			        	<div class="our-services settings d-flex align-items-center flex-column align-self-center justify-content-center" onclick="ajouterActivite()">
				        	<a href="activities/addActivity" class="container-fluid text-decoration-none"><span class="actionTitle container-fluid text-decoration-none text-dark">Ajouter une activité</span></a>
				            <a href="activities/addActivity" class="container-fluid text-decoration-none"><span class="actionDescription container-fluid text-decoration-none text-dark">J'ai quitté mon domicile pour faire une activité, je la déclare</span></a>
			        	</div>
			   		</div>
			   	</div>
			   	<div class="row">
			    	<div class="box">
			        	<div class="our-services settings d-flex align-items-center flex-column align-self-center justify-content-center" onclick="ajouterLieu()">
				        	<a href="places/addPlace" class="container-fluid text-decoration-none"><span class="actionTitle container-fluid text-decoration-none text-dark">Ajouter un lieu</span></a>
				            <a href="places/addPlace" class="container-fluid text-decoration-none"><span class="actionDescription container-fluid text-decoration-none text-dark">J'ai visité un lieu, je le déclare</span></a>
			        	</div>
			   		</div>
			   	</div>
		    </div>  
          </div>
		</div>
		<% if (e.isPositif()) { %>
			<div class="col-md-8 mx-auto">
				<div class="alert alert-info text-center">
					<% out.print(tempsRestant); %>		
				</div>
			</div>
		<% } %>
    </main>
  </body>
</html>
