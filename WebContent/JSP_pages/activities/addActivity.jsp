<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.Utilisateur" %>
<%@ page import="bean.Lieu" %>
<%@ page import="sql.ManagerLieu" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
	<head>	    
	    <title>Ajouter une activité</title>
   		<jsp:include page="/JSP_pages/basePath.jsp" />
 		<link href="front/bootstrap/css/signin.css" rel="stylesheet">
 		<link href="front/bootstrap/css/admin.css" rel="stylesheet">
	    <jsp:include page="/JSP_pages/head.jsp" />
	   	<script>
			//Dirige vers la page d'ajout d'un lieu
			function ajouterLieu() {
				document.location.href = 'places/addPlace';
			}
	   	</script> 
	</head>
	
	<body>
		<%
			Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant"); 
			ManagerLieu manager = new ManagerLieu(request, response);
			List<Lieu> lieux = manager.getAllLieux();
		%>
		<div class="col-md-12 pl-0">
			<jsp:include page="/JSP_pages/navbar.jsp"/>
			<div class="container">
				<% if (request.getParameter("error") != null)
					out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
		     	<div class="row">
		     		<% if (lieux.size() > 0) { %>
						
						<div class="form-signin col-md-6">
						  <form method="post" action="activities/addActivity">
						  	<div class="form-group mb-4">
							  	<h1 class="h3 mb-3 fw-normal text-center">Entrez les informations de l'activité</h1>
							    <hr>
							    
								<label for="dateDebut" class="visually-hidden">Date de début</label>
								<input type="date"  name="dateDebut" class="form-control" required>
								
								<label for="heureDebut" class="visually-hidden">Heure de début</label>
								<input type="time"  name="heureDebut" class="form-control" required>
								
								<label for="dateFin" class="visually-hidden">Date de fin</label>
								<input type="date"  name="dateFin" class="form-control" required>
								
								<label for="heureFin" class="visually-hidden">Heure de fin</label>
								<input type="time"  name="heureFin" class="form-control" required>
		
							    <div class="form-group">
								    <label for="idLieu">Lieu</label>
								    <select class="form-control" name="idLieu" id="idLieu">
								    	<% for (Lieu l : lieux) { %>
									      <option value="<% out.print(l.getId()); %>"><% out.print(l.getNom() + " - " + l.getAdresse()); %></option>
									    <% } %>
								    </select>
			  					</div>
		  					</div>
						    <div class="form-group">
								<button type="submit" class="w-100 btn btn-lg btn-primary">Valider</button>
						   		<button type="reset" class="w-100 btn btn-lg btn-danger">Vider le formulaire</button>
						   	</div>
						  </form>
						</div>
					<% } else { %>
						<div class="container-fluid mb-5">
						    <div class="text-center mt-5">
						        <h1>Pour créer une activité, un lieu doit exister</h1>
						    </div>
						    <hr>
						    <div class="col-md-8 mx-auto">
								<div class="row">
							    	<div class="box">
							        	<div class="our-services settings d-flex align-items-center flex-column align-self-center justify-content-center" onclick="ajouterLieu()">
								        	<a class="container-fluid text-decoration-none"><span class="actionTitle container-fluid text-decoration-none text-dark">Ajouter un lieu</span></a>
								            <a class="container-fluid text-decoration-none"><span class="actionDescription container-fluid text-decoration-none text-dark">Créer un lieu afin de l'associer à une activité</span></a>
							        	</div>
							   		</div>
					   			</div>
							</div>
						</div>
			   		<% } %>
				</div>
			</div>
		</div>
	</body>
</html>