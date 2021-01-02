<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>	    
	    <title>Modifier les informations</title>
	    <link href="front/bootstrap/css/signin.css" rel="stylesheet">
    	<jsp:include page="head.jsp" />
	</head>
	<body>
		<div class="col-md-12 pl-0">
			<jsp:include page="navbar.jsp"/>
			<br>
			<div class="container">
				<% if (request.getParameter("error") != null)
					out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
		     	<div class="row">
					<div class="form-signin" class="col-md-6">
					  <form method="post" action="modifyAccount" enctype="multipart/form-data text-center">
					  	<h1 class="h3 mb-3 fw-normal text-center">Modifiez vos informations</h1>
					  	<hr>				    
					    <jsp:include page="input_informations.jsp" />
					    
					    <button type="submit" class="w-100 btn btn-lg btn-primary">Modifier les informations</button>
					    <button type="reset" class="w-100 btn btn-lg btn-danger">Vider le formulaire</button>
					  </form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>