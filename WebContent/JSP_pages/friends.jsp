<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bean.Utilisateur"%>
<%@page import="bean.Ami"%>
<%@ page import="sql.ManagerUtilisateur" %>

<!DOCTYPE html>
<html>
<head>
	<title>Amis</title>
	
	<link href="front/bootstrap/css/list.css" rel="stylesheet">
	<link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

	<% Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
	   ManagerUtilisateur manager = new ManagerUtilisateur(); Utilisateur u; %>
	
	<jsp:include page="navbar.jsp" />
	
	<div class="page-content page-container" id="page-content">
	
	    <div class="padding">
	        
            <div class="col-sm-12">
                
                <div class="ami">
                
                	<h1> Amis </h1>
                
                	<% if (utilisateur.getAmis().size() > 0) { %>
                		
                    	<div class="list list-row card" style="width: 50%;">
                    	                  	
	                    	<% for (Ami a : utilisateur.getAmis()) { %>
	                    	
	                    		<% if (utilisateur.getId() == a.getIdUtilisateur()) {
	                    		   		u = manager.getUtilisateurAmi(a.getIdAmi()); 
	                    		   } else {
	                    		   		u = manager.getUtilisateurAmi(a.getIdUtilisateur());
                    		   	   } %>
	                    	
	                    		<div class="utilisateur">
	                    		
			                        <div class="list-item">
			                        
			                            	<div>
			                            	<img src="<% if (u.getImage() == null) {
													 		out.print("front/img/user.png");
											 			 } else {
															out.print("uploads/" + u.getImage()); 
											 			 }	%>" class="img-radius" alt="User-Profile-Image" />
											 </div>
			                            
			                          
				                            <div class="flex" style="width:40%;max-width:40%"> 
				                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
											</div>	
				                            
				                            <div class="flex" style="width:40%;max-width:40%"> 					                            	
		                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>											   										  											    
				                            </div>
										
			                        </div>
		                        
		                        </div>
		                        
		                    <% } %>
		                    
	                     </div>
		                    
                   	<% } else { %>
                    
						<div class="list-item">
		                	<h3>Vous n'avez aucun ami</h2>								
		                </div>
						
					<% } %>
					
				</div>
					                
                	<% if (utilisateur.getDemandes().size() > 0) { %>
                	
                		<div class="ami">
                	
	                		<h1> Demandes d'ami </h1>
	                		
	                    	<div class="list list-row card" style="width: 50%;">
	                    	                  	
		                    	<% for (Ami a : utilisateur.getDemandes()) { %>
		                    	
		                    		<% u = manager.getUtilisateurAmi(a.getIdUtilisateur()); %>
		                    	
		                    		<div class="utilisateur">
		                    		
				                        <div class="list-item">
				                        
				                            	<div>
				                            	<img src="<% if (u.getImage() == null) {
														 		out.print("front/img/user.png");
												 			 } else {
																out.print("uploads/" + u.getImage()); 
												 			 }	%>" class="img-radius" alt="User-Profile-Image" />
												 </div>
				                            
				                          
					                            <div class="flex" style="width:40%;max-width:40%"> 
					                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
												</div>	
					                            
					                            <div class="flex" style="width:40%;max-width:40%"> 					                            	
			                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>											   										  											    
					                            </div>
											
				                        </div>
			                        
			                        </div>
			                        
			                    <% } %>
			                    
		                     </div>
		                     
	                     </div>
		                    
                   	<% } %>
                
            </div>
	        
	    </div>
	    
	</div>
	
</body>
</html>