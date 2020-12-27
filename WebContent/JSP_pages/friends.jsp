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
	<script src="front/jquery/jquery-3.5.1.js"></script>
    <script src="front/bootstrap/js/bootstrap.min.js"></script>
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
                		
                    	<div class="list list-row card" style="width: 60%;">
                    	                  	
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
                	
	                		<h1> Demandes d'ami en attente </h1>
	                		
	                    	<div class="list list-row card" style="width: 60%;">
	                    	                  	
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
			                            
			                          
				                            <div class="flex" style="width:35%;max-width:35%"> 
				                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
											</div>	
				                            
				                            <div class="flex" style="width:35%;max-width:35%"> 					                            	
		                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>											   										  											    
				                            </div>
				                            
				                           	<div class="flex" style="width:30%;max-width:30%;">
				                           		<form action="acceptFriendRequest" method="post">
					      							<input type="hidden" name="idAccepteur" value="<% out.print(utilisateur.getId()); %>" />
					      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
											  		<button type="submit" class="btn btn-primary" style="border-radius:15px;">Accepter</button>
											  	</form>			                           		
				                           		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalRefuser<% out.print(u.getId()); %>" style="border-radius:15px; float:right;">Refuser</button> 					                           										   										  											    
				                           	</div>
				                           	
				                           	<!-- Modal refuser demande d'ami -->
											<div class="modal fade" id="modalRefuser<% out.print(u.getId()); %>" tabindex="-1" role="dialog" aria-hidden="true">
											  	<div class="modal-dialog" role="document">
											    	<div class="modal-content">
											    	
											      		<div class="modal-header">
											        		<h5 class="modal-title">Refuser une demande d'ami</h5>
											        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											          			<span aria-hidden="true">&times;</span>
											        		</button>										        	
											      		</div>
											      		
											     		<div class="modal-body">
											        		Voulez vous vraiment refuser la demande d'ami de &#xAB; <% out.print(u.getPrenom() + " " + u.getNom()); %> &#xBB; ?
											      		</div>
											      		
											      		<div class="modal-footer">
											      		
								      						<form action="rejectFriendRequest" method="post">
								      							<input type="hidden" name="idAccepteur" value="<% out.print(utilisateur.getId()); %>" />
								      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
											  					<button type="submit" class="btn btn-primary">Valider</button>
											  				</form>
											        		<button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>	
											        										        
											      		</div>
											      		
											    	</div>
											  	</div>
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