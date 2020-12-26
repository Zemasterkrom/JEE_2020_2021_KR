<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>

<head>
	<title>Interface administrateur</title>
	
    <!-- https://bbbootstrap.com/snippets/bootstrap-our-services-section-hover-effect-38722692 -->
	<link href="front/bootstrap/css/admin.css" rel="stylesheet">
	<link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<script>

	//Dirige vers la page de gestion des utilisateurs
	function gererUtilisateurs() {
		  document.location.href = 'users';
	}
	
	//Dirige vers la page de gestion des activités
	function gererActivites() {
		  document.location.href = 'activities';
	}
	
	//Dirige vers la page de gestion des lieux
	function gererLieux() {
		document.location.href = 'places';
	}
	
	</script>
</head>

<body>

	<jsp:include page="navbar.jsp" />

	<div class="container-fluid mb-5">
	
	    <div class="text-center mt-5">
	        <h1>Interface administrateur</h1>
	    </div>
	    
	    <div class="col-md-4" style="margin:auto;">
	        <div class="row">
	            <div class="box">
	                <div id="test" class="our-services settings" onclick="gererUtilisateurs()">
	                	<br><br>
	                    <h4>Gérer les utilisateurs</h4>
	                    <p>Liste des utilisateurs de l'application</p>
	                    <p>Opérations : supprimer un utilisateur & modifier le rang d'un utilisateur</p>
	                </div>
	            </div>
	        </div>
	        <div class="row">
	            <div class="box">
	                <div class="our-services speedup" onclick="gererActivites()">
	                	<br><br>
	                    <h4>Gérer les activités</h4>
	                    <p>Liste des activités de chaque utilisateur de l'application</p>
	                    <p>Opération : supprimer une activité</p>
	                </div>
	            </div>
	        </div>
	        <div class="row">
	            <div class="box">
	                <div class="our-services privacy" onclick="gererLieux()">
	                	<br><br>
	                    <h4>Gérer les lieux</h4>
	                    <p>Liste des lieux de l'application</p>
	                    <p>Opérations : supprimer un lieu & modifier un lieu</p>
	                </div>
	            </div>
	        </div>
	    </div>
	    
	</div>

</body>
</html>