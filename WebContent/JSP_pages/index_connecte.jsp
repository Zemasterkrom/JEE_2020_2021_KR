<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.Utilisateur" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Tous AntiCovid</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.1/examples/jumbotron/">

    <!-- Bootstrap core CSS -->
    <link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="front/jquery/jquery-3.5.1.js"></script>
    <script src="front/bootstrap/js/bootstrap.min.js"></script>
  </head>

  <body>

	<% Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant"); %>
	 
	<jsp:include page="navbar.jsp" />

    <main role="main">

      <div class="jumbotron">
        <div class="container">
        	<h1 class="display-3">Accueil</h1>
        	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bienvenue <% out.print(utilisateur.getPrenom()); %>.</p>
        	
        	<jsp:include page="index.jsp" />
        </div>
      </div>

      <div class="container">
        
        <div class="row">
          <div class="col-md-12" style="text-align: center;">
            <h2>Vous êtes connecté</h2>        
          </div>
        </div>

        <hr>

      </div>

    </main>
    
  </body>
</html>
