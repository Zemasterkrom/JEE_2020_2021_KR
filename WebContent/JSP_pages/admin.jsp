<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>

	<head>
		<title>Interface administrateur</title>
		
	    <!-- https://bbbootstrap.com/snippets/bootstrap-our-services-section-hover-effect-38722692 -->
		<link href="front/bootstrap/css/admin.css" rel="stylesheet">
		<jsp:include page="head.jsp" />
	</head>

	<body>
		<jsp:include page="navbar.jsp" />
		<div class="container-fluid mb-5">
		    <div class="text-center mt-5">
		        <h1>Interface administrateur</h1>
		    </div>
		    
		    <hr>
		    
		    <div class="col-md-8 mx-auto">
				<div class="row">
			    	 <div class="box">
			        	<div id="signal" class="our-services settings d-flex align-items-center flex-column align-self-center justify-content-center">
				         	<a href="users" class="container-fluid text-decoration-none"><span class="actionTitle container-fluid text-decoration-none text-dark">Gérer les utilisateurs</span></a>
				            <a href="users" class="container-fluid text-decoration-none"><span class="actionDescription container-fluid text-decoration-none text-dark">Opérations : supprimer un utilisateur et modifier le rang d'un utilisateur</span></a>
			            </div>
			        </div>
				</div>
			    <div class="row">
			    	<div class="box">
			        	<div id="signal" class="our-services settings d-flex align-items-center flex-column align-self-center justify-content-center">
				        	<a href="activities" class="container-fluid text-decoration-none"><span class="actionTitle container-fluid text-decoration-none text-dark">Gérer les activités</span></a>
				            <a href="activities" class="container-fluid text-decoration-none"><span class="actionDescription container-fluid text-decoration-none text-dark">Opération : supprimer une activité</span></a>
			        	</div>
			   		</div>
			   	</div>
			  	<div class="row">
			  		<div class="box">
			      		<div id="signal" class="our-services settings d-flex align-items-center flex-column align-self-center justify-content-center">
				     		<a href="places" class="container-fluid text-decoration-none"><span class="actionTitle container-fluid text-decoration-none text-dark">Gérer les lieux</span></a>
				     		<a href="places" class="container-fluid text-decoration-none"><span class="actionDescription container-fluid text-decoration-none text-dark">Opérations : supprimer un lieu et modifier un lieu</span></a>
			 			</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>