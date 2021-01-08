<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@ page import="bean.Utilisateur" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%! @SuppressWarnings("unchecked") %>
    
<!DOCTYPE html>
<html>
	<head>
		<title>Utilisateurs</title>
   		<jsp:include page="/JSP_pages/basePath.jsp" />
		<link href="front/bootstrap/css/list.css" rel="stylesheet">
		<script src="front/popper/popper.min.js"></script>
		<jsp:include page="/JSP_pages/head.jsp" />
	</head>
	
	<body>
	
		<% List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("Utilisateurs"); int drop = 1; %>
		
		<jsp:include page="/JSP_pages/navbar.jsp" />
		
		<div class="page-content page-container" id="page-content">
		        <div class="row">
		            <div class="col-sm-12 p-4">
					<% if (request.getParameter("error") != null)
							out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
		                <div class="container-fluid d-flex justify-content-center">
		                	<% if (utilisateurs.size() > 0) { %>
		                    	<div class="list list-row card w-75">
			                    	<% for (Utilisateur u : utilisateurs) { %>
			                    		<div class="utilisateur">
					                        <div class="list-item row h-100">
					                            	<div>
						                            	<img src="<% if (u.getImage() == null) {
																 		out.print("front/img/user.png");
														 			 } else {
																		out.print("uploads/" + u.getImage()); 
														 			 }	%>" class="img-radius" alt="User-Profile-Image" />
													</div>
						                            <div class="col-sm"> 
						                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  
						                            		 
					   									<div class="item-except text-muted text-sm h-1x">Né(e) le <% SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
					   																								 out.print(format.format(u.getDateNaiss())); %></div>		                            											   
													</div>	
						                            <div class="col-sm"> 					                            	
				                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>
				                            			<div class="item-date text-muted text-sm h-1x">Rang : <% out.print(u.getRang()); %></div>												   										  											    
						                            </div>              
					                            <% if (u.getRang().equals("normal")) { %>
					                            
					                            	<div class="col-sm">
					                            		<div class="dropdown float-right p-4">
													  		<button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Actions</button>
													  		
													  		<div class="dropdown-menu">			  	
														  		<a href="#" data-toggle="modal" data-target="#modalRang<% out.print(drop); %>" class="dropdown-item">Passer administrateur</a>
														  		<a href="#" data-toggle="modal" data-target="#modalSupprimer<% out.print(drop); %>" class="dropdown-item">Supprimer l'utilisateur</a>									  		
													  		</div>
														</div>
													</div>
													<!-- Modal modifier rang -->
													<div class="modal fade" id="modalRang<% out.print(drop); %>" tabindex="-1" role="dialog" aria-hidden="true">
													  	<div class="modal-dialog" role="document">
													    	<div class="modal-content">
													    	
													      		<div class="modal-header">
													        		<h5 class="modal-title">Modifier le rang</h5>
													        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													          			<span aria-hidden="true">&times;</span>
													        		</button>										        	
													      		</div>
													      		
													     		<div class="modal-body">
													        		Voulez vous vraiment faire de <% out.print(u.getPrenom() + " " + u.getNom()); %> un administrateur ?
													      		</div>
													      		
													      		<div class="modal-footer">
													      		
										      						<form action="admin/users/modifyUserRank" method="post">
										      							<input type="hidden" name="idUtilisateur" value="<% out.print(u.getId()); %>" />
													  					<button type="submit" class="btn btn-primary">Valider</button>
													  				</form>
													        		<button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>	
													        										        
													      		</div>
													      		
													    	</div>
													  	</div>
													</div>
													<!-- Modal supprimer utilisateur -->
													<div class="modal fade" id="modalSupprimer<% out.print(drop); %>" tabindex="-1" role="dialog" aria-hidden="true">
													  	<div class="modal-dialog" role="document">
													    	<div class="modal-content">
													    	
													      		<div class="modal-header">
													        		<h5 class="modal-title">Supprimer un utilisateur</h5>
													        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													          			<span aria-hidden="true">&times;</span>
													        		</button>										        	
													      		</div>
													      		
													     		<div class="modal-body">
													        		Voulez vous vraiment supprimer le compte de &#xAB; <% out.print(u.getPrenom() + " " + u.getNom()); %> &#xBB; de l'application  ?
													      		</div>
													      		
													      		<div class="modal-footer">
													      		
										      						<form action="admin/users/deleteUser" method="post">
										      							<input type="hidden" name="idUtilisateur" value="<% out.print(u.getId()); %>" />
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
				                    <% drop++; } %>
			                     </div>
	                    	<% } else { %>
								<div class="list-itemd-inline text-center">
				                	<h2 >Aucun utilisateur trouvé</h2>								
				                </div>
							<% } %>                                      
		                </div>
		            </div>
		        </div>
		    </div>		
	</body>
</html>