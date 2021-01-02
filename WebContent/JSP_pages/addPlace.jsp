<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.Utilisateur" %>
<%@ page import="bean.Lieu" %>
<%@ page import="sql.ManagerLieu" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
	<head>	    
	    <title>Ajouter un lieu</title>
 		<link href="front/bootstrap/css/signin.css" rel="stylesheet">
	    <jsp:include page="head.jsp" />
	</head>
	
	<body>
		<div class="col-md-12 pl-0">
					
			<jsp:include page="navbar.jsp"/>
			<div class="container">
		     	<% if (request.getParameter("error") != null)
						out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
		     	<div class="row">
					<div class="form-signin" class="col-md-6">
						<form method="post" action="addPlace">
							<div class="form-group mb-4">
							    <h1 class="h3 mb-3 fw-normal text-center">Entrez les informations du lieu</h1>
							    <hr>
							    
								<label for="nom" class="visually-hidden">Nom</label>
								<input type="text"  name="nom" class="form-control" required>
								
								<label for="adresse" class="visually-hidden">Adresse</label>
								<input type="text"  name="adresse" class="form-control" required>
							</div>
							<div class="form-group">
								<button type="submit" class="w-100 btn btn-lg btn-primary">Valider</button>
						  		<button type="reset" class="w-100 btn btn-lg btn-danger">Vider le formulaire</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>