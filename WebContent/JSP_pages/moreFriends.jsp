<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> 
<%@page import="bean.Utilisateur"%>
<%@page import="bean.Ami"%>
<%@page import="sql.ManagerAmi" %>

<!DOCTYPE html>
<html>

<head>
	<title>Ajouter un ami</title>
	
	<link href="front/bootstrap/css/list.css" rel="stylesheet">
	<link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="front/jquery/jquery-3.5.1.js"></script>
    <script src="front/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>

	<% Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
	   ArrayList<Utilisateur> utilisateurs = (ArrayList<Utilisateur>) request.getAttribute("Utilisateurs");
	   ManagerAmi manager = new ManagerAmi(); Ami a; %>
	
	<jsp:include page="navbar.jsp" />
	
	<div class="page-content page-container" id="page-content">
	
	    <div class="padding">
	        
            <div class="col-sm-12">
                
                <div class="ami">
                
                	<h1> Utilisateurs </h1>
                
                	<div class="list list-row card" style="width:70%;">
                	
                		<% if (utilisateurs.size() > 0) { %>
                		                                  	                  	
	                    	<% for (Utilisateur u : utilisateurs) { %>
	                    	
	                    		<% a = manager.getAmi(utilisateur.getId(), u.getId()); %>
	                    	
	                    		<% if (a != null) { %>
	                    		
	                    			<% if (!a.isAccepte()) { %>
	                    		
			                    		<div class="utilisateur">
			                    		
					                        <div class="list-item">
					                        
				                            	<div>
				                            	<img src="<% if (u.getImage() == null) {
														 		out.print("front/img/user.png");
												 			 } else {
																out.print("uploads/" + u.getImage()); 
												 			 }	%>" class="img-radius" alt="User-Profile-Image" />
												 </div>
				                            
				                          
					                            <div class="flex" style="width:30%;max-width:30%"> 
					                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
												</div>	
					                            
					                            <div class="flex" style="width:30%;max-width:30%"> 					                            	
			                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>											   										  											    
					                            </div>
					                            				                            
					                            <% if (a.getIdUtilisateur() == utilisateur.getId()) { %>
					                            
					                            	<div class="flex" style="width:40%;max-width:40%;">
					                            	 
					                            		<div class="item-except text-muted text-sm h-1x" style="float:right;">Vous avez déjà envoyé une demande d'ami à cet utilisateur</div>					                                                 		
						                           		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalAnnuler<% out.print(u.getId()); %>" style="border-radius:15px; float:right;">Annuler la demande</button>
						                           		
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
													      		
										      						<form action="cancelFriendRequest" method="post">
										      							<input type="hidden" name="idAnnuleur" value="<% out.print(utilisateur.getId()); %>" />
										      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
													  					<button type="submit" class="btn btn-primary">Valider</button>
													  				</form>
													        		<button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>	
													        										        
													      		</div>
													      		
													    	</div>
													  	</div>
													</div>
						                        	    	
						                        <% } else { %>
						                        
						                        	 <div class="flex" style="width:40%;max-width:40%;display: flex;flex-direction: column;flex-wrap: wrap;">
						                        	 
						                        	 	<div class="item-except text-muted text-sm h-1x" style="text-align:right;">Vous avez reçu une demande d'ami de cet utilisateur</div>
						                        	 	
						                        	 	<div style="display:flex;justify-content:flex-end;">
						                        	 		
															<form action="acceptFriendRequest" method="post" style="margin-right:10px;">
								      							<input type="hidden" name="idAccepteur" value="<% out.print(utilisateur.getId()); %>" />
								      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
														  		<button type="submit" class="btn btn-primary" style="border-radius:15px;">Accepter</button>
														  	</form>			                           		
							                           		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalRefuser<% out.print(u.getId()); %>" style="border-radius:15px;">Refuser</button> 		                           										   										  											    
															
														</div>
														
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
										      							<input type="hidden" name="idRefuseur" value="<% out.print(utilisateur.getId()); %>" />
										      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
													  					<button type="submit" class="btn btn-primary">Valider</button>
													  				</form>
													        		<button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>	
													        										        
													      		</div>
													      		
													    	</div>
													  	</div>
													</div>
													 
						                        <% } %>
												
					                        </div>
			                        
			                        	</div>
			                        	
		                        	<% } %>		
		                        	                        
		                        <% } else { %>
		                        
		                        	<div class="utilisateur">
		                    		
				                        <div class="list-item">
				                        
				                            	<div>
				                            	<img src="<% if (u.getImage() == null) {
														 		out.print("front/img/user.png");
												 			 } else {
																out.print("uploads/" + u.getImage()); 
												 			 }	%>" class="img-radius" alt="User-Profile-Image" />
												 </div>
				                            
				                          
					                            <div class="flex" style="width:30%;max-width:30%"> 
					                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
												</div>	
					                            
					                            <div class="flex" style="width:30%;max-width:30%"> 					                            	
			                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>											   										  											    
					                            </div>
					                            
					                            <div class="flex" style="width:40%;max-width:40%;">        
					                                               		
					                           		<form action="addFriend" method="post" style="float:right;">
						      							<input type="hidden" name="idUtilisateur" value="<% out.print(utilisateur.getId()); %>" />
						      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
									  					<button type="submit" class="btn btn-primary" style="border-radius:15px;">Ajouter en ami</button>
									  				</form> 	
									  								                           										   										  											    
					                           	</div>
											
				                        </div>
		                        
		                        	</div>
		                        	
		                        <% } %>
		                        
		                    <% } %>
		                    	                   	                    
	                   	<% } else { %>
	                   	
		                    <div class="utilisateur">
		                    
								<div class="list-item">
								
				                	<h3>Aucun utilisateur trouvé</h2>	
				                								
				                </div>
				                
			                </div>
							
						<% } %>
		                
					</div>	
					
				</div>
                
            </div>
	        
	    </div>
	    
	</div>
	
</body>
</html>