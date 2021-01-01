<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%! @SuppressWarnings("unchecked") %>

<!DOCTYPE html>
<html>
	<head>	    
	    <title>Connexion</title> 
	    <link href="front/bootstrap/css/signin.css" rel="stylesheet">
	    <jsp:include page="head.jsp" />
	</head>
	
	<body>
	
		<% List<String> erreurs = (List<String>) request.getAttribute("Erreurs"); %>
		
		<div class="col-md-12" style="padding-left:0;">
			<jsp:include page="navbar.jsp"/>
			<br>
			<div class="container" style="position:relative;">
				<% if (request.getParameter("error") != null)
					out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
		     	<div class="row">
					<div class="form-signin" class="col-md-6">
					  <form method="post" action="login">
					    <h1 class="h3 mb-3 fw-normal" style="text-align:center;">Entrez vos informations de connexion</h1>
					    <br>
					    
					    <label for="login" class="visually-hidden">Login</label>
					    <input type="text" id="login" name="login" class="form-control" value="<% if (request.getAttribute("login") != null) { 
					    																				out.println(request.getAttribute("login")); 
					    																		  } %>" required>		    
		 			    <% if (erreurs != null && erreurs.contains("LoginInexistant")) { 
				    		out.print("<p style=\"color:red;font-size:11px;\">Utilisateur inexistant</p>");
					    } else { out.print("<p></p>"); } %>
					    
					    <label for="mdp" class="visually-hidden">Mot de passe</label>
					    <input type="password" id="mdp" name="mdp" class="form-control" required>			    
					    <% if (erreurs != null && erreurs.contains("MDPIncorrect")) { 
		 			    	out.print("<p style=\"color:red;font-size:11px;\">Le mot de passe est incorrect</p>");
					    } else { out.print("<p></p>"); } %>
					    
					    <button type="submit" class="w-100 btn btn-lg btn-primary">Se connecter</button>
					    <button type="reset" class="w-100 btn btn-lg btn-danger">Vider le formulaire</button>
					  </form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>