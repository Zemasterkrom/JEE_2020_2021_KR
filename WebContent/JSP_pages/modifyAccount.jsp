<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	     <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	    
	    <title>Modifier les informations</title>

    	<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">    
	    <!-- Custom styles for this template -->
	    <link href="front/bootstrap/css/signin.css" rel="stylesheet">
		<link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	</head>
	
	<body>
	
	<div class="col-md-12" style="padding-left:0;">

		<jsp:include page="navbar.jsp"/>
		
		<br>
		
		<div class="container">
	     	<div class="row">
	     	
				<div class="form-signin" class="col-md-6">
				
				  <form method="post" action="modifyAccount">
				  	<h1 class="h3 mb-3 fw-normal" style="text-align:center;">Modifiez vos informations</h1>
				    <br>
				    
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