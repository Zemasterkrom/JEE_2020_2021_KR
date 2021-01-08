<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Tous AntiLaCovid</title>
    <jsp:include page="/JSP_pages/basePath.jsp" />
    <jsp:include page="/JSP_pages/head.jsp" />
  </head>

  <body>

	<jsp:include page="/JSP_pages/navbar.jsp" />

    <main role="main">

      <div class="jumbotron rounded">
        <div class="container">
        	<h1 class="display-3">Accueil</h1>
        	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bienvenue sur l'application Tous AntiLaCovid.</p>        	
        	<p>&nbsp;&nbsp;&nbsp;Pour lutter contre la propagation du virus, cette application a été créée pour vous permettre d'indiquer si vous avez été touché par le virus ou si vous avez été en contact d'une personne que vous avez pu côtoyer lors de vos activités et qui a été atteinte par le virus.</p>
         	<p>&nbsp;&nbsp;&nbsp;Pour profiter des fonctionnalités du site, veuillez vous connecter, ou vous inscrire si vous ne possédez pas de compte.</p>
        </div>
      </div>

      <div class="container">
        
        <div class="row">
          <div class="col-md-12 text-center">
            <h2>Vous n'êtes pas connecté</h2>
            
            <hr>
            
            <p><a class="btn btn-secondary" href="account/login" role="button">Se connecter</a></p>
            <p><a class="btn btn-secondary" href="account/register" role="button">S'inscrire</a></p>
          </div>
        </div>


      </div>

    </main>
    
  </body>
</html>
