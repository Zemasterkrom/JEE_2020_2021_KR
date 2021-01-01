<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>	    
	    <title>Inscription</title>
 		<link href="front/bootstrap/css/signin.css" rel="stylesheet">
	    <jsp:include page="head.jsp" />
	</head>
	
	<body>
	
	<div class="col-md-12" style="padding-left:0;">
	
		<jsp:include page="navbar.jsp"/>
	
		<div class="container">
			<% if (request.getParameter("error") != null)
					out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
	     	<div class="row">
	     	
				<div class="form-signin" class="col-md-6">
				
				  <form method="post" action="register" enctype="multipart/form-data">
				    <h1 class="h3 mb-3 fw-normal" style="text-align:center;">Entrez vos informations</h1>
				    <br>
				    
					<jsp:include page="input_informations.jsp" />
				    
					<jsp:include page="input_password.jsp" />
				    
				    <button type="submit" class="w-100 btn btn-lg btn-primary">S'inscrire</button>
				    <button type="reset" class="w-100 btn btn-lg btn-danger">Vider le formulaire</button>
				  </form>
				  
				</div>
				
			</div>
		</div>
		
	</div>
	
	</body>
</html>