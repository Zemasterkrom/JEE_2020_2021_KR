<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@ page import="bean.Lieu" %>
<%! @SuppressWarnings("unchecked") %>
    
<!DOCTYPE html>
<html>
	<head>
		<title>Lieux</title>
   		<jsp:include page="/JSP_pages/basePath.jsp" />
		<link href="front/bootstrap/css/list.css" rel="stylesheet">
		<script src="front/popper/popper.min.js"></script>
		<jsp:include page="/JSP_pages/head.jsp" />
	</head>
	
	<body>
		<% List<Lieu> lieux = (List<Lieu>) request.getAttribute("Lieux"); int drop = 1; %>
		
		<jsp:include page="/JSP_pages/navbar.jsp" />
		<div class="page-content page-container" id="page-content">
		    <div>
		        <div class="row">
		            <div class="col-sm-12 p-4">
		           		 <% if (request.getParameter("error") != null)
							out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>             	
		                <div class="container-fluid d-flex justify-content-center">
		                	<% if (lieux.size() > 0) { %>
		                    	<div class="list list-row card w-75">  
			                    	<% for (Lieu l : lieux) { %>
			                    		<div class="utilisateur">
					                        <div class="list-item row h-100">                    
						                            <div> 
						                            	<% out.print(l.getNom()); %>  	
						                            	
			   											<div class="item-except text-muted text-sm h-1x">Adresse : <% out.print(l.getAdresse()); %></div>
			   											<div class="item-except text-muted text-sm h-1x">Activités : <% out.print(l.getActivites().size()); %></div>															   										  											    
						                            </div>
						                            
					                            	<div class="ml-auto">
									                    <div class="dropdown float-right p-4">
													  		<button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Actions</button>
													  		
													  		<div class="dropdown-menu">
																<a href="admin/places/modifyPlace?idLieu=<% out.print(l.getId()); %>" class="dropdown-item">Modifier le lieu</a>
														  		
														  		<% if (l.getActivites().size() == 0) { %>
														  			<a href="#" data-toggle="modal" data-target="#modalSupprimer<% out.print(drop); %>" class="dropdown-item">Supprimer le lieu</a>											  		
														  		<% } %>										  		
													  		</div>
														</div>
													</div>
													<% if (l.getActivites().size() == 0) { %>
														<!-- Modal supprimer lieu -->
														<div class="modal fade" id="modalSupprimer<% out.print(drop); %>" tabindex="-1" role="dialog" aria-hidden="true">
														  	<div class="modal-dialog" role="document">
														    	<div class="modal-content">
														      		<div class="modal-header">
														        		<h5 class="modal-title">Supprimer un lieu</h5>
														        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
														          			<span aria-hidden="true">&times;</span>
														        		</button>										        	
														      		</div>
														     		<div class="modal-body">
														        		Voulez vous vraiment supprimer le lieu 	&#xAB; <% out.print(l.getNom()); %> &#xBB; de l'application  ?
														      		</div>
														      		<div class="modal-footer">
											      						<form action="admin/places/deletePlace" method="post">
											      							<input type="hidden" name="idLieu" value="<% out.print(l.getId()); %>" />
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
				                	<h2 >Aucun lieu trouvé</h2>								
				                </div>
								
							<% } %>
								                   
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</body>
</html>