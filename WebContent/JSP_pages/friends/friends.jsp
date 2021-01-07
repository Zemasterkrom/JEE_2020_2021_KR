<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bean.Utilisateur"%>
<%@page import="bean.Ami"%>
<%@page import="sql.ManagerUtilisateur" %>

<!DOCTYPE html>
<html>
	<head>
		<title>Amis</title>
		
		<link href="front/bootstrap/css/list.css" rel="stylesheet">
		<jsp:include page="/JSP_pages/head.jsp" />
	</head>

	<body>
	
		<% Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
		   ManagerUtilisateur manager = new ManagerUtilisateur(request, response); Utilisateur u; %>
		
		<jsp:include page="/JSP_pages/navbar.jsp" />
		
		
		<div class="page-content page-container" id="page-content">
	     	<div class="col-sm-12 w-75 mx-auto">
	       	<% if (request.getParameter("error") != null)
				out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
	       	 <div class="ami">
	                
	         	<h1> Amis </h1>
	                
	          		<div class="list list-row card">
	                	
	          			<% if (utilisateur.getAmis().size() > 0) { %>
	                		                                  	                  	
		                    	<% for (Ami a : utilisateur.getAmis()) { %>
		                    	
		                    		<% if (utilisateur.getId() == a.getIdUtilisateur()) {
		                    		   		u = manager.getUtilisateurAmi(a.getIdAmi()); 
		                    		   } else {
		                    		   		u = manager.getUtilisateurAmi(a.getIdUtilisateur());
	                    		   	   } %>
		                    	
		                    		<div class="utilisateur">
		                    		
				                        <div class="list-item row h-100">
				                        
				                            	<div>
				                            	<img src="<% if (u.getImage() == null) {
														 		out.print("front/img/user.png");
												 			 } else {
																out.print("uploads/" + u.getImage()); 
												 			 }	%>" class="img-radius" alt="User-Profile-Image" />
												 </div>
				                            
				                          
					                            <div class="flex"> 
					                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
												</div>	
					                            
					                            <div class="flex" > 					                            	
			                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>											   										  											    
					                            </div>
					                            
					                            <div class="flex">                           		
					                           		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalSupprimerAmi<% out.print(u.getId()); %>" style="border-radius:15px; float:right;">Supprimer</button> 					                           										   										  											    
					                           	</div>
					                           	
					                           	<!-- Modal supprimer ami -->
												<div class="modal fade" id="modalSupprimerAmi<% out.print(u.getId()); %>" tabindex="-1" role="dialog" aria-hidden="true">
												  	<div class="modal-dialog" role="document">
												    	<div class="modal-content">
												    	
												      		<div class="modal-header">
												        		<h5 class="modal-title">Supprimer un ami</h5>
												        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												          			<span aria-hidden="true">&times;</span>
												        		</button>										        	
												      		</div>
												      		
												     		<div class="modal-body">
												        		Voulez vous vraiment supprimer &#xAB; <% out.print(u.getPrenom() + " " + u.getNom()); %> &#xBB; de votre liste d'amis ?
												      		</div>
												      		
												      		<div class="modal-footer">
												      		
									      						<form action="friends/deleteFriend" method="post">
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
			                    	                   	                    
		                   	<% } else { %>
		                   	
			                    <div class="utilisateur">
			                    
									<div class="list-item">
									
					                	<h3>Vous n'avez aucun ami</h3>	
					                								
					                </div>
					                
				                </div>
								
							<% } %>
							
							<div class="utilisateur mx-auto">
							
								<div class="list-item">
								
				                	<a href="friends/moreFriends" class="btn btn-primary" data-dismiss="modal">Ajouter un ami</a>
				                									
				                </div>
				                
			                </div>
			                
						</div>	
						
					</div>
						                
	                	<% if (utilisateur.getDemandesRecues().size() > 0) { %>
	                	
	                		<div class="ami">
	                	
		                		<h1> Demandes d'ami reçues en attente </h1>
		                		
		                    	<div class="list list-row card">
		                    	                  	
			                    	<% for (Ami a : utilisateur.getDemandesRecues()) { %>
			                    	
			                    		<% u = manager.getUtilisateurAmi(a.getIdUtilisateur()); %>
			                    	
			                    		<div class="utilisateur">
			                    		
					                        <div class="list-item row h-100">
					                        
				                            	<div>
				                            	<img src="<% if (u.getImage() == null) {
														 		out.print("front/img/user.png");
												 			 } else {
																out.print("uploads/" + u.getImage()); 
												 			 }	%>" class="img-radius" alt="User-Profile-Image" />
												 </div>
				                            
				                          
					                            <div class="flex"> 
					                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
												</div>	
					                            
					                            <div class="flex"> 					                            	
			                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>											   										  											    
					                            </div>
					                            
					                           	<div class="flex d-flex justify-content-sm-end">
					                           		<form action="friends/acceptFriendRequest" method="post" class="mr-2">
						      							<input type="hidden" name="idAccepteur" value="<% out.print(utilisateur.getId()); %>" />
						      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
												  		<button type="submit" class="btn btn-primary rounded">Accepter</button>
												  	</form>			                           		
					                           		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalRefuser<% out.print(u.getId()); %>" style="border-radius:15px;">Refuser</button> 					                           										   										  											    
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
												      		
									      						<form action="friends/rejectFriendRequest" method="post">
									      							<input type="hidden" name="idRefuseur" value="<% out.print(utilisateur.getId()); %>" />
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
	                   	
	                   	<% if (utilisateur.getDemandesEnvoyees().size() > 0) { %>
	                	
	                		<div class="ami">
	                	
		                		<h1> Demandes d'ami envoyées en attente </h1>
		                		
		                    	<div class="list list-row card">
		                    	                  	
			                    	<% for (Ami a : utilisateur.getDemandesEnvoyees()) { %>
			                    	
			                    		<% u = manager.getUtilisateurAmi(a.getIdAmi()); %>
			                    	
			                    		<div class="utilisateur">
			                    		
					                        <div class="list-item row h-100">
					                        
				                            	<div>
				                            	<img src="<% if (u.getImage() == null) {
														 		out.print("front/img/user.png");
												 			 } else {
																out.print("uploads/" + u.getImage()); 
												 			 }	%>" class="img-radius" alt="User-Profile-Image" />
												 </div>
				                            
				                          
					                            <div class="flex"> 
					                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
												</div>	
					                            
					                            <div class="flex"> 					                            	
			                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>											   										  											    
					                            </div>
					                            
					                           	<div class="flex d-flex justify-content-sm-end">
					                           		<button type="button" class="btn btn-primary rounded float-right ml-auto" data-toggle="modal" data-target="#modalAnnuler<% out.print(u.getId()); %>">Annuler la demande</button>
							                    </div>
					                           	
					                           	<!-- Modal annuler demande d'ami -->
												<div class="modal fade" id="modalAnnuler<% out.print(u.getId()); %>" tabindex="-1" role="dialog" aria-hidden="true">
												  	<div class="modal-dialog" role="document">
												    	<div class="modal-content">
												    	
												      		<div class="modal-header">
												        		<h5 class="modal-title">Annuler une demande d'ami</h5>
												        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												          			<span aria-hidden="true">&times;</span>
												        		</button>										        	
												      		</div>
												      		
												     		<div class="modal-body">
												        		Voulez vous vraiment annuler la demande d'ami envoyée à &#xAB; <% out.print(u.getPrenom() + " " + u.getNom()); %> &#xBB; ?
												      		</div>
												      		
												      		<div class="modal-footer">
												      		
									      						<form action="friends/cancelFriendRequest" method="post">
									      							<input type="hidden" name="idAnnuleur" value="<% out.print(utilisateur.getId()); %>" />
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
		
	</body>
	
</html>