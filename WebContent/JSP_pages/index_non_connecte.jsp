<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

	<jsp:include page="navbar.jsp" />

    <main role="main">

      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron">
        <div class="container">
          <h1 class="display-3">Accueil</h1>
          <p>Description</p>
        </div>
      </div>

      <div class="container">
        <!-- Example row of columns -->
        <div class="row">
          <div class="col-md-12" style="text-align: center;">
            <h2>Vous n'êtes pas connecté</h2>
            <p><a class="btn btn-secondary" href="login" role="button">Se connecter</a></p>
            <p><a class="btn btn-secondary" href="register" role="button">S'inscrire</a></p>
          </div>
        </div>

        <hr>

      </div> <!-- /container -->

    </main>
    
  </body>
</html>
