<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Tous AntiLaCovid</title>
    <jsp:include page="head.jsp" />
  </head>

  <body>

	<jsp:include page="navbar.jsp" />

    <main role="main">

      <div class="jumbotron">
        <div class="container">
        	<h1 class="display-3">Accueil</h1>
        	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bienvenue sur l'application Tous AntiLaCovid.</p>
        	
        	<jsp:include page="index.jsp" />
        
         	<p>&nbsp;&nbsp;&nbsp;Pour profiter des fonctionnalités du site, veuillez vous connecter, ou vous inscrire si vous ne possédez pas de compte.</p>
        </div>
      </div>

      <div class="container">
        
        <div class="row">
          <div class="col-md-12" style="text-align: center;">
            <h2>Vous n'êtes pas connecté</h2>
            
            <br>
            
            <p><a class="btn btn-secondary" href="login" role="button">Se connecter</a></p>
            <p><a class="btn btn-secondary" href="register" role="button">S'inscrire</a></p>
          </div>
        </div>

        <hr>

      </div>

    </main>
    
  </body>
</html>
