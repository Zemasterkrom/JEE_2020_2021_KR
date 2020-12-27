<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.Utilisateur" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
	<title>Votre compte</title>
	
	<!-- https://bbbootstrap.com/snippets/social-profile-container-63944396# -->
	<link href="front/bootstrap/css/account.css" rel="stylesheet">
	<link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

	<jsp:include page="navbar.jsp" />
	
	<% Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant"); %>
	
	<div class="page-content page-container" id="page-content">
	    <div class="padding" align="center">
	        <div class="row container d-flex justify-content-center">
	            <div class="col-xl-10 col-md-4">
	            
	                <div class="card user-card-full">
	                    <div class="row m-l-0 m-r-0">
	                    
	                        <div class="col-sm-4 bg-c-lite-green user-profile">
	                            <div class="card-block text-center text-white">
	                                <div class="m-b-25"> 
	                                <img src="<% if (utilisateur.getImage() == null) {
														 	out.print("front/img/user.png");
												 } else {
													out.print("uploads/" + utilisateur.getImage()); 
												 }	%>" class="img-radius" alt="User-Profile-Image" />
									</div>
	                                													 
	                                <h6 class="f-w-600"><% out.println(utilisateur.getPrenom() + " " + utilisateur.getNom()); %></h6>
	                                <p>Rang : <% out.println(utilisateur.getRang()); %></p>
	                            </div>
	                        </div>
	                        
	                        <div class="col-sm-8">
	                            <div class="card-block">
	                                <h6 class="m-b-20 p-b-5 b-b-default f-w-600">Informations</h6>
	                                
	                                <div class="row">
	                                    <div class="col-sm-6">
	                                        <p class="m-b-10 f-w-600">Date de naissance</p>
	                                        <h6 class="text-muted f-w-400"><% SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                     					   									  out.println(format.format(utilisateur.getDateNaiss())); %></h6>
	                                    </div>
	                                    
	                                    <div class="col-sm-6">
	                                        <p class="m-b-10 f-w-600">Login</p>
	                                        <h6 class="text-muted f-w-400"><% out.println(utilisateur.getLogin()); %></h6>
	                                    </div>
	                                </div>
	                                
	                                <br>	
	                                
	                                <h6 class="m-b-20 p-b-5 b-b-default f-w-600">Modifications</h6>
	                                
	                                <div class="row">
	                                	 <div class="button-box col-lg-12">
									         <a href="modifyAccount" class="btn btn-info" role="button">Modifier les informations</a>
									         <a href="modifyPassword" class="btn btn-info" role="button">Modifier le mot de passe</a>
									   	 </div> 
	                                </div>	
	                                                        
	                            </div>
	                        </div>
	                                     
	                    </div>
	                </div>
	                
	            </div>
	        </div>
	    </div>
	</div>
	
</body>
</html>