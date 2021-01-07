<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@page import="bean.Utilisateur"%>
<%@page import="bean.Ami"%>
<%@page import="sql.ManagerAmi" %>
<%! @SuppressWarnings("unchecked") %>

<!DOCTYPE html>
<html>
	<head>
		<title>Ajouter un ami</title>
   		<jsp:include page="/JSP_pages/basePath.jsp" />
		<link href="front/bootstrap/css/list.css" rel="stylesheet">
		<jsp:include page="/JSP_pages/head.jsp" />
	</head>
	<body>
	
		<% boolean allAccepted = true;
		   Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
		   List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("Utilisateurs");
		   ManagerAmi manager = new ManagerAmi(request, response); Ami a; %>
		
		<jsp:include page="/JSP_pages/navbar.jsp" />
		
		<div class="page-content page-container" id="page-content">
		    <div>
	            <div class="col-sm-12">
			<% if (request.getParameter("error") != null)
					out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
	                <div class="ami">
	                	<h1> Utilisateurs </h1>
	                	<div class="list list-row card w-75">
	                		<% if (utilisateurs.size() > 0) { %>              	                  	
		                    	<% for (Utilisateur u : utilisateurs) { %>
		                    		<% a = manager.getAmi(utilisateur.getId(), u.getId()); %>
		                    		<% if (a != null) { %>
		                    			<% if (!a.isAccepte()) { 
		                    				allAccepted = false;
		                    			%>
				                    		<div class="utilisateur">
						                        <div class="list-item">
					                            	<div>
					                            	<img src="<% if (u.getImage() == null) {
															 		out.print("front/img/user.png");
													 			 } else {
																	out.print("uploads/" + u.getImage()); 
													 			 }	%>" class="img-radius" alt="User-Profile-Image" />
													 </div>
						                            <div class="flex w-30 mw-30"> 
						                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
													</div>	
						                            <div class="flex w-30 mw-30"> 					                            	
				                            			<div class="item-except text-muted text-sm h-1x"><% out.print(u.getLogin()); %></div>											   										  											    
						                            </div>
						                            		                            
						                            <% if (a.getIdUtilisateur() == utilisateur.getId()) { %>
						                            	<div class="flex d-flex flex-column flex-wrap">
						                            		<div class="item-except text-muted text-sm text-right h-1x">Vous avez déjà envoyé une demande d'ami à cet utilisateur</div>
						                            		<div class="d-flex justify-content-sm-end">					                                                 		
							                           			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalAnnuler<% out.print(u.getId()); %>" style="border-radius:15px;">Annuler la demande</button>
							                           		</div>
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
											      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
														  					<button type="submit" class="btn btn-primary">Valider</button>
														  				</form>
														        		<button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>								        
														      		</div>
														    	</div>
														  	</div>
														</div>
							                        	    	
							                        <% } else { %>
							                        
							                        	 <div class="flex d-flex flex-column flex-wrap">
							                        	 	<div class="item-except text-muted text-sm text-right h-1x">Vous avez reçu une demande d'ami de cet utilisateur</div>
							                        	 	<div class="d-flex justify-content-sm-end">
																<form action="friends/acceptFriendRequest" method="post" class="mr-1">
									      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
															  		<button type="submit" class="btn btn-primary rounded">Accepter</button>
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
														 
							                        <% } %>
						                        </div>
				                        	</div>
				                        	
			                        	<% } %>		
			                        	                        
			                        <% } else { %>
			                        
			                        	<div class="utilisateur">
					                        <div class="list-item row h-100">
					                            	<div>
					                            	<img src="<% if (u.getImage() == null) {
															 		out.print("front/img/user.png");
													 			 } else {
																	out.print("uploads/" + u.getImage()); 
													 			 }	%>" class="img-radius" alt="User-Profile-Image" />
													 </div>
						                            <div> 
						                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  					                            			                            											   
													</div>	
						                            <div> 					                            	
				                            			<div class="item-except text-muted text-sm h-1x"><% out.print(u.getLogin()); %></div>											   										  											    
						                            </div>
						                            <div class="flex">       	
						                           		<form action="friends/addFriend" method="post" class="float-right">
							      							<input type="hidden" name="idAmi" value="<% out.print(u.getId()); %>" />
										  					<button type="submit" class="btn btn-primary rounded">Ajouter en ami</button>
										  				</form> 				                           										   										  											    
						                           	</div>
					                        </div>
			                        	</div>
			                        <% } %>
			                        
			                    <% }
		                    	   if (utilisateurs.size() == 0 && allAccepted == true) { %>
			                    	   	<div class="utilisateur">
											<div class="list-item">
							                	<h3>Vous possédez tous les utilisateurs en tant qu'ami</h3>							
							                </div>
					                	</div>
				                	<% } %>
			                    	                   	                    
		                   	<% } else { %>
			                    <div class="utilisateur">
									<div class="list-item">
					                	<h3>Aucun utilisateur trouvé</h3>							
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