<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%! @SuppressWarnings("unchecked") %>

<!DOCTYPE html>
<html>
	<head>	    
	    <title>Modifier le mot de passe</title>
    	<jsp:include page="head.jsp" />
	</head>
	
	<body>
	
		<% List<String> erreurs = (List<String>) request.getAttribute("Erreurs"); %>
		
		<div class="col-md-12" style="padding-left:0;">
			<jsp:include page="navbar.jsp"/>
			<div class="container">
				<% if (request.getParameter("error") != null)
					out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
		     	<div class="row">
					<div class="form-signin" class="col-md-6">
					  <form method="post" action="modifyPassword">
					  	<h1 class="h3 mb-3 fw-normal" style="text-align:center;">Modifiez votre mot de passe</h1>
					    <br>
					    			
					    <label for="ancienmdp" class="visually-hidden">Ancien mot de passe</label>
					    <input type="password" id="ancienmdp" name="ancienmdp" class="form-control" required>			    
					    <% if (erreurs != null && erreurs.contains("AncienMDPIncorrect")) { 
						    	out.print("<p style=\"color:red;font-size:11px;\">L'ancien mot de passe est incorrect</p>");
					    } else { out.print("<p></p>"); } %>
				    
					    <jsp:include page="input_password.jsp" />
					    
					    <button type="submit" class="w-100 btn btn-lg btn-primary">Modifier le mot de passe</button>
					    <button type="reset" class="w-100 btn btn-lg btn-danger">Vider le formulaire</button>
					  </form>
					  
					</div>
				</div>
			</div>
		</div>
	</body>
</html>