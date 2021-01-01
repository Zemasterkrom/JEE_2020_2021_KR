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
        	<h1 class="display-3 text-danger">Erreur</h1>
        </div>
      </div>
      
      <div class="container mx-auto">
        <div class="row">
          <div class="col-md-12">
            <h2 class="text-center">${param.error}</h2>
          </div>
        </div>
        <hr>
        <div class="row d-flex justify-content-center">
	        <button type="button" class="btn btn-primary" onclick="window.history.back()">&lt; Page précédente</button>
	       	<a href="home"><button type="button" class="btn btn-light">Aller à l'accueil</button></a>
        </div>
      </div>
    </main>
    
  </body>
</html>
